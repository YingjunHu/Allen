.syntax unified





.text



.align 8
.global binary_search_ARM
.func binary_search_ARM, binary_search_ARM
.type binary_search_ARM, %function

binary_search_ARM:
    @ We need to save away a bunch of registers
    push    {r4-r11, ip, lr}
    @ May need to decrement stack pointer for more stack space

    

    @r0 = data, r1 = toFind, r2 = start, r3 = end


    @r4 = mid
    SUB r4,r3,r2
    LSR r4,r4,#1
    ADD r4,r2,r4

    CMP r2,r3
    MOVGT r0,#-1
    BGT end

    LSL r6,r4,#2    @r6 = index
    LDR r5,[r0,r6]  @r5 = data[mid]
    CMP r5,r1
    MOVEQ r0,r4
    BEQ end

    @SUBGT r3,r4,#1
    @BLGT binary_search_ARM
    @BGT end

    @ADD r2,r4,#1
    @BL binary_search_ARM


    SUBGT r3,r4,#1
    ADDLT r2,r4,#1
    BL binary_search_ARM

end:


    
    @ Remember to restore the stack pointer before popping!
    @ This handles restoring registers and returning
    pop     {r4-r11, ip, pc}

    
.endfunc

.end


