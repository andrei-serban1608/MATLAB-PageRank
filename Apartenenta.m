% Functia care primeste ca parametrii x, val1, val2 si care calculeaza valoarea functiei membru in punctul x.
% Stim ca 0 <= x <= 1

% Pentru ca functia u(x) sa fie continua, aceasta trebuie sa aiba limitele
% laterale egale in punctele de discontinuitate. Altfel zis, trebuie ca
% val1 * a + b = 0 si val2 * a + b = 1. Rezolvat in functie de a si b, asta
% inseamna ca b = -val1 / (val2 - val1) si a = 1 / (val2 - val1). Asadar,
% implementez cei doi coeficienti in functie de aceasta solutie.
function y = Apartenenta(x, val1, val2)
    b = -val1 / (val2 - val1);
    a = 1 / (val2 - val1);
    % Primul brat al functiei membru
    if x >= 0 && x < val1
        y = 0;
    end
    % Al doilea brat al functiei membru
    if x >= val1 && x <= val2
        y = a * x + b;
    end
    % Ultimul brat al functiei membru
    if x > val2 && x <= 1
        y = 1;
    end
end
	