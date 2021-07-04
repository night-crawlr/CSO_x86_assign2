.global _start

.text

_start:

#movq $8,%rbx			#n is in rbx
#movq $10,%rcx			#k is in rcx
movq $1,%r8			#r8=1
movq $1,%r9			#r9=1
movq $0,%r15			#r15=0

fibonacci:
movq %r9,%r10			#r10=r9
addq %r8,%r9			#r9=r9+r8
movq %r10,%r8			#r8=previous(r9)ie r10
cmp %rbx,%r8			# doing r8-rbx if >0 exit fibonacci
jg program_done			#if r8>rbx then program ends


#movq %r8,%rax			#rax=r8	
#idivq %rcx			# rdx=r8%rcx rax=r8/rcx
#movq %rdx,%rdi			#r8%rcx is first argument for fibonacci so store it in rdi	

movq %r8,%rdi
movq $0,%rdx			#making rdx as 0 for next division
movq $1,%rax			#rax is for multiplication
call factorial			# calling factorial
add %rax,%r15  			#r15=r15+rax

movq $0,%rax			#rax=0;
movq $0,%rdx			#rdx=0;
movq %r15,%rax			#rax=r15
idivq %rcx			#rax/rcx
movq %rdx,%r15			#r15=r15%rcx

jmp fibonacci

factorial:		
pushq %rbp			#save old rbp
movq %rsp,%rbp			#creating new rbp
pushq %rdi			#pushing rdi into stack as it is local variable
cmp $1,%rdi			#comparing rdi with 1 if equal then return 1
jne label			#if not eqal then return rdi*fac(rdi-1)
popq %rdi			#if equal then pop rdi and rbp to chang frame and reatain old rdi
popq %rbp
movq $1,%rax			#returning 1 as return value
ret				#go back to next adress of caller
label:
dec %rdi			#if ne then dec rdi by 1 and call new fac(rdi-1)
call factorial
popq %rdi			#after returning from fac(rdi-1) restoring old rdi value 
popq %rbp			#restoring old rbp
imulq %rdi,%rax			#rax=(rdi*fac(rdi-1))
movq %rax,%r10			#temp for rax
idivq %rcx			#dividing rax with rcx
movq %rdx,%rax			#rax=rax%c
movq $0,%rdx			#rdx=0 for nex division
ret				#return to caller


program_done:
movq %r15,%rdx
movq $60,%rax
xor %rdi,%rdi
exit:
syscall

