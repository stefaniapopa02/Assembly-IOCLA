; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

section .data
    iter dd 0 ; pe iter il folosim pe post de contor al pozitiei curente din vectorul de structuri


; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

    xor eax, eax ; registru in care retinem ziua/luna/anul din data zilei "de azi"(present)
    xor ebx, ebx ; registru in care retinem ziua/luna/anul nasterii persoanei curente
    xor ebp, ebp ; registru in care retinem valoarea contorului pozitiei curente din vectorul de structuri
    sub edx, 1 ; vectorul de structuri se parcurge pana la pozitia len - 1

    function:
        mov ax, word [esi + my_date.month] ; luna din data retinuta in present
        mov ebp, [iter] 
        mov bx, word [edi + my_date_size * ebp + my_date.month] ; luna in care s-a nascut persoana curenta
        cmp ax, bx
        jg GREATER
        jl LOWER 
        je EQUAL

    GREATER: ; daca luna in care ne aflam > luna in care s-a nascut persoana => varsta persoanei = anul in care ne aflam - anul in care s-a nascut
        mov eax, dword [esi + my_date.year]
        mov ebx, dword [edi + my_date_size * ebp + my_date.year]
        sub eax, ebx ; calculam varsta in eax
        mov [ecx + 4 * ebp], eax 
        jmp function_cont

    LOWER: ; daca luna in care ne aflam > luna in care s-a nascut persoana => varsta persoanei = anul in care ne aflam - anul in care s-a nascut - 1
        mov eax, dword [esi + my_date.year]
        mov ebx, dword [edi + my_date_size * ebp + my_date.year]
        cmp eax, ebx
        je ZERO ; cazul in care data de nastere e dupa data prezenta  -> trebuie returnat 0
        sub eax, ebx
        sub eax, 1 ; calculam varsta in eax
        mov [ecx + 4 * ebp], eax 
        jmp function_cont

    EQUAL: ; daca luna in care ne aflam = luna in care s-a nascut persoana -> ne uitam la zi
        mov ax, word [esi + my_date.day]
        mov bx, word [edi + my_date_size * ebp + my_date.day]
        cmp ax, bx
        jge GREATER ; in aceasta situatie se aplica cazul GREATER
        jl LOWER ; in aceasta situatie se aplica cazul LOWER

    ZERO: ; cazul in care data de nastere e dupa data prezenta  -> trebuie returnat 0
        mov eax, 0
        mov [ecx + 4 * ebp], eax

    function_cont: ; am calculat varsta persoanei curente, acum trecem la urmatoarea persoana
        inc ebp ; incrementam contorul
        mov [iter], ebp ; actualizam valoarea lui iter
        cmp ebp, edx ; verificam daca am ajuns la sfarsit
        jle function ; daca nu, continuam
        jg finish

    finish: ; daca am terminat, readucem valoarea lui iter la 0 
        xor eax, eax
        mov [iter], eax

    
      
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
