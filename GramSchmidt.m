% Functia pentru calculul matricelor Q si R din descompunerea matricei A
% utilizand algoritmul Gram-Schmidt modificat
function [Q, R] = GramSchmidt(A)
    % Creez variabila N pentru a retine marimea lui A
    N = size(A);
    % Initializez matricile Q si R ca fiind nule si de marimea lui A
    Q = zeros(N);
    R = zeros(N);
    % Codul preluat din pseudocdul dat in laboratorul 3, sectia 'Algoritmul
    % Gram-Schmidt modificat'
    for i = 1 : N
        R(i, i) = norm(A(:, i));
        Q(:, i) = (1 / R(i, i)) * A(:, i);
        for j = i + 1 : N
            R(i, j) = Q(:, i)' * A(:, j);
            A(:, j) = A(:, j) - Q(:, i) * R(i, j);
        end
    end
end

