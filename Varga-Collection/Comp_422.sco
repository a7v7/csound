t 0.00	60.000

i 1	0.0000	30.000	; length in seconds

;------------------------------------------------------------------------------
f 64 0 16 -2	1.4	; output gain
		10	; min. frequency
		21000	; max. frequency
		0.5	; threshold level (RMS)
		1.0	; compressed band gain
		1.0	; compression ratio below thr. level
		1.0	; compression ratio above thr. level
		0.02	; time diff. between envelope and audio signal (sec.)
		100	; RMS envelope attack speed
		100	; RMS envelope decay speed
		25	; envelope lowpass filter frequency (Hz)
;------------------------------------------------------------------------------

e	; END OF SCORE
