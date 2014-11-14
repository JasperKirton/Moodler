do
    (x0, y0) <- mouse
    let (x, y) = quantise2 quantum (x0, y0)
    root <- currentPlane
    audio_saw0  <-  new' "audio_saw"
    audio_sin1  <-  new' "audio_sin"
    audio_square2  <-  new' "audio_square"
    audio_triangle3  <-  new' "audio_triangle"
    id10  <-  new' "id"
    id11  <-  new' "id"
    id12  <-  new' "id"
    id13  <-  new' "id"
    id15  <-  new' "id"
    id16  <-  new' "id"
    id7  <-  new' "id"
    id8  <-  new' "id"
    input22  <-  new' "input"
    input9  <-  new' "input"
    sum28  <-  new' "sum"
    container71 <- container' "panel_vco2.bmp" (x+(0.0), y+(0.0)) root
    in72 <- plugin' (id16 ++ "." ++ "signal") (x+(36.0), y+(36.0)) container71
    in73 <- plugin' (id7 ++ "." ++ "signal") (x+(13.0), y+(80.0)) container71
    hide in73
    in74 <- plugin' (id8 ++ "." ++ "signal") (x+(31.0), y+(3.0)) container71
    hide in74
    in75 <- plugin' (id10 ++ "." ++ "signal") (x+(36.0), y+(-36.0)) container71
    knob76 <- knob' (input9 ++ "." ++ "result") (x+(36.0), y+(0.0)) container71
    knob77 <- knob' (input22 ++ "." ++ "result") (x+(36.0), y+(72.0)) container71
    out78 <- plugout' (id15 ++ "." ++ "result") (x+(-24.0), y+(-84.0)) container71
    out79 <- plugout' (id11 ++ "." ++ "result") (x+(48.0), y+(-84.0)) container71
    out80 <- plugout' (id12 ++ "." ++ "result") (x+(-24.0), y+(-120.0)) container71
    out81 <- plugout' (id13 ++ "." ++ "result") (x+(48.0), y+(-120.0)) container71
    proxy82 <- proxy' (x+(-47.0), y+(82.0)) container71
    hide proxy82
    container104 <- container' "panel_3x1.bmp" (-815.0,439.0) proxy82
    in105 <- plugin' (sum28 ++ "." ++ "signal2") (-836.0,414.0) container104
    in106 <- plugin' (sum28 ++ "." ++ "signal1") (-836.0,464.0) container104
    label107 <- label' "sum" (-840.0,514.0) container104
    out108 <- plugout' (sum28 ++ "." ++ "result") (-795.0,439.0) container104
    container83 <- container' "panel_3x1.bmp" (-434.0,420.0) proxy82
    in84 <- plugin' (audio_triangle3 ++ "." ++ "freq") (-455.0,445.0) container83
    in85 <- plugin' (audio_triangle3 ++ "." ++ "sync") (-455.0,395.0) container83
    label86 <- label' "audio_triangle" (-459.0,495.0) container83
    out87 <- plugout' (audio_triangle3 ++ "." ++ "result") (-414.0,420.0) container83
    container88 <- container' "panel_3x1.bmp" (-318.0,291.0) proxy82
    in89 <- plugin' (audio_saw0 ++ "." ++ "freq") (-339.0,316.0) container88
    in90 <- plugin' (audio_saw0 ++ "." ++ "sync") (-339.0,266.0) container88
    label91 <- label' "audio_saw" (-343.0,366.0) container88
    out92 <- plugout' (audio_saw0 ++ "." ++ "result") (-298.0,291.0) container88
    container93 <- container' "panel_3x1.bmp" (-691.0,453.0) proxy82
    in94 <- plugin' (audio_sin1 ++ "." ++ "freq") (-712.0,478.0) container93
    in95 <- plugin' (audio_sin1 ++ "." ++ "sync") (-712.0,428.0) container93
    label96 <- label' "audio_sin" (-716.0,528.0) container93
    out97 <- plugout' (audio_sin1 ++ "." ++ "result") (-671.0,453.0) container93
    container98 <- container' "panel_3x1.bmp" (-826.0,199.0) proxy82
    in100 <- plugin' (audio_square2 ++ "." ++ "pwm") (-847.0,199.0) container98
    in101 <- plugin' (audio_square2 ++ "." ++ "sync") (-847.0,149.0) container98
    in99 <- plugin' (audio_square2 ++ "." ++ "freq") (-847.0,249.0) container98
    label102 <- label' "audio_square" (-851.0,274.0) container98
    out103 <- plugout' (audio_square2 ++ "." ++ "result") (-806.0,199.0) container98
    in109 <- plugin' (id11 ++ "." ++ "signal") (-753.0,198.0) proxy82
    in110 <- plugin' (id12 ++ "." ++ "signal") (-360.0,422.0) proxy82
    in111 <- plugin' (id13 ++ "." ++ "signal") (-247.0,292.0) proxy82
    in112 <- plugin' (id15 ++ "." ++ "signal") (-556.0,449.0) proxy82
    out113 <- plugout' (id16 ++ "." ++ "result") (-891.0,413.0) proxy82
    out114 <- plugout' (id7 ++ "." ++ "result") (-892.0,469.0) proxy82
    out115 <- plugout' (id8 ++ "." ++ "result") (-894.0,199.0) proxy82
    out116 <- plugout' (id10 ++ "." ++ "result") (-893.0,146.0) proxy82
    cable knob77 in73
    cable knob76 in74
    cable out113 in105
    cable out114 in106
    cable out108 in84
    cable out116 in85
    cable out108 in89
    cable out116 in90
    cable out108 in94
    cable out116 in95
    cable out115 in100
    cable out116 in101
    cable out108 in99
    cable out103 in109
    cable out87 in110
    cable out92 in111
    cable out97 in112
    recompile
    set knob76 (0.0)
    set knob77 (0.0)
    return ()
