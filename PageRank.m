% Calculeaza indicii PageRank pentru cele 3 cerinte
% Scrie fisierul de iesire nume.out
function [R1, R2] = PageRank(nume, d, eps)
    % Deschid fisierul dat ca parametru al functiei
    fileName = fopen(nume);
    % Retin in N numarul de pagini ce va fi si afisat
    N = fscanf(fileName, "%d\n", 1);
    % Trec prin N liste de adiacenta pentru a ajunge la valorile val1 si
    % val2
    for i = 1 : N
        fgetl(fileName);
    end
    % Citesc in variabilele val1 si val2 valorile respective
    val1 = fscanf(fileName, "%f", 1);
    val2 = fscanf(fileName, "%f", 1);
    % Inchid fisierul de intrare pentru a putea refolosi variabila fileName
    fclose(fileName);
    % Creez numele fisierului de iesire, concatenand la parametrul 'nume'
    % sirul '.out'
    outFileName = [nume '.out'];
    % Redeschid in fileName, de data aceasta fisierul de iesire dat de
    % numele creat mai sus 'outFileName'
    fileName = fopen(outFileName, 'w');
    % Afisez numarul de pagini N, urmat de doua newline-uri, pentru a lasa
    % spatiu intre N si primul vector de pagerank
    fprintf(fileName, "%d\n\n", N);
    % In primul vector de iesire al functiei calculez pagerank-ul conform
    % metodei iterative
    R1 = Iterative(nume, d, eps);
    % Afisez elementele vectorului cu precizie de 6 zecimale
    for i = 1 : N
        fprintf(fileName, "%.6f\n", R1(i));
    end
    % Linie libera intre vectori
    fprintf(fileName, "\n");
    % In cel de-al doilea vector de iesire al functiei retin vectorul de
    % pagerank-uri conform metodei algebrice
    R2 = Algebraic(nume, d);
    % Afisez elementele vectorului cu precizie de 6 zecimale
    for i = 1 : N
        fprintf(fileName, "%.6f\n", R2(i));
    end
    % Linie libera intre vectori
    fprintf(fileName, "\n");
    % Pentru a retine indicii paginilor initiale care au fost sortate,
    % creez vectorul indPR, care retine indicii paginilor, la inceput
    % nesortati, motiv pentru care e initializat cu numerele de la 1 la N
    indPR = 1 : N;
    % Initializez vectorul de pagerankuri ce va fi sortat cu vectorul
    % calculat dupa metoda algebrica
    PR1 = R2;
    % Pentru sortare am utilizat selection sort, deoarece este cel mai
    % simplu de scris; se interschimba nu doar elementele vectorului in
    % sine, dar si elementele vectorului de indici 'indPR'
    for i = 1 : N - 1
        for j = i + 1 : N
            if PR1(i) <= PR1(j)
                aux = PR1(i);
                PR1(i) = PR1(j);
                PR1(j) = aux;
                aux = indPR(i);
                indPR(i) = indPR(j);
                indPR(j) = aux;
            end
        end
    end
    % La final, afisez, conform cerintei, indicele vectorului sortat,
    % indicele vectorului nesortat si functia de apartenenta a elementului
    for i = 1 : N
        apt = Apartenenta(PR1(i), val1, val2);
        fprintf(fileName, "%d %d %.6f\n", i, indPR(i), apt);
    end
    % Se inchide fisierul de iesire
    fclose(fileName);
end
