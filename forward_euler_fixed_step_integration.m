%Runs numerical integration using forward Euler approximation
%INPUTS:
%rate_func_in: the function used to compute dXdt. rate_func_in will
% have the form: dXdt = rate_func_in(t,X) (t is before X)
%tspan: a two element vector [t_start,t_end] that denotes the integration endpoints
%X0: the vector describing the initial conditions, X(t_start)
%h_ref: the desired value of the average step size (not the actual value)
%OUTPUTS:
%t_list: the vector of times, [t_start;t_1;t_2;...;.t_end] that X is approximated at
%X_list: the vector of X, [X0';X1';X2';...;(X_end)'] at each time step
%h_avg: the average step size
%num_evals: total number of calls made to rate_func_in during the integration

function [t_list,X_list,h_avg, num_evals] = forward_euler_fixed_step_integration(rate_func_in,tspan,X0,h_ref)
    %Make the step size never exceed h_ref
    N = ceil((tspan(2)-tspan(1))/h_ref);
    h = (tspan(2)-tspan(1))/N;
    
    %Initialize the time steps and outputs
    t_list = [linspace(tspan(1), tspan(2), N+1)]';
    X_list = zeros(N+1, numel(X0));
    X_list(1,:) = transpose(X0);
    num_evals = 0;
    
    %Run X_n+1 in a loop
    for n = 1:N
        [XB, step_evals] = forward_euler_step(rate_func_in, t_list(n), transpose(X_list(n,:)), h);
         X_list(n+1,:) = transpose(XB);
        num_evals = num_evals + step_evals;
    end
    
    %all steps are equal so h_avg = h
    h_avg = h;
end 
