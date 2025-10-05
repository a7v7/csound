;sco file 
f1 0 8192 10 10 5 9 5 8 4 7 3 7 2 6 3 3 1 1

t 0 60

i1 0 2 1
i1 2 2 0
i1 4 2 1
i1 6 2 0
e

>David Schuyeteneer wrote:
>> 
>> Is there a way to, for example adding reverb, to an instrument 
>> based on TRUE / FALSE events ?
>
>Apparently my mail server didn't want to send this during the
>weekend. Here goes again.
>
>Look at the if...kgoto opcodes in the manual (under the entry 
>PROGRAM CONTROL STATEMENTS). In practise, you will have to
>make a jump inside your instrument. Your funky imagination will
>have to stretch towards:
>
>    apeak = awhatever  ; Your sound
>
>    itest = 3300
>
>        ; You can only do gotos at i- or k-rate, so 
>        ; apeak must be downsampled, perhaps like this.
>    kpeak downsamp apeak, ksmps
>        ; now test Kpeak & do conditional processing on Apeak
>    if kpeak < itest kgoto noverb
>    gareverbsig = gareverbsig + apeak
>    kgoto continue   ; skip non-reverb processing (if any)
>
>noverb:              ; This is a label, ie a jump target
>      ; do non-reverb processing (if any)
>continue:
>      ; continue instr processing here
>
>
>But if you are anyway doing three separate reson filters, 
>couldn't you process just one of them directly, like:
>
>instr 10
>    anoise rand 10000
>    aband1 reson anoise, 110, 10
>    aband2 reson anoise, 330, 20
>    aband3 reson anoise, 3300, 50
>
>    gareverbsig = gareverbsig + aband3
> 
>    aamp linseg 20000, p3, 0     ; (whatever)
>    anoise balance (aband1 + aband2 + aband3), aamp
>        out anoise   ; (perhaps)
>endin
>
>?
>
>And again, every time you have a problem with the Csound language,
>you must include full orc and sco files (preferably edited to the 
>minimal version which still causes the problem) - else it will 
>be much harder to help.
>
>Cheers,
>
>        re
>
>
