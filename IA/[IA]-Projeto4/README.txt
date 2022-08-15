Aluno: Lucas Garavaglia

Para a execução do programa basta executar o arquivo p4.pl.
No Linux: swipl p4.pl.
O arquivo de entrada deve ter o formato de um arquivo prolog e a extensão .pl.


Para saber em quais estações, linhas e a distancia da estação o trem vai passar
basta digitar: 
X: Deve colocar a estação de origem desejada.
Y: Deve colocar a estação de destino desejada.
Dist: Distancia total.
Cam: Caminho percorrido.
Linhas: Linhas percorridas.
caminho(X,Y,Dist,Cam,Linhas).

exemplo de uso para o arquivo input.pl:
caminho(a,h,Dist,Cam,Linhas).
saida:
Dist = 6,
Cam = [a, b, d, h],
Linhas = [linha1, linha4, linha10] ;
Dist = 9.7,
Cam = [a, c, d, h],
Linhas = [linha2, linha7, linha10] ;
false.
