;; defining constants, you can use these as immediate values in your code
CACHE_LINES  EQU 100
CACHE_LINE_SIZE EQU 8
OFFSET_BITS  EQU 3
TAG_BITS EQU 29 ; 32 - OFSSET_BITS

section .data
    tag dd 0
    no_bytes dd 0 ;nr de octeti pusi pana in momentul actual pe linia corespunzatoare din cache
    adresa dd 0 ; pt a retine adresa pusa initial in edx


section .text
    global load
    extern printf

;; void load(char* reg, char** tags, char cache[CACHE_LINES][CACHE_LINE_SIZE], char* address, int to_replace);
load:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; address of reg
    mov ebx, [ebp + 12] ; tags
    mov ecx, [ebp + 16] ; cache
    mov edx, [ebp + 20] ; address
    mov edi, [ebp + 24] ; to_replace (index of the cache line that needs to be replaced in case of a cache MISS)
    ;; DO NOT MODIFY

    ;; TODO: Implment load
    ;; FREESTYLE STARTS HERE

    xor esi, esi
    xor ebp, ebp
    mov [adresa], edx

    function:
        mov esi, edx
        shr esi, 3 ;elimin ult 3 cifre, le pastrez pe primele 29 ce reprezinta tag ul
        mov [tag], esi

    cont_function:
        mov esi, [ebx + 4 * ebp] ;iau pe rand fiecare tag din tags
        add ebp, 1 ;ebp contor pt elementul curent din vectorul tags
        cmp ebp, CACHE_LINES ;verificam daca am ajuns la finalul vectorului tags
        je CACHE ;daca am ajuns la final si nu am gasit tag ul, trb sa l adaugam pe acesta in cache
        cmp esi, [tag] ;daca nu am ajuns la final, verificam daca tag ul curent este chiar cel cautat
        je REG ;daca da, scriem in registru octetul
        jmp cont_function

    CACHE:
        mov esi, [tag]
        mov [ebx + 4 * edi], esi ;adaug tag ul in vectorul tags

        shl esi, 3 ;formez tag000
        mov [tag], esi ;in tag retinem acum pe rand cei 8 octeti ce trb pusi in cache(cele 8 adrese)

        xor ebp, ebp

        add ebp, edi
        add ebp, edi
        add ebp, edi
        add ebp, edi
        add ebp, edi
        add ebp, edi
        add ebp, edi
        add ebp, edi ; fiecare linie din cache are 8 octeti, mergem la linia corespunzatoare to_replace

    ADD_BYTES:

        mov esi, [no_bytes]
        add esi, 1
        mov [no_bytes], esi ;actualizam mereu numarul de octeti pusi pana in momentul curent pe linia din cache

        mov esi, [tag]
        xor edx, edx
        mov dl, byte[esi] ;luam un octet de la adresa curenta
        mov [ecx + ebp], edx

        add esi, 1
        mov [tag], esi ;la adresa curenta daugam cate 1 pana formam toti cei 8 octeti

        add ebp, 1 ;ne mutam la urmatoarea pozitie de pe linia cache
        mov esi, [no_bytes]
        cmp esi, 8 ;verificam daca am adaugat pe linia din cache toti cei 8 octeti
        jl ADD_BYTES ;daca nu, continuam



    REG:
        mov esi, [adresa] ; in esi am address
        xor edx, edx
        mov dl, byte[esi] ;luam un octet de la adresa corespunzatoare
        mov [eax], dl ;il punem in registru

    
    EXIT:
        xor ebp, ebp
        mov [tag], ebp
        mov [no_bytes], ebp ;la sfarsit reactualizam valorile variabilelor la 0
    

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY


