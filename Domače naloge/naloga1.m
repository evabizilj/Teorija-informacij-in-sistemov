function H = naloga1(besedilo,p)
% R = 1 - H / log2(length((histc(besedilo, unique(besedilo)))));

% H(X1)
if p==0
    besedilo = besedilo'; % vrsticni vektor
    crke = isletter(besedilo);
    % v spremenljivko B shranimo crke, spremenimo v velike
    B = upper(besedilo(crke));
    % X1 (1 znak) vsebuje samo unikatne znake
    % za vsak znak izracunamo verjetnost pojava v besedilu
    % unique ... unikate, histc ... frekvence znakov (f)
    % uporaba histcounts (B pretvorimo v stevilo, uporaba kategoricnih
    % sprem.)
    B1 = double(B);
    frekvence0 = histcounts(categorical(B1),categorical(unique(B1)));
    % verjetnosti pojavitev znakov (frekvenca/dolzina besedila)
    verjetnost = frekvence0 / length(B);
    
    % nedolocenost
    H = nedolocenost0(verjetnost);
    
% H(X2|X1)
elseif p==1
    B = upper(besedilo(isletter(besedilo)));
    B1 = double(B);
    frekvence1 = histcounts(categorical(B1),categorical(unique(B1)));
    verjetnost1 = frekvence1' / length(B);
   
    % nedolocenost parov znakov 
    pari = [B(1:end-1), B(2:end)]; 
    [U, iA, iB] = unique(pari, 'rows');
    frekvence12 = histcounts(categorical(double(iB)), categorical(double(1:length(iA))));
   
    verjetnost12 = frekvence12' / sum(frekvence12);
    
    H = nedolocenost1(verjetnost1, verjetnost12);

    
% H(X3|X1,X2)
elseif p==2
    % H1
    B = upper(besedilo(isletter(besedilo)));
    B1 = double(B);
    frekvence1 = histcounts(categorical(B1), categorical(unique(B1)));
    verjetnost1 = frekvence1' / length(B);
   
    % H1, H2
    pari = [B(1:end-1), B(2:end)]; 
    [U, iA, iB] = unique(pari, 'rows');
    frekvence12 = histcounts(categorical(double(iB)), categorical(double(1:length(iA))));
    verjetnost12 = frekvence12'/sum(frekvence12);
    H12 = nedolocenost1(verjetnost1, verjetnost12);
    
    % H1, H2, H3
    trojice = [B(1:end-2), B(2:end-1), B(3:end)];
    [U, iA, iB] = unique(trojice, 'rows');
    frekvence123 = histcounts(categorical(double(iB)), categorical(double(1:length(iA))));
    verjetnost123 = frekvence123' / sum(frekvence123);
    
    H = nedolocenost2(verjetnost12, verjetnost123);
    
%H(X4|X1,X2,X3)
elseif p==3
    % H1
    B = upper(besedilo(isletter(besedilo)));
    B1 = double(B);
    frekvence1 = histcounts(categorical(B1),categorical(unique(B1)));
    verjetnost1 = frekvence1' / length(B);
   
    % H1, H2
    pari = [B(1:end-1), B(2:end)]; 
    [U, iA, iB] = unique(pari, 'rows');
    frekvence12 = histcounts(categorical(double(iB)), categorical(double(1:length(iA))));
    verjetnost12 = frekvence12' / sum(frekvence12);
    H12 = nedolocenost1(verjetnost1, verjetnost12);
    
    % H1, H2, H3
    trojice = [B(1:end-2), B(2:end-1), B(3:end)];
    [U, iA, iB] = unique(trojice, 'rows');
    frekvence123 = histcounts(categorical(double(iB)), categorical(double(1:length(iA))));
    verjetnost123 = frekvence123' / sum(frekvence123);
    
    % H1, H2, H3, H4
    stirice = [B(1:end-3), B(2:end - 2), B(3:end - 1), B(4:end)];
    [U, iA, iB] = unique(stirice, 'rows');
    frekvence1234 = histcounts(categorical(double(iB)), categorical(double(1:length(iA))));
    verjetnost1234 = frekvence1234' / sum(frekvence1234);
    
    H = nedolocenost3(verjetnost123, verjetnost1234);
    
end % end if
end % end funkcije

function H = nedolocenost0(verjetnost)
H = - verjetnost * log2(verjetnost)';
end

%H(X2,X1) = H(X2, X1) - H(X1)
function H = nedolocenost1(verjetnost1, verjetnost12)
H12 = -verjetnost12' * log2(verjetnost12);
H1 = -(verjetnost1') * log2(verjetnost1);
H = H12 - H1;
end

%H(X3|X2, X1) = H(X3, X2, X1) - H(X2, X1)
function H = nedolocenost2(verjetnost12, verjetnost123)
H123 = -(verjetnost123') * log2(verjetnost123);
H12 = -(verjetnost12') * log2(verjetnost12);
H = H123 - H12;
end

%H(X4|X3, X2, X1) = H(X4, X3, X2, X1) - H(X2, X1)
function H = nedolocenost3(verjetnost123, verjetnost1234)
H1234 = -(verjetnost1234') * log2(verjetnost1234);
H123 = -(verjetnost123') * log2(verjetnost123);
H = H1234 - H123;
end


