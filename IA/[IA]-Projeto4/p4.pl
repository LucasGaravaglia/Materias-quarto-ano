:- include(input).


% Predicato que mostra os caminhos possiveis de X a Y*
caminho(X,Y,Len,Estacoes,Linhas):-
  caminhoAuxiliar(X,[Y],0,Len,Estacoes,H),
  reverse(H, Linhas). % inverte a lista de linhas para mostrar na ordem correta

% Caso base para exibir os caminhos.
caminhoAuxiliar(X,[X|Y1],Len, Len, [X|Y1],[]).

% Chamada recursiva para os caminhos possiveis.
caminhoAuxiliar(X,[X1|Y1],Dist,DistF,CamF,[L1|L]):-
  pode_ir(Z,X1,D1,L1),
  D2 is Dist+D1,
  caminhoAuxiliar(X,[Z,X1|Y1],D2,DistF,CamF,L).
