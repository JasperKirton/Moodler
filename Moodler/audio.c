#include <stdio.h>
#include <stdlib.h>
#include "portaudio.h"

/*
 * I consider a single stereo sample to have two values in it.
 */

#define NUM_CHANNELS 2
#define BUFFER_SIZE 2048*NUM_CHANNELS /* bytes */
#define SAMPLE_TYPE short
#define SAMPLE_RATE 48000
#define MAX_VOICES 16

const int samplesPerBlock = 256;
const int samplesPerBuffer = BUFFER_SIZE/sizeof(SAMPLE_TYPE)/NUM_CHANNELS;
const int blocksPerBuffer = samplesPerBuffer/samplesPerBlock;

/*
 * These are exported to Haskell
 */
void (*fill_buffer)(void *state, SAMPLE_TYPE *);
int numStates;
void *states[16];
SAMPLE_TYPE *(moodler_buffer[MAX_VOICES]);

double t = 0;
int count = 0;

/* XXX Free */
void set_num_states(int n) {
    numStates = n;

    for (int i = 0; i < numStates; ++i) {
        moodler_buffer[i] = malloc(BUFFER_SIZE);
    }
}

void set_state_address(int i, void *state) {
    states[i] = state;
}

void set_fill_buffer(void (*fill)(void *state, SAMPLE_TYPE *)) {
    fill_buffer = fill;
}

int callback(const void *input,
             void *output,
             unsigned long frameCount,
             const PaStreamCallbackTimeInfo *timeInfo,
             PaStreamCallbackFlags statusFlags,
             void *userData) {

    SAMPLE_TYPE *sample_buffer = (SAMPLE_TYPE *)output;

    /*
     * Clear the audio buffer for filling.
     */
    for (int k = 0; k < samplesPerBuffer * NUM_CHANNELS; ++k) {
        sample_buffer[k] = 0;
    }

    int j = 0;
    for (int k = 0; k < blocksPerBuffer; ++k) {
        for (int i = 0; i < numStates; ++i) {
            /*
             * Use ith state structure to fill the kth part
             * of the ith voice's buffer.
             */
            fill_buffer(states[i], moodler_buffer[i]+k*NUM_CHANNELS*samplesPerBlock);
        }
    }

    /*
     * Sum the buffers we computed into the destination buffer
     */
    for (int i = 0; i < numStates; ++i) {
        for (int k = 0; k < samplesPerBuffer * NUM_CHANNELS; ++k) {
            sample_buffer[k] += moodler_buffer[i][k];
        }
    }
    return paContinue;
}

void play() {
    PaStreamParameters outputParameters;
    PaStream *stream;
    PaError err;
    int i;

    err = Pa_Initialize();
    if( err != paNoError ) goto error;

    outputParameters.device = Pa_GetDefaultOutputDevice(); /* default output device */
    if (outputParameters.device == paNoDevice) {
      fprintf(stderr,"Error: No default output device.\n");
      goto error;
    }
    outputParameters.channelCount = 2;       /* stereo output */
    outputParameters.sampleFormat = paInt16; /* 16 bit int output */
    outputParameters.suggestedLatency = Pa_GetDeviceInfo(
         outputParameters.device)->defaultLowOutputLatency;
    outputParameters.hostApiSpecificStreamInfo = NULL;

    err = Pa_OpenStream(
              &stream,
              NULL, /* no input */
              &outputParameters,
              SAMPLE_RATE,
              samplesPerBuffer,
              paClipOff,  /* we won't output out of range samples so don't bother clipping them */
              callback,
              NULL);
    if( err != paNoError ) goto error;

    err = Pa_StartStream( stream );
    if( err != paNoError ) goto error;
    return;

error:
    Pa_Terminate();
    fprintf( stderr, "An error occured while using the portaudio stream\n" );
    fprintf( stderr, "Error number: %d\n", err );
    fprintf( stderr, "Error message: %s\n", Pa_GetErrorText( err ) );
    return;
}
