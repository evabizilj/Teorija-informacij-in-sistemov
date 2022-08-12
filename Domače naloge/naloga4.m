function izhod = naloga4(vhod, Fs)

izhod = [];

frekvencaVzorcenja = Fs;

% perioda vzorcenja
delta = length(vhod) / frekvencaVzorcenja;

% zvocni signal pretvorimo v frekvencni prostor
X = fft(vhod);

% moc (P) po frekvencah 
P = (abs(X).^2) / length(X)^2;

% tocke vzorcenja v casu 
t = (0 : length(vhod) - 1) * delta;  

steviloTonov = 0;  
toleranca = 0.005;

% tabela tonov
toni = [ "C1", "CIS1", "D1", "DIS1", "E1", "F1", "FIS1", "G1", "GIS1", "A1", "B1", "H1", "C2", "CIS2", "D2", "DIS2", "E2", "F2", "FIS2", "G2", "GIS2", "A2", "B2", "H2"; 
        261.63, 277.18, 293.66, 311.13, 329.63, 349.23, 369.99, 392, 415.30, 440, 466.16, 493.88, 523.25, 554.37, 587.33, 622.25, 659.25, 698.46, 739.99, 783.99, 830.61, 880, 932.33, 987.77 ];

% tabela vsebuje imena in sestavne tone vseh akordov, ki jih zelimo iskati v zvočnem signalu
akordi = [ "Cdur", (str2double(toni(2, 1))), (str2double(toni(2, 5))), (str2double(toni(2, 8))); 
           "Cmol", (str2double(toni(2, 1))), (str2double(toni(2, 4))), (str2double(toni(2, 8)));
           "Ddur", (str2double(toni(2, 3))), (str2double(toni(2, 7))), (str2double(toni(2, 10)));
           "Dmol", (str2double(toni(2, 3))), (str2double(toni(2, 6))), (str2double(toni(2, 10)));
           "Edur", (str2double(toni(2, 5))), (str2double(toni(2, 9))), (str2double(toni(2, 12)));
           "Emol", (str2double(toni(2, 5))), (str2double(toni(2, 8))), (str2double(toni(2, 12)));
           "Fdur", (str2double(toni(2, 6))), (str2double(toni(2, 10))), (str2double(toni(2, 13)));
           "Fmol", (str2double(toni(2, 6))), (str2double(toni(2, 9))), (str2double(toni(2, 13)));
           "Gdur", (str2double(toni(2, 8))), (str2double(toni(2, 12))), (str2double(toni(2, 15)));
           "Gmol", (str2double(toni(2, 8))), (str2double(toni(2, 11))), (str2double(toni(2, 15)));
           "Adur", (str2double(toni(2, 10))), (str2double(toni(2, 14))), (str2double(toni(2, 17)));
           "Amol", (str2double(toni(2, 10))), (str2double(toni(2, 13))), (str2double(toni(2, 17)));
           "Hdur", (str2double(toni(2, 12))), (str2double(toni(2, 16))), (str2double(toni(2, 19)));
           "Hmol", (str2double(toni(2, 12))), (str2double(toni(2, 15))), (str2double(toni(2, 19))) ];

for i = 1 : 14
    for j = 2 : 4
        % pogledamo tudi vzorec levo in desno, ce se tam pojavi vrh
        frekvenca = str2double(akordi(i, j));
        predhodnik = P(1, round(frekvenca * delta) - 1);
        trenutno = P(1, round(frekvenca * delta));
        naslednik = P(1, round(frekvenca * delta) + 1);
    
        if (predhodnik > toleranca || trenutno > toleranca || naslednik > toleranca)
            steviloTonov = steviloTonov + 1;
        end
    
    end
  
    % stevilo tonov mora biti tocno 3
    if (steviloTonov == 3)
        izhod = akordi(i, 1);
    end
    
    steviloTonov = 0;
end

