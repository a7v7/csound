
t 0 170.00			/* tempo */

i 90	0.0000	20.000		/* output instr */

;i 1	 0.000	4.0000	28	80
;i 1	 0.000	4.0000	40	127
;i 1	 0.000	4.0000	59	108
;i 1	 0.000	4.0000	64	108
;i 1	 0.000	4.0000	68	108

;i 1	 4.000	4.0000	30	80
;i 1	 4.000	4.0000	42	127
;i 1	 4.000	4.0000	61	108
;i 1	 4.000	4.0000	66	108
;i 1	 4.000	4.0000	70	108

;i 1	 8.000	4.0000	27	80
;i 1	 8.000	4.0000	39	127
;i 1	 8.000	4.0000	58	108
;i 1	 8.000	4.0000	63	108
;i 1	 8.000	4.0000	66	108

;i 1	12.000	4.0000	28	80
;i 1	12.000	4.0000	40	127
;i 1	12.000	4.0000	59	108
;i 1	12.000	4.0000	64	108
;i 1	12.000	4.0000	68	108

i 1	 0.000	16.000	28	80
i 1	 0.000	16.000	40	127
i 1	 0.000	16.000	52	96
i 1	 0.000	16.000	59	108
i 1	 0.000	16.000	64	108
i 1	 0.000	16.000	68	108

/* ------------------------------------------------------------------------- */

f 64 0 64 -2	1000.0		/* volume				*/
		170.0		/* tempo				*/

		1.0		/* osc. 1 mix				*/
		0	0.015	/* osc. 1 FM depth (Hz, rel.)		*/
		0.1	0	/* osc. 1 min. FM frequency (Hz, rel.)	*/
		0.2	0	/* osc. 1 max. FM frequency (Hz, rel.)	*/
		180		/* osc. 1 FM waveform table		*/
		20000	0	/* osc. 1 LP f. at min. FM (Hz, rel.)	*/
		2500	0	/* osc. 1 LP f. at max. FM (Hz, rel.)	*/

		1000	0	/* osc. 1 EQ 1 frequency (Hz, rel.)	*/
		1.0	0.7071	/* osc. 1 EQ 1 level, Q			*/
		0		/* osc. 1 EQ 1 mode (0:peak 1:lo 2:hi)	*/
		1000	0	/* osc. 1 EQ 2 frequency (Hz, rel.)	*/
		1.0	0.7071	/* osc. 1 EQ 2 level, Q			*/
		0		/* osc. 1 EQ 2 mode (0:peak 1:lo 2:hi)	*/

		0.1		/* osc. 2 mix				*/
		0		/* osc. 2 FM depth in Hz		*/
		0.015		/* osc. 2 FM depth / note frequency	*/
		16.0		/* osc. 2 window overlap		*/
		0		/* osc. 2 window size in seconds	*/
		8.0		/* osc. 2 window size * note frequency	*/

		1000	0	/* osc. 2 EQ 1 frequency (Hz, rel.)	*/
		1.0	0.7071	/* osc. 2 EQ 1 level, Q			*/
		0		/* osc. 2 EQ 1 mode (0:peak 1:lo 2:hi)	*/
		1500	0	/* osc. 2 EQ 2 frequency (Hz, rel.)	*/
		0.25	0.7071	/* osc. 2 EQ 2 level, Q			*/
		2		/* osc. 2 EQ 2 mode (0:peak 1:lo 2:hi)	*/

/* ------------------------------------------------------------------------- */

f 65 0 16 -2	0.25		/* envelope attack time / beat time	*/
		1.25		/* envelope max. amplitude		*/
		1.0		/* time in beats to reach max. amp.	*/
		0.5		/* envelope release time / beat time	*/

		1.0		/* oscillator start frequency / note f.	*/
		1.0		/* osc. frequency envelope speed	*/

		0.0025		/* osc. FM (vibrato) depth / note frq.	*/
		10.0		/* FM (vibrato) speed (Hz)		*/
		0.0		/* FM (vibrato) start phase (0..1)	*/
		180		/* FM (vibrato) waveform table		*/

/* ------------------------------------------------------------------------- */

f 66 0 64 -2	0	2	/* output EQ 1 frequency (Hz, rel.)	*/
		1.5	1.0	/* output EQ 1 level, Q			*/
		0		/* output EQ 1 mode (0:peak 1:lo 2:hi)	*/
		3000	0	/* output EQ 2 frequency (Hz, rel.)	*/
		2.0	0.7071	/* output EQ 2 level, Q			*/
		2		/* output EQ 2 mode (0:peak 1:lo 2:hi)	*/
		12000	0	/* output EQ 3 frequency (Hz, rel.)	*/
		4.0	1.0	/* output EQ 3 level, Q			*/
		0		/* output EQ 3 mode (0:peak 1:lo 2:hi)	*/
		5000	0	/* output EQ 4 frequency (Hz, rel.)	*/
		0.5	0.7071	/* output EQ 4 level, Q			*/
		2		/* output EQ 4 mode (0:peak 1:lo 2:hi)	*/

		0	2.0	/* 1st order filter 1 frq. (Hz, rel.)	*/
		0.1		/* 1st order filter 1 level at sr/2	*/
		1000	0	/* 1st order filter 2 frq. (Hz, rel.)	*/
		1.0		/* 1st order filter 2 level at sr/2	*/

/* ------------------------------------------------------------------------- */

f 67 0 16 -2	-90		/* azimuth 1				*/
		-30		/* azimuth 2				*/
		30		/* azimuth 3				*/
		90		/* azimuth 4				*/
		0		/* elevation 1				*/
		0		/* elevation 2				*/
		0		/* elevation 3				*/
		0		/* elevation 4				*/
		2.0		/* distance 1				*/
		2.0		/* distance 2				*/
		2.0		/* distance 3				*/
		2.0		/* distance 4				*/

/* ------------------------------------------------------------------------- */

f 180 0 16384 10 1		/* sine wave				*/

f 1 0 16384 20 3 1		/* window function for osc. 2		*/

/* ------------------------------------------------------------------------- */

e	/* end of score */


