section .text
    global rotp

section .data
    len dd 0 ; avem nevoie de aceasta variabila pentru a nu pierde lungimea sirurilor de caractere

;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE

    xor ebp, ebp ; il folosim pe ebp ca reprezentant al lui i (din formula data), acesta porneste de la valoarea 0
    mov [len], ecx ; retinem lungimea cuvintelor pentru a putea calcula indicele (len-i-1) dat in formula

    function:
        mov ecx, [len] 
        mov al, byte [esi + ebp]  ; plain[i]
        sub ecx, ebp 
        sub ecx, 1 ; construim (len-i-1)
        mov bl, byte [edi + ecx]  ; key[len-i-1]
        xor al, bl
        mov [edx + ebp], al ; atribuim valoarea coresounzatoare lui ciphertext[i]
        add ebp, 1 ; il incrementam pe i
        cmp ecx, 0 ; verificam daca am ajuns la sfarsit
        jg function


    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY