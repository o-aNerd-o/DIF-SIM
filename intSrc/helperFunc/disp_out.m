function disp_out(str, pipe)
    if ( isempty(pipe) )
        disp(str);
    else
        %isempty(get(pipe, 'value'))
        if (pipe.Value == "")
            pipe.Value = str;
        else
            pipe.Value = [pipe.Value; str];
        end
        %disp(str);        
    end
end