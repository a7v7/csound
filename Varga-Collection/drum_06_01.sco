
t 0 150.00	/* tempo */

i 90 0 18.0	/* output instrument */

i 1	0.0000	0.4000	32	127
i 1	0.9900	0.4000	32	120
i 1	1.9800	0.4000	32	124
i 1	2.9800	0.4000	32	116
i 1	4.0000	0.4000	32	127
i 1	4.9900	0.4000	32	120
i 1	5.9800	0.4000	32	124
i 1	6.9800	0.4000	32	116
i 1	8.0000	0.4000	32	127
i 1	8.9900	0.4000	32	120
i 1	9.9800	0.4000	32	124
i 1	10.980	0.4000	32	116
i 1	12.000	0.4000	32	127
i 1	12.990	0.4000	32	120
i 1	13.980	0.4000	32	124
i 1	14.980	0.4000	32	116

/* ------------------------------------------------------------------------- */

f 64 0 128 -2	3500.0		/* output volume			*/
		150.0		/* tempo				*/

		4.3333		/* oscillator start freq. 1 / note frq.	*/
		8.0		/* osc. frq. 1 decay speed at max. vel.	*/
		16.0		/* osc. freq. 1 max. decay speed	*/
		96		/* note velocity for max. decay speed	*/
		1.0		/* oscillator start freq. 2 / note frq.	*/
		2.0		/* osc. freq. 2 decay speed		*/
		0.0		/* oscillator start freq. 3 / note frq.	*/
		1.0		/* osc. freq. 3 decay speed		*/
		0.0		/* oscillator start freq. 4 / note frq.	*/
		1.0		/* osc. freq. 4 decay speed		*/

		0		/* lowpass filter start freq. 1 (Hz)	*/
		1		/* lowpass filter freq. 1 decay speed	*/
		3000.0		/* lowpass filter start freq. 2 (Hz)	*/
		256.0		/* lowpass filter freq. 2 decay speed	*/
		48.0		/* LP filter start freq. 3 / note frq.	*/
		64.0		/* lowpass filter freq. 3 decay speed	*/
		16.0		/* LP filter start freq. 4 / note frq.	*/
		10.0		/* lowpass filter freq. 4 decay speed	*/

		2.0		/* EQ 1 frequency / osc. frequency	*/
		0		/* EQ 1 frequency / note frequency	*/
		0		/* EQ 1 frequency (Hz)			*/
		0.0		/* EQ 1 level				*/
		1.0		/* EQ 1 Q				*/
		1		/* EQ 1 mode (0:peak,1:low,2:high)	*/
		0.0		/* EQ input mix to EQ output		*/
		0.5		/* EQ 1 mix to EQ output		*/

		4.0		/* EQ 2 frequency / osc. frequency	*/
		0		/* EQ 2 frequency / note frequency	*/
		0		/* EQ 2 frequency (Hz)			*/
		0.0		/* EQ 2 level				*/
		0.7071		/* EQ 2 Q				*/
		1		/* EQ 2 mode (0:peak,1:low,2:high)	*/
		1		/* EQ 2 input (0: EQ 1, 1: EQ input)	*/
		-4.0		/* EQ 2 mix to EQ output		*/

		1.0		/* EQ 3 frequency / osc. frequency	*/
		0		/* EQ 3 frequency / note frequency	*/
		0		/* EQ 3 frequency (Hz)			*/
		0.25		/* EQ 3 level				*/
		1.0		/* EQ 3 Q				*/
		1		/* EQ 3 mode (0:peak,1:low,2:high)	*/
		1		/* EQ 3 input (0: EQ 2, 1: EQ input)	*/
		0.0		/* EQ 3 mix to EQ output		*/

		0		/* EQ 4 frequency / osc. frequency	*/
		1.5		/* EQ 4 frequency / note frequency	*/
		0		/* EQ 4 frequency (Hz)			*/
		2.0		/* EQ 4 level				*/
		1.0		/* EQ 4 Q				*/
		0		/* EQ 4 mode (0:peak,1:low,2:high)	*/
		0		/* EQ 4 input (0: EQ 3, 1: EQ input)	*/
		1.5		/* EQ 4 mix to EQ output		*/

		0.25		/* noise mix				*/

		0		/* noise EQ 1 frequency / osc. freq.	*/
		0		/* noise EQ 1 frequency / note freq.	*/
		1000		/* noise EQ 1 frequency (Hz)		*/
		1.0		/* noise EQ 1 level			*/
		0.7071		/* noise EQ 1 Q				*/
		0		/* noise EQ 1 mode (0:peak,1:lo,2:hi)	*/

		0		/* noise EQ 2 frequency / osc. freq.	*/
		0		/* noise EQ 2 frequency / note freq.	*/
		1000		/* noise EQ 2 frequency (Hz)		*/
		1.0		/* noise EQ 2 level			*/
		0.7071		/* noise EQ 2 Q				*/
		0		/* noise EQ 2 mode (0:peak,1:lo,2:hi)	*/

		48	55	/* MIDI key range for panning		*/
		0	0	/* azimuth range			*/
		0	0	/* elevation range			*/
		0.5	0.5	/* distance range			*/

/* ------------------------------------------------------------------------- */

f 1 0 262144 10 1

e	/* end of score */


