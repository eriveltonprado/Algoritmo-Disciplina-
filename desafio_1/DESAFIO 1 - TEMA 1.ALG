Algoritmo "Desafio 1 - Tema 1"
// Disciplina  : Algoritmo e Lógica de Programação
// Professor   : André Olímpio
// Descrição   : Sistema de Gerenciamento de Campeonato de E-Sports
// Autor(a)    : Erivelton Alexandre do Prado RA 02610572
// Data atual  : 29/09/2026

Const
   ptsVitoria = 3
   ptsEmpate = 1
   derrota = 0
   maxEquipe = 5

Tipo
   equipe = registro
      codigo: inteiro
      nomeEquipe, capitao: caractere
      qtdVitorias, qtdEmpates, qtdDerrotas: inteiro
      ptsMarcados, ptsSofridos: inteiro
      saldoPontos, pontuacao: inteiro
   fimregistro

Var
// Seção de variáveis globais
   vetEquipes: vetor[1..maxEquipe] de equipe
   confrontos: vetor[1..maxEquipe,1..maxEquipe] de inteiro // Matriz verifica quantas vezes as equipes se enfrentaram
   totalEquipes, totalPartidas: inteiro
   opcaoMenu: inteiro

// Seção de sub-rotinas

procedimento inicializar()
var
   i, j: inteiro
inicio
   totalEquipes <- 0
   totalPartidas <- 0

   para i de 1 ate maxEquipe faca
      para j de 1 ate maxEquipe faca
         confrontos[i,j] <- 0
      fimpara
   fimpara
fimprocedimento


funcao buscarEquipe(cod: inteiro): inteiro
var
   indice, achou: inteiro
inicio
   achou <- 0

   se (totalEquipes > 0) entao
      para indice de 1 ate totalEquipes faca
         se (vetEquipes[indice].codigo = cod) entao
            achou <- indice
         fimse
      fimpara
   fimse

   retorne achou
fimfuncao


procedimento cadastrar(var quantidade: inteiro)
var
   novoCod: inteiro
   novoNome, novoCapitao: caractere
inicio
   escreval("Cadastrar equipe")

   se (quantidade >= maxEquipe) entao
      escreval("Capacidade máxima atingida!")
   senao
      escreva("Código da Equipe: ")
      leia(novoCod)

      se (novoCod <= 0) entao
         escreval("Erro: O código deve ser maior que zero!")
      senao
         se (buscarEquipe(novoCod) > 0) entao
            escreval("Este código já existe! Cadastro não permitido.")
         senao
            repita
               escreva("Nome da Equipe: ")
               leia(novoNome)

               se (novoNome = "") entao
                  escreval("Erro: O nome da equipe não pode ficar vazio!")
               fimse
            ate (novoNome <> "")

            repita
               escreva("Nome do Capitão: ")
               leia(novoCapitao)

               se (novoCapitao = "") entao
                  escreval("Erro: O nome do capitão não pode ficar vazio!")
               fimse
            ate (novoCapitao <> "")

            quantidade <- quantidade + 1
            vetEquipes[quantidade].codigo <- novoCod
            vetEquipes[quantidade].nomeEquipe <- novoNome
            vetEquipes[quantidade].capitao <- novoCapitao

            vetEquipes[quantidade].pontuacao <- 0
            vetEquipes[quantidade].qtdVitorias <- 0
            vetEquipes[quantidade].qtdEmpates <- 0
            vetEquipes[quantidade].qtdDerrotas <- 0
            vetEquipes[quantidade].ptsMarcados <- 0
            vetEquipes[quantidade].ptsSofridos <- 0
            vetEquipes[quantidade].saldoPontos <- 0

            escreval("Equipe registrada com sucesso!")
         fimse
      fimse
   fimse
   escreval
fimprocedimento


procedimento listarEquipes()
var
   i: inteiro
inicio
   escreval("Lista de equipes")

   se (totalEquipes = 0) entao
      escreval("Nenhuma equipe cadastrada.")
   senao
      para i de 1 ate totalEquipes faca
         escreval(vetEquipes[i].codigo, " - ", vetEquipes[i].nomeEquipe, " | Capitão: ", vetEquipes[i].capitao)
      fimpara
   fimse
   escreval
fimprocedimento


procedimento registrarPartida(var quantidade: inteiro)
var
   cod1, cod2, posi1, posi2: inteiro
   ptsPartida1, ptsPartida2: inteiro
