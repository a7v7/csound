sr	=  44100
kr	=  22050
ksmps	=  2
nchnls	=  2

/* mono output file name */

#define OUTFLNAME # "_tmp.dat" #

/* ------------------------------------------------------------------------- */

/* parameters for spatialization */

#define SOUNDSPEED	# 340.0 #	/* sound speed (in m/s) */
#define EARDIST		# 0.18 #	/* distance between ears (in meters) */
#define DELAYOFFS1	# 0.02 #	/* delay when dist. = 0, < 0.05 sec. */
#define AMPDIST0	# 10 #		/* amplitude when distance = 0 */

/* ------------------------------------------------------------------------- */

/* convert distance to delay time */

#define Dist2Delay(xdst)	# ((($xdst)/$SOUNDSPEED)+$DELAYOFFS1) #

/* convert distance to amplitude */

#define Dist2Amp(xdst)		# (1/(($xdst)+1/$AMPDIST0)) #

/* azimuth to LEFT channel amp. */

#define Azim2AmpL(xazim)	# abs(1.4142135*cos((($xazim)+1.570796)/2)) #

/* azimuth to RIGHT channel amp. */

#define Azim2AmpR(xazim)	# abs(1.4142135*sin((($xazim)+1.570796)/2)) #

/* ------------------------------------------------------------------------- */

/* temp macro for filtering */

#define SpatFilter #

a_	butterlp	0.333*a_L_,500			/* left channel */
a_1_	butterlp	0.533*a_L_,4000
a_2_	tone		0.134*a_L_,12000
a_2_	=  a_+a_1_+a_2_

a_	butterlp	0.333*a_R_,500			/* right channel */
a_1_	butterlp	0.533*a_R_,4000
a_3_	tone		0.134*a_R_,12000
a_3_	=  a_+a_1_+a_3_

#

#define SpatStereo #

i_1_	wrap i_az_,-180,180			/* convert azimuth value */
i_1_	mirror i_1_*3.141593/180,-1.570796,1.570796

i_2_	limit i_d_,0,$SOUNDSPEED*0.95		/* limit distance */

i_3_	=  i_2_*cos(i_1_)			/* Y distance */
i_4_	=  i_2_*sin(i_1_)+$EARDIST/2		/* X distance from LEFT ear */
i_5_	=  i_2_*sin(i_1_)-$EARDIST/2		/* X distance from RIGHT ear */
i_4_	=  sqrt(i_4_*i_4_+i_3_*i_3_)		/* distance from LEFT ear */
i_5_	=  sqrt(i_5_*i_5_+i_3_*i_3_)		/* distance from RIGHT ear */

i_2_	=  $Dist2Amp(i_4_)	/* amp. / LEFT channel */
i_3_	=  $Dist2Amp(i_5_)	/* amp. / RIGHT channel */
i_6_	=  $Azim2AmpL(i_1_)	/* high frequency level / LEFT channel */
i_7_	=  $Azim2AmpR(i_1_)	/* high frequency level / RIGHT channel */

k_2_	samphold i_2_,-1,i_2_,0			/* lock init. variables */
k_3_	samphold i_3_,-1,i_3_,0
k_6_	samphold i_6_,-1,i_6_,0
k_7_	samphold i_7_,-1,i_7_,0

a_4_	=  a_					/* save input signal */

a_L_	delay a_*k_2_,(int($Dist2Delay(i_4_)*sr+0.5)+0.01)/sr	/* delay / L */
a_R_	delay a_*k_3_,(int($Dist2Delay(i_5_)*sr+0.5)+0.01)/sr	/* delay / R */

/* apply filter */

$SpatFilter

a_L_	=  k_6_*a_L_+(1-k_6_)*a_2_		/* mix output signal */
a_R_	=  k_7_*a_R_+(1-k_7_)*a_3_

a_	=  a_4_					/* restore original input */

#

/* ------------------------------------------------------------------------- */

/* spatializer macro */

#define SPATMACRO # $SpatStereo #

/* convert MIDI note number to frequency */

#define MIDI2CPS(xmidikey) # (440.0*exp(log(2.0)*(($xmidikey)-69.0)/12.0)) #

/* convert frequency to MIDI note number */

#define CPS2MIDI(xfreqcps) # (12.0*(log(($xfreqcps)/440.0)/log(2.0))+69.0) #

/* convert velocity to amplitude */

#define VELOC2AMP(xvelocity) # (0.0039+(($xvelocity)*($xvelocity))/16192.0) #

/* convert amplitude to velocity */

#define AMP2VELOC(xamplitude) # (sqrt((($xamplitude)-0.0039)*16192.0)) #

