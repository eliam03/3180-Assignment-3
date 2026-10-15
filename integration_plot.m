function integration_plot(step_func)
    
    figure()
    set(groot, 'defaultTextInterpreter', 'latex');
    set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');
    tspan = [0,2*pi];
    X0 = solution01(tspan(1));
    h_list = linspace(.1,1.5,5);
    for i = 1:length(h_list)
        [t_list,numerical_Xlist,h_avg, num_evals] = fixed_step_integration(@rate_func01,step_func,tspan,X0,h_list(i));
        plot(t_list, numerical_Xlist)
        hold on
    end
    t_list = linspace(0,2*pi,200);
    analytical_Xlist = solution01(t_list);
    plot(t_list, analytical_Xlist,'--k')
    l = legend("h = " + h_list(1), "h = " + h_list(2),"h = " + h_list(3),"h = " + h_list(4), "h = " + h_list(5),"Analytical Solution",'FontSize',9 );
    legend('Location','northwest','FontSize',13)
    xlabel("time (s)",'FontSize',13)
    ylabel("x(t) (-)",'FontSize',13)
    title("Implicit Midpoint Integration Plot",'FontSize',13)
    axis([0 6.5 -2 3])
    myfig = gcf();
    exportgraphics(myfig , 'implicit_midpoint_integration_plot.png', 'Resolution', 600);
end