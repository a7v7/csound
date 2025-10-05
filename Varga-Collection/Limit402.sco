t 0.00	60.000

i 1	0.0000	30.000	; length in seconds

;------------------------------------------------------------------------------
f 64 0 8 -2	1.4	; output gain
		0.5	; max. level
		0.02	; time diff. between envelope and audio signal (sec.)
		0.01	; envelope decay speed (0..1)
		0.0001	; envelope attack speed
		25	; envelope lowpass filter frequency (Hz)
;------------------------------------------------------------------------------

e	; END OF SCORE
