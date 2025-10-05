;   idur = p3
;   iexpstrt = p4             ; range = .0000001 to 1
;   iexpend = p5              ; range = .0000001 to 1
;   input = p6               ; soundin.x -   x = numbers from 1 to 10 

i1   0    2.6    1      .001
s
f0 2                               ; 2 seconds of silence
s
i1   0    2.6    .001    1
s
f0 2                               ; 2 seconds of silence
s
i2   0    2.6     1     .0001  6    ; read in the file named - soundin.6
s
f0 2                               ; 2 seconds of silence
s
i2   0    2.6     1     .0001  5    ; read in the file named - soundin.5
e
