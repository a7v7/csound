;===========================================;
;       STRAIGHT MIXING INSTRUMENT          ;
;       P4 = FILE A     P5 = FILE B         ;
;       P6 = A RISE     P7 = A DECAY        ;
;       P8 = B RISE     P9 = B DECAY        ;
;===========================================;
;                       soundA  soundB  riseA   decA    riseB   decB
i01     0       4       5       6       .01     3.99    3       1
s
; Sample File is Soundin.5 -- no rescaling
f1  	0   	32768  	-1   	5   	0
;===========================================;
;        PITCH CHANGING INSTRUMENT          ;
;       P4 = SOUNDIN #  P5 = DESIRED PITCH  ;
;       P6 = OLD PITCH  P7 = ORIGINAL SR    ;
;===========================================;
i02 	0   	4   	5   	5.01    6.00    18900
i02     4   	2   	6.00    7.00
i02 	6   	3   	5   	4.06
e
