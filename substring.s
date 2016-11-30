.syntax unified

.text

.align 8
.global substring
.func substring, substring
.type substring, %function

substring:
    @ Save caller's registers on the stack
    push {r4-r11, ip, lr}

    @ YOUR CODE GOES HERE (char *str1 is in r0, char *str2 is in r1)
    @-----------------------
	@r10=i,r11=j
	MOV r10,#0
	MOV r11,#0

	@r9=flag
	MOV r9,#0

	@r4=str1 r5=str2
	MOV r4,r0
	MOV r5,r1
	BL strlen

	@r6=length1
	CMP r0,#0
	MOVEQ r9,#1
	BEQ end
	MOV r6,r0
	MOV r0,r5
	BL strlen

	@r7=length2
	CMP r0,#0
	MOVEQ r9,#1
	BEQ end
	MOV r7,r0
	CMP r6,r7
	BGE firstletter

	@put longer string into r4, shorter one into r5
	MOV r0,r4
	MOV r4,r5
	MOV r5,r0

	@swtich the length accordingly
	MOV r0,r6
	MOV r6,r7
	MOV r7,r0
	CMP r7,#0
firstletter:
    	@while i<length2
	CMP r10,r6
	BGE end

	@r1=str2[0]
	LDRB r1,[r5]

	@r2=str1[i]
	LDRB r2,[r4,r10]

	CMP r1,r2
	BNE skip
onebyone:
	@while j<length1
	CMP r11,r7
	BGE check

	@r1=str2[j]
	LDRB r1,[r5,r11]
	ADD r3,r11,r10

	@r2=str1[j+i]
	LDRB r2,[r4,r3]
	CMP r1,r2
	MOVNE r9,#0
	BNE check
	MOV r9,#1
	ADD r11,r11,#1
	B onebyone
check:
	CMP r9,#1
	BEQ end
skip:
	ADD r10,r10,#1
	B firstletter
    @ put your return value in r0 here:
end:
	MOV r0,r9
    @-----------------------

    @ restore caller's registers
    pop {r4-r11, ip, lr}

    @ ARM equivalent of return
    BX lr
.endfunc

.end

