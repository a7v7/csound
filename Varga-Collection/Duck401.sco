t 0.00	120.000	; tempo

i 1	0.0000	10.000	; 1. input file
i 2	0.0000	10.000	; 2. input file (compressed)

i 90	0.0000	10.000	; total length in beats

;------------------------------------------------------------------------------
f 64 0 16 -2	1.0	; output gain			COMPRESSOR PARAMETERS
		0.5	; threshold level (RMS)
		1.0	; compression ratio below thr. level
		1.0	; compression ratio above thr. level
		0.02	; time diff. between envelope and audio signal (sec.)
		100	; RMS envelope attack speed
		100	; RMS envelope decay speed
		25	; envelope lowpass filter frequency (Hz)
		1.0	; 1. input file gain		INPUT FILE PARAMETERS
		0.000	; 1. input file start position (sec.)
		1.0	; 2. input file gain
		0.000	; 2. input file start position (sec.)
		1.0	; 1. file RMS level to 2. file threshold
		0.25	; min. thr. level of compressor of 2nd input file
;------------------------------------------------------------------------------

e	; END OF SCORE
