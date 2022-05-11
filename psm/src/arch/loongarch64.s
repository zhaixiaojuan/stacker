#include "psm.h"

.text
.globl rust_psm_stack_direction
.p2align 2
.type rust_psm_stack_direction,@function
/* extern "C" fn() -> u8 */
rust_psm_stack_direction:
.cfi_startproc
    addi.w $r4, $r0, STACK_DIRECTION_DESCENDING
    jr $r1
.rust_psm_stack_direction_end:
.size       rust_psm_stack_direction,.rust_psm_stack_direction_end-rust_psm_stack_direction
.cfi_endproc


.globl rust_psm_stack_pointer
.p2align 2
.type rust_psm_stack_pointer,@function
/* extern "C" fn() -> *mut u8 */
rust_psm_stack_pointer:
.cfi_startproc
    move $r4, $r3
    jr $r1
.rust_psm_stack_pointer_end:
.size       rust_psm_stack_pointer,.rust_psm_stack_pointer_end-rust_psm_stack_pointer
.cfi_endproc


.globl rust_psm_replace_stack
.p2align 2
.type rust_psm_replace_stack,@function
/* extern "C" fn(r4: usize, r5: extern "C" fn(usize), r6: *mut u8) */
rust_psm_replace_stack:
.cfi_startproc
    move $r3, $r6
    jr $r5
.rust_psm_replace_stack_end:
.size       rust_psm_replace_stack,.rust_psm_on_stack_end-rust_psm_on_stack
.cfi_endproc


.globl rust_psm_on_stack
.p2align 2
.type rust_psm_on_stack,@function
/* extern "C" fn(r4: iusize, r5: usize, r6: extern "C" fn(usize), r7: *mut u8) */
rust_psm_on_stack:
.cfi_startproc
    st.d $r3, $r7, -8 
    st.d $r1, $r7, -16
    .cfi_def_cfa 7, 0
    .cfi_offset 3, -8
    .cfi_offset 1, -16
    addi.d $r3, $r7, -16
    .cfi_def_cfa 3, -16
    jirl $r1, $r6, 0
    ld.d $r1, $r3, 0
    .cfi_restore 12 
    ld.d $r3, $r3, 8
    .cfi_restore 3
    jr $r1
.rust_psm_on_stack_end:
.size       rust_psm_on_stack,.rust_psm_on_stack_end-rust_psm_on_stack
.cfi_endproc
