function R = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
	fid = fopen(nume, 'r');
  N = fscanf(fid, '%d', 1);
  matrice = zeros(N, N);
  i = 1;
  while i <= N
    nod = fscanf(fid, '%d', 1);
    vecin = fscanf(fid, '%d', 1);
    for j = 1 : vecin
      vecin = fscanf(fid, '%d', 1);
      if nod != vecin
        % paginile cu link catre ele insele nu apar
        matrice(nod, vecin) = 1;
        else
          matrice(nod, vecin) = 0;
      endif
    endfor
    i = i + 1;
  endwhile
  
  % matricea de adiacenta
  K = zeros(N, N);
  i = 1;
  while i <= N
    K(i, i) = sum(matrice(i, :));
    i = i + 1;
  endwhile
  i = 1;
  while i <= N
    K(i, i) = 1 / K(i, i);
    i = i + 1;
  endwhile
  % calcule intermediare
  M = K * matrice;
  M = M';
  I = eye(N);   %matricea identitate
  v = ones(N, 1); %vector coloana cu N linii de 1
  
  % folosim formula data
  A = PR_Inv(I - d * M);
  B = (1 - d) / N * v;
  R = A * B;

endfunction
