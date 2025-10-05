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

; Sound In Stereo
;   Sta  Dur   Amp  Pitch  SoundIn  OutCh
i3  0.0  58.69  0.0  1      16       1    8

; 2D Echos X, Y in meters
;    Sta  Dur   Amp  EarX  EarY  SourceX  SourceY  WallX  WallY  InCh  OutCh1  OutCh2
i18  0.0  60    4    80    42    84       47       146    260     1     2       3

;Large Room Reverb
;    Sta  Dur   Amp  InCh  Decay  Densty1  Densty2  PreFilt  HiPass  LoPass  OutCh
i27  0.0  60    .05  2     1.50   .80      1.4      10000    5100    200     6
i27  0.0  60    .05  3     1.52   .82      1.5      10100    5000    210     7

; Reverb Mixer
;    Sta  Dur  Amp  InCh1  InCh2
i91  0    60   1    6      7

; Clear Zak
;    Sta  Dur
i99  0.0  60

