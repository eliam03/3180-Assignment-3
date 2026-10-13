function integration_plot(step_func)
    figure()
    tspan = [0,2*pi];
    X0 = solution01(tspan(1));
    h_list = linspace(.01,2,5);
    for i = 1:length(h_list)
        [t_list,numerical_Xlist,h_avg, num_evals] = fixed_step_integration(@rate_func01,step_func,tspan,X0,h_list(i));
        plot(t_list, numerical_Xlist)
        hold on
    end
    t_list = linspace(0,2*pi,200);
    analytical_Xlist = solution01(t_list);
    plot(t_list, analytical_Xlist,'--k')
    l = legend("h = " + h_list(1), "h = " + h_list(2),"h = " + h_list(3),"h = " + h_list(4), "h = " + h_list(5),"Analystical Solution");

end