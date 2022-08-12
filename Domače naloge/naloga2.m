function [izhod, R, kodBela, kodCrna] = naloga2(vhod)
% Kodiranje slike "vhod" po prilagojenem standardu ITU-T T.4.
%
% vhod     - matrika, ki predstavlja sliko [n X 1728]
% izhod    - binarni vrsticni vektor
% R        - kompresijsko razmerje
% kodBela  - tabela dolzin kodnih zamenjav belih slikovnih tock
% kodCrna  - tabela dolzin kodnih zamenjav crnih slikovnih tock

[visina, sirina] = size(vhod);
stetje = 0;
%visina
for i=1:visina
    if vhod(i,1)==0
        stetje = stetje + 1;
        %fprintf('%d\n', i);
    end
end
stetje;
countB=0;
countW=0;
indW=1;
indB=1;
white=zeros(1,80000);
black=zeros(1,80000);
%white(1)=0;
%black(1)=1;
kateri=vhod(1,1);%1 je beli, 0 je crni
% for i=1:visina
%     if vhod(i,1)==0
%         white(indW) = 0;
%         indW = indW + 1;
%         countB = countB + 1;
%     else
%         countW = countW + 1;
%     end
%     kateri = vhod(i, 1);
%     for j=1:sirina
%         if vhod(i, j) == 1%smo prisli na 1, ki je bela
%             if kateri == 1
%                 countW = countW + 1;
%             else
%                 black(indB) = countB;
%                 countB = 0;
%                 indB = indB + 1;
%                 kateri = 1;
%             end
%         else%smo prisli na 0, ki je crna
%             if kateri == 0
%                 countB = countB + 1;
%             else
%                 white(indW) = countW;
%                 indW = indW + 1;
%                 countW = 0;
%                 kateri = 0;
%             end
%                 
%         end
%     end
%     if countW~=0
%         white(indW) = countW;
%         indW = indW + 1;
%     end
%     if countB~=0
%         black(indB) = countB;
%         indB = indB + 1;
%     end
%     countW = 0;
%     countB = 0;
% end
%  for i=1:visina
%      countB;
%      countW;
%      if vhod(i,1)==0
%          white(indW)=0;
%          indW=indW+1;
%          kateri = 0;
%      else
%          %kateri = 0;
%      end
%      for j=1:sirina
%          if vhod(i,j)==0
%              if kateri==1
%                  countW=countW+1;
%              else
%                  countW=1;
%                  %black=[black, countB];
%                  black(indB)=countB;
%                  countB=0;
%                  indB=indB+1;
%                  kateri=1;
%                  %fprintf('%d %d\n', i, j);
%                  %j
%              end
%          else
%              if kateri==0
%                  countB=countB+1;
%              else
%                  countB=1;
%                  white(indW)=countW;
%                  countW=0;
%                  indW=indW+1;
%                  kateri=0;
%                  
%  %                  countW=0;
%  %                  indW=indW+1;
%  %                  kateri=0;
%              end
%          end
%      end
%      if countW~=0
%          white(indW)=countW;
%          countW=0;
%          indW=indW+1;
%          %kateri=0;
%      end
%      if countB~=0
%          %black=[black, countB];
%          black(indB)=countB;
%          countB=0;
%          indB=indB+1;
%          kateri=1;
%      end
%      %white(indW)=0;
%      %indW=indW+1;
%  end
zaporedje = zeros(1,100000);
indZaporedje = 1;
 
  for i=1:visina
     countB;
     countW;
