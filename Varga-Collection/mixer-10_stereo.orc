
/* ------------- mixer v1.2 orchestra file (stereo version) ---------------- */

sr	=  44100
kr	=  1378.125
ksmps	=  32
nchnls	=  2

/* ------------------------------------------------------------------------- */

gaxL	init 0
gaxR	init 0

	instr 1

iftnum	=  int(p4+100.5)	/* ftable number			*/
ivol2	=  p5			/* note amplitude			*/
ipnum	=  int(p6+0.5)		/* part number				*/

/* ------------------------------------------------------------------------- */

ivol	table  0, iftnum	/* volume				*/
iskptim	table  1, iftnum	/* skip time				*/
idloffs	table  2, iftnum	/* delay offset				*/

iEQx	table  3, iftnum	/* EQ enable/disable			*/
iEQ1f	table  4, iftnum	/* EQ 1 frequency			*/
iEQ1l	table  5, iftnum	/* EQ 1 level				*/
iEQ1q	table  6, iftnum	/* EQ 1 Q				*/
iEQ1m	table  7, iftnum	/* EQ 1 mode				*/
iEQ2f	table  8, iftnum	/* EQ 2 frequency			*/
iEQ2l	table  9, iftnum	/* EQ 2 level				*/
iEQ2q	table 10, iftnum	/* EQ 2 Q				*/
iEQ2m	table 11, iftnum	/* EQ 2 mode				*/

iflnum	table int(12.5+ipnum), iftnum	/* file number			*/

ilnth	table  1, 1		/* output file length			*/
idelx	table  2, 1		/* output file delay			*/

/* ------------------------------------------------------------------------- */

ivol	=  ivol * ivol2

iEQ1m	=  int(iEQ1m+0.5)
iEQ2m	=  int(iEQ2m+0.5)

iflnum	=  int(iflnum+0.5)

idel	=  idelx - idloffs			/* delay time		*/
iflen	filelen iflnum
p3	=  idel + (iflen - iskptim) + 0.1	/* note length		*/
i_time	times
i_time	=  ((p3 + i_time) > ilnth ? (ilnth - i_time) : p3)
i_time	limit i_time, 1.0, 3600.0
p3	=  i_time

/* ------------------------------------------------------------------------- */

aL, aR	soundin iflnum, iskptim

	if (iEQx<0.5) goto cont1	/* skip EQ if disabled */

aL	pareq aL, iEQ1f, iEQ1l, iEQ1q, iEQ1m
aL	pareq aL, iEQ2f, iEQ2l, iEQ2q, iEQ2m
aR	pareq aR, iEQ1f, iEQ1l, iEQ1q, iEQ1m
aR	pareq aR, iEQ2f, iEQ2l, iEQ2q, iEQ2m

cont1:

a0L	delay aL*ivol, idel
a0R	delay aR*ivol, idel

gaxL	=  gaxL + a0L
gaxR	=  gaxR + a0R

	endin

/* ------------------------------------------------------------------------- */

	instr 90		/* output instrument		*/

/* ------------------------------------------------------------------------- */

ivol	table  0, 1	/* volume				*/
ilnth	table  1, 1	/* output file length			*/

iEQx	table  3, 1	/* EQ enable/disable			*/
iEQ1f	table  4, 1	/* EQ 1 frequency			*/
iEQ1l	table  5, 1	/* EQ 1 level				*/
iEQ1q	table  6, 1	/* EQ 1 Q				*/
iEQ1m	table  7, 1	/* EQ 1 mode				*/
iEQ2f	table  8, 1	/* EQ 2 frequency			*/
iEQ2l	table  9, 1	/* EQ 2 level				*/
iEQ2q	table 10, 1	/* EQ 2 Q				*/
iEQ2m	table 11, 1	/* EQ 2 mode				*/

/* ------------------------------------------------------------------------- */

p3	=  ilnth

iEQ1m	=  int(iEQ1m+0.5)
iEQ2m	=  int(iEQ2m+0.5)

aL	=  gaxL
aR	=  gaxR

gaxL	=  0
gaxR	=  0

	if (iEQx<0.5) goto cont1	/* skip EQ if disabled */

aL	pareq aL, iEQ1f, iEQ1l, iEQ1q, iEQ1m
aL	pareq aL, iEQ2f, iEQ2l, iEQ2q, iEQ2m
aR	pareq aR, iEQ1f, iEQ1l, iEQ1q, iEQ1m
aR	pareq aR, iEQ2f, iEQ2l, iEQ2q, iEQ2m

cont1:

k_env	init int(p3*kr + 0.5)		/* output envelope */
k_env	=  int(k_env - 0.5)
kenv	limit k_env - (0.1*kr), 0.0, 0.1*kr
aenv	interp (kenv / (0.1*kr)) - 1.0
aenv	=  aenv + 1.0

	outs aL * ivol * aenv, aR * ivol * aenv

	endin


