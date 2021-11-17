function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out 
  fid = fopen(nume, 'r');
  N = fscanf(fid, '%d', 1);
  k = 1;
  while k <= N + 1
    fgets(fid);
    k = k + 1;
  end
  
  %citesc val1 si val2
  val1 = fscanf(fid, '%f', 1);
  val2 = fscanf(fid, '%f', 1);
  %concatenez .out la fisierul de input, pentru a forma numele fisierului de output
  fisier = strcat(nume, '.out');
  %deschid fisierul de output
  fid2 = fopen(fisier, 'w');
  fprintf(fid2, '%d\n\n', N);
  
  % algoritmul Iterative
  R1 = Iterative(nume, d, eps);
  %scriu in fisier
  fprintf(fid2, '%.6f\n', R1);
  fprintf(fid2, '\n');
  % algoritmul ALgebraic
  R2 = Algebraic(nume, d);
  %scriu in fisier
  fprintf(fid2, '%.6f\n', R2);
  fprintf(fid2, '\n');
  
  % se ordoneaza descrescator vectorul de Page-Rank
  v = R2;
  nod = [1 : N];
  for i = 1 : N - 1
    for j = i + 1 : N
      if v(i) <= v(j)
        aux = v(i);
        v(i) = v(j);
        v(j) = aux;
        aux = nod(i);
        nod(i) = nod(j);
        nod(j) = aux;
      endif
    endfor
  endfor

  i = 1;
  while i <= N
    rez(i) = Apartenenta(v(i), val1, val2);  %calculez apartenenta
    i = i + 1;
  endwhile
  
  i = 1;
  while i <= N
    fprintf(fid2, '%d %d %.6f\n', i, nod(i), rez(i));
    i = i + 1;
  endwhile
  
  %inchid fisierele
  fclose(fid2);
  fclose(fid);
 
endfunction