%      if vhod(i,1)==0
%          white(indW)=0;
%          indW=indW+1;
%          kateri = 0;
%      end
    if vhod(i,1)==1
        kateri = 1;
        zaporedje(indZaporedje) = 1;
        indZaporedje = indZaporedje + 1;
    else
        white(indW) = 0;
        indW = indW + 1;
        zaporedje(indZaporedje) = 1;
        indZaporedje = indZaporedje + 1;
        zaporedje(indZaporedje) = 0;
        indZaporedje = indZaporedje + 1;
        kateri = 0;
    end
     for j=1:sirina
         if vhod(i,j)==0
             if kateri==1
                 white(indW) = countW;
                 countW = 0;
                 indW = indW + 1;
                 countB = countB + 1;
                 kateri = 0;
                 zaporedje(indZaporedje) = 0;
                 indZaporedje = indZaporedje + 1;
             else
                 countB = countB + 1;
                 kateri = 0;
             end
         else
             if kateri==0
                 black(indB) = countB;
                 indB = indB + 1;
                 countB = 0;
                 countW = countW + 1;
                 kateri = 1;
                 zaporedje(indZaporedje) = 1;
                 indZaporedje = indZaporedje + 1;
             else
                 countW = countW + 1;
                 kateri = 1;
             end
         end
     end
     if countW~=0
         white(indW)=countW;
         countW=0;
         indW=indW+1;
         %kateri=0;
     end
     if countB~=0
         %black=[black, countB];
         black(indB)=countB;
         countB=0;
         indB=indB+1;
         kateri=1;
     end
     %white(indW)=0;
     %indW=indW+1;
 end

%  tmp = white;
%  white = black;
%  black = tmp;
 %neki = histc(white, 0)
% length(white)
%indW
%white(indW - 1)
%white=white(1:find(white,1,'last'));
white = white(1:indW-1);
%white(1:200)
%white(end - 1)
%black=black(1:find(black,1,'last'));
black = black(1:indB-1);
%black(1:200);
dolzina = length(white);
%indW
dolzina1 = length(black);
%indB
doKam = dolzina1 + dolzina;
zaporedje = zaporedje(1:doKam);
% neki = histc(white, 0)
% length(white)
%tabela=zeros(1,10);
% tabela(1:3) = double(dec2bin(2, 3))
% tabela(4:6) = double(dec2bin(4, 3))
% tabela



        
% countB = find(diff([1, vhod, 1] == 0));
% p = countB(1: 2: end - 1);
% black = countB(2: 2: end) - p;
% %bela
% %countB=zeros(countB);
% if vhod(1, 1) == 0
%     countW = find(diff([0, vhod, 0] == 1));
%     p = countW(1: 2: end -1);
%     white = countW(2: 2: end) - p;
%     white = [0 white];
% else
%     countW = find(diff([0, vhod, 0] == 1));
%     p = countW(1: 2: end - 1);
%     white = countW(2: 2: end) - p;
% end
 %white
 %black
  s = unique(white)
  unikatneCrna = unique(black)
  histcBela = histc(white, s)
  histcCrna = histc(black, unikatneCrna)
  %imenovalecBela = size(white)
  %imenovalecCrna = size(black)
  imenovalecBela = length(white);
  imenovalecCrna = length(black);
  p = histcBela / imenovalecBela;
  verjetnostiCrna = histcCrna / imenovalecCrna;
  
  kodBela = huffman(s, histcBela)
  kodCrna = huffman(unikatneCrna, histcCrna)
  if isempty(kodBela)
      kodneZamenjaveBela = [];
  else
      kodneZamenjaveBela = kodneZamenjave(kodBela(:, 2)); 
  end
      
  if isempty(kodCrna)
       kodneZamenjaveCrna = [];
  else
      kodneZamenjaveCrna = kodneZamenjave(kodCrna(:, 2));
  end
  %c = bitsll(2, 0)
  celaTabelaBela = kodBela;
  celaTabelaBela = [celaTabelaBela kodneZamenjaveBela];
  celaTabelaCrna = kodCrna;
  celaTabelaCrna = [celaTabelaCrna kodneZamenjaveCrna];
  
  kdoZacne = 1;
  %bla = zeros(1, 1000);
  %bla(1:3) = dec2bin(kodneZamenjaveBela(3), kodBela(3, 2)) - 48
  %bla(4:6) = dec2bin(kodneZamenjaveBela(3), kodBela(5, 2)) - 48
  %bla(1:3) = double(dec2bin(kodneZamenjave(3), kodCrna(3)))
  upamDaIzhod = dobiIzhod(1, celaTabelaBela, celaTabelaCrna, white, black, kdoZacne, zaporedje);
  upamDaIzhod = upamDaIzhod(1:find(upamDaIzhod,1,'last'));
  upamDaIzhod = upamDaIzhod(1:end-1);

