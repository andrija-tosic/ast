(8 poena) Definisati 8086 kod i izgled aktivacionog sloga za funkciju covid_safety. Za predstavljanje
podataka tipa int kao i memorijskih adresa koriste se 2 bajta. Pretpostaviti da se rezultat funkcije
call_guard (koji je tipa int) smešta na stek, a rezultat funkcije covid_safety vraća kroz registar CX.
struct event {
 int type;
 struct event* next;
};

int covid_safety(struct event *e, int location, int v_type) {
 int violations_num = 0;
 if (e->type == v_type) {
 violations_num += call_guard(v_type, location);
 }
 if(e->next != 0)
    return violations_num + covid_safety(e->next, location, v_type);
}

struct event:
        type    [bx]
        next    [bx+2]

covid_safety stek:
        v_type          [bp+8]
        location        [bp+6]
        *e              [bp+4]
        IP              [bp+2]
BP ->   staro BP
SP ->   violations_num  [bp-2]

push    bp
mov     bp, SP

sub     sp, 2       ; za violations_num

mov     [bp-2], 0

mov     bx, [bp+4]  ; bx = *e
mov     ax, [bx]    ; ax = e->type
cmp     ax, [bp+8]
jne     lab1

mov     ax, [bp+6]
push    ax
mov     ax, [bp+8]
push    ax
call    call_guard
pop     cx
sub     sp, 4

add     [bp-2], cx

lab1:

mov     ax, [bx+2]
cmp     ax, 0
je      lab2

mov     ax, [bp+8]
push    ax
mov     ax, [bp+6]
push    ax
mov     ax, [bx+2]
push    ax
call    covid_safety
sub     sp, 6
add     cx, [bp-2]
ret

lab2: ?