/* generate ftables */

i_	=  0

loop_01:

i_cps_	=  $MIDI2CPS(i_)
i__	=  int(i_+256.5)
idummy	ftgen i__, 0, 16384, 11, int(sr/(2*i_cps_)), 1, 1.0
	tableigpw i__
i_	=  int(i_+1.5)
	if (i_<127.5) igoto loop_01

/* ------------------------------------------------------------------------- */

#define LP1FRQ # 10.0 #

	seed 0

ga0x	init 0

	instr 1

/* ------------------------------------------------------------------------- */

iazim1	table	 0, 67		/* azimuth 1				*/
iazim2	table	 1, 67		/* azimuth 2				*/
iazim3	table	 2, 67		/* azimuth 3				*/
iazim4	table	 3, 67		/* azimuth 4				*/
ielev1	table	 4, 67		/* elevation 1				*/
ielev2	table	 5, 67		/* elevation 2				*/
ielev3	table	 6, 67		/* elevation 3				*/
ielev4	table	 7, 67		/* elevation 4				*/
idist1	table	 8, 67		/* distance 1				*/
idist2	table	 9, 67		/* distance 2				*/
idist3	table	10, 67		/* distance 3				*/
idist4	table	11, 67		/* distance 4				*/

/* ------------------------------------------------------------------------- */

	schedule 2, 0, p3, p4, p5, iazim1, ielev1, idist1
	schedule 2, 0, p3, p4, p5, iazim2, ielev2, idist2
	schedule 2, 0, p3, p4, p5, iazim3, ielev3, idist3
	schedule 2, 0, p3, p4, p5, iazim4, ielev4, idist4

	endin

	instr 2

start01:

/* ------------------------------------------------------------------------- */

ivol	table	 0, 64		/* volume				*/
ibpm	table	 1, 64		/* tempo				*/

/* ------------------------------------------------------------------------- */

imx01	table	 2, 64		/* OSC 1 mix				*/
ifmd1a	table	 3, 64		/* OSC 1 FM depth in Hz			*/
ifmd1r	table	 4, 64		/* OSC 1 FM depth / note freq.		*/
ifm1mna	table	 5, 64		/* OSC 1 min. FM freq. in Hz		*/
ifm1mnr	table	 6, 64		/* OSC 1 min. FM freq. / note. f.	*/
ifm1mxa	table	 7, 64		/* OSC 1 max. FM freq. in Hz		*/
ifm1mxr	table	 8, 64		/* OSC 1 max. FM freq. / note. f.	*/
ifm1fn	table	 9, 64		/* OSC 1 FM waveform table		*/
iLP1mna	table	10, 64		/* OSC 1 LP frq. at min. FM (Hz)	*/
iLP1mnr	table	11, 64		/* OSC 1 LP frq. at min. FM (rel.)	*/
iLP1mxa	table	12, 64		/* OSC 1 LP frq. at max. FM (Hz)	*/
iLP1mxr	table	13, 64		/* OSC 1 LP frq. at max. FM (rel.)	*/

i1EQ1fa	table	14, 64		/* OSC 1 EQ 1 frequency in Hz		*/
i1EQ1fr	table	15, 64		/* OSC 1 EQ 1 frequency / note frq.	*/
i1EQ1l	table	16, 64		/* OSC 1 EQ 1 level			*/
i1EQ1q	table	17, 64		/* OSC 1 EQ 1 Q				*/
i1EQ1m	table	18, 64		/* OSC 1 EQ 1 mode (0:peak 1:lo 2:hi)	*/
i1EQ2fa	table	19, 64		/* OSC 1 EQ 2 frequency in Hz		*/
i1EQ2fr	table	20, 64		/* OSC 1 EQ 2 frequency / note frq.	*/
i1EQ2l	table	21, 64		/* OSC 1 EQ 2 level			*/
i1EQ2q	table	22, 64		/* OSC 1 EQ 2 Q				*/
i1EQ2m	table	23, 64		/* OSC 1 EQ 2 mode (0:peak 1:lo 2:hi)	*/


imx02	table	24, 64		/* OSC 2 mix				*/
ifmd2a	table	25, 64		/* OSC 2 FM depth in Hz			*/
ifmd2r	table	26, 64		/* OSC 2 FM depth / note frequency	*/
iolp2	table	27, 64		/* OSC 2 window overlap			*/
iwsiz2a	table	28, 64		/* OSC 2 window size in seconds		*/
iwsiz2r	table	29, 64		/* OSC 2 window size * note frequency	*/

