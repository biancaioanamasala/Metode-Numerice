function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
  % Se va inlocui aceasta linie cu descrierea algoritmului de inversare 
  % matricea ortogonale Q
  [m n] = size(A);
  Q = [];
  %for k = 1 : n
  k = 1;
  while k <= n
    q = A(1 : m, k);
    tmp = q;
    for j = 1 : k - 1
      % produsul scalar
      ps = sum(tmp .* Q(:, j));
      q = q - ps * Q(1 : m, j);
    end
    % normalizarea si adaugarea vectorului
    q = q / norm(q);
    Q = [Q q]; 
    k = k + 1; 
  end
  % aplicam formula
  R = Q' * A;
  I = Q' * eye(n);
  B = zeros(n);
  for j = 1 : n
	  for i = n : - 1 : 1
      aux1 = I(i, j);
      aux2 = R(i, i + 1 : n);
      aux3 = B(i + 1 : n, j);
      aux4 = R(i, i);
		  B(i ,j) = (aux1 - aux2 * aux3) / aux4;
	  end
  end

endfunction
