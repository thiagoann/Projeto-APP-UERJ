import "dart:io";

class Pecas {
  //Indicar as pecas disponiveis
  //FEITO

  String nomePeca;
  int numPeca;

  Pecas(this.nomePeca, this.numPeca);

  @override
  String toString() => "${nomePeca} : ${numPeca}";
}

class tabuleiro {
  List tabulJogo = [];
  var linhas;
  var i, j;

  tabuleiro() {
    //Constructor

    for (i = 0; i < 3; i++) {
      tabulJogo.add(List.generate(3, (i) => Posicao()));
    }
  }

  void desenharTabueleiro() {
    for (linhas in tabulJogo) {
      for (var posicao in linhas) {
        stdout.write(' | $posicao |');
      }
      print('');
    }
    print('');
  }
} //end of constructor tabuleiro
//end of class

class Posicao {
  Pecas? pecaInserida;

  Posicao({this.pecaInserida = null});

  bool vazio() {
    if (this.pecaInserida == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String toString() => '${pecaInserida ?? "Vazio"}';
}

class Jogador {
  List<Pecas> opcoesJogador1 = [];
  List<Pecas> pecasJogo = [];
  List<Pecas> opcoesJogador2 = [];
  var i;
  late String numeracaoPeca = '';
  String jogadorVez;

  Jogador({required String this.jogadorVez}) {
    for (i = 1; i <= 9; i++) {
      pecasJogo.add(Pecas(this.jogadorVez, i));
    }
    for (i = 1; i <= 9; i++) {
      if (i % 2 != 0) {
        opcoesJogador1.add(Pecas(this.jogadorVez, i));
      } else {
        opcoesJogador2.add(Pecas(this.jogadorVez, i));
      }
    }
  }
  void InserirPecas(
      tabuleiro tabul, int numeroEscolhido, int posJogolin, int posJogoCol) {
    Posicao pos = tabul.tabulJogo[posJogolin][posJogoCol];
    if (pos.vazio() || pos.pecaInserida!.numPeca < numeroEscolhido) {
      for (i = 0; i < opcoesJogador1.length; i++) {
        if (opcoesJogador1[i].numPeca == numeroEscolhido) {
          tabul.tabulJogo[posJogolin][posJogoCol].pecaInserida =
              opcoesJogador1.removeAt(i);
        }
      }
      for (i = 0; i < opcoesJogador2.length; i++) {
        if (opcoesJogador2[i].numPeca == numeroEscolhido) {
          tabul.tabulJogo[posJogolin][posJogoCol].pecaInserida =
              opcoesJogador2.removeAt(i);
        }
      }
    }
  }
}

class Jogo {
  var posLin, posCol;
  tabuleiro tabul = tabuleiro();
  num somaDiagPrincip = 0, somaDiagSecund = 0;
  num somaLinhas = 0, somaCols = 0;
  var i, j;
  final Jogador j1;
  final Jogador j2;
  final List vecJogadores; //vetor vazio
  // Pecas? x;
  // Posicao pos = Posicao(pecaInserida: x);

  Jogo({Jogador? j1, Jogador? j2})
      : j1 = j1 ?? Jogador(jogadorVez: ''),
        j2 = j2 ?? Jogador(jogadorVez: ''),
        vecJogadores = [j1, j2];

  bool haVencedor() {
    var somaDiagPrincip;
    var somaDiagSecund;
    var somaLinha1,somaLinha2,somaLinha3;
    var somaCol1, somaCol2, somaCol3;

    somaDiagPrincip = tabul.tabulJogo[0][0] + tabul.tabulJogo[1][1]+ tabul.tabulJogo[2][2];
    somaDiagSecund = tabul.tabulJogo[2][0]+ tabul.tabulJogo[1][1]+ tabul.tabulJogo[0][2];

    //Calculo da soma das linhas

    somaLinha1 = tabul.tabulJogo[0][0]+tabul.tabulJogo[0][1]+tabul.tabulJogo[0][2];
    somaLinha2 = tabul.tabulJogo[1][0]+tabul.tabulJogo[1][1]+tabul.tabulJogo[1][2];
    somaLinha3 = tabul.tabulJogo[2][0]+tabul.tabulJogo[2][1]+tabul.tabulJogo[2][2];

    // //Calculo da soma das colunas
    somaCol1 = tabul.tabulJogo[0][0]+tabul.tabulJogo[1][0]+tabul.tabulJogo[2][0];
    somaCol2 = tabul.tabulJogo[0][1]+tabul.tabulJogo[1][1]+tabul.tabulJogo[2][1];
    somaCol3 = tabul.tabulJogo[0][2]+tabul.tabulJogo[1][2]+tabul.tabulJogo[2][2];
    //Checa se houve vencedor
    if (somaDiagPrincip == 15) {
      print("Ha vencedor.\n");
      return true;
    } else if (somaDiagSecund == 15) {
      print("Ha vencedor.\n");
      return true;
    } else if (somaLinha1 == 15) {
      print("Ha vencedor.\n");
      return true;
    }else if(somaLinha2==15){
      print("Ha vencedor.\n");
      return true;
    }else if(somaLinha3==15){
      print("Ha vencedor.\n");
      return true;
    } else if (somaCol1 == 15) {
      print("Ha vencedor.\n");
      return true;
    } else if (somaCol2 == 15) {
      print("Ha vencedor.\n");
      return true;
    }else if (somaCol3 == 15) {
      print("Ha vencedor.\n");
      return true;
    } else {
      print("Empate.\n");
      return false;
    }
  }
  void rodar_prog() {
    bool havencedor = false;
    while (!havencedor) {
      //enquanto nao houver vencedor
      for (Jogador jogador in vecJogadores) {
        if (jogador == j1) {
          print("Jogador_${jogador.jogadorVez} => ${jogador.opcoesJogador1}");
          tabul.desenharTabueleiro();
          stdout.write(
              'Jogador_${jogador.jogadorVez}=>Insira uma peca no formato: (peca, posLin, posCol) ');
          var num = stdin.readLineSync()?.split(',');
          jogador.InserirPecas(
              tabul, int.parse(num![0]), int.parse(num[1]), int.parse(num[2]));
        } else {
          print("Jogador_${jogador.jogadorVez} => ${jogador.opcoesJogador2}");
          tabul.desenharTabueleiro();
          stdout.write(
              'Jogador_${jogador.jogadorVez}=>Insira uma peca no formato: (peca, posLin, posCol) ');
          var num = stdin.readLineSync()?.split(',');
          jogador.InserirPecas(
              tabul, int.parse(num![0]), int.parse(num[1]), int.parse(num[2]));
        }
        havencedor = this.haVencedor();
        if (havencedor) {
          break;
        }
      }
    }
  }

} //end of class Jogo

void main() {
  var nTicTacToe =
      Jogo(j1: Jogador(jogadorVez: "T"), j2: Jogador(jogadorVez: "C"));
  nTicTacToe.rodar_prog();
}