i2EQ1fa	table	30, 64		/* OSC 2 EQ 1 frequency in Hz		*/
i2EQ1fr	table	31, 64		/* OSC 2 EQ 1 frequency / note frq.	*/
i2EQ1l	table	32, 64		/* OSC 2 EQ 1 level			*/
i2EQ1q	table	33, 64		/* OSC 2 EQ 1 Q				*/
i2EQ1m	table	34, 64		/* OSC 2 EQ 1 mode (0:peak 1:lo 2:hi)	*/
i2EQ2fa	table	35, 64		/* OSC 2 EQ 2 frequency in Hz		*/
i2EQ2fr	table	36, 64		/* OSC 2 EQ 2 frequency / note frq.	*/
i2EQ2l	table	37, 64		/* OSC 2 EQ 2 level			*/
i2EQ2q	table	38, 64		/* OSC 2 EQ 2 Q				*/
i2EQ2m	table	39, 64		/* OSC 2 EQ 2 mode (0:peak 1:lo 2:hi)	*/

/* ------------------------------------------------------------------------- */

ibtime	=  60/ibpm		/* beat time				    */

iatt	table	 0, 65		/* attack time				*/
imaxamp	table	 1, 65		/* max. amplitude			*/
imaxt	table	 2, 65		/* time / max. amp.			*/
irel	table	 3, 65		/* release time				*/

ifrq0	table	 4, 65		/* osc. start freq.			*/
ifrqs	table	 5, 65		/* osc. frq. env. speed			*/

ivibdr	table	 6, 65		/* vibrato depth			*/
ivibf	table	 7, 65		/* vibrato speed			*/
ivibp	table	 8, 65		/* vibrato phase			*/
ivibt	table	 9, 65		/* vibrato ftable			*/

iatt	=  iatt*ibtime
imaxt	=  imaxt*ibtime
irel	=  irel*ibtime

ifrqs	=  ibtime/ifrqs

/* ------------------------------------------------------------------------- */

iEQ1fa	table	 0, 66		/* EQ 1 frequency (Hz)			*/
iEQ1fn	table	 1, 66		/* EQ 1 frequency / note frequency	*/
iEQ1l	table	 2, 66		/* EQ 1 level				*/
iEQ1q	table	 3, 66		/* EQ 1 Q				*/
iEQ1m	table	 4, 66		/* EQ 1 mode				*/

iEQ2fa	table	 5, 66		/* EQ 2 frequency (Hz)			*/
iEQ2fn	table	 6, 66		/* EQ 2 frequency / note frequency	*/
iEQ2l	table	 7, 66		/* EQ 2 level				*/
iEQ2q	table	 8, 66		/* EQ 2 Q				*/
iEQ2m	table	 9, 66		/* EQ 2 mode				*/

iEQ3fa	table	10, 66		/* EQ 3 frequency (Hz)			*/
iEQ3fn	table	11, 66		/* EQ 3 frequency / note frequency	*/
iEQ3l	table	12, 66		/* EQ 3 level				*/
iEQ3q	table	13, 66		/* EQ 3 Q				*/
iEQ3m	table	14, 66		/* EQ 3 mode				*/

iEQ4fa	table	15, 66		/* EQ 4 frequency (Hz)			*/
iEQ4fn	table	16, 66		/* EQ 4 frequency / note frequency	*/
iEQ4l	table	17, 66		/* EQ 4 level				*/
iEQ4q	table	18, 66		/* EQ 4 Q				*/
iEQ4m	table	19, 66		/* EQ 4 mode				*/

iflt1fa	table	20, 66		/* 1st order filter 1 frq. in Hz	*/
iflt1fr	table	21, 66		/* 1st order filter 1 frq. / note f.	*/
iflt1l	table	22, 66		/* 1st order filter 1 level at sr/2	*/

iflt2fa	table	23, 66		/* 1st order filter 2 frq. in Hz	*/
iflt2fr	table	24, 66		/* 1st order filter 2 frq. / note f.	*/
iflt2l	table	25, 66		/* 1st order filter 2 level at sr/2	*/

/* ------------------------------------------------------------------------- */

imkey	=  p4		/* get note parameters from score */
imvel	=  p5

imkey	limit imkey, 0, 127
imvel	limit imvel, 0, 127

icps	=  $MIDI2CPS(imkey)			/* note frequency */
iamp	=  $VELOC2AMP(imvel)			/* note amplitude */
iamp	=  iamp*sr/(($LP1FRQ)*3.14159265)

p3	=  p3 + irel + 0.1

kamp	linseg 0, iatt, 1, 1, 1			/* amp. envelope */
kamp2	linseg 1, p3-(irel+0.1), 1, irel, 0, 1, 0
kamp3	expseg 1, imaxt, imaxamp, imaxt, 1, 1, 1
aamp	interp ivol*iamp*kamp*kamp2*kamp3

