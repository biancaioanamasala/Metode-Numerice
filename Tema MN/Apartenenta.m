function y = Apartenenta(x, val1, val2)
	% Functia care primeste ca parametrii x, val1, val2 si care calculeaza valoarea functiei membru in punctul x.
	% Stim ca 0 <= x <= 1 
	% Se rezolva sistemul cu ajutorul formei matriceale
  aux = [0; 1];
  A(1, 2) = 1;
  A(2, 2) = 1;
  A(1, 1) = val1;
  A(2, 1) = val2;
  
  % se tine cont de intervalele date 
  if x >= 0 && x < val1
    y = 0;
  elseif x > val2 && x <= 1
    y = 1;
  elseif x >= val1 && x <= val2
    M = PR_Inv(A) * aux;
    a = M(1, 1);
    b = M(2, 1);
    % se calculeaza valoarea functiei in punctul x
    y = a * x + b;
  else
    y = -1;
  endif
endfunction