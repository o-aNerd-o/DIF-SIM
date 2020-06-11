function outStr = prepHeading(inStr, Token, noTokens)
    noT1 = floor( (noTokens - (length(inStr)+2) )/ 2 );
    noT2 = ceil(  (noTokens - (length(inStr)+2) )/ 2 );
    outStr = [ sprintf('%s\n',  repmat(Token, 1, noTokens) ) ...
               sprintf('%s\n', [repmat(Token, 1, noT1) ' ' upper(inStr) ' ' repmat(Token, 1, noT2)] ) ...
               sprintf('%s\n',  repmat(Token, 1, noTokens) ) ];
end