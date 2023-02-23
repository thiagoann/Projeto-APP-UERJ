import "dart:io";

class Pecas {
  //Indicar as pecas disponiveis
  //FEITO

  String nomePeca;
  int numPeca;

  Pecas(this.nomePeca, this.numPeca);

  @override
  String toString() => "${this.nomePeca} : ${this.numPeca}";
}

class tabuleiro {
  late List tabulJogo;
  var input_linhas, input_colunas;
  var i, j;

  tabuleiro() {
    //Constructor

    print("Numero de linhas?");
    input_linhas = int.parse(stdin.readLineSync()!);
    if (input_linhas < 1) {
      print("Deve haver mais de uma linha para formar um tabuleiro!");
      input_linhas = int.parse(stdin.readLineSync()!);
    } //end of if

    print("Numero de colunas?");
    input_colunas = int.parse(stdin.readLineSync()!);
    if (input_colunas < 1) {
      print("Deve haver mais de uma linha para formar um tabuleiro!");
      input_colunas = int.parse(stdin.readLineSync()!);
    } //endof if

    List tabulJogo = List.generate(input_linhas, (i) => List.filled(input_colunas, 0),growable: false);
    this.tabulJogo = tabulJogo;
  } //end of constructor tabuleiro

  void desenharTabueleiro() {
    for (input_linhas in this.tabulJogo) {
      for (var posicao in input_linhas) {
        stdout.write(' | $posicao |');
      }
      print('');
    }
    print('');
  }
}
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
  String toString() => '${this.pecaInserida ?? "Vazio"}';
}

class Jogador {
  List<Pecas> opcoesJogador1 = [];
  List<Pecas> opcoesJogador2 = [];
  var i;
  late String numeracaoPeca = '';
  String jogadorVez;

  Jogador({required String this.jogadorVez}) {
    for (i = 1; i <= 9; i++) {
      if (i % 2 != 0) {
        this.opcoesJogador1.add(Pecas(numeracaoPeca, i));
      } else {
        opcoesJogador2.add(Pecas(numeracaoPeca, i));
      }
    }
  }
  void InserirPecas(tabuleiro tabul, int numeroEscolhido, int posJogolin, int posJogoCol) {
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

  Jogo({Jogador? j1, Jogador? j2})
      : j1 = j1 ?? Jogador(jogadorVez: ''),
        j2 = j2 ?? Jogador(jogadorVez: ''),
        vecJogadores = [j1, j2];

  void rodar_prog() {
    bool haVencedor = false;
    while (!haVencedor) {
      //enquanto nao houver vencedor
      for (Jogador jogador in this.vecJogadores) {
        print("Player_${jogador.jogadorVez} => ${jogador.opcoesJogador1}");
        this.tabul.desenharTabueleiro();
        stdout.write(
            'Jogador_${jogador.jogadorVez}=>Insira uma peca no formato: (peca, posLin, posCol) ');
        var num = stdin.readLineSync()?.split(',');
        jogador.InserirPecas(this.tabul, int.parse(num![0]), int.parse(num[1]),
            int.parse(num[2]));
        haVencedor = this.haVencedor();
        if (haVencedor) {
          break;
        }
      }
    }
  }

  bool haVencedor() {
    for (i = 0; i < tabul.input_linhas; i++) {
      this.somaCols = 0;
      for (j = 0; j < tabul.input_colunas; j++) {
        this.somaCols = somaCols;
        somaCols += tabul.tabulJogo[j][i];
      }
    }
    //Checa se houve vencedor
    if (somaDiagPrincip == 15) {
      print("Ha vencedor.\n");
      return true;
    } else if (somaDiagSecund == 15) {
      print("Ha vencedor.\n");
      return true;
    } else if (somaLinhas == 15) {
      print("Ha vencedor.\n");
      return true;
    } else if (somaCols == 15) {
      print("Ha vencedor.\n");
      return true;
    } else {
      print("Empate.\n");
      return false;
    }
  }
} //end of class Jogo

void main() {
  var nTicTacToe =
      Jogo(j1: Jogador(jogadorVez: "1"), j2: Jogador(jogadorVez: "2"));
  nTicTacToe.rodar_prog();
}