inicio
   escreval("Registrar resultado de partida")

   se (totalEquipes < 2) entao
      escreval("Cadastre pelo menos duas equipes para registrar uma partida.")
   senao
      escreva("Código da primeira equipe: ")
      leia(cod1)
      posi1 <- buscarEquipe(cod1)

      escreva("Código da segunda equipe: ")
      leia(cod2)
      posi2 <- buscarEquipe(cod2)

      se (posi1 = 0) ou (posi2 = 0) entao
         escreval("Erro: Uma ou ambas as equipes não foram localizadas.")
      senao
         se (posi1 = posi2) entao
            escreval("Erro: Uma equipe não pode jogar contra ela própria!")
         senao
            repita
               escreva("Pontos marcados pela equipe ", vetEquipes[posi1].nomeEquipe, ": ")
               leia(ptsPartida1)

               se (ptsPartida1 < 0) entao
                  escreval("Erro: Os pontos não podem ser negativos!")
               fimse
            ate (ptsPartida1 >= 0)

            repita
               escreva("Pontos marcados pela equipe ", vetEquipes[posi2].nomeEquipe, ": ")
               leia(ptsPartida2)

               se (ptsPartida2 < 0) entao
                  escreval("Erro: Os pontos não podem ser negativos!")
               fimse
            ate (ptsPartida2 >= 0)

            confrontos[posi1,posi2] <- confrontos[posi1,posi2] + 1
            confrontos[posi2,posi1] <- confrontos[posi2,posi1] + 1
            quantidade <- quantidade + 1

            // Atualização das estatísticas
            vetEquipes[posi1].ptsMarcados <- vetEquipes[posi1].ptsMarcados + ptsPartida1
            vetEquipes[posi1].ptsSofridos <- vetEquipes[posi1].ptsSofridos + ptsPartida2
            vetEquipes[posi1].saldoPontos <- vetEquipes[posi1].ptsMarcados - vetEquipes[posi1].ptsSofridos

            vetEquipes[posi2].ptsMarcados <- vetEquipes[posi2].ptsMarcados + ptsPartida2
            vetEquipes[posi2].ptsSofridos <- vetEquipes[posi2].ptsSofridos + ptsPartida1
            vetEquipes[posi2].saldoPontos <- vetEquipes[posi2].ptsMarcados - vetEquipes[posi2].ptsSofridos

            // Define o resultado final
            se (ptsPartida1 > ptsPartida2) entao
               vetEquipes[posi1].pontuacao <- vetEquipes[posi1].pontuacao + ptsVitoria
               vetEquipes[posi1].qtdVitorias <- vetEquipes[posi1].qtdVitorias + 1
               vetEquipes[posi2].pontuacao <- vetEquipes[posi2].pontuacao + derrota
               vetEquipes[posi2].qtdDerrotas <- vetEquipes[posi2].qtdDerrotas + 1
            senao
               se (ptsPartida2 > ptsPartida1) entao
                  vetEquipes[posi2].pontuacao <- vetEquipes[posi2].pontuacao + ptsVitoria
                  vetEquipes[posi2].qtdVitorias <- vetEquipes[posi2].qtdVitorias + 1
                  vetEquipes[posi1].pontuacao <- vetEquipes[posi1].pontuacao + derrota
                  vetEquipes[posi1].qtdDerrotas <- vetEquipes[posi1].qtdDerrotas + 1
               senao
                  vetEquipes[posi1].pontuacao <- vetEquipes[posi1].pontuacao + ptsEmpate
                  vetEquipes[posi1].qtdEmpates <- vetEquipes[posi1].qtdEmpates + 1
                  vetEquipes[posi2].pontuacao <- vetEquipes[posi2].pontuacao + ptsEmpate
                  vetEquipes[posi2].qtdEmpates <- vetEquipes[posi2].qtdEmpates + 1
               fimse
            fimse

            escreval("Partida registrada com sucesso!")
         fimse
      fimse
   fimse
   escreval
fimprocedimento


procedimento consultarEquipe()
var
   codBusca, posicaoBusca: inteiro