ifn	= int(256.5+imkey)			/* ftable number */

kcps	port icps, ifrqs, ifrq0*icps		/* osc. frequency */
k_	oscili 1.0, ivibf, ivibt, ivibp
kcps	=  kcps*(1 + k_*ivibdr)

/* -------- OSC 1 -------- */

#define OSC1(xnum) #

ifmf_$xnum_1	unirand 1.0
kfmf_$xnum_1	=  kfmf_min_1 + (kfmf_max_1-kfmf_min_1)*ifmf_$xnum_1
ifmp_$xnum_1	unirand 1.0
k_		oscili 1.0, kfmf_$xnum_1, ifm1fn, ifmp_$xnum_1

k_frq_		=  kcps + ifmd1a*k_ + ifmd1r*k_*kcps	/* osc. freq. */

iphs_$xnum_1	unirand 1.0
a_		oscili 1.0, k_frq_, ifn, iphs_$xnum_1

k_ffrq_		=  kLPf_min_1*exp(log(kLPf_max_1/kLPf_min_1)*abs(k_))
k_ffrq_		limit k_ffrq_, 0, sr*0.48

a_		butterlp a_, k_ffrq_

ax1		=  ax1 + a_

#

ax1	=  0

kfmf_min_1	=  ifm1mna + ifm1mnr*kcps	/* min. FM freq. */
kfmf_max_1	=  ifm1mxa + ifm1mxr*kcps	/* max. FM freq. */
kLPf_min_1	=  iLP1mna + iLP1mnr*kcps	/* LP freq. at min. FM */
kLPf_max_1	=  iLP1mxa + iLP1mxr*kcps	/* LP freq. at max. FM */

$OSC1(0)
$OSC1(1)
$OSC1(2)
$OSC1(3)
$OSC1(4)
$OSC1(5)
$OSC1(6)
$OSC1(7)
$OSC1(8)
$OSC1(9)
$OSC1(10)
$OSC1(11)

ax1	pareq ax1, i1EQ1fa + i1EQ1fr*kcps, i1EQ1l, i1EQ1q, i1EQ1m
ax1	pareq ax1, i1EQ2fa + i1EQ2fr*kcps, i1EQ2l, i1EQ2q, i1EQ2m

aphs	unirand 1		/* ------ OSC 2 ------ */
afm	trirand 1

kwsize	=  iwsiz2a + iwsiz2r/kcps		/* window size */
kdens	=  (1/kwsize)*iolp2			/* grain density */
atrns	=  kcps + afm*ifmd2a + afm*ifmd2r*kcps	/* grain frequency */
atrns	=  atrns*(16384/sr)			/* transpose */

ax2	fog 1.0, kdens, atrns, aphs, 0, 0, 0, kwsize, kwsize, \
	    256, ifn, 1, 3600, 0, 0

ax2	pareq ax2, i2EQ1fa + i2EQ1fr*kcps, i2EQ1l, i2EQ1q, i2EQ1m
ax2	pareq ax2, i2EQ2fa + i2EQ2fr*kcps, i2EQ2l, i2EQ2q, i2EQ2m

/* ax1 = osc. 1, ax2 = osc. 2 */

a0x	=  ax1*imx01 + ax2*imx02

a0x	pareq a0x, kcps*iEQ1fn + iEQ1fa, iEQ1l, iEQ1q, iEQ1m	/* EQ */
a0x	pareq a0x, kcps*iEQ2fn + iEQ2fa, iEQ2l, iEQ2q, iEQ2m
a0x	pareq a0x, kcps*iEQ3fn + iEQ3fa, iEQ3l, iEQ3q, iEQ3m
a0x	pareq a0x, kcps*iEQ4fn + iEQ4fa, iEQ4l, iEQ4q, iEQ4m

a_	tone a0x, kcps*iflt1fr + iflt1fa		/* 1st order filters */
a0x	=  iflt1l*a0x + (1.0-iflt1l)*a_
a_	tone a0x, kcps*iflt2fr + iflt2fa
a0x	=  iflt2l*a0x + (1.0-iflt2l)*a_

a0x	tone a0x, ($LP1FRQ)

a0x	=  a0x*aamp			/* amp. envelope */

ga0x	=  ga0x + a0x			/* send to output */

a_	=  a0x

i_az_	=  p6
i_el_	=  p7
i_d_	=  p8

$SPATMACRO

	outs a_L_, a_R_

	endin

	instr 90

	soundout ga0x, $OUTFLNAME, 6
ga0x	=  0

	endin


