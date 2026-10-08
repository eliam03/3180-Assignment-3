function error = local_error(rate_func_in, sol_func, XA, t, h)
    Xn1 = forward_euler_step(rate_func_in, t, XA, h); % change explicit_midpoint_step to the other funcs when needed
    error = norm(Xn1 - sol_func(t + h));
end