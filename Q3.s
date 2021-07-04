.global _start

.text

_start:

#movq $6,%rbx		#rbx=n;
movq %rbx,%r12		#r12=n; temp for rbx
movq $0,%r13   		#r13=0;
movq $1,%rax
leaq 8(%rsp),%rcx		#base adress of input array
leaq 816(%rsp),%rdx		#base adress of output array
#inputing array;

#movq $98,(%rcx)
movq $-1,(%rdx)


#movq $93,8(%rcx)
movq $-1,8(%rdx)


#movq $95,16(%rcx)
movq $-1,16(%rdx)

#movq $94,24(%rcx)
movq $-1,24(%rdx)

#movq $97,32(%rcx)
movq $-1,32(%rdx)

#movq $1,40(%rcx)
movq $-1,40(%rdx)

decq %r12		#index decrementing
#initiating for loop from i=n-1 to i=0;

movq %rsp,%rbp;		#saving frame of stack before push into it
movq $0,%r10		#r10 stack size
pushq %r12
incq %r10		#incresing size
decq %r12

loop:

movq (%rcx,%r12,8),%r14	#x=arr[i]
movq (%rsp),%r15	#y=stack.top()
movq (%rcx,%r15,8),%r15 #rcx+r15*8 ie r15=rbx[r15]

cmp %r15,%r14		#x-y

js else
#if(x>=y)
pushq %r12		#stack.push(i);
incq %r10		#increasing size
decq %r12		#r12--;
cmp $0,%r12             #r12-0
js loop_ended           #if r12 is negative then loop ended
jmp loop		#continue;
else:

movq (%rsp),%r8		#r8=stack.top();
movq (%rcx,%r8,8),%r8	#r8=arr[stack.top()];
movq %r8,%rdi		#temporarily moving r8 ie arr[stack.top] to rdi
cmp %r14,%rdi		#rdi=arr[stack.top()]-x
cmovg %rax,%rdi		#if rdi >0 then rdi is 1
cmovle %r13,%rdi	#else rdi = 0
cmp $0,%r10		#r10-0
cmovg %rax,%rsi		#if r10 > 0 rsi=1
cmovle %r13,%rsi		#else rsi=0
andq %rdi,%rsi		#rsi=rsi&&rdi

cmp $1,%rsi		#while(!stacempty) && array(stack.top)>arr[r12]
jne while_ended
while:

movq (%rsp),%rdi	#rdi=stcak.top()
movq %r14,(%rdx,%rdi,8)	#ble(rdi)=r14
#decq %r12
popq %rdi		#pop the value 
decq %r10		#derease the size

jmp else

while_ended:
pushq %r12		#when condition is not met push the value ie arr[i]
incq %r10		#increase size
decq %r12		#decreasing index
cmp $0,%r12		#r12-0
js loop_ended		#if r12 is negative then loop ended
jmp loop
loop_ended:
#movq $2,%r13
#movq (%rdx,%r13,8),%rax
movq $60,%rax
xor %rdi,%rdi
exit:
syscall