inicio
   escreva("Digite o código para busca: ")
   leia(codBusca)
   posicaoBusca <- buscarEquipe(codBusca)

   se (posicaoBusca > 0) entao
      escreval("Consultar equipe")
      escreval("Código: ", vetEquipes[posicaoBusca].codigo)
      escreval("Nome: ", vetEquipes[posicaoBusca].nomeEquipe)
      escreval("Capitão: ", vetEquipes[posicaoBusca].capitao)
      escreval("Pontuação geral: ", vetEquipes[posicaoBusca].pontuacao)
      escreval("Vitórias: ", vetEquipes[posicaoBusca].qtdVitorias, " | Empates: ", vetEquipes[posicaoBusca].qtdEmpates, " | Derrotas: ", vetEquipes[posicaoBusca].qtdDerrotas)
      escreval("Pontos Marcados: ", vetEquipes[posicaoBusca].ptsMarcados, " | Sofridos: ", vetEquipes[posicaoBusca].ptsSofridos, " | Saldo: ", vetEquipes[posicaoBusca].saldoPontos)
   senao
      escreval("Equipe não encontrada!")
   fimse
   escreval
fimprocedimento


// Classificação das equipes por pontuação, vitórias, saldo de pontos e pontos marcados
procedimento ordenarClassificacao()
var
   x, y, k, auxConfronto: inteiro
   aux: equipe
   trocar: logico
inicio
   se (totalEquipes > 1) entao
      para x de 1 ate (totalEquipes - 1) faca
         para y de 1 ate (totalEquipes - x) faca
            trocar <- falso

            se (vetEquipes[y].pontuacao < vetEquipes[y+1].pontuacao) entao
               trocar <- verdadeiro
            senao
               se (vetEquipes[y].pontuacao = vetEquipes[y+1].pontuacao) entao
                  se (vetEquipes[y].qtdVitorias < vetEquipes[y+1].qtdVitorias) entao
                     trocar <- verdadeiro
                  senao
                     se (vetEquipes[y].qtdVitorias = vetEquipes[y+1].qtdVitorias) entao
                        se (vetEquipes[y].saldoPontos < vetEquipes[y+1].saldoPontos) entao
                           trocar <- verdadeiro
                        senao
                           se (vetEquipes[y].saldoPontos = vetEquipes[y+1].saldoPontos) e (vetEquipes[y].ptsMarcados < vetEquipes[y+1].ptsMarcados) entao
                              trocar <- verdadeiro
                           fimse
                        fimse
                     fimse
                  fimse
               fimse
            fimse

            se (trocar = verdadeiro) entao
               aux <- vetEquipes[y]
               vetEquipes[y] <- vetEquipes[y+1]
               vetEquipes[y+1] <- aux

               // As linhas e colunas acompanham a posição das equipes
               para k de 1 ate maxEquipe faca
                  auxConfronto <- confrontos[y,k]
                  confrontos[y,k] <- confrontos[y+1,k]
                  confrontos[y+1,k] <- auxConfronto
               fimpara

               para k de 1 ate maxEquipe faca
                  auxConfronto <- confrontos[k,y]
                  confrontos[k,y] <- confrontos[k,y+1]
                  confrontos[k,y+1] <- auxConfronto
               fimpara
            fimse
         fimpara
      fimpara
   fimse
fimprocedimento


procedimento exibirClassificacao()
var
   i: inteiro
inicio
   escreval("Classificação geral")

   se (totalEquipes = 0) entao
      escreval("Nenhuma equipe cadastrada.")
   senao
      ordenarClassificacao()

      escreval("Pos | Nome do Time | Pts | Vit | Emp | Der | PM | PS | Saldo")
      para i de 1 ate totalEquipes faca
         escreval(i, " | ", vetEquipes[i].nomeEquipe, " | ", vetEquipes[i].pontuacao, " | ", vetEquipes[i].qtdVitorias, " | ", vetEquipes[i].qtdEmpates, " | ", vetEquipes[i].qtdDerrotas, " | ", vetEquipes[i].ptsMarcados, " | ", vetEquipes[i].ptsSofridos, " | ", vetEquipes[i].saldoPontos)
      fimpara
   fimse
   escreval
fimprocedimento


procedimento exibirEstatisticas()
var
   i, totVitorias, totEmpates, ptsTotais: inteiro
   idMaisVit, idMaisPts, idMaisSaldo, idMaisAtaque: inteiro
   mediaPontos: real
