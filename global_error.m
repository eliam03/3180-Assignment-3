function [error,h_avg, num_evals] = global_error(rate_func_in, sol_func, XA, t_range, href, method)
    if method == "midpoint"
        [t_list,X_list,h_avg, num_evals] = explicit_midpoint_fixed_step_integration(rate_func_in, t_range, XA, href); % change explicit_midpoint_step to the other funcs when needed
    end
    if method == "euler"
        [t_list,X_list,h_avg, num_evals] = forward_euler_fixed_step_integration(rate_func_in, t_range, XA, href); % change explicit_midpoint_step to the other funcs when needed
    end
    if method == "backward_euler"
        [t_list,X_list,h_avg, num_evals] = fixed_step_integration(rate_func_in, @backward_euler_step, t_range, XA, href); % change explicit_midpoint_step to the other funcs when needed
    end
    if method == "implicit_midpoint"
        [t_list,X_list,h_avg, num_evals] = fixed_step_integration(rate_func_in, @implicit_midpoint, t_range, XA, href); % change explicit_midpoint_step to the other funcs when needed
    end
    error = norm(X_list(:,end) - sol_func(t_range(end)));
end