t 0.00	60.000

i 90	0.0000	30.000	; length in seconds

;------------------------------------------------------------------------------
f 64 0 16 -2	1.4	; output gain
		0.6	; 1. max. level			1st limiter
		20	; 1. delay time in ms
		0.01	; 1. decay speed (0..1)
		0.0001	; 1. attack speed
		25	; 1. lowpass filter freq.
		0.6	; 2. max. level			2nd limiter
		2.5	; 2. delay time in ms
		0.5	; 2. decay speed (0..1)
		0.0025	; 2. attack speed
		200	; 2. lowpass filter freq.
;------------------------------------------------------------------------------

f 232 0 129 1	"AMPTABLE.DAT"	0 6 0

e	; END OF SCORE
