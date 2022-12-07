.model small
.data   

   
msg db "Enter the String 'Small letter only'.... : $"  
buf db 50 , ? , 50 dup(?)
msg2 db 0dh,0ah ,"#########################################" , 0dh,0ah , "The Length Of Data Is : $" 
mesgError db 0dh,0ah ,"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" , 0dh,0ah ,"Data not Valid , Please Enter Correct Data !!" ,  0dh,0ah , "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"  ,  0dh,0ah , "$"
mesgPass db 0dh,0ah ,"#########################################" , 0dh,0ah ,"DATA IS CORRECT ..$" 
capitalMsg db 0dh,0ah ,"#########################################" , 0dh,0ah ,"The Message in   CAPITAL LETTER IS : $"  
nof db 0dh,0ah ,"#########################################" , 0dh,0ah ,"Number of word is : $" 
counter db 1

enceypt db 50 dup("$") 
mesageEncrypted db 0dh,0ah ,"#########################################" , 0dh,0ah ,"THE MESSAGE AFTER ENCRYPTION : $"   

welcome db 0dh,0ah ,"----------------------------------------------------", 0dh,0ah , "                 WELCOME TO MY ENCRYPTION SYSTEM",0dh,0ah ,"                 NAME :TAREQ KHANFAR" , 0dh,0ah ,"                 ID :1200265", 0dh,0ah ,"----------------------------------------------------" ,0dh,0ah,"$"
FINISH db  0dh,0ah ,"----------------------------------------------------", 0dh,0ah ,"                 THE END...$"
.code  
.startup 

   


MOV AH,9
LEA DX,welcome
INT 21H 

again: 

mov ah , 9
lea dx , msg
int 21h   


mov ah , 0ah
lea dx , buf
int 21h      


 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      xor cx , cx
      mov cl , [buf+1]  
     
      
        lea bx , buf+2
        mov si , 0
 checkData:
    cmp [bx] , 'a'
    JAE checkTwo 
    cmp [bx] ,' '
    je getNext 
    jmp out_1     

    
 checkTwo:
 cmp [bx] , 'z'
 jbe getNext
 cmp [bx] ,' '
 je getNext
 
 jmp out_1

     

 getNext:
 inc bx
 loop checkData  
 
 mov ah,9
 lea dx , mesgPass
 int 21h 
 jmp bye 
 
 out_1:

 mov ah,9
 lea dx , mesgError
 int 21h  
 jmp again
 
bye:
mov ah,9
lea dx , msg2
int 21h

mov al, [buf+1]
mov ah,0

mov cl,10
div cl  
mov ch , ah

add al,30h
mov dl,al
mov ah,2
int 21h
  
add ch,30h
mov dl,ch
mov ah,2
int 21h   

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
 
MOV AH , 9
LEA DX , capitalMsg
int 21h
        
xor ax , ax
xor dx , dx 
xor cx , cx
mov cl , [buf+1]
lea bx , buf +2       
printCapital:
mov dl,[bx] 
cmp dl , " "
jne else
inc counter
else: 
sub dl ,32
mov ah,2
int 21h  
inc bx
loop printCapital 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov ah,9
lea dx , nof
int 21h 

xor ax, ax
xor cx, cx
mov al, counter

mov cl,10
div cl  
mov ch , ah

add al,30h
mov dl,al
mov ah,2
int 21h
  
add ch,30h
mov dl,ch
mov ah,2
int 21h   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
xor cx,cx
xor ax,ax
xor dx,dx
mov cl , [buf+1]
lea bx , buf +2  
mov si,0 
enc:
 mov al , [bx]
 ror al,2
 mov enceypt[si] , al 
 
 inc si
 inc bx
 loop enc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOV AH,9
  LEA DX ,mesageEncrypted
  INT 21H  
    
  mov ah,9
  lea dx,enceypt
  int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  MOV AH,9
  LEA DX , FINISH
  INT 21H
.exit
end