f1 0 8192 10 1                         ; Sine
f2 0 4096 7 0 1024 1 2048 -1 1024 0    ; Triangle
f3 0 1024 7 1 512 1 0 -1 512 -1        ; Square
f4 0 4096 -7 0 1024 .5 2048 -.5 1024 0 ; Half Level Tri for Shallow PWM
f5 0 1024 7 0 1024 0                   ; Constant 0 for No PWM/Sqr/Tri

t 0 480

; Wave: 1=Saw, 2=Pwm, 3=Saw/Tri/Ramp

;                    -----VCOs------ ------VCF------ ---VCOs-- ------LFOs------
;     Strt Leng Levl Pitch Semi Fine Vcf1  Vcf2  Rez Wav1 Wav2 Wave Rate1 Rate2 Ring
i1.1  0    -2   .7   06.00 1    1    1000  200   10  2    2    2   .25   .3     .75
i1.1  +    -1   .    07.07 .    .    ~     <     .
i1.1  +    -1   .    06.00 .    .    ~     <     .
i1.1  +    1    .    07.03 .    .    ~     <     .
i1.1  +    -2   .    06.00 .    .    ~     <     .
i1.1  +    1    .    06.07 .    .    ~     <     .
i1.1  +    -2   .    07.00 .    .    ~     <     .
i1.1  +    -1   .    07.07 .    .    ~     <     .
i1.1  +    -1   .    06.00 .    .    ~     <     .
i1.1  +    -1   .    07.07 .    .    ~     <     .
i1.1  +    -2   .    06.00 .    .    ~     <     .
i1.1  +     1   .    06.03 .    .    1000  200   .
e
