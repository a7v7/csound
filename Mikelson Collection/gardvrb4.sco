;-------------------------------------------------------------------------------
; Reverbs derived from those presented by Bill Gardner
; using nested all-pass filters.
; Coded by Hans Mikelson 1998
;-------------------------------------------------------------------------------

; 1. Noise Click
; 2. Disk Input Mono
; 3. Disk Input Stereo
; 8. Simple Sum
; 9. Feedback Filter
;10. Delay
;11. Simple All-Pass Filter
;12. Nested All-Pass Filter
;13. Double Nested All-Pass Filter
;15. Output
;17. 2D First Echo
;21. Small Room Reverb
;22. Medium Room Reverb
;23. Large Room Reverb
;25. Small Room Reverb with controls
;26. Medium Room Reverb with controls
;27. Large Room Reverb with controls

f1  0 65536  10 1
f2  0 65536  10 1 .1 .2  .4  .1  .5

;-------------------------------------------------------------------------------

; Click
;   Sta  Dur   Amp    OutCh  Fco
i1  0.0  .1    25000  1      8000

; Single Nested All-Pass Filter
;    Sta  Dur  Fco    Gain   InCh1  InCh2  OutCh
i9   0    2.5  600    .4     1      7      2
;    Sta  Dur  Time1  Gain1  Time2  Gain2  InCh  OutCh  Fco
i14  0    2.5  37     .4     19     .4     2     3      1500
i14  0    2.5  53     .55    31     .55    3     4      1100
i14  0    2.5  104    .7     61     .7     4     5      700
i14  0    2.5  174    .8     91     .8     5     6      400
; Delay
i10  0    2.5  102    1                    6     7

; Reverb Mixer
;    Sta  Dur  Amp  InCh1  InCh2
;i91  0    2.5  1.5  2      2
;i91  0    2.5  3.0  3      3
;i91  0    2.5  4.5  4      4
i91  0    2.5  6.0  6      6

; Clear Zak
;    Sta  Dur
;i99  0.0  2.5

