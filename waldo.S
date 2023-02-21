/* whereiswaldo()
* Description: Searches through the linked list of people to find if the
* waldo element is present in the list.
* Input: waldo - person_t struct that has the attributes of the person
* we want to find in the linked list.
* Returns: If the waldo element is found, return its position
* information relative to the image. If not found, return -1.
*/
// int32_t whereiswaldo(person_t* waldo);
.global people_list_head    0

whereiswaldo:
    pushl   %ebp
    movl    %esp,%ebp
    pushl   %esi
    pushl   %edi
    pushl   %ebx

    movl    8(%ebp), %edi
    movl    people_list_head, %esi

loop:
    cmp     %esi,0
    je      not_found
    // r
    xorl    %ecx, %ecx
    movb    (%edi),%cl
    cmpb     %cl, (%esi)
    jne     next
    // g
    xorl    %ecx, %ecx
    movb    1(%edi),%cl
    cmpb     %cl, 1(%esi)
    jne     next
    // b
    xorl    %ecx, %ecx
    movb    2(%edi),%cl
    cmpb     %cl, 2(%esi)
    jne     next
    // glass
    xorl    %ecx, %ecx
    movb    3(%edi),%cl
    cmpb     %cl, 3(%esi)
    jne     next
    // pos
    /*
    movl    4(%edi),%ecx
    cmp     %ecx, 4(%esi)
    jne     next */

    // matched, return
    movl    %ecx, %eax
    //movl    4(%edi),%eax
    popl    %ebx
    popl    %edi
    popl    %esi
    leave
    ret

next:
    movl    8(%edi),%esi
    jmp     loop

not_found:
    movl    $-1,%eax
    popl    %ebx
    popl    %edi
    popl    %esi
    leave
    ret