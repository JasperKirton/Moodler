do
    root <- getRoot
    let out = "out"
    let keyboard = "keyboard"
    let trigger = "trigger"
    adsr3 <- new' "adsr"
    adsr4 <- new' "adsr"
    audio_saw5 <- new' "audio_saw"
    audio_saw6 <- new' "audio_saw"
    audio_saw7 <- new' "audio_saw"
    audio_sin10 <- new' "audio_sin"
    audio_sin8 <- new' "audio_sin"
    audio_sin9 <- new' "audio_sin"
    audio_square11 <- new' "audio_square"
    audio_square12 <- new' "audio_square"
    audio_square13 <- new' "audio_square"
    audio_triangle14 <- new' "audio_triangle"
    audio_triangle15 <- new' "audio_triangle"
    audio_triangle16 <- new' "audio_triangle"
    id17 <- new' "id"
    id18 <- new' "id"
    id19 <- new' "id"
    id20 <- new' "id"
    id21 <- new' "id"
    id22 <- new' "id"
    id23 <- new' "id"
    id24 <- new' "id"
    id25 <- new' "id"
    id26 <- new' "id"
    id27 <- new' "id"
    id28 <- new' "id"
    id29 <- new' "id"
    id30 <- new' "id"
    id31 <- new' "id"
    id32 <- new' "id"
    id33 <- new' "id"
    id34 <- new' "id"
    id35 <- new' "id"
    id36 <- new' "id"
    id37 <- new' "id"
    id38 <- new' "id"
    id39 <- new' "id"
    id40 <- new' "id"
    id41 <- new' "id"
    id42 <- new' "id"
    id43 <- new' "id"
    input44 <- new' "input"
    input45 <- new' "input"
    input46 <- new' "input"
    input47 <- new' "input"
    input48 <- new' "input"
    input49 <- new' "input"
    input50 <- new' "input"
    input51 <- new' "input"
    input52 <- new' "input"
    input53 <- new' "input"
    input54 <- new' "input"
    input55 <- new' "input"
    input56 <- new' "input"
    input57 <- new' "input"
    input58 <- new' "input"
    input59 <- new' "input"
    input60 <- new' "input"
    input61 <- new' "input"
    input62 <- new' "input"
    input63 <- new' "input"
    input64 <- new' "input"
    input65 <- new' "input"
    input66 <- new' "input"
    input67 <- new' "input"
    input68 <- new' "input"
    new "input" "keyboard"
    let keyboard = "keyboard"
    ladder69 <- new' "ladder"
    lfo70 <- new' "lfo"
    noise71 <- new' "noise"
    sum472 <- new' "sum4"
    sum473 <- new' "sum4"
    sum474 <- new' "sum4"
    sum75 <- new' "sum"
    sum76 <- new' "sum"
    sum77 <- new' "sum"
    sum78 <- new' "sum"
    sum79 <- new' "sum"
    new "input" "trigger"
    let trigger = "trigger"
    vca80 <- new' "vca"
    vca81 <- new' "vca"
    vca82 <- new' "vca"
    vca83 <- new' "vca"
    vca84 <- new' "vca"
    vca85 <- new' "vca"
    vca86 <- new' "vca"
    vca87 <- new' "vca"
    in2 <- plugin' (out ++ "." ++ "value") (278.0,128.0) root
    in88 <- plugin' (id17 ++ "." ++ "signal") (-240.0,0.0) root
    rename "frequency" in88
    in89 <- plugin' (id18 ++ "." ++ "signal") (-240.0,-60.0) root
    out0 <- plugout' (keyboard ++ "." ++ "result") (-496.0,130.0) root
    out1 <- plugout' (trigger ++ "." ++ "result") (-495.0,23.0) root
    out90 <- plugout' (id27 ++ "." ++ "result") (-108.0,-36.0) root
    proxy91 <- proxy' (-180.0,-36.0) root
    container138 <- container' "panel_vco2.png" (-156.0,288.0) proxy91
    in139 <- plugin' (id37 ++ "." ++ "signal") (-120.0,324.0) container138
    in140 <- plugin' (id38 ++ "." ++ "signal") (-135.0,361.5) container138
    hide in140
    in141 <- plugin' (id39 ++ "." ++ "signal") (-134.0,286.5) container138
    hide in141
    in142 <- plugin' (id40 ++ "." ++ "signal") (-120.0,252.0) container138
    knob143 <- knob' (input64 ++ "." ++ "result") (-120.0,360.0) container138
    knob144 <- knob' (input56 ++ "." ++ "result") (-120.0,288.0) container138
    out145 <- plugout' (id36 ++ "." ++ "result") (-180.0,204.0) container138
    out146 <- plugout' (id41 ++ "." ++ "result") (-108.0,204.0) container138
    out147 <- plugout' (id42 ++ "." ++ "result") (-180.0,168.0) container138
    out148 <- plugout' (id43 ++ "." ++ "result") (-108.0,168.0) container138
    proxy149 <- proxy' (-195.0,363.5) container138
    hide proxy149
    container150 <- container' "panel_3x1.png" (-968.0,522.5) proxy149
    in151 <- plugin' (audio_square11 ++ "." ++ "freq") (-989.0,572.5) container150
    in152 <- plugin' (audio_square11 ++ "." ++ "pwm") (-989.0,522.5) container150
    in153 <- plugin' (audio_square11 ++ "." ++ "sync") (-989.0,472.5) container150
    label154 <- label' "audio_square" (-993.0,597.5) container150
    out155 <- plugout' (audio_square11 ++ "." ++ "result") (-948.0,522.5) container150
    container156 <- container' "panel_3x1.png" (-957.0,762.5) proxy149
    in157 <- plugin' (sum78 ++ "." ++ "signal2") (-978.0,737.5) container156
    in158 <- plugin' (sum78 ++ "." ++ "signal1") (-978.0,787.5) container156
    label159 <- label' "sum" (-982.0,837.5) container156
    out160 <- plugout' (sum78 ++ "." ++ "result") (-937.0,762.5) container156
    container161 <- container' "panel_3x1.png" (-576.0,743.5) proxy149
    in162 <- plugin' (audio_triangle16 ++ "." ++ "freq") (-597.0,768.5) container161
    in163 <- plugin' (audio_triangle16 ++ "." ++ "sync") (-597.0,718.5) container161
    label164 <- label' "audio_triangle" (-601.0,818.5) container161
    out165 <- plugout' (audio_triangle16 ++ "." ++ "result") (-556.0,743.5) container161
    container166 <- container' "panel_3x1.png" (-460.0,614.5) proxy149
    in167 <- plugin' (audio_saw7 ++ "." ++ "freq") (-481.0,639.5) container166
    in168 <- plugin' (audio_saw7 ++ "." ++ "sync") (-481.0,589.5) container166
    label169 <- label' "audio_saw" (-485.0,689.5) container166
    out170 <- plugout' (audio_saw7 ++ "." ++ "result") (-440.0,614.5) container166
    container171 <- container' "panel_3x1.png" (-833.0,776.5) proxy149
    in172 <- plugin' (audio_sin10 ++ "." ++ "freq") (-854.0,801.5) container171
    in173 <- plugin' (audio_sin10 ++ "." ++ "sync") (-854.0,751.5) container171
    label174 <- label' "audio_sin" (-858.0,851.5) container171
    out175 <- plugout' (audio_sin10 ++ "." ++ "result") (-813.0,776.5) container171
    in176 <- plugin' (id41 ++ "." ++ "signal") (-895.0,521.5) proxy149
    in177 <- plugin' (id42 ++ "." ++ "signal") (-502.0,745.5) proxy149
    in178 <- plugin' (id43 ++ "." ++ "signal") (-389.0,615.5) proxy149
    in179 <- plugin' (id36 ++ "." ++ "signal") (-698.0,772.5) proxy149
    out180 <- plugout' (id37 ++ "." ++ "result") (-1033.0,736.5) proxy149
    out181 <- plugout' (id38 ++ "." ++ "result") (-1034.0,792.5) proxy149
    out182 <- plugout' (id39 ++ "." ++ "result") (-1036.0,522.5) proxy149
    out183 <- plugout' (id40 ++ "." ++ "result") (-1035.0,469.5) proxy149
    container184 <- container' "panel_lfo.png" (-384.0,-912.0) proxy91
    in185 <- plugin' (lfo70 ++ "." ++ "sync") (-372.0,-888.0) container184
    in186 <- plugin' (lfo70 ++ "." ++ "rate") (-386.5,-836.0) container184
    hide in186
    knob187 <- knob' (input67 ++ "." ++ "result") (-372.0,-840.0) container184
    out188 <- plugout' (lfo70 ++ "." ++ "saw") (-396.0,-1032.0) container184
    out189 <- plugout' (lfo70 ++ "." ++ "triangle") (-336.0,-1032.0) container184
    out190 <- plugout' (lfo70 ++ "." ++ "sin_result") (-396.0,-996.0) container184
    out191 <- plugout' (lfo70 ++ "." ++ "square_result") (-336.0,-996.0) container184
    container192 <- container' "panel_3x1.png" (-192.0,-312.0) proxy91
    in193 <- plugin' (sum79 ++ "." ++ "signal1") (-216.0,-288.0) container192
    in194 <- plugin' (sum79 ++ "." ++ "signal2") (-216.0,-336.0) container192
    label195 <- label' "sum" (-216.0,-228.0) container192
    out196 <- plugout' (sum79 ++ "." ++ "result") (-168.0,-312.0) container192
    container197 <- container' "panel_3x1.png" (-192.0,-912.0) proxy91
    in198 <- plugin' (vca80 ++ "." ++ "cv") (-218.0,-890.5) container197
    hide in198
    in199 <- plugin' (vca80 ++ "." ++ "signal") (-216.0,-936.0) container197
    knob200 <- knob' (input50 ++ "." ++ "result") (-216.0,-888.0) container197
    label201 <- label' "vca" (-216.0,-840.0) container197
    out202 <- plugout' (vca80 ++ "." ++ "result") (-180.0,-912.0) container197
    container203 <- container' "panel_3x1.png" (96.0,-912.0) proxy91
    in204 <- plugin' (vca81 ++ "." ++ "cv") (70.0,-888.5) container203
    hide in204
    in205 <- plugin' (vca81 ++ "." ++ "signal") (72.0,-936.0) container203
    knob206 <- knob' (input51 ++ "." ++ "result") (70.0,-888.5) container203
    hide knob206
    knob207 <- knob' (input52 ++ "." ++ "result") (72.0,-888.0) container203
    label208 <- label' "vca" (72.0,-840.0) container203
    out209 <- plugout' (vca81 ++ "." ++ "result") (108.0,-912.0) container203
    container210 <- container' "panel_3x1.png" (-48.0,-912.0) proxy91
    in211 <- plugin' (vca82 ++ "." ++ "cv") (-68.0,-887.5) container210
    hide in211
    in212 <- plugin' (vca82 ++ "." ++ "signal") (-72.0,-936.0) container210
    knob213 <- knob' (input53 ++ "." ++ "result") (-72.0,-888.0) container210
    label214 <- label' "vca" (-72.0,-840.0) container210
    out215 <- plugout' (vca82 ++ "." ++ "result") (-24.0,-912.0) container210
    container216 <- container' "panel_adsr.png" (-384.0,-612.0) proxy91
    in217 <- plugin' (adsr4 ++ "." ++ "attack") (-410.02,-555.7655) container216
    hide in217
    in218 <- plugin' (adsr4 ++ "." ++ "decay") (-357.02,-538.7655) container216
    hide in218
    in219 <- plugin' (adsr4 ++ "." ++ "sustain") (-357.02,-588.7655) container216
    hide in219
    in220 <- plugin' (adsr4 ++ "." ++ "release") (-357.02,-638.7655) container216
    hide in220
    in221 <- plugin' (adsr4 ++ "." ++ "gate") (-348.0,-684.0) container216
    knob222 <- knob' (input46 ++ "." ++ "result") (-408.0,-552.0) container216
    knob223 <- knob' (input47 ++ "." ++ "result") (-348.0,-552.0) container216
    knob224 <- knob' (input49 ++ "." ++ "result") (-408.0,-600.0) container216
    knob225 <- knob' (input48 ++ "." ++ "result") (-348.0,-600.0) container216
    out226 <- plugout' (adsr4 ++ "." ++ "result") (-348.0,-720.0) container216
    container227 <- container' "panel_adsr.png" (-384.0,-312.0) proxy91
    in228 <- plugin' (adsr3 ++ "." ++ "attack") (-414.5,-248.0) container227
    hide in228
    in229 <- plugin' (adsr3 ++ "." ++ "decay") (-361.5,-231.0) container227
    hide in229
    in230 <- plugin' (adsr3 ++ "." ++ "sustain") (-428.5,-307.0) container227
    hide in230
    in231 <- plugin' (adsr3 ++ "." ++ "release") (-361.5,-331.0) container227
    hide in231
    in232 <- plugin' (adsr3 ++ "." ++ "gate") (-348.0,-384.0) container227
    knob233 <- knob' (input60 ++ "." ++ "result") (-408.0,-252.0) container227
    knob234 <- knob' (input61 ++ "." ++ "result") (-348.0,-252.0) container227
    knob235 <- knob' (input66 ++ "." ++ "result") (-408.0,-300.0) container227
    knob236 <- knob' (input65 ++ "." ++ "result") (-348.0,-300.0) container227
    out237 <- plugout' (adsr3 ++ "." ++ "result") (-348.0,-420.0) container227
    container238 <- container' "panel_3x1.png" (-48.0,-312.0) proxy91
    in239 <- plugin' (vca84 ++ "." ++ "cv") (-72.0,-288.0) container238
    in240 <- plugin' (vca84 ++ "." ++ "signal") (-72.0,-336.0) container238
    label241 <- label' "vca" (-72.0,-228.0) container238
    out242 <- plugout' (vca84 ++ "." ++ "result") (-36.0,-312.0) container238
    container243 <- container' "panel_3x1.png" (-36.0,-24.0) proxy91
    in244 <- plugin' (vca86 ++ "." ++ "cv") (-63.0,5.0) container243
    hide in244
    in245 <- plugin' (vca86 ++ "." ++ "signal") (-60.0,-48.0) container243
    knob246 <- knob' (input45 ++ "." ++ "result") (-60.0,0.0) container243
    label247 <- label' "vca" (-60.0,60.0) container243
    out248 <- plugout' (vca86 ++ "." ++ "result") (-24.0,-24.0) container243
    container249 <- container' "panel_3x1.png" (0.0,300.0) proxy91
    label250 <- label' "noise" (-24.0,372.0) container249
    out251 <- plugout' (noise71 ++ "." ++ "result") (12.0,300.0) container249
    container252 <- container' "panel_4x1.png" (-336.0,-12.0) proxy91
    in253 <- plugin' (sum472 ++ "." ++ "signal1") (-360.0,60.0) container252
    in254 <- plugin' (sum472 ++ "." ++ "signal2") (-360.0,12.0) container252
    in255 <- plugin' (sum472 ++ "." ++ "signal3") (-360.0,-36.0) container252
    in256 <- plugin' (sum472 ++ "." ++ "signal4") (-360.0,-84.0) container252
    label257 <- label' "sum4" (-360.0,108.0) container252
    out258 <- plugout' (sum472 ++ "." ++ "result") (-324.0,-12.0) container252
    container259 <- container' "panel_4x1.png" (192.0,300.0) proxy91
    in260 <- plugin' (sum473 ++ "." ++ "signal1") (168.0,372.0) container259
    in261 <- plugin' (sum473 ++ "." ++ "signal2") (168.0,324.0) container259
    in262 <- plugin' (sum473 ++ "." ++ "signal3") (168.0,264.0) container259
    in263 <- plugin' (sum473 ++ "." ++ "signal4") (168.0,228.0) container259
    label264 <- label' "sum4" (168.0,420.0) container259
    out265 <- plugout' (sum473 ++ "." ++ "result") (216.0,300.0) container259
    container266 <- container' "panel_3x1.png" (96.0,300.0) proxy91
    in267 <- plugin' (vca87 ++ "." ++ "cv") (71.0,320.0) container266
    hide in267
    in268 <- plugin' (vca87 ++ "." ++ "signal") (72.0,276.0) container266
    knob269 <- knob' (input44 ++ "." ++ "result") (72.0,324.0) container266
    label270 <- label' "vca" (72.0,372.0) container266
    out271 <- plugout' (vca87 ++ "." ++ "result") (108.0,300.0) container266
    container272 <- container' "panel_4x1.png" (108.0,-36.0) proxy91
    in273 <- plugin' (sum474 ++ "." ++ "signal1") (84.0,48.0) container272
    in274 <- plugin' (sum474 ++ "." ++ "signal2") (84.0,0.0) container272
    in275 <- plugin' (sum474 ++ "." ++ "signal3") (84.0,-60.0) container272
    in276 <- plugin' (sum474 ++ "." ++ "signal4") (84.0,-108.0) container272
    label277 <- label' "sum4" (84.0,72.0) container272
    out278 <- plugout' (sum474 ++ "." ++ "result") (132.0,-36.0) container272
    container279 <- container' "panel_ladder.png" (276.0,-36.0) proxy91
    in280 <- plugin' (ladder69 ++ "." ++ "signal") (228.0,-156.0) container279
    in281 <- plugin' (sum75 ++ "." ++ "signal1") (325.0,39.5) container279
    hide in281
    in282 <- plugin' (sum75 ++ "." ++ "signal2") (276.0,36.0) container279
    in283 <- plugin' (ladder69 ++ "." ++ "freq") (299.0,-6.5) container279
    hide in283
    in284 <- plugin' (ladder69 ++ "." ++ "res") (322.0,-43.5) container279
    hide in284
    knob285 <- knob' (input62 ++ "." ++ "result") (324.0,-24.0) container279
    knob286 <- knob' (input63 ++ "." ++ "result") (324.0,36.0) container279
    out287 <- plugout' (ladder69 ++ "." ++ "result") (324.0,-156.0) container279
    out288 <- plugout' (sum75 ++ "." ++ "result") (241.0,-3.5) container279
    hide out288
    container289 <- container' "panel_3x1.png" (-192.0,-612.0) proxy91
    in290 <- plugin' (vca85 ++ "." ++ "cv") (-218.0,-585.5) container289
    hide in290
    in291 <- plugin' (vca85 ++ "." ++ "signal") (-216.0,-636.0) container289
    knob292 <- knob' (input58 ++ "." ++ "result") (-216.0,-588.0) container289
    label293 <- label' "vca" (-216.0,-540.0) container289
    out294 <- plugout' (vca85 ++ "." ++ "result") (-180.0,-612.0) container289
    container295 <- container' "panel_3x1.png" (-504.0,-12.0) proxy91
    in296 <- plugin' (vca83 ++ "." ++ "signal") (-528.0,-36.0) container295
    in297 <- plugin' (vca83 ++ "." ++ "cv") (-531.0,13.5) container295
    hide in297
    knob298 <- knob' (input68 ++ "." ++ "result") (-528.0,12.0) container295
    rename "adsr->freqency gain" knob298
    label299 <- label' "vca" (-528.0,72.0) container295
    out300 <- plugout' (vca83 ++ "." ++ "result") (-492.0,-12.0) container295
    container301 <- container' "panel_vco2.png" (-492.0,288.0) proxy91
    in302 <- plugin' (id20 ++ "." ++ "signal") (-456.0,324.0) container301
    in303 <- plugin' (id21 ++ "." ++ "signal") (-482.0,360.5) container301
    hide in303
    in304 <- plugin' (id22 ++ "." ++ "signal") (-481.0,285.5) container301
    hide in304
    in305 <- plugin' (id23 ++ "." ++ "signal") (-456.0,252.0) container301
    knob306 <- knob' (input57 ++ "." ++ "result") (-456.0,360.0) container301
    knob307 <- knob' (input54 ++ "." ++ "result") (-456.0,288.0) container301
    out308 <- plugout' (id24 ++ "." ++ "result") (-444.0,204.0) container301
    out309 <- plugout' (id25 ++ "." ++ "result") (-516.0,168.0) container301
    out310 <- plugout' (id26 ++ "." ++ "result") (-444.0,168.0) container301
    out311 <- plugout' (id19 ++ "." ++ "result") (-516.0,204.0) container301
    proxy312 <- proxy' (-542.0,362.5) container301
    hide proxy312
    container313 <- container' "panel_3x1.png" (-1106.0,439.5) proxy312
    in314 <- plugin' (audio_square12 ++ "." ++ "freq") (-1127.0,489.5) container313
    in315 <- plugin' (audio_square12 ++ "." ++ "pwm") (-1127.0,439.5) container313
    in316 <- plugin' (audio_square12 ++ "." ++ "sync") (-1127.0,389.5) container313
    label317 <- label' "audio_square" (-1131.0,514.5) container313
    out318 <- plugout' (audio_square12 ++ "." ++ "result") (-1086.0,439.5) container313
    container319 <- container' "panel_3x1.png" (-1095.0,679.5) proxy312
    in320 <- plugin' (sum76 ++ "." ++ "signal2") (-1116.0,654.5) container319
    in321 <- plugin' (sum76 ++ "." ++ "signal1") (-1116.0,704.5) container319
    label322 <- label' "sum" (-1120.0,754.5) container319
    out323 <- plugout' (sum76 ++ "." ++ "result") (-1075.0,679.5) container319
    container324 <- container' "panel_3x1.png" (-714.0,660.5) proxy312
    in325 <- plugin' (audio_triangle14 ++ "." ++ "freq") (-735.0,685.5) container324
    in326 <- plugin' (audio_triangle14 ++ "." ++ "sync") (-735.0,635.5) container324
    label327 <- label' "audio_triangle" (-739.0,735.5) container324
    out328 <- plugout' (audio_triangle14 ++ "." ++ "result") (-694.0,660.5) container324
    container329 <- container' "panel_3x1.png" (-598.0,531.5) proxy312
    in330 <- plugin' (audio_saw5 ++ "." ++ "freq") (-619.0,556.5) container329
    in331 <- plugin' (audio_saw5 ++ "." ++ "sync") (-619.0,506.5) container329
    label332 <- label' "audio_saw" (-623.0,606.5) container329
    out333 <- plugout' (audio_saw5 ++ "." ++ "result") (-578.0,531.5) container329
    container334 <- container' "panel_3x1.png" (-971.0,693.5) proxy312
    in335 <- plugin' (audio_sin8 ++ "." ++ "freq") (-992.0,718.5) container334
    in336 <- plugin' (audio_sin8 ++ "." ++ "sync") (-992.0,668.5) container334
    label337 <- label' "audio_sin" (-996.0,768.5) container334
    out338 <- plugout' (audio_sin8 ++ "." ++ "result") (-951.0,693.5) container334
    in339 <- plugin' (id24 ++ "." ++ "signal") (-1033.0,438.5) proxy312
    in340 <- plugin' (id25 ++ "." ++ "signal") (-640.0,662.5) proxy312
    in341 <- plugin' (id26 ++ "." ++ "signal") (-527.0,532.5) proxy312
    in342 <- plugin' (id19 ++ "." ++ "signal") (-836.0,689.5) proxy312
    out343 <- plugout' (id20 ++ "." ++ "result") (-1171.0,653.5) proxy312
    out344 <- plugout' (id21 ++ "." ++ "result") (-1172.0,709.5) proxy312
    out345 <- plugout' (id22 ++ "." ++ "result") (-1174.0,439.5) proxy312
    out346 <- plugout' (id23 ++ "." ++ "result") (-1173.0,386.5) proxy312
    container92 <- container' "panel_vco2.png" (-324.0,288.0) proxy91
    in93 <- plugin' (id29 ++ "." ++ "signal") (-288.0,324.0) container92
    in94 <- plugin' (id30 ++ "." ++ "signal") (-307.0,369.5) container92
    hide in94
    in95 <- plugin' (id31 ++ "." ++ "signal") (-306.0,294.5) container92
    hide in95
    in96 <- plugin' (id32 ++ "." ++ "signal") (-288.0,252.0) container92
    knob97 <- knob' (input59 ++ "." ++ "result") (-288.0,360.0) container92
    knob98 <- knob' (input55 ++ "." ++ "result") (-288.0,288.0) container92
    out100 <- plugout' (id33 ++ "." ++ "result") (-276.0,204.0) container92
    out101 <- plugout' (id34 ++ "." ++ "result") (-348.0,168.0) container92
    out102 <- plugout' (id35 ++ "." ++ "result") (-276.0,168.0) container92
    out99 <- plugout' (id28 ++ "." ++ "result") (-348.0,204.0) container92
    proxy103 <- proxy' (-367.0,371.5) container92
    hide proxy103
    container104 <- container' "panel_3x1.png" (-972.0,523.5) proxy103
    in105 <- plugin' (audio_square13 ++ "." ++ "freq") (-993.0,573.5) container104
    in106 <- plugin' (audio_square13 ++ "." ++ "pwm") (-993.0,523.5) container104
    in107 <- plugin' (audio_square13 ++ "." ++ "sync") (-993.0,473.5) container104
    label108 <- label' "audio_square" (-997.0,598.5) container104
    out109 <- plugout' (audio_square13 ++ "." ++ "result") (-952.0,523.5) container104
    container110 <- container' "panel_3x1.png" (-961.0,763.5) proxy103
    in111 <- plugin' (sum77 ++ "." ++ "signal2") (-982.0,738.5) container110
    in112 <- plugin' (sum77 ++ "." ++ "signal1") (-982.0,788.5) container110
    label113 <- label' "sum" (-986.0,838.5) container110
    out114 <- plugout' (sum77 ++ "." ++ "result") (-941.0,763.5) container110
    container115 <- container' "panel_3x1.png" (-580.0,744.5) proxy103
    in116 <- plugin' (audio_triangle15 ++ "." ++ "freq") (-601.0,769.5) container115
    in117 <- plugin' (audio_triangle15 ++ "." ++ "sync") (-601.0,719.5) container115
    label118 <- label' "audio_triangle" (-605.0,819.5) container115
    out119 <- plugout' (audio_triangle15 ++ "." ++ "result") (-560.0,744.5) container115
    container120 <- container' "panel_3x1.png" (-464.0,615.5) proxy103
    in121 <- plugin' (audio_saw6 ++ "." ++ "freq") (-485.0,640.5) container120
    in122 <- plugin' (audio_saw6 ++ "." ++ "sync") (-485.0,590.5) container120
    label123 <- label' "audio_saw" (-489.0,690.5) container120
    out124 <- plugout' (audio_saw6 ++ "." ++ "result") (-444.0,615.5) container120
    container125 <- container' "panel_3x1.png" (-837.0,777.5) proxy103
    in126 <- plugin' (audio_sin9 ++ "." ++ "freq") (-858.0,802.5) container125
    in127 <- plugin' (audio_sin9 ++ "." ++ "sync") (-858.0,752.5) container125
    label128 <- label' "audio_sin" (-862.0,852.5) container125
    out129 <- plugout' (audio_sin9 ++ "." ++ "result") (-817.0,777.5) container125
    in130 <- plugin' (id33 ++ "." ++ "signal") (-899.0,522.5) proxy103
    in131 <- plugin' (id34 ++ "." ++ "signal") (-506.0,746.5) proxy103
    in132 <- plugin' (id35 ++ "." ++ "signal") (-393.0,616.5) proxy103
    in133 <- plugin' (id28 ++ "." ++ "signal") (-702.0,773.5) proxy103
    out134 <- plugout' (id29 ++ "." ++ "result") (-1037.0,737.5) proxy103
    out135 <- plugout' (id30 ++ "." ++ "result") (-1038.0,793.5) proxy103
    out136 <- plugout' (id31 ++ "." ++ "result") (-1040.0,523.5) proxy103
    out137 <- plugout' (id32 ++ "." ++ "result") (-1039.0,470.5) proxy103
    in347 <- plugin' (id27 ++ "." ++ "signal") (300.0,-216.0) proxy91
    out348 <- plugout' (id17 ++ "." ++ "result") (-528.0,-132.0) proxy91
    out349 <- plugout' (id18 ++ "." ++ "result") (-528.0,-264.0) proxy91
    cable out258 in139
    cable knob143 in140
    cable knob144 in141
    cable out160 in151
    cable out182 in152
    cable out183 in153
    cable out180 in157
    cable out181 in158
    cable out160 in162
    cable out183 in163
    cable out160 in167
    cable out183 in168
    cable out160 in172
    cable out183 in173
    cable out155 in176
    cable out165 in177
    cable out170 in178
    cable out175 in179
    cable out349 in185
    cable knob187 in186
    cable out202 in193
    cable out237 in194
    cable knob200 in198
    cable out190 in199
    cable knob206 in204
    cable out190 in205
    cable knob213 in211
    cable out190 in212
    cable knob222 in217
    cable knob223 in218
    cable knob224 in219
    cable knob225 in220
    cable out349 in221
    cable knob233 in228
    cable knob234 in229
    cable knob235 in230
    cable knob236 in231
    cable out349 in232
    cable out196 in239
    cable out287 in240
    cable knob246 in244
    cable out348 in245
    cable out215 in254
    cable out300 in255
    cable out348 in256
    cable out310 in260
    cable out102 in261
    cable out148 in262
    cable out271 in263
    cable knob269 in267
    cable out251 in268
    cable out294 in273
    cable out209 in274
    cable out248 in275
    cable out265 in280
    cable knob286 in281
    cable out278 in282
    cable out288 in283
    cable knob285 in284
    cable knob292 in290
    cable out226 in291
    cable out237 in296
    cable knob298 in297
    cable out258 in302
    cable knob306 in303
    cable knob307 in304
    cable out323 in314
    cable out345 in315
    cable out346 in316
    cable out343 in320
    cable out344 in321
    cable out323 in325
    cable out346 in326
    cable out323 in330
    cable out346 in331
    cable out323 in335
    cable out346 in336
    cable out318 in339
    cable out328 in340
    cable out333 in341
    cable out338 in342
    cable out258 in93
    cable knob97 in94
    cable knob98 in95
    cable out114 in105
    cable out136 in106
    cable out137 in107
    cable out134 in111
    cable out135 in112
    cable out114 in116
    cable out137 in117
    cable out114 in121
    cable out137 in122
    cable out114 in126
    cable out137 in127
    cable out109 in130
    cable out119 in131
    cable out124 in132
    cable out129 in133
    cable out242 in347
    recompile
    set knob143 (0.0)
    set knob144 (0.24)
    set knob187 (0.0)
    set knob200 (0.4999224)
    set knob206 (0.0)
    set knob207 (0.0)
    set knob213 (0.0)
    set knob222 (9.607368e-2)
    set knob223 (0.17859738)
    set knob224 (0.5606312)
    set knob225 (0.12)
    set knob233 (0.18623775)
    set knob234 (0.50404507)
    set knob235 (0.19112307)
    set knob236 (0.39999998)
    set knob246 (1.0)
    set knob269 (0.0)
    set knob285 (0.4752239)
    set knob286 (0.1492165)
    set knob292 (0.2638312)
    set knob298 (0.0)
    set knob306 (0.0)
    set knob307 (0.19)
    set knob97 (0.0)
    set knob98 (0.26)
    return ()
    bind "!" "alert"
    bind "#" "sharpen"
    bind "0" "setzero"
    bind "1" "setone"
    bind "<" "setmin"
    bind "=" "setvalue"
    bind ">" "setmax"
    bind "A" "noteA"
    bind "B" "noteB"
    bind "C" "noteC"
    bind "D" "noteD"
    bind "E" "noteE"
    bind "F" "noteF"
    bind "G" "noteG"
    bind "H" "unhide"
    bind "P" "unparent"
    bind "\\" "nolimits"
    bind "a" "addknob"
    bind "b" "flatten"
    bind "d" "delete"
    bind "h" "hide"
    bind "m" "relocate"
    bind "n" "rename"
    bind "p" "up"
    bind "u" "hide"
    bind "z" "check"
    bind "|" "quantise"