section .data
    extern len_cheie, len_haystack
    iter_key dd 0 ;contor ce retine pozitia curenta din vectorul de chei
    iter_ciphertext dd 0 ;contor ce retine pozitia curenta din sirul de caractere pe care il construim

section .text
    global columnar_transposition

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    xor ebp, ebp ;ebp va fi folosit pentru a retine pozitia caracterului curent din haystack, in procesul de parcurgere al lui haystack

    jmp function ;incepem cu inceputul

    NEXT_KEY:
        mov eax, [iter_key]
        inc eax ;incrementam contorul vectorul de chei
        cmp eax, [len_cheie] ;verificam daca am ajuns la sfarsitul vectorului de chei
        je FINISH ;daca da, atunci am terminat de construit ciphertext
        mov [iter_key], eax ;daca nu, continuam procedeul cu cheia curenta (cu noua coloana)
        
    function:
        mov eax, [iter_key] ;pozitia curenta din vectorul de chei
        mov ebp, [edi + 4 * eax] ;valoarea cheii de la pozitia curenta(coloana curenta)

    cont_function:
        mov al, byte [esi + ebp] ;retinem caracterul curent din haystack ce urmeaza a fi adaugat in ciphertext
        mov ecx, [iter_ciphertext] ;ne uitam pe ce pozitie urmeaza sa adaugam un nou caracter in ciphertext
        mov [ebx + ecx], al ;il adaugam

        inc ecx ;incrementam contorul din ciphertext (il pregatim pentru adauugarea unui nou caracter)
        mov [iter_ciphertext], ecx ;actualizam valoarea lui iter_ciphertext

        add ebp, [len_cheie] ;pentru a simula parcurgerea caracterelor de pe o coloana, adaugam la pozitia curenta din haystack lungimea cheii = nr de coloane
        mov eax, [len_haystack]
        sub eax, 1 ;caracterele sunt stocate pana la pozitia (len_haystack - 1)
        cmp ebp, eax ;verificam daca am terminat de parcurs coloana curenta
        jg NEXT_KEY ;am terminat si mergem la urmatoarea coloana (valoarea de pe urmatoarea pozitie din key)
        jle cont_function ;nu am terminat, deci continuam cu urmatorul caracter de pe coloana
       
    FINISH: ;daca am terminat de construit sirul de caractere ce trebuie returnat, readucem variabilele la valoarea 0
        xor eax, eax
        mov [iter_key], eax
        mov [iter_ciphertext], eax

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY