                         .model small
 
.data

    ;account number
    Acnt_msg db   " enter your account number: $"
    Acnt_wrong db     " account number does not exist.$"
    Acc_pass db "1234$"
    Acc_pass_length dw $-(offset Acc_pass)-1
    entered_Acc_pass_length dw 0h
    
    ;password data
    pass_msg db      " enter your password: $"
    Pass_wrong db         " Invalid_opiton password$"
    Pass db "test$"
    Pass_len dw $-(offset Pass)-1
    entered_Pass_len dw 0h
       
    ;menu options
    Intro_msg db            "**************************  welcome to your account  ***************************$"
    Balance_menu db         " 1. check your balance$"
    Withdraw_menu db      " 2. withdraw money$"
    dep_menu db      " 3. deposit money$"
    Exit_menu db      " 4. exit$"
    
    ;messages
    Thank_msg db            "                          Thank_msg you for banking with us!$"
    Invalid_opiton db         " Invalid_opiton input. please Choose_opiton a different option.$"
    Choose_opiton db         " enter option: $"
    Success_msg db         " transaction Success_msgful$"
    Limit_amount db         " limit exceeded (maximum amount =  5000)$"
       
    ;balance
    Current_balance dw 20000
    Current_balance_msg db         " current balance =  $"
    
    ;withdraw
    Enter_withdraw_amount db         " enter amount to withdraw:  $"
    Withdraw_amount dw 0h 
    Low_balance db         " insufficient balance$"
    
    ;deposit
    dep_prompt db         " enter amount to deposit:  $"
    dep_amt dw 0h
            
    ;amount options
    above1000 db         " 1. 1000 - 5000$"
    above100 db      " 2. 100 - 999$" 
    Max_limit dw 5000
    Min_limit dw 100
      
    ;digit place
   Thousand dw 1000
   Hundred db 100
   Ten db 10
    
