function time = floor2grid(time, stepWidth)
    time = floor(time/stepWidth)*stepWidth;
end