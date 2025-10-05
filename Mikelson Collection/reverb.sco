; 1. NOISE CLICK
; 2. DISK INPUT
; 8. SIMPLE SUM
; 9. FEEDBACK FILTER
;10. DELAY
;11. SIMPLE ALL-PASS FILTER
;12. NESTED ALL-PASS FILTER
;13. DOUBLE NESTED ALL-PASS FILTER
;15. OUTPUT 

;-------------------------------------------------------------------------------
; NO REVERB
;-------------------------------------------------------------------------------
;   Sta  	Dur  	Amp  	Pitch	 	SoundIn		OutCh
i2  0.0  	4.0  	0.8  	1	 		11			1

;-------------------------------------------------------------------------------
; SMALL ROOM
;-------------------------------------------------------------------------------
;   Sta  	Dur  	Amp  	Pitch	 	SoundIn		OutCh
i2  4.5  	4.0  	0.8  	1	 		11			1

;   Sta  	Dur  	Fco  	Gain			InCh1  		InCh2  	OutCh
i9  4.5  	4.5  	4200 	.3			1	  		5	    	2

;   Sta  	Dur  	Time		Gain	 		InCh  		OutCh
i10 4.5  	4.5  	24		1.0	 		2	  		3

;   Sta  	Dur  	Time1	Gain1  		Time2		Gain2  	Time3  Gain3	 InCh  OutCh
i13 4.5  4.5  		35	 	.15	   		22			.25	  	8.3    .30	 3	  4

;   Sta  	Dur  	Gain	 	InCh
i15 4.5  	4.5  	.5	 	4

;   Sta  	Dur  	Time1	Gain1  		Time2		Gain2  	InCh   OutCh
i12 4.5  	4.5  	66	 	.08	   		30			.3	  	4	  5

;   Sta  	Dur  	Gain	 	InCh
i15 4.5  	4.5  	.5	 	5

;-------------------------------------------------------------------------------
; MEDIUM ROOM
;-------------------------------------------------------------------------------
;   Sta  	Dur  	Amp  	Pitch	 	SoundIn		OutCh
i2  9.0  	4.0  	0.7  	1	 		11			1

;   Sta  	Dur  	Fco  	Gain			InCh1  		InCh2  	OutCh
i9  9.0  	4.5  	2500 	.4			1	  		10	    	2

;   Sta  	Dur  	Time1	Gain1  		Time2		Gain2  	Time3  Gain3	 InCh  OutCh
i13 9.0  	4.5  	35	 	.25	   		8.3			.35	  	22	  .45	 2	  3

;   Sta  	Dur  	Gain	 	InCh
i15 9.0  	4.5  	.4	 	3

;   Sta  	Dur  	Time		Gain	 		InCh  		OutCh
i10 9.0  	4.5  	5		1.0	 		3	  		4

;   Sta  	Dur  	Time1	Gain1  		InCh  		OutCh
i11 9.0  	4.5  	30	 	.45	   		4	    		5

;   Sta  	Dur  	Time		Gain	 		InCh  		OutCh
i10 9.0  	4.5  	67		1.0	 		5	  		6

;   Sta  	Dur  	Gain	 	InCh
i15 9.0  	4.5  	.4	 	6
	
;   Sta  	Dur  	Time		Gain	 		InCh  		OutCh
i10 9.0  	4.5  	15		.4	 		6	  		7

;   Sta  	Dur  	InCh1	InCh2  		OutCh
i8  9.0  	4.5  	1	 	7	   		8

;   Sta  	Dur  	Time1	Gain1  		Time2		Gain2  	InCh  OutCh
i12 9.0  	4.5  	39	 	.25	   		9.8			.35	  	8	 9

;   Sta  	Dur  	Gain	 	InCh
i15 9.0  	4.5  	.4	 	9

;   Sta  	Dur  	Time		Gain	 		InCh  		OutCh
i10 9.0  	4.5  	108		1.0	 		9	  		10

;-------------------------------------------------------------------------------
; LARGE ROOM
;-------------------------------------------------------------------------------
;   Sta  	Dur  	Amp  	Pitch	 	SoundIn		OutCh
i2  14   	4.0  	0.5  	1	 		11			1

;   Sta  	Dur  	Fco  	Gain			InCh1  		InCh2  	OutCh
i9  14   	4.5  	2600 	.4			1	  		10	    	2

;   Sta  	Dur  	Time1	Gain1  		InCh  	OutCh
i11 14   	4.5  	8	 	.3	   		2	    	3

;   Sta  	Dur  	Time1	Gain1  		InCh  	OutCh
i11 14   	4.5  	12	 	.3	   		3	    	4

;   Sta  	Dur  	Time		Gain	 		InCh  	OutCh
i10 14   	4.5  	4		1.0	 		4	  	5

;   Sta  	Dur  	Gain	 	InCh
i15 14   	4.5  	1.36	 	5
	
;   Sta  	Dur  	Time		Gain	 		InCh  	OutCh
i10 14   	4.5  	17		1.0	 		5	  	6

;   Sta  	Dur  	Time1	Gain1  		Time2	Gain2  InCh  	OutCh
i12 14   	4.5  	87	 	.5	   		62		.25	  6	   	7

;   Sta  	Dur  	Time		Gain	 		InCh  	OutCh
i10 14   	4.5  	31		1.0	 		7	  	8

;   Sta  	Dur  	Gain	 	InCh
i15 14   	4.5  	.56	 	8

;   Sta  	Dur  	Time		Gain	 		InCh  	OutCh
i10 14   	4.5  	3		1.0	 		8	  	9

;   Sta 	Dur  	Time1	Gain1  		Time2	Gain2  Time3  	Gain3	 InCh  	OutCh
i13 14   	4.5  	120	 	.5	   		76		.25	  30	    	.25	 	 9	  	10

;   Sta  	Dur  	Gain	 	InCh
i15 14   	4.5  	.56	 	10




