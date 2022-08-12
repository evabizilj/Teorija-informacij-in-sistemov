function [izhod, crc] = naloga3(vhod, n)
 
  % HAMMINGOV KOD
  
  % podatki o kodu
  codeLength = n;
  numSecurityBits = ceil(log2(codeLength + 1)); 
  numDataBits = codeLength - numSecurityBits;
 
  % inicializacija izhoda
  izhod = zeros(0);
  
  % zapišemo matriko brez identitete (podatkovni biti) z
  % uporabo ceil in floor
  
  j = 0;
  for i = 0 : codeLength
      roundH = ceil(log2(i)); % + infinity direction
      roundL = floor(log2(i)); % - infinity direction
      if (roundH == roundL) 
          j = j - 1;
      end
      if (roundH ~= roundL) 
        % pretvorimo v binarno število dolžine numSecBits
        dec_bin = dec2bin(i, numSecurityBits) - '0';
        str2double(dec_bin);
       
        % števila uredimo po vrsti in zapišemo v matriko
        matrix(:, j + 1) = flip(dec_bin, 2);
      end
      j = j + 1;
  end
  
  % izračunamo identiteto
  identity = zeros(numSecurityBits);
  identity(1 : numSecurityBits + 1 : end) = 1;
  
  % matriki za preverjanje sodosti prilepimo identiteto
  H = [matrix identity];
  
  % v vektorju vhod je več kodnih zamenjav; obravnavamo vsakega posebaj
  numCodes = length(vhod)/codeLength; % število kodnih zamenjav v vektorju vhod
  A = vhod;
  B = [codeLength, numCodes];
  
  % reshapes A into array codeLength x numCodes
  y = reshape(A, B)';

  % izračun sindroma
  sindrom = mod((y * H'), 2);
  
  % število sindromov
  [numRows, numCols] = size(sindrom);
  
  i = 1;
  while (i <= numRows)
      % if the rows of A are also rows of B
      [notImportant, index] = ismember(sindrom(i, :), H', 'rows');
     
      % inicializacija vektorja napake
      e = zeros(1, numSecurityBits + numDataBits);
      
      if (index == 0)
          index = index - 1;
      end
      
      % na mestu, kjer se sindrom ujema z stolpcem v H, zapišemo 1 v vektor napake
      if (index >= 0)
          e(index) = 1;
      end
      
      % vsako kodno zamenjavo xoramo z vektorjem napake
      yi = y(i, :);
      yiXORe = xor(yi, e);
      
      % vzamemo samo podatkovne bite
      dataBits = yiXORe([end - codeLength + 1 : numDataBits]);
      
      % združimo z že obstoječim izhodom
      izhod = [izhod dataBits];
      
      i = i + 1;
  end
  
  % CRC
  register = zeros(1, 8);
  i = 1;
  
  while (i <= codeLength * numCodes)
      
    pm = mod(register(8) + vhod(i), 2); 
    register1 = register(1 : 8 - 1); %1
    
    if (pm == 0)
      register = [pm register1];
    elseif (pm == 1) 
      register = [pm register1]; 
      register([2 3]) = mod(register([2 3]) + pm, 2);
    end
    
    i = i + 1;
    
  end
  
  intToString = int2str(register);
  right_left = fliplr(intToString);
  hex = dec2hex(bin2dec(right_left));
  
  crc = hex;
 
end
  
   
 