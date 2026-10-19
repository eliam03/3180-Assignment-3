function integration_plot(step_func)
    
    figure()
    set(groot, 'defaultTextInterpreter', 'latex');
    set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');
    tspan = [0,20];
    X0 = solution01(tspan(1));
    h_list = [.5,.4,.05];
    for i = 1:length(h_list)
        color = ["blue","red","green"];
        [t_list,numerical_Xlist,h_avg, num_evals] = fixed_step_integration(@rate_func01,step_func,tspan,X0,h_list(i));
        plot(t_list, numerical_Xlist, 'Marker', 'o','Color',color(i),'MarkerSize',2,'MarkerFaceColor',color(i));
        hold on
        %plot(t_list, numerical_Xlist,'Color',[h_list(i), h_list(i), h_list(i)])
    end
    t_list = linspace(0,20,200);
    analytical_Xlist = solution01(t_list);
    plot(t_list, analytical_Xlist,'k')
    l = legend("h = " + h_list(1), "h = " + h_list(2),"h = " + h_list(3),"Analytical Solution",'FontSize',10 );
    legend('Location','northwest','FontSize',10)
    xlabel("Time (-)",'FontSize',13)
    ylabel("$x(t) (-)$",'FontSize',13)
    title("Explicit Midpoint Integration Example",'FontSize',15)
    axis([0 8 -2 3])
    myfig = gcf();
    exportgraphics(myfig , 'explicit_midpoint_integration_plot.png', 'Resolution', 600);
end