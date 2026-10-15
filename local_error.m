function [error, diff] = local_error(rate_func_in, sol_func, XA, t, h, method)
    if method == "euler"
        Xn1 = forward_euler_step(rate_func_in, t, XA, h); % change explicit_midpoint_step to the other funcs when needed
    end
    if method == "midpoint"
        Xn1 = explicit_midpoint_step(rate_func_in, t, XA, h); % change explicit_midpoint_step to the other funcs when needed
    end
    error = norm(Xn1 - sol_func(t + h));
    diff = norm(sol_func(t+h) - sol_func(t));
end