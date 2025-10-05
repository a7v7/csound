;------------------------------------------------------------------------------
; MODIFIED HYPERBOLIC TANGENT DISTORTION
; CODED BY HANS MIKELSON OCTOBER 1998
;------------------------------------------------------------------------------
f1 0 8192 10 1

; SINE
;    Sta   Dur  Amp    Pitch  Table  OutCh
i2   0.0   .2   10000  7.00   1      1

; DISTORTION
;    Sta  Dur   Overdrive  Gain  Shape1  Shape2  Rect  InCh  OutCh  Output
i11  0    .2    4          .5    0       .1      .5    1     2      1

; ZAK CLEAR
i99  0    .2