[visina, sirina] = size(vhod);
velikostVhoda = visina*sirina;
izhod = upamDaIzhod - 48;
R = length(izhod)/velikostVhoda;
kodBela = kodBela;
kodCrna = kodCrna;

end

function huff = huffman(tabela, kolicina)
    [~, sirina] = size(tabela)
    visinaNove = sirina + (sirina - 1)
    primerjanja = sirina - 1
    hufftabela = zeros(sirina, 5)
    hufftabela(1:sirina, 1) = tabela
    hufftabela(1:sirina, 2) = kolicina
    %hufftabela(sirina + 1:end, 1) = Inf;
    hufftabela = sortrows(hufftabela, 2, {'descend'})
    %hufftabela(sirina + 1:end, 2) = Inf;
    %hufftabela
    kjeSmo = sirina + 1;
    tmpSirina = sirina;
%     if sirina == 1
%         huff = [tabela(1) 1];
%         return
%     else
%         huff = [];
%         return
%     end
    for i=1:primerjanja
        [~, indeks] = min(hufftabela(1:tmpSirina, 2));
        hufftabela(kjeSmo, 3) = indeks;
        hufftabela(kjeSmo, 2) = hufftabela(kjeSmo, 2) + hufftabela(indeks, 2);
        hufftabela(indeks, 2) = Inf;
        %hufftabela
        [~, indeks] = min(hufftabela(1:tmpSirina, 2));
        hufftabela(kjeSmo, 4) = indeks;
        hufftabela(kjeSmo, 2) = hufftabela(kjeSmo, 2) + hufftabela(indeks, 2);
        hufftabela(indeks, 2) = Inf;
        %hufftabela
        kjeSmo = kjeSmo + 1;
        %hufftabela
        tmpSirina = tmpSirina+ 1;
    end
    
    for i=tmpSirina:-1:sirina + 1
        hufftabela(hufftabela(i, 3), 5) = hufftabela(hufftabela(i, 3), 5) + hufftabela(i ,5) + 1;
        hufftabela(hufftabela(i, 4), 5) = hufftabela(hufftabela(i, 4), 5) + hufftabela(i ,5) + 1;
        %hufftabela
    end
    hufftabela(:, 2:4) = [];
    hufftabela(sirina + 1:end, :) = [];
    hufftabela = sortrows(hufftabela, [2 1], {'ascend'});
    huff = hufftabela;
end

function kodne = kodneZamenjave(li)
%     %prvi stolpec bo za li, drugi pa za kodno zamenjavao
%     [visina, ~] = size(li);
%     neki = 0;
%     %li(1,2) = dec2bin(neki, li(1,1));
%     %bla(1,1) = dec2bin(neki, li(1,1))
%     bla{1,1} = li(1,1);
%     bla{1,2} = dec2bin(neki, li(1,1));
%     tabela{1,1} = li(1,1);
%     tabela{1,2} = dec2bin(bitsll((0), 0), li(1,1));
%     for i=2:visina
%        neki = neki + 1;
%        tabela{i,1} = li(i,1);
%        razlika = li(i,1) - li(i-1, 1);
%        neki = bitsll(neki, razlika);
%        tabela{i,2} =dec2bin(neki, li(i,1));
%     end
%     tabela(:, 1) = [];
%     kodne = tabela; 
    %tabela(1, :) = dec2bin(2, 3)
    [visina, ~] = size(li);
    neki = 0;
    %li(1,2) = dec2bin(neki, li(1,1));
    %bla(1,1) = dec2bin(neki, li(1,1))
    %bla{1,1} = li(1,1);
    %bla{1,2} = dec2bin(neki, li(1,1));
    %tabela(1, :) = li(1,1);
    tabela(1,2) = bitsll(0, 0);
    for i=2:visina
        neki = neki + 1;
        tabela(i, 1) = li(i, 1);
        razlika = li(i, 1) - li(i - 1, 1);
        neki = bitsll(neki, razlika);
        tabela(i, 2) = neki;
    end
    tabela(:, 1) = [];
    kodne = tabela;
