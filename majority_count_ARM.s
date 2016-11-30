.syntax unified


.data 


.text



.align 8
.global majority_count_ARM
.func majority_count_ARM, majority_count_ARM
.type majority_count_ARM, %function

majority_count_ARM:
    @ We need to save away a bunch of registers
    push    {r4-r11, ip, lr}
    @ May want to decrement stack pointer for more space

    @r0 = arr , r1 = len,  r2 = result


    SUB sp,sp,#20
    STR r0,[sp]      @store r0 to sp
    STR r1,[sp,#4]	 @store r1 to sp+4
    STR r2,[sp,#8]   @store r2 to sp+8

    CMP r1,#0
    MOVEQ r0,#0
    BEQ end

    CMP r1,#1
    CMPEQ r2,#0
    LDRNE r3,[r0]  @r3 = arr[0] can delete
    STRNE r3,[r2]  @*result = arr[0]
    MOVNE r0,#1
    BNE end

    ADD r3,sp,#12  @r3 = address of left_majority   can be delete
    ADD r4,sp,#16  @r4 = address of right_majority  can be delete

    LSR r1,r1,#2   @second parameter len/2
    MOV r2,r3
    BL majority_count_ARM
    MOV r5,r0      @r5 = left_majority_count

    LDR r0,[sp]    @read r0 from stack
    ADD r0,r0,r1   @first parameter arr+len/2
    LDR r6,[sp,#4] @read r1 from stack  can delete
    SUB r1,r6,r1   @second parameter len-len/2
    MOV r2,r4      
    BL majority_count_ARM
    MOV r6,r0      @r6 = right_majority_count

check_left:
    CMP r5,#0
    BEQ check_right
    LDR r0,[sp]    @r0 = arr
    LDR r1,[sp,#4] @r1 = len
    LDR r2,[sp,#12] @r2 = left_majority
    BL count
    MOV r7,r0      @r7 = c

    LSR r1,r1,#1   @r1 = len/2
    CMP r7,r1
    BLE check_right
    LDR r3,[sp,#8] @r3 = result
    CMP r3,#0
    BEQ first_if_end
    STR r2,[r3]
first_if_end:
    MOV r0,r7    @r0 = c
    B end



check_right:
	CMP r6,#0
	BEQ end_check_right
	LDR r0,[sp]    @r0 = arr
    LDR r1,[sp,#4] @r1 = len
    LDR r2,[sp,#16] @r2 = right_majority
    BL count
    MOV r7,r0      @r7 = c

    LSR r1,r1,#1   @r1 = len/2
    CMP r7,r1
    BLE end_check_right
    LDR r3,[sp,#8] @r3 = result
    CMP r3,#0
    BEQ second_end_if
    STR r2,[r3]    @*result = right_majority
second_end_if:
	MOV r0,r7
	B end



end_check_right:
	MOV r0,#0


end:

    @ Remember to restore your stack pointer before popping!
    @ This handles restoring registers and returning
    pop     {r4-r11, ip, pc}





count:
	push {r4-r11, ip, lr}

	@r0 = arr, r1 = len, r2 = target

	MOV r3,#0   @r3 = i = 0
	MOV r4,#0   @r4 = ret_count = 0

loop:
	CMP r3,r1
	BGE end
	LDR r5,[r0,r3,LSL #2]   @r5 = arr[i]
	CMP r5,r2
	ADDEQ r4,r4,#1
	ADD r3,r3,#1
	B loop
end:
	MOV r0,r4

	pop {r4-r11, ip, lr}
	


.endfunc

.end


