function error = local_error(rate_func_in, XA, t, h)
    Xn1 = explicit_midpoint_step(rate_func_in, t, XA, h); % change explicit_midpoint_step to the other funcs when needed
    error = abs(Xn1 - rate_func_in(t + h, XA));
end