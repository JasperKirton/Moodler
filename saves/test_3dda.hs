do
    root <- getRoot
    let out = "out"
    let keyboard = "keyboard"
    let trigger = "trigger"
    dda0 <- new' "dda"
    dda1 <- new' "dda"
    dda2 <- new' "dda"
    gate3 <- new' "gate"
    gate4 <- new' "gate"
    gate5 <- new' "gate"
    id10 <- new' "id"
    id11 <- new' "id"
    id12 <- new' "id"
    id13 <- new' "id"
    id14 <- new' "id"
    id15 <- new' "id"
    id16 <- new' "id"
    id17 <- new' "id"
    id6 <- new' "id"
    id7 <- new' "id"
    id8 <- new' "id"
    id9 <- new' "id"
    input18 <- new' "input"
    input19 <- new' "input"
    input20 <- new' "input"
    input21 <- new' "input"
    input22 <- new' "input"
    input23 <- new' "input"
    input24 <- new' "input"
    input25 <- new' "input"
    input26 <- new' "input"
    input27 <- new' "input"
    input28 <- new' "input"
    input29 <- new' "input"
    input30 <- new' "input"
    input31 <- new' "input"
    input32 <- new' "input"
    new "input" "keyboard"
    let keyboard = "keyboard"
    ladder33 <- new' "ladder"
    ladder34 <- new' "ladder"
    ladder35 <- new' "ladder"
    lfo36 <- new' "lfo"
    sum37 <- new' "sum"
    sum38 <- new' "sum"
    sum39 <- new' "sum"
    sum440 <- new' "sum4"
    new "input" "trigger"
    let trigger = "trigger"
    vca41 <- new' "vca"
    vca42 <- new' "vca"
    vca43 <- new' "vca"
    vca44 <- new' "vca"
    container124 <- container' "panel_3x1.bmp" (144.0,-288.0) root
    in125 <- plugin' (vca43 ++ "." ++ "cv") (125.0,-264.0) container124
    setColour in125 "#sample"
    hide in125
    in126 <- plugin' (vca43 ++ "." ++ "signal") (120.0,-312.0) container124
    setColour in126 "#sample"
    knob127 <- knob' (input18 ++ "." ++ "result") (120.0,-264.0) container124
    label128 <- label' "vca" (120.0,-216.0) container124
    out129 <- plugout' (vca43 ++ "." ++ "result") (168.0,-288.0) container124
    setColour out129 "#sample"
    container130 <- container' "panel_3x1.bmp" (144.0,12.0) root
    in131 <- plugin' (vca44 ++ "." ++ "cv") (127.0,38.0) container130
    setColour in131 "#sample"
    hide in131
    in132 <- plugin' (vca44 ++ "." ++ "signal") (120.0,-12.0) container130
    setColour in132 "#sample"
    knob133 <- knob' (input20 ++ "." ++ "result") (120.0,36.0) container130
    label134 <- label' "vca" (120.0,84.0) container130
    out135 <- plugout' (vca44 ++ "." ++ "result") (168.0,12.0) container130
    setColour out135 "#sample"
    container136 <- container' "panel_lfo.bmp" (-396.0,12.0) root
    in137 <- plugin' (lfo36 ++ "." ++ "sync") (-384.0,36.0) container136
    setColour in137 "#control"
    in138 <- plugin' (lfo36 ++ "." ++ "rate") (-399.0,90.0) container136
    setColour in138 "#sample"
    hide in138
    knob139 <- knob' (input19 ++ "." ++ "result") (-384.0,84.0) container136
    out140 <- plugout' (lfo36 ++ "." ++ "square_result") (-348.0,-72.0) container136
    setColour out140 "#control"
    out141 <- plugout' (lfo36 ++ "." ++ "triangle") (-408.0,-108.0) container136
    setColour out141 "#control"
    out142 <- plugout' (lfo36 ++ "." ++ "saw") (-348.0,-108.0) container136
    setColour out142 "#control"
    out143 <- plugout' (lfo36 ++ "." ++ "sin_result") (-408.0,-72.0) container136
    setColour out143 "#control"
    container144 <- container' "panel_3x1.bmp" (336.0,0.0) root
    in145 <- plugin' (vca41 ++ "." ++ "cv") (319.0,29.0) container144
    setColour in145 "#sample"
    hide in145
    in146 <- plugin' (vca41 ++ "." ++ "signal") (312.0,-24.0) container144
    setColour in146 "#sample"
    knob147 <- knob' (input25 ++ "." ++ "result") (312.0,24.0) container144
    label148 <- label' "vca" (312.0,84.0) container144
    out149 <- plugout' (vca41 ++ "." ++ "result") (360.0,0.0) container144
    setColour out149 "#sample"
    container150 <- container' "panel_ladder.bmp" (12.0,312.0) root
    in151 <- plugin' (ladder33 ++ "." ++ "signal") (-36.0,192.0) container150
    setColour in151 "#sample"
    in152 <- plugin' (sum37 ++ "." ++ "signal1") (61.0,389.0) container150
    setColour in152 "#sample"
    hide in152
    in153 <- plugin' (sum37 ++ "." ++ "signal2") (12.0,384.0) container150
    setColour in153 "#control"
    in154 <- plugin' (ladder33 ++ "." ++ "freq") (35.0,343.0) container150
    setColour in154 "#sample"
    hide in154
    in155 <- plugin' (ladder33 ++ "." ++ "res") (58.0,306.0) container150
    setColour in155 "#sample"
    hide in155
    knob156 <- knob' (input26 ++ "." ++ "result") (60.0,324.0) container150
    knob157 <- knob' (input27 ++ "." ++ "result") (60.0,384.0) container150
    out158 <- plugout' (ladder33 ++ "." ++ "result") (60.0,192.0) container150
    setColour out158 "#sample"
    out159 <- plugout' (sum37 ++ "." ++ "result") (-23.0,346.0) container150
    setColour out159 "#sample"
    hide out159
    container160 <- container' "panel_ladder.bmp" (12.0,12.0) root
    in161 <- plugin' (ladder34 ++ "." ++ "signal") (-36.0,-108.0) container160
    setColour in161 "#sample"
    in162 <- plugin' (sum38 ++ "." ++ "signal1") (50.0,80.0) container160
    setColour in162 "#sample"
    hide in162
    in163 <- plugin' (sum38 ++ "." ++ "signal2") (12.0,84.0) container160
    setColour in163 "#control"
    in164 <- plugin' (ladder34 ++ "." ++ "freq") (24.0,34.0) container160
    setColour in164 "#sample"
    hide in164
    in165 <- plugin' (ladder34 ++ "." ++ "res") (47.0,-3.0) container160
    setColour in165 "#sample"
    hide in165
    knob166 <- knob' (input28 ++ "." ++ "result") (60.0,24.0) container160
    knob167 <- knob' (input29 ++ "." ++ "result") (60.0,84.0) container160
    out168 <- plugout' (ladder34 ++ "." ++ "result") (60.0,-108.0) container160
    setColour out168 "#sample"
    out169 <- plugout' (sum38 ++ "." ++ "result") (-34.0,37.0) container160
    setColour out169 "#sample"
    hide out169
    container170 <- container' "panel_ladder.bmp" (12.0,-288.0) root
    in171 <- plugin' (ladder35 ++ "." ++ "freq") (35.0,-262.0) container170
    setColour in171 "#sample"
    hide in171
    in172 <- plugin' (ladder35 ++ "." ++ "res") (58.0,-299.0) container170
    setColour in172 "#sample"
    hide in172
    in173 <- plugin' (ladder35 ++ "." ++ "signal") (-36.0,-408.0) container170
    setColour in173 "#sample"
    in174 <- plugin' (sum39 ++ "." ++ "signal1") (61.0,-216.0) container170
    setColour in174 "#sample"
    hide in174
    in175 <- plugin' (sum39 ++ "." ++ "signal2") (12.0,-216.0) container170
    setColour in175 "#control"
    knob176 <- knob' (input30 ++ "." ++ "result") (60.0,-276.0) container170
    knob177 <- knob' (input31 ++ "." ++ "result") (60.0,-216.0) container170
    out178 <- plugout' (ladder35 ++ "." ++ "result") (60.0,-408.0) container170
    setColour out178 "#sample"
    out179 <- plugout' (sum39 ++ "." ++ "result") (-23.0,-259.0) container170
    setColour out179 "#sample"
    hide out179
    container45 <- container' "panel_4x1.bmp" (240.0,12.0) root
    in46 <- plugin' (sum440 ++ "." ++ "signal1") (216.0,96.0) container45
    setColour in46 "#sample"
    in47 <- plugin' (sum440 ++ "." ++ "signal2") (216.0,36.0) container45
    setColour in47 "#sample"
    in48 <- plugin' (sum440 ++ "." ++ "signal3") (216.0,-12.0) container45
    setColour in48 "#sample"
    in49 <- plugin' (sum440 ++ "." ++ "signal4") (216.0,-60.0) container45
    setColour in49 "#sample"
    label50 <- label' "sum4" (216.0,96.0) container45
    out51 <- plugout' (sum440 ++ "." ++ "result") (252.0,12.0) container45
    setColour out51 "#sample"
    container52 <- container' "panel_3x1.bmp" (144.0,312.0) root
    in53 <- plugin' (vca42 ++ "." ++ "cv") (126.0,334.0) container52
    setColour in53 "#sample"
    hide in53
    in54 <- plugin' (vca42 ++ "." ++ "signal") (120.0,288.0) container52
    setColour in54 "#sample"
    knob55 <- knob' (input32 ++ "." ++ "result") (120.0,336.0) container52
    label56 <- label' "vca" (120.0,384.0) container52
    out57 <- plugout' (vca42 ++ "." ++ "result") (168.0,312.0) container52
    setColour out57 "#sample"
    container58 <- container' "panel_3dda.bmp" (-240.0,12.0) root
    in59 <- plugin' (id14 ++ "." ++ "signal") (-276.0,108.0) container58
    setColour in59 "#control"
    in60 <- plugin' (id15 ++ "." ++ "signal") (-276.0,48.0) container58
    setColour in60 "#control"
    in61 <- plugin' (id16 ++ "." ++ "signal") (-276.0,0.0) container58
    setColour in61 "#control"
    in62 <- plugin' (id17 ++ "." ++ "signal") (-276.0,-48.0) container58
    setColour in62 "#control"
    in63 <- plugin' (id6 ++ "." ++ "signal") (-278.0,-103.0) container58
    setColour in63 "#sample"
    hide in63
    in64 <- plugin' (id13 ++ "." ++ "signal") (-228.0,108.0) container58
    setColour in64 "#control"
    in65 <- plugin' (id10 ++ "." ++ "signal") (-235.0,49.0) container58
    setColour in65 "#sample"
    hide in65
    in66 <- plugin' (id11 ++ "." ++ "signal") (-235.0,-3.0) container58
    setColour in66 "#sample"
    hide in66
    in67 <- plugin' (id12 ++ "." ++ "signal") (-234.0,-53.0) container58
    setColour in67 "#sample"
    hide in67
    knob68 <- knob' (input21 ++ "." ++ "result") (-228.0,48.0) container58
    knob69 <- knob' (input24 ++ "." ++ "result") (-276.0,-108.0) container58
    knob70 <- knob' (input23 ++ "." ++ "result") (-228.0,-48.0) container58
    knob71 <- knob' (input22 ++ "." ++ "result") (-228.0,0.0) container58
    out72 <- plugout' (id7 ++ "." ++ "result") (-192.0,48.0) container58
    setColour out72 "#control"
    out73 <- plugout' (id8 ++ "." ++ "result") (-192.0,0.0) container58
    setColour out73 "#control"
    out74 <- plugout' (id9 ++ "." ++ "result") (-192.0,-48.0) container58
    setColour out74 "#control"
    proxy75 <- proxy' (-196.0,-102.0) container58
    hide proxy75
    container105 <- container' "panel_4x1.bmp" (-89.0,-14.0) proxy75
    in106 <- plugin' (dda1 ++ "." ++ "reset") (-110.0,61.0) container105
    setColour in106 "#sample"
    in107 <- plugin' (dda1 ++ "." ++ "clock") (-110.0,11.0) container105
    setColour in107 "#sample"
    in108 <- plugin' (dda1 ++ "." ++ "phase") (-110.0,-39.0) container105
    setColour in108 "#sample"
    in109 <- plugin' (dda1 ++ "." ++ "dy") (-110.0,-89.0) container105
    setColour in109 "#sample"
    label110 <- label' "dda" (-114.0,61.0) container105
    out111 <- plugout' (dda1 ++ "." ++ "trigger") (-69.0,-14.0) container105
    setColour out111 "#sample"
    container76 <- container' "panel_4x1.bmp" (-95.0,-308.0) proxy75
    in77 <- plugin' (dda2 ++ "." ++ "reset") (-116.0,-233.0) container76
    setColour in77 "#sample"
    in78 <- plugin' (dda2 ++ "." ++ "clock") (-116.0,-283.0) container76
    setColour in78 "#sample"
    in79 <- plugin' (dda2 ++ "." ++ "phase") (-116.0,-333.0) container76
    setColour in79 "#sample"
    in80 <- plugin' (dda2 ++ "." ++ "dy") (-116.0,-383.0) container76
    setColour in80 "#sample"
    label81 <- label' "dda" (-120.0,-233.0) container76
    out82 <- plugout' (dda2 ++ "." ++ "trigger") (-75.0,-308.0) container76
    setColour out82 "#sample"
    container83 <- container' "panel_3x1.bmp" (196.0,318.0) proxy75
    in84 <- plugin' (gate4 ++ "." ++ "length") (175.0,343.0) container83
    setColour in84 "#sample"
    in85 <- plugin' (gate4 ++ "." ++ "trigger") (175.0,293.0) container83
    setColour in85 "#sample"
    label86 <- label' "gate" (171.0,393.0) container83
    out87 <- plugout' (gate4 ++ "." ++ "gate") (216.0,318.0) container83
    setColour out87 "#sample"
    container88 <- container' "panel_3x1.bmp" (191.0,-340.0) proxy75
    in89 <- plugin' (gate5 ++ "." ++ "length") (170.0,-315.0) container88
    setColour in89 "#sample"
    in90 <- plugin' (gate5 ++ "." ++ "trigger") (170.0,-365.0) container88
    setColour in90 "#sample"
    label91 <- label' "gate" (166.0,-265.0) container88
    out92 <- plugout' (gate5 ++ "." ++ "gate") (211.0,-340.0) container88
    setColour out92 "#sample"
    container93 <- container' "panel_3x1.bmp" (191.0,-74.0) proxy75
    in94 <- plugin' (gate3 ++ "." ++ "length") (170.0,-49.0) container93
    setColour in94 "#sample"
    in95 <- plugin' (gate3 ++ "." ++ "trigger") (170.0,-99.0) container93
    setColour in95 "#sample"
    label96 <- label' "gate" (166.0,1.0) container93
    out97 <- plugout' (gate3 ++ "." ++ "gate") (211.0,-74.0) container93
    setColour out97 "#sample"
    container98 <- container' "panel_4x1.bmp" (-87.0,281.0) proxy75
    in100 <- plugin' (dda0 ++ "." ++ "clock") (-108.0,306.0) container98
    setColour in100 "#sample"
    in101 <- plugin' (dda0 ++ "." ++ "phase") (-108.0,256.0) container98
    setColour in101 "#sample"
    in102 <- plugin' (dda0 ++ "." ++ "dy") (-108.0,206.0) container98
    setColour in102 "#sample"
    in99 <- plugin' (dda0 ++ "." ++ "reset") (-108.0,356.0) container98
    setColour in99 "#sample"
    label103 <- label' "dda" (-112.0,356.0) container98
    out104 <- plugout' (dda0 ++ "." ++ "trigger") (-67.0,281.0) container98
    setColour out104 "#sample"
    in112 <- plugin' (id7 ++ "." ++ "signal") (465.0,55.0) proxy75
    setColour in112 "#sample"
    in113 <- plugin' (id8 ++ "." ++ "signal") (465.0,4.0) proxy75
    setColour in113 "#sample"
    in114 <- plugin' (id9 ++ "." ++ "signal") (462.0,-46.0) proxy75
    setColour in114 "#sample"
    out115 <- plugout' (id14 ++ "." ++ "result") (-500.0,134.0) proxy75
    setColour out115 "#sample"
    out116 <- plugout' (id15 ++ "." ++ "result") (-500.0,84.0) proxy75
    setColour out116 "#sample"
    out117 <- plugout' (id16 ++ "." ++ "result") (-499.0,30.0) proxy75
    setColour out117 "#sample"
    out118 <- plugout' (id17 ++ "." ++ "result") (-497.0,-19.0) proxy75
    setColour out118 "#sample"
    out119 <- plugout' (id6 ++ "." ++ "result") (-497.0,-71.0) proxy75
    setColour out119 "#sample"
    out120 <- plugout' (id13 ++ "." ++ "result") (-414.0,134.0) proxy75
    setColour out120 "#sample"
    out121 <- plugout' (id10 ++ "." ++ "result") (-435.0,48.0) proxy75
    setColour out121 "#sample"
    out122 <- plugout' (id11 ++ "." ++ "result") (-435.0,20.0) proxy75
    setColour out122 "#sample"
    out123 <- plugout' (id12 ++ "." ++ "result") (-434.0,-4.0) proxy75
    setColour out123 "#sample"
    in180 <- plugin' (out ++ "." ++ "value") (564.0,72.0) root
    setColour in180 "#sample"
    out181 <- plugout' (keyboard ++ "." ++ "result") (-492.0,132.0) root
    setColour out181 "#sample"
    out182 <- plugout' (trigger ++ "." ++ "result") (-492.0,24.0) root
    setColour out182 "#sample"
    cable knob127 in125
    cable out178 in126
    cable knob133 in131
    cable out168 in132
    cable knob139 in138
    cable knob147 in145
    cable out51 in146
    cable out72 in151
    cable knob157 in152
    cable out159 in154
    cable knob156 in155
    cable out73 in161
    cable knob167 in162
    cable out169 in164
    cable knob166 in165
    cable out179 in171
    cable knob176 in172
    cable out74 in173
    cable knob177 in174
    cable out57 in46
    cable out135 in47
    cable out129 in48
    cable knob55 in53
    cable out158 in54
    cable out140 in59
    cable knob69 in63
    cable knob68 in65
    cable knob71 in66
    cable knob70 in67
    cable out120 in106
    cable out115 in107
    cable out117 in108
    cable out122 in109
    cable out120 in77
    cable out115 in78
    cable out118 in79
    cable out123 in80
    cable out119 in84
    cable out104 in85
    cable out119 in89
    cable out82 in90
    cable out119 in94
    cable out111 in95
    cable out115 in100
    cable out116 in101
    cable out121 in102
    cable out120 in99
    cable out87 in112
    cable out97 in113
    cable out92 in114
    cable out149 in180
    recompile
    set knob127 (2.0)
    set knob133 (2.0)
    set knob139 (5.802963)
    set knob147 (2.2610939)
    set knob156 (3.96)
    set knob157 (0.0)
    set knob166 (3.96)
    set knob167 (5.8333334e-2)
    set knob176 (3.99)
    set knob177 (0.2)
    set knob55 (2.06)
    set knob68 (0.2)
    set knob69 (0.1550057)
    set knob70 (0.41)
    set knob71 (0.305)
    return ()
    bind '!' "alert"
    bind '#' "sharpen"
    bind '%' "setcolour"
    bind '-' "setmin"
    bind '0' "setzero"
    bind '1' "setone"
    bind '<' "setmin"
    bind '=' "setvalue"
    bind '>' "setmax"
    bind 'A' "noteA"
    bind 'B' "noteB"
    bind 'C' "noteC"
    bind 'D' "noteD"
    bind 'E' "noteE"
    bind 'F' "noteF"
    bind 'G' "noteG"
    bind 'H' "unhide"
    bind 'P' "unparent"
    bind '\\' "nolimits"
    bind 'a' "addknob"
    bind 'b' "flatten"
    bind 'd' "delete"
    bind 'h' "hide"
    bind 'm' "relocate"
    bind 'n' "rename"
    bind 'p' "up"
    bind 'u' "hide"
    bind 'z' "check"
    bind '|' "quantise"
