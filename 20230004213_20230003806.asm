.data
msg_inicial: .asciz " Bem vindo ao casino do Arthur e do Davi!!! \n"
msg_opcao:   .asciz " O que deseja fazer? 1 para jogar de graça, 2 para jogar apostando e 3 para sair \n "
msg_aposta: .asciz "\n Digite o valor desejado para ser apostado: "
msg_player_option: .asciz " \n Qual a ação desejada? 1 para HIT, 2 para STAY \n"
msg_win: .asciz " \n Voce venceu \n"
msg_lose: .asciz "Voce perdeu"
player_card: .asciz "\n Cartas do player \n"
dealer_card: .asciz "\n Cartas do dealer \n"
.align 2
mao_player: .space 44
mao_dealer: .space 44
 .text
 main: 				#alunos: Arthur Antonio Bertoglio(20230004213) e Davi Augusto Marangoni Mocva(20230003803)
 	la a0, msg_inicial
 	addi a7,zero, 4
 	ecall
 	la a0, msg_opcao
 	addi a7,zero, 4
 	ecall
 	addi a7,zero,5
 	ecall
 	li t0, 1
 	li t1, 2
 	li t2, 3
 	beq a0,t0, joga
 	beq a0,t1, aposta
 	beq a0,t2, sair

sair: 	
 	addi a7,zero,10
 	ecall
 	
aposta: # parte ainda não implementada
 	la a0, msg_aposta
 	addi a7,zero, 4
 	ecall
 	addi a7,zero,5
 	ecall
 	j sair
joga:	addi s0,zero,0 # contador cartas player
 	addi s1,zero,0 # contador cartas dealer
 	
 	addi t4,zero,0 #contador de cartas
 	addi t5,zero,2# condição de parada
 	la s3, mao_player
 	la s4, mao_dealer
cartasP:beq t4,t5,cartasD
 	jal tirar_carta
 	sw a0, 0(s3)
 	add s0,s0,a0
 	addi t4,t4,1
 	addi s3,s3,4
 	j cartasP
 	addi t6,zero,0 #contador de cartas
cartasD:beq t6,t5,player_round
	jal tirar_carta
	sw a0, 0(s4)
 	add s1,s1,a0
	addi t6,t6,1
 	addi s4,s4,4
 	j cartasD
player_round: 
 	jal mostra_carta
 	la a0, msg_player_option
 	addi a7,zero,4
 	ecall
 	addi a7,zero,5
 	ecall
 	beq a0,t0,hit
 	beq a0,t1,stay
hit: 	jal tirar_carta
	la s3 mao_player
	sw a0 8(s3)
	add s0,s0,a0
	addi t4,t4,1
	j player_round
stay:	bge s0,s1,player_win
	j player_lose
player_win:	la a0, msg_win
		addi a7,zero,4
		ecall
		jal sair
player_lose:	la a0, msg_lose
		addi a7,zero,4
		ecall
		jal sair
	
  
tirar_carta: 	
		addi a0,zero,1 # define a menor quantidade que a carta pode assumir
 		addi a1,zero,13 # define a maior quantidade que a carta pode assumir
 		addi a7,zero,42
 		ecall
 		ret
 		
mostra_carta:	la a0,player_card
		addi a7,zero,4
		ecall 	
		addi t2,zero,0#contador
		la s3, mao_player
loop_mostra:	beq t2,t4,mostraD
		lw a0, 0(s3)
		addi a7,zero,1
		ecall
		li a0,10
		li a7,11
		ecall
		addi t2,t2,1
		addi s3,s3,4
		j loop_mostra
mostraD:	la a0,dealer_card
		addi a7,zero,4
		ecall
		addi t2,zero,0
		la s4, mao_dealer
loop_d:		beq t2,t6,end_mostra
		lw a0, 0(s4)
		addi a7,zero,1
		ecall
		li a0,10
		li a7,11
		ecall
		addi t2,t2,1
		addi s4,s4,4
		j loop_d
end_mostra:	ret
		