.code
    start:
    .startup
    
    ;check account number
    lea si, Acc_pass ;store offset of existing account number in si
    mov cx, Acc_pass_length ;loop Acc_pass_length times as account number is Acc_pass_length characters long
    
    mov ah, 09h
    lea dx, Acnt_msg      
    int 21h   
   
    
    
    verify_acc: mov ah, 01h
                int 21h
               ; call newline       
                cmp al, 0dh
                je breaka
                    
                inc entered_Acc_pass_length
                cmp al, [si] ;compare with actual account number
                jne set_acc_flag
                jmp conta
                             
                set_acc_flag: mov bl, 01h 
                             
                conta: inc si
                jmp verify_acc
                    
    breaka: cmp cx, entered_Acc_pass_length
            jl acc_fail
            jg acc_fail
               
            cmp bl, 01h
            je acc_fail
            jne returna
        
    acc_fail: 
              call newline 
              lea dx, Acnt_wrong 
               
              jmp wrong 
                                   
    returna:
    
    
    ;check password 
    call newline                ;okay
    mov ah, 09h
    lea dx, pass_msg
    int 21h
    
    call check_Pass
    jmp menu      
    
         
    ;incorrect verification handling
    wrong: 
           mov ah, 09h
           int 21h
           
           mov ah, 4ch
           int 21h
           
           
           
    ;display the menu
    menu: 
          call newline
          mov ah, 09h
          lea dx, Intro_msg 
          
          int 21h 
           
          call newline
          mov ah, 09h
          lea dx, Balance_menu
           
          int 21h
          
          call newline
          mov ah, 09h
          lea dx, Withdraw_menu
          int 21h
          
          
          call newline
          mov ah, 09h
          lea dx, dep_menu
          int 21h
          
          
          call newline
          mov ah, 09h
          lea dx, Exit_menu
          int 21h
          
          
          call newline
          mov ah, 09h
          lea dx, Choose_opiton
          int 21h
          
          mov ah, 01h
          int 21h
          
          ;comparing with ascii code of decimal numbers
          cmp al, 49
          je balance
          
          cmp al, 50
          je withdraw
          
          cmp al, 51
          je deposit
          
          cmp al, 52
          je exit
          
          jmp inp_error
                    
                      
                        
    ;display the current balance
    balance: call newline
             mov ah, 0h ;to check for a keystroke.
             int 16h
             
             mov ah, 09h
             lea dx, Current_balance_msg
             int 21h
                   
             xor ax, ax
             mov ax, Current_balance
             call display_num
                   
             jmp back
                   
                    
                    
    ;withdraw money from account
    withdraw: call newline
              mov ah, 0h
              int 16h
              
              call newline      
              mov ah, 09h
              lea dx, above1000
              int 21h
              
              
              call newline
              mov ah, 09h
              lea dx, above100
              int 21h
              
              
              call newline
              mov ah, 09h
              lea dx, Choose_opiton
              int 21h
              
              mov ah, 01h
              int 21h
              
              ;check withdrawal amount option
              cmp al, 49
              je with_above1000
              cmp al, 50
              je with_above100
              jmp inp_error
                    
                       
    ;if withdrawal amount is between 1000 and 5000
    with_above1000: call newline
                    mov ah, 09h
                    lea dx, Enter_withdraw_amount
                    int 21h
                                  
                    call input_4digit_num
                    mov Withdraw_amount, bx
                    
                    cmp bx, Max_limit
                    jg exceed_error
                    jmp with_transact
                                        
                    
    ;if withdrawal amount is between 100 and 999
    with_above100: call newline
                   mov ah, 09h
                   lea dx, Enter_withdraw_amount
                   int 21h
                                  
                   call input_3digit_num
                   mov Withdraw_amount, bx
                    
                   jmp with_transact                
    
    
    ;start the withdrawal transaction
    with_transact: cmp bx, Current_balance
                   jg Low_balance_error
                   
                   mov bx, Current_balance
                   sub bx, Withdraw_amount
                   mov Current_balance, bx
                       
                   mov ah, 0h
                   int 16h
                   call Success_msg_msg
                   jmp back
              
                                                                                                   
    ;if the current balance is lower than the withdrawal amount
    Low_balance_error: mov ah, 0h
                   int 16h
                   mov ah, 09h
                   lea dx, Low_balance
                   int 21h
                   jmp back       
                    
                    
                    
    ;deposit money to account
    deposit: call newline
             mov ah, 0h
             int 16h
             
             call newline      
             mov ah, 09h
             lea dx, above1000
             int 21h
             
             call newline 
             mov ah, 09h
             lea dx, above100
             int 21h
             
             call newline 
             mov ah, 09h
             lea dx, Choose_opiton
             int 21h
              
             mov ah, 01h
             int 21h
              
             ;check deposit amount option
             cmp al, 49
             je dep_above1000
             cmp al, 50
             je dep_above100
             jmp inp_error 
    
             
    ;if deposit amount is between rs.1000 and rs.5000
    dep_above1000: call newline
                   mov ah, 09h
                   lea dx, dep_prompt
                   int 21h
                                  
                   call input_4digit_num
                   mov dep_amt, bx
                    
                   cmp bx, Max_limit
                   jg exceed_error
                   jmp dep_transact
                                        
                    
    ;if deposit amount is between rs.100 and rs.999
    dep_above100: call newline
                  mov ah, 09h
                  lea dx, dep_prompt
                  int 21h
                                  
                  call input_3digit_num
                  mov dep_amt, bx
                  
                  jmp dep_transact
                                 
    
    ;start the deposit transaction
    dep_transact: call newline
                  mov bx, Current_balance
                  add bx, dep_amt
                  mov Current_balance, bx                       
                  mov ah, 0h
                  int 16h   
                  call Success_msg_msg
                  jmp back
                       
    
                    
                      
    ;exit the application                 
    exit: mov ah, 0h
          int 16h
          call newline
          mov ah, 09h
          lea dx, Thank_msg
          int 21h
          
          mov ah, 4ch
          int 21h                   
           
    
    
    ;if user enters incorrect option
    inp_error: call newline
               mov ah, 09h
               lea dx, Invalid_opiton
               int 21h
               jmp back
               
               
               
    ;if amount exceeds specified limit
    exceed_error: mov ah, 0h
                  int 16h  
                  call newline
                  mov ah, 09h
                  lea dx, Limit_amount
                  int 21h
                  jmp back
                       
        
        
    ;return to main menu
    back: mov ah, 0h
          int 16h
           
          mov ah, 0h
          mov al, 03h
          int 10h
          
          jmp menu
           
                
                
    ;procedure to input a 4digit decimal number
    input_4digit_num proc near
        mov ah, 01h
        int 21h
        
        ;check whether character is a digit
        cmp al, 30h
        jl inp_error
        cmp al, 39h
        jg inp_error 
        
        sub al, 30h
        mov ah, 0
        mul Thousand;1st digit
        mov bx, ax
        
        mov ah, 01h
        int 21h
        
        ;check whether character is a digit
        cmp al, 30h
        jl inp_error
        cmp al, 39h
        jg inp_error
        
        sub al, 30h
        mul Hundred;2nd digit
        add bx, ax
        
        mov ah, 01h
        int 21h
        
        ;check whether character is a digit
        cmp al, 30h
        jl inp_error
        cmp al, 39h
        jg inp_error
        
        sub al, 30h
        mul Ten;3rd digit
        add bx, ax               
        
        mov ah, 01h
        int 21h
        
        ;check whether character is a digit
        cmp al, 30h
        jl inp_error
        cmp al, 39h
        jg inp_error
        
        sub al, 30h ;4th digit
        mov ah, 0
        add bx, ax
        
        ret
          
    
    ;procedure to input a 3digit decimal number
    input_3digit_num proc near
        mov ah, 01h
        int 21h
        
        ;check whether character is a digit
        cmp al, 30h
        jl inp_error
        cmp al, 39h
        jg inp_error
        
        sub al, 30h
        mov ah, 0
        mul Hundred;1st digit
        mov bx, ax
        
        mov ah, 01h
        int 21h
        
        ;check whether character is a digit
        cmp al, 30h
        jl inp_error
        cmp al, 39h
        jg inp_error
        
        sub al, 30h
        mul Ten;2nd digit
        add bx, ax               
        
        mov ah, 01h
        int 21h
        
        ;check whether character is a digit
        cmp al, 30h
        jl inp_error
        cmp al, 39h
        jg inp_error
        
        sub al, 30h ;3rd digit
        mov ah, 0
        add bx, ax
        
        ret
        
              
    ;procedure to display a 16bit decimal number
    display_num proc near
        xor cx, cx ;to count the digits
        mov bx, 10 ;fixed divider
        
        digits:
        xor dx, dx ;zero dx for word division
        div bx
        push dx ;remainder (0,9)
        inc cx
        test ax, ax
        jnz digits ;continue until ax is empty
        
        next:
        pop dx
        add dl, 30h
        mov ah, 02h
        int 21h
        loop next
        
        ret
          
          
    ;procedure to display a Success_msgful transaction message
    Success_msg_msg proc near
       
        mov ah, 09h
        lea dx, Success_msg
        int 21h
        
        call newline
        mov ah, 09h
        lea dx, Current_balance_msg
        int 21h
        
        xor ax, ax
        mov ax, Current_balance
        call display_num
        
        ret
        
    
    ;procedure to verify password
    check_Pass proc near
        mov entered_Pass_len, 0h
        mov bl, 0h ;flag stored in bl
        lea si, Pass ;store offset of correct password in si
        mov cx, Pass_len ;length of entered password has to be compard with actual password length.
        
        Verify_account: mov ah, 08h ;character input without echo to output device.
                    int 21h
                                
                    cmp al, 0dh ;break if user presses enter key.
                    je breakp
                        
                    inc entered_Pass_len
                    cmp al, [si] ;compare with actual password.
                    jne set_Pass_flag
                    je contp
                           
                    set_Pass_flag: mov bl, 01h
                       
                    contp: mov ah, 02h 
                           mov dl, 23h ;hide password characters with *.
                           int 21h
                      
                    inc si
                    jmp Verify_account
                          
        breakp: cmp cx, entered_Pass_len
                jl Pass_fail
                jg Pass_fail
                   
                cmp bl, 01h
                je Pass_fail
                jne returnp
            
        Pass_fail: lea dx, Pass_wrong
                  jmp wrong 
                                       
        returnp: ret  
        
       
        
        
    endp   
    
     newline proc 
               
               mov ah, 02
               mov dx, 10
               int 21h
               mov ah, 02
               mov dx, 13
               int 21h 
               
               ;mov dx, 0
          
            
            ret
        
                                       
    code ends
end start