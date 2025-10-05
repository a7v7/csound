;******************************************************
;** Unified orc/sco file example with realtime flags **
;******************************************************

<CsoundSynthesizer>

<CsOptions>
;***** command line flags ******
;------- no display    midi in     DirectX audio out   buffer length    number of console text-lines
;         -d            -+K0         -+X1                 -b800            -+j500
</CsOptions>


<CsInstruments>

;** <<< orc/sco for DirectCsound test >>>
;** In this file flags are set in the"CsOption" area.
;** To run this example, simply drag this file to the csound.exe icon
;** 
;** Then answer to the console requests about the midi port number 
;** and the DirectSound device number. Try to play the midi keyboard. 
;** If all is OK (i.e. if you can hear the notes you play) then
;** close csound and rerun it suppressing the console message display
;** by modifying the CsOption area in the followig way
;** 
;** -+O -m0 -+X -+K -b100 test.orc test.sco 
;** 
;** Notice that the latency delay is hugely reduced respect previous versions
;** of RTsound. If you have a PENTIUM II processor you can reduce the buffer
;** by typing a smaller number referring to -b flag (try with 100 or less)


	sr = 44100  
	kr = 441
	ksmps = 100
	nchnls = 1	

	instr	1
inum	notnum
icps	cpsmidi
iamp	ampmidi	4000
kmp	linenr	iamp, 0, .8, .01 
a1	oscili	kmp, icps, 1
	out	a1      
	endin


</CsInstruments>


<CsScore>

f0 15
f1 0 128 10 1 0 1 0 1 0 1  ; audio function

e

</CsScore>


</CsoundSynthesizer>



























