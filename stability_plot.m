function stability_plot()
    
    fig = figure()
    fig.Position(4) = fig.Position(4) * 1.5; % Stretches the figure height by 50%
    set(groot, 'defaultTextInterpreter', 'latex');
    set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');
    functions = ["forward_euler_step", "explicit_midpoint_step", "implicit_midpoint_step","backward_euler_step"];
    names = ["Forward Euler", "Explicit Midpoint", "Implicit Midpoint Step","Backward Euler Step"];


    tspan = [0,20];
    X0 = solution01(tspan(1));
    h = .38
    t = tiledlayout(4, 1, 'TileSpacing', 'compact', 'Padding', 'compact');
    for i = 1:length(functions)
            nexttile

        step_func = str2func(functions(i));
        [t_list,numerical_Xlist,h_avg, num_evals] = fixed_step_integration(@rate_func01,step_func,tspan,X0,h);
        %subplot(4,1,i);
        t_list2 = linspace(0,20,300);
        analytical_Xlist = solution01(t_list2);
        plot(t_list2, analytical_Xlist,'k','LineWidth',2)
        hold on
        plot(t_list, numerical_Xlist, 'ro','MarkerSize',4,'MarkerFaceColor','r');
        plot(t_list, numerical_Xlist, 'r','LineWidth',1);

        xlabel("Time (-)",'FontSize',15)
        ylabel("$x(t) (-)$",'FontSize',15)
        title(names(i), 'FontSize',15)
        axis([0 20 -2 3])
        ax = gca; 
        ax.FontSize = 14;     %     p = get(gca, 'Position');
    % p(2) = p(2) - 0.05;  % Move bottom edge down
    % p(4) = p(4) + 0.05;  % Increase height
    % set(gca, 'Position', p);
    end
    title(t, 'Integration Stability Plot at $h_{ref} = .38$', 'FontSize', 15, 'Interpreter', 'latex')    
    l = legend("Numerical Solution","Analytical Solution",'FontSize',9 );
    l.Layout.Tile = 'north'; 
    l.FontSize = 13;
    myfig = gcf();
    exportgraphics(myfig , 'stability_plot38.png', 'Resolution', 600);
end