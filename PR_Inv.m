% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
% Se va inlocui aceasta linie cu descrierea algoritmului de inversare
function B = PR_Inv(A)
    % In variabila N tin minte marimea matricei de intrare A
    N = size(A);
    % Initializez inversa B cu zero si creez matricea unitate de marime N,
    % numita I, pentru rezolvarea ecuatiei matriceale: A * B = I
    B = zeros(N);
    I = eye(N);
    % Cu ajutorul functiei auxiliare de descompunere cu Gram-Schmidt
    % initializez matricele Q si R, care ma vor ajuta in aflarea inversei
    [Q, R] = GramSchmidt(A);
    % Deoarece vreau sa rezolv sistemul A * B = I, iar A = Q * R, unde Q
    % este matrice ortogonala si R este superior triunghiulara => A * B = I
    % <=> Q * R * B = I <=> R * B = Q' * I. Iau fiecare coloana a
    % matricilor B si I cu contorul k, astfel ajungand la rezolvarea unui
    % sistem superior triunghiular R * x(k) = b(k), unde x(k) si b(k) sunt
    % cea de-a k coloana a matricei B, respectiv I.
    for k = 1 : N
        % Retin in variabilele auxiliare x si b, coloana de pe pozitia k a
        % matricelor B si I, la fiecare iteratie
        x = B(:, k);
        b = Q' * I(:, k);
        % Rezolv sistemul superior triunghiular R * x = b, cu ajutorul
        % formulei preluate din laboratorul 2, sectia 'Rezolvarea
        % sistemelor triunghiulare'
        for i = N : -1 : 1
            x(i) = b(i);
            for j = i + 1 : N
                x(i) = x(i) - R(i, j) * x(j);
            end
            x(i) = x(i) / R(i, i);
        end
        % La final, reinlocuiesc cea de-a k coloana a matricei B cu
        % vectorul coloana x, cu valorile calculate pentru a construi
        % inversa
        B(:, k) = x;
    end
end