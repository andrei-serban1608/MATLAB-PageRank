% Functia care calculeaza matricea R folosind algoritmul iterativ.
% Intrari:
%	-> nume: numele fisierului din care se citeste;
%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa 
%   continue navigarea (0.85 in cele mai multe cazuri)
%	-> eps: eruarea care apare in algoritm.
% Iesiri:
%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
function R = Iterative(nume, d, eps)
    % Se deschide fisierul dat ca parametru al functiei
    fileName = fopen(nume);
    % Se citeste numarul de N pagini din fisier
    N = fscanf(fileName, "%d\n", 1);
    % Initializez matricea A de adiacenta a grafului descris in fisierul de
    % intrare
    A = zeros(N);
    K = zeros(N);
    % Parcurg cele N liste de adiacenta din fisier cu un loop for
    for i = 1 : N
        % Citesc intr-o variabila auxiliara, ca string, fiecare lista de
        % adiacenta a grafului
        auxStr = fgetl(fileName);
        % Convertesc acea lista de adiacenta intr-un vector
        auxV = str2num(auxStr);
        % Retin in variabila sz cel de-al doilea argument al functiei
        % size() al vectorului - numarul de coloane / numarul de elemente
        % al vectorului linie
        [~, sz] = size(auxV);
        % Primul element al vectorului reprezinta indicele paginii, iar cel
        % de-al doilea reprezinta numarul de pagini spre care acea pagina
        % are link, de aceea parcurg paginile de la cel de-al 3lea element
        % pana la final pentru a le introduce in matricea de adiacenta
        for j = 3 : sz
            % Exclud cazul de exceptie in care o pagina are link spre ea
            % insasi, comparand elementul din lista de adiacenta cu
            % indicele paginii in sine
            if auxV(j) ~= auxV(1)
                % Daca nu e link spre propria pagina, elementul din
                % matricea A de pe linia paginii parcurse si coloana 
                % paginii spre care are link devine 1
                A(auxV(1), auxV(j)) = 1;
            end
        end
    end
    % Calculez, cu ajutorul functiei sum(), in vectorul coloana lSum,
    % sumele pe linie ale matricei de adiacenta A
    lSum = sum(A, 2);
    for i = 1 : N
        % Matricea diagonala care contine numarul de linkuri de pe fiecare
        % linie pe diagonala principala are elementele de pe diagonala
        % sumele pe linie ale matricii A, calculate in auxV
        K(i, i) = lSum(i);
    end
    % Matricea M de probabilitati de accesare a paginilor este construita
    % din formula preluata din algoritmul Iterative de pe Wikipedia
    M = (PR_Inv(K) * A)';
    % initializez vectorul de pagerankuri la iteratia 0 cu 1 / numarul
    % total de pagini, ca in algoritmul Iterative din resursa
    R = (1 / N) * ones(N, 1);
    prevR = zeros(N, 1);
    % Utilizez metoda iterativa descrisa in articolul de Wikipedia, la
    % sectia Iterative, utilizand argumentul eps al functiei ca marja de
    % eroare
    while abs(norm(R - prevR)) >= eps
        prevR = R;
        % Formula luata din resursa din cerinta
        R = d * M * prevR + ((1 - d) / N) * ones(N, 1);
    end
    % La final, ma intorc la iteratia anterioara, deoarece R se modifica la
    % valoarea care va avea norma mai mica decat eps inainte de a iesi din
    % repetitie
    R = prevR;
    % Se inchide fisierul
    fclose(fileName);
end