inicio
   escreval("Estatísticas do campeonato")
   escreval("Total de equipes cadastradas: ", totalEquipes)
   escreval("Total de partidas realizadas: ", totalPartidas)

   totVitorias <- 0
   totEmpates <- 0
   ptsTotais <- 0
   mediaPontos <- 0

   se (totalEquipes > 0) entao
      idMaisVit <- 1
      idMaisPts <- 1
      idMaisSaldo <- 1
      idMaisAtaque <- 1

      para i de 1 ate totalEquipes faca
         totVitorias <- totVitorias + vetEquipes[i].qtdVitorias
         totEmpates <- totEmpates + vetEquipes[i].qtdEmpates
         ptsTotais <- ptsTotais + vetEquipes[i].ptsMarcados

         se (vetEquipes[i].qtdVitorias > vetEquipes[idMaisVit].qtdVitorias) entao
            idMaisVit <- i
         fimse

         se (vetEquipes[i].pontuacao > vetEquipes[idMaisPts].pontuacao) entao
            idMaisPts <- i
         fimse

         se (vetEquipes[i].saldoPontos > vetEquipes[idMaisSaldo].saldoPontos) entao
            idMaisSaldo <- i
         fimse

         se (vetEquipes[i].ptsMarcados > vetEquipes[idMaisAtaque].ptsMarcados) entao
            idMaisAtaque <- i
         fimse
      fimpara
   fimse

   escreval("Quantidade de vitórias na competição: ", totVitorias)
   escreval("Quantidade de empates na competição: ", (totEmpates / 2))

   se (totalPartidas > 0) entao
      mediaPontos <- ptsTotais / totalPartidas
      escreval("Média de pontos marcados por partida: ", mediaPontos:0:2)

      escreval("Equipes com maior pontuação:")
      para i de 1 ate totalEquipes faca
         se (vetEquipes[i].pontuacao = vetEquipes[idMaisPts].pontuacao) entao
            escreval(vetEquipes[i].nomeEquipe)
         fimse
      fimpara

      escreval("Equipes com maior número de vitórias:")
      para i de 1 ate totalEquipes faca
         se (vetEquipes[i].qtdVitorias = vetEquipes[idMaisVit].qtdVitorias) entao
            escreval(vetEquipes[i].nomeEquipe)
         fimse
      fimpara

      escreval("Equipes com maior saldo de pontos:")
      para i de 1 ate totalEquipes faca
         se (vetEquipes[i].saldoPontos = vetEquipes[idMaisSaldo].saldoPontos) entao
            escreval(vetEquipes[i].nomeEquipe)
         fimse
      fimpara

      escreval("Equipes com mais pontos marcados:")
      para i de 1 ate totalEquipes faca
         se (vetEquipes[i].ptsMarcados = vetEquipes[idMaisAtaque].ptsMarcados) entao
            escreval(vetEquipes[i].nomeEquipe)
         fimse
      fimpara
   senao
      escreval("Nenhuma partida realizada.")
   fimse
   escreval
fimprocedimento


procedimento consultarConfrontos()
var
   cod1, cod2, posi1, posi2: inteiro
inicio
   escreval("Consultar confrontos")

   escreva("Código da primeira equipe: ")
   leia(cod1)

   escreva("Código da segunda equipe: ")
   leia(cod2)

   posi1 <- buscarEquipe(cod1)
   posi2 <- buscarEquipe(cod2)

   se (posi1 > 0) e (posi2 > 0) entao
      se (posi1 = posi2) entao
         escreval("Erro: Informe duas equipes diferentes!")
      senao
         escreval("Total de confrontos: ", confrontos[posi1,posi2])
      fimse
   senao
      escreval("Uma ou ambas as equipes não foram localizadas.")
   fimse
   escreval
fimprocedimento


procedimento iniciarCampeonato(n: inteiro)
inicio
   se (n <= 0) entao
      escreval("Campeonato iniciado!")
   senao
      escreval(n, "...")
      iniciarCampeonato(n - 1)
   fimse
fimprocedimento


Inicio
   inicializar()

   repita
      escreval("Campeonato ARENA CODE")
      escreval("1. Cadastrar equipe")
      escreval("2. Listar equipes")
      escreval("3. Iniciar campeonato")
      escreval("4. Registrar resultado de partida")
      escreval("5. Consultar equipe")
      escreval("6. Exibir classificação geral")
      escreval("7. Exibir estatísticas do campeonato")
      escreval("8. Consultar confrontos")
      escreval("9. Encerrar sistema")
      escreval
      escreva("Opção: ")
      leia(opcaoMenu)
      escreval

      escolha (opcaoMenu)
         caso 1
            cadastrar(totalEquipes)

         caso 2
            listarEquipes()

         caso 3
            iniciarCampeonato(5)

         caso 4
            registrarPartida(totalPartidas)

         caso 5
            consultarEquipe()

         caso 6
            exibirClassificacao()

         caso 7
            exibirEstatisticas()

         caso 8
            consultarConfrontos()

         caso 9
            escreval

         outrocaso
            escreval("Opção inválida! Tente novamente.")
      fimescolha
   ate (opcaoMenu = 9)

Fimalgoritmo