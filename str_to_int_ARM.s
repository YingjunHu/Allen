.syntax unified


.text



.align 8
.global str_to_int
.func str_to_int, str_to_int
.type str_to_int, %function

str_to_int:
    @ We need to save away a bunch of registers
    push {r4-r11, ip, lr}

    

    @r0 = str       r1 = dest

    @check if str and dest are null
    CMP r0,#0
    BEQ rtn_zero
    CMPNE r1,#0
    BEQ rtn_zero

    MOV r2,#0   @r2 = result
    MOV r3,#0   @r3 = negative sign

    @check for negative sign
    LDRB r4,[r0] @r4 = *str
    CMP r4,#45  @compare with '-'
    MOVEQ r3,#1
    ADDEQ r0,r0,#1

    LDRB r4,[r0]
    CMP r4,#0
    BEQ rtn_zero

while:
	LDRB r4,[r0]   @r4 = *str
	CMP r4,#0
	BEQ end_while
    MOV r7,#10
	MUL r2,r2,r7 @result *=10
	SUB r5,r4,#48 @r5 = currentInt

	@check it's valid number
	CMP r5,#9
	BGT rtn_zero
	CMPLE r5,#0
	BLT rtn_zero

	ADD r2,r2,r5
	ADD r0,r0,#1
	B while

end_while:
	CMP r3,#0
	MOVNE r6,#0
	SUBNE r2,r6,r2

	STR r2,[r1]
	MOV r0,#1
	B end

rtn_zero:
	MOV r0,#0

end:

    
    @ This handles restoring registers and returning
    pop {r4-r11, ip, pc}

    BX lr
.endfunc

.end


