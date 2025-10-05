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
;   Sta  Dur  Amp  Pitch  SoundIn  OutCh
;i2  0.0  2.7  0.0  .5     5      1

; Small Room Reverb
;    Sta  Dur  Amp  InCh
;i21  0.0  2.2  1.0  1

; Medium Room Reverb
;    Sta  Dur  Amp  InCh
;i22  0.0  2.5  1.0  1

; Large Room Reverb
;    Sta  Dur  Amp  InCh
;i23  0.0  2.8  1.0  1

; Sound In Stereo
;   Sta  Dur  Amp  Pitch  SoundIn  OutCh1  OutCh2
;i3  0.0  8.69 0.8  1      11       1       2

; Sound In Mono
;   Sta  Dur  Amp  Pitch  SoundIn  OutCh
;i2  0.0  1.0  0.0  1      11       1

; Simple Sine
;   Sta  Dur  Amp    Pitch  Table  OutCh
;i6  0.0  1.7  10000  9.00   2      1

; Simple Sum
;  Sta  Dur  InCh1  InCh2  OutCh
;i8 0    4.0  1      2      3

; Sound In Stereo
;   Sta  Dur   Amp  Pitch  SoundIn  OutCh
i2  0.0  20.43 0.8  .3628  "vocestereo.aiff"      1

; 2D Echos X, Y in meters
;    Sta  Dur  Amp  EarX  EarY  SourceX  SourceY  WallX  WallY  InCh  OutCh1  OutCh2
i17  0.0  22   4    10    12    34       17       46     60     1     2       3

;Large Room Reverb
;    Sta  Dur  Amp  InCh  Decay  Densty1  Densty2  PreFilt  HiPass  LoPass  OutCh
i27  0.0  22   .5   2     1.50   .80      1.4      10000    5100    200     6
i27  0.0  22   .5   3     1.52   .82      1.5      10100    5000    210     7
;i27  0.0  5.0  .2   4     1.50   .80      1.4      10000    5100    200     8
;i27  0.0  5.0  .2   5     1.52   .82      1.5      10100    5000    210     9

; Reverb Mixer
;    Sta  Dur  Amp  InCh1  InCh2
i91  0    22   1    6      7
;i91  0    5.0  1    8      9

; Clear Zak
;    Sta  Dur
i99  0.0  22

