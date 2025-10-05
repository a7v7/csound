
t 0 140.00	/* tempo */

i 90 0 8.0	/* output instrument */

i 1	0.0000	0.5000	56	127
i 1	0.5000	0.5000	56	127
i 1	1.0000	0.5000	56	127
i 1	1.5000	0.5000	56	127
i 1	2.0000	0.2500	49	127
i 1	2.2500	0.5000	49	127
i 1	2.7500	0.5000	49	127
i 1	3.2500	0.2500	49	127
i 1	3.5000	0.2500	44	127
i 1	3.7500	0.7500	44	127

/* ------------------------------------------------------------------------- */

f 64 0 64 -2	3500.0		/* output volume			*/
		140.0		/* tempo				*/

		1.0		/* oscillator start freq. 1 / note frq.	*/
		42.0		/* osc. frq. 1 decay speed at max. vel.	*/
		36.0		/* osc. freq. 1 max. decay speed	*/
		96		/* note velocity for max. decay speed	*/
		1.0		/* oscillator start freq. 2 / note frq.	*/
		0.0001		/* osc. freq. 2 decay speed		*/
		0.0		/* oscillator start freq. 3 / note frq.	*/
		1.0		/* osc. freq. 3 decay speed		*/
		0.0		/* oscillator start freq. 4 / note frq.	*/
		1.0		/* osc. freq. 4 decay speed		*/

		16000		/* lowpass filter start freq. 1 (Hz)	*/
		42		/* lowpass filter freq. 1 decay speed	*/
		0		/* lowpass filter start freq. 2 (Hz)	*/
		1		/* lowpass filter freq. 2 decay speed	*/
		4		/* LP filter start freq. 3 / note frq.	*/
		16.8		/* lowpass filter freq. 3 decay speed	*/
		0		/* LP filter start freq. 4 / note frq.	*/
		1		/* lowpass filter freq. 4 decay speed	*/

		4		/* EQ 1 frequency / osc. frequency	*/
		0		/* EQ 1 frequency / note frequency	*/
		0		/* EQ 1 frequency (Hz)			*/
		2		/* EQ 1 level				*/
		0.7071		/* EQ 1 Q				*/
		2		/* EQ 1 mode (0:peak,1:low,2:high)	*/

		0.5		/* EQ 2 frequency / osc. frequency	*/
		0		/* EQ 2 frequency / note frequency	*/
		0		/* EQ 2 frequency (Hz)			*/
		0.25		/* EQ 2 level				*/
		0.7071		/* EQ 2 Q				*/
		1		/* EQ 2 mode (0:peak,1:low,2:high)	*/

		0.5		/* EQ 3 frequency / osc. frequency	*/
		0		/* EQ 3 frequency / note frequency	*/
		0		/* EQ 3 frequency (Hz)			*/
		4		/* EQ 3 level				*/
		2.0		/* EQ 3 Q				*/
		0		/* EQ 3 mode (0:peak,1:low,2:high)	*/

		0		/* EQ 4 frequency / osc. frequency	*/
		1.0		/* EQ 4 frequency / note frequency	*/
		0		/* EQ 4 frequency (Hz)			*/
		1.4142		/* EQ 4 level				*/
		1.4142		/* EQ 4 Q				*/
		0		/* EQ 4 mode (0:peak,1:low,2:high)	*/

		4.0		/* noise mix				*/

		0		/* noise EQ 1 frequency / osc. freq.	*/
		1		/* noise EQ 1 frequency / note freq.	*/
		0		/* noise EQ 1 frequency (Hz)		*/
		0.25		/* noise EQ 1 level			*/
		0.7071		/* noise EQ 1 Q				*/
		1		/* noise EQ 1 mode (0:peak,1:lo,2:hi)	*/

		0		/* noise EQ 2 frequency / osc. freq.	*/
		4		/* noise EQ 2 frequency / note freq.	*/
		0		/* noise EQ 2 frequency (Hz)		*/
		0.125		/* noise EQ 2 level			*/
		0.7071		/* noise EQ 2 Q				*/
		2		/* noise EQ 2 mode (0:peak,1:lo,2:hi)	*/

		44	56	/* MIDI key range for panning		*/
		-90	-270	/* azimuth range			*/
		0	0	/* elevation range			*/
		1	1	/* distance range			*/

/* ------------------------------------------------------------------------- */

f 1 0 262144 10 1

e	/* end of score */


