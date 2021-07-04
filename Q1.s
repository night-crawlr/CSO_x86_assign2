.global _start

.text

_start:
						#used registers
		#rax,rbx,rcx,rdx,rbp,rdi,rsi,r8,r10,r12,r13,r14,r15
						#uasble registers for further programing
		#r9,r11,rdi
 
#movq $30,%rbx					#rbx=30; A=30
#movq $8,%rcx					#rcx=8;ie B=8
movq %rbx,%rdx					#rdx=30;initially storing X=30
movq $1,%rbp					#rbp=1
check:						#label for checking divisibility and comprime
jmp divisibility				#if divisibility is satisfied then r14 is stored as 1 else 0
divisibility_done:
jmp coprime					#if comprime is satisdfied then r15 is storred as 1 else 0
coprime_done:
and %r14,%r15  					# r15 = r14 && r15 if 1 we are done else decement x and check
cmp $1,%r15					#if 0 complted else dec
je completed					#if they are 0 jump to completed label
dec %rdx					#if not decrement x and jmp to both divisibility and co prime check
jmp check					#goto check



divisibility:
movq %rdx,%r8					#creating temp of rdx as i need to use division r8=X
movq $0,%r14					#r14=0
movq %rbx,%rax					#need to move A into rax
movq $0,%rdx					#rdx=0;
idivq %r8					#rax=QUOTIENT rdx=REMAINDER
cmp $0,%rdx					#checking if rdx is 0 or not
movq %r8,%rdx
cmove %rbp,%r14					#if rdx=0 r14=1 else r14=0
jmp divisibility_done


coprime:					#for chrcking coprime we check gcd of 2 numbers and if gcd is 1 then it is co prime
movq %rcx,%r12					#r12=rcx as for gcd loop
movq %rdx,%r13					#r13=rdx as for gcd loop
movq $0,%r15					#r15 ie flag for coprime or not
jmp GCD						#doing GCD storing GCD in %rax
GCD_completed:					#GCD finding completed
cmp $1,%rax					#if rax =1
cmove %rbp,%r15					#conditionally moe 1 to r15
jmp coprime_done

GCD:
jmp MIN						#doing min and min is stored in r12
MIN_ended:					#min ended
cmp %r12,%r13					#checking equal or not
cmove %r12,%rax					#rax = r12 if both r12 and r13 are same r13 is ans
je GCD_completed
subq %r12,%r13					#r13 = r13-r12
jmp GCD

MIN:
cmp %r12,%r13					#doing r13-r12 to find min
js swap
swap_ended:
jmp MIN_ended 

swap:
movq %r12,%rdi					#temp=r12
movq %r13,%r12					#r12=r13
movq %rdi,%r13					#r13=temp
jmp swap_ended




completed:
movq $10,%r12    				#r12 = 10
movq $0,%r13					#r13 as sum var
movq %rdx,%rax					#moving rdx value into rax
loop:				
movq $0,%rdx					#and making rdx=0
idivq %r12					#dividing 10 rem in rdx and quo in rax
addq %rdx,%r13					#ading remainder to sum var as to find sum of digits
cmp $0,%rax					#seeing whatet division has come to an end or not
je loop_ended
jmp loop


loop_ended:
movq %r13,%rdx
jmp program_done


program_done:
movq $60,%rax
xor %rdi,%rdi
exit:
syscall
