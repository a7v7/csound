f1  0 512	  9 1 1 0								;SINE LO-RES
f11 0 2048 10 1								;SINE WAVE hi-res

;THIS IS FOR REVERB SETTINGS
;===========================
;p1		 p2	 p3	 p4		 p5
;instr	strt dur	 rvbtime	 hfdif
i99		0	33	6		.2

;p1		p2		p3	p4		p5	  p6		 p7		 p8
;instr	strt		dur	envamp	kfreq  ipanfrq	 randfrq	 randamp
i2		0.000	10	4000		1000	  10		 15		 20000

i2		8.000	10	8000		1000	  0		 0	      0
