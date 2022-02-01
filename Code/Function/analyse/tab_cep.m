function [CEP_s] = tab_cep(CEP,CEP_10)

CEP_s = CEP(end,:);
CEP_s(2,:)= CEP_10(end,:);

end

