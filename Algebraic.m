% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
% Intrari: 
%	-> nume: numele fisierului in care se scrie;
%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
% Iesiri:
%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
function R = Algebraic(nume, d)
    % Deschid fisierul dat ca parametru
    fileName = fopen(nume);
    % Citesc numarul de pagini N din fisier
    N = fscanf(fileName, "%d\n", 1);
    % Initializez matricele de adiacenta si de probabilitati la marimea N
    Adj = zeros(N);
    A = zeros(N);
    % Parcurg cele N liste de adiacenta
    for i = 1 : N
        % Initial, citesc intr-un string fiecare lista de adiacenta
        auxStr = fgetl(fileName);
        % Convertesc stringurile in vectori linie
        auxV = str2num(auxStr);
        % Retin in sz cel de-al doilea argument al functiei size(auxV):
        % numarul de coloane al matricii auxV
        [~, sz] = size(auxV);
        % Pentru a sari peste indicele paginii in sine si numarul de pagini
        % spre care aceasta are linkuri, parcurg vectorul auxV de la al
        % 3lea element, de unde incep linkurile propriu-zise spre alte
        % pagini
        for j = 3 : sz
            % Exclud cazul de exceptie in care o pagina are link spre ea
            % insasi, comparand elementul din lista de adiacenta cu
            % indicele paginii in sine
            if auxV(j) ~= auxV(1)
                % Daca nu e link spre propria pagina, elementul din
                % matricea de adiacenta de pe linia paginii parcurse si 
                % coloana paginii spre care are link devine 1
                Adj(auxV(1), auxV(j)) = 1;
            end
        end
    end
    % Calculez, cu ajutorul functiei sum(), in vectorul coloana lSum,
    % sumele pe linie ale matricei de adiacenta Adj
    lSum = sum(Adj, 2);
    % K este aceeasi matrice ca la functia Iterative(), care contine pe
    % diagonala principala numarul de linkuri spre care duce fiecare pagina
    K = zeros(N);
    for i = 1 : N
        % Matricea diagonala care contine numarul de linkuri de pe fiecare
        % linie pe diagonala principala are elementele de pe diagonala
        % sumele pe linie ale matricii A, calculate in auxV
        K(i, i) = lSum(i);
    end
    % Matricea A de probabilitati de accesare a paginilor este construita
    % din formula preluata din algoritmul Iterative de pe Wikipedia
    A = (PR_Inv(K) * Adj)';
    b = ((1 - d) / N) * ones(N);
    % Din formula algebrica de pe Wikipedia R = b + d * A * R, se poate
    % rescrie ca fiind (I - d * A) * R = b, adica R = (I - d * A)^-1 * b.
    % Utilizez functia scrisa de mine PR_Inv() pentru a calcula inversa
    % matricei I - d * A, astfel calculand vectorul de pagerank R
    R = PR_Inv(eye(N) - d * A) * b;
    % Se inchide fisierul
    fclose(fileName);
end