end

function KAKO = dobiIzhod(indeks, kodBela, kodCrna, white, black, kdoZacne, zaporedje) 
%     izhod = zeros(1,1000);
%     izhod = kodnaZC(3)
%     length(kodnaZC(3))
%     a = double(kodnaZC(3))
%     doKam = length(white) + length(black);
%     kokSiJihNapisal = 0;
%     indeksW = 1;
%     indeksB = 1;
%     kjeSi = 1;
%     tabela = zeros(1,200000);
%     if kdoZacne == 1
%         kater = 1;
%        while true
%            if kater == 1
%                indeksKoda = find(kodBela(:, 1) == white(indeksW));
%                %kodBela(indeksKoda, 3);
%                %kodBela(indeksKoda, 2);
%                %double(dec2bin(kodBela(indeksKoda, 3), kodBela(indeksKoda, 2)))
%                tabela(kjeSi:kjeSi+kodBela(indeksKoda, 2) - 1) = double(dec2bin(kodBela(indeksKoda, 3), kodBela(indeksKoda, 2)));
%                kjeSi = kjeSi + kodBela(indeksKoda, 2);
%                white(indeksW);
%                kater = 0;
%                indeksW = indeksW + 1;
%                if indeksW == length(white) + 1 && indeksB == length(black) + 1
%                    break
%                end
%            else
%                %indeksB
%                %black(indeksB)
%                indeksKoda = find(kodCrna(:, 1) == black(indeksB));
%                tabela(kjeSi:kjeSi+kodCrna(indeksKoda, 2) - 1) = double(dec2bin(kodCrna(indeksKoda, 3), kodCrna(indeksKoda, 2)));
%                kjeSi = kjeSi + kodCrna(indeksKoda, 2);
%                black(indeksB);
%                kater = 1;
%                indeksB = indeksB + 1;
%                if indeksW == length(white) + 1 && indeksB == length(black) + 1
%                    break
%                end
%            end
%        end
%     else
%         kater = 1;
%         while true
%             
%         end
%     end
%     indeksW;
%     indeksB;
%     tabela(kjeSi) = 47;
%     KAKO = tabela;
    indW = 1;
    indB = 1;
    kjeSi = 1;
    tabela = zeros(1,200000);
    for i=1:length(zaporedje)
        if zaporedje(i) == 1%v zaporedju je 1, torej bela
            indeksKoda = find(kodBela(:, 1) == white(indW));
            tabela(kjeSi:kjeSi+kodBela(indeksKoda, 2) - 1) = double(dec2bin(kodBela(indeksKoda, 3), kodBela(indeksKoda, 2)));
            kjeSi = kjeSi + kodBela(indeksKoda, 2);
            indW = indW + 1;
        else%v zaporedju je 0, torej crna
            indeksKoda = find(kodCrna(:, 1) == black(indB));
            tabela(kjeSi:kjeSi+kodCrna(indeksKoda, 2) - 1) = double(dec2bin(kodCrna(indeksKoda, 3), kodCrna(indeksKoda, 2)));
            kjeSi = kjeSi + kodCrna(indeksKoda, 2);
            indB = indB + 1;
        end
    end

    tabela(kjeSi) = 47;
    KAKO = tabela;
end