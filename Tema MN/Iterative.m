function R = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
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
        % paginile cu linkuri catre ele
        matrice(nod, vecin) = 1;
        else
          matrice(nod, vecin) = 0;
      endif
    endfor
    i = i + 1;
  endwhile
  val1 = fscanf(fid, '%f', 1);
  val2 = fscanf(fid, '%f', 1);
  
  % calculul matricelor
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

  M = K * matrice;
  M = M';
  
  % se initializeaza vectorul de page-rankuri
  R_l = zeros(N, 1);
  i = 1;
  while i <= N
    R_l(i) = 1 / N;
    i = i + 1;
  endwhile
  % se opreste cand cand este atinsa toleranta
  v = ones(N, 1);
  min = 99999;
  while min >= eps
    R = d * M * R_l + (1 - d) / N * v;
    min = norm(R - R_l);
    if norm(R - R_l) <= eps
      break;
    endif
    R_l = R;
  endwhile
  R = R_l;
  
  fclose(fid);
  %inchid fisierul