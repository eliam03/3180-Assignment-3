function error = global_error(rate_func_in, XA, t_range, h)
    [~, Xn1, ~, ~] = explicit_midpoint_fixed_step_integration(rate_func_in, t_range, XA, h) % change explicit_midpoint_step to the other funcs when needed
    error = abs(Xn1(end) - rate_func_in(t_range(end), XA))
end