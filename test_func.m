function test_func()
    close all;
    set(groot, 'defaultTextInterpreter', 'latex');
    set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');

    t = 0.492;
    XA = solution01(t);
    hs = logspace(-4.5,-1,100);
    local_errors_e = zeros(size(hs));
    local_errors_m = zeros(size(hs));
    local_errors_b = zeros(size(hs));
    local_errors_i = zeros(size(hs));

    diffs_e = zeros(size(hs));
    diffs_m = zeros(size(hs));
    
    for n = 1:length(hs)
        h = hs(n);
        [l_ee, diffe] = local_error(@rate_func01, @solution01, XA, t, h, "euler");
        [l_em, diffm] = local_error(@rate_func01, @solution01, XA, t, h, "midpoint");
        local_errors_e(n) = l_ee;
        local_errors_m(n) = l_em;
        diffs_e(n) = diffe;
        diffs_m(n) = diffm;

        [l_eb, diffb] = local_error(@rate_func01, @solution01, XA, t, h, "backward_euler");
        [l_ei, diffi] = local_error(@rate_func01, @solution01, XA, t, h, "implicit_midpoint");
        local_errors_b(n) = l_eb;
        local_errors_i(n) = l_ei;
        
    end
    
    figure();
    loglog(hs, local_errors_e, "b.", MarkerSize=10); hold on
    loglog(hs, diffs_e, "c*", MarkerSize=10);
    coeffs_e = polyfit(log(hs), log(local_errors_e), 1);
    localfit_e = exp(polyval(coeffs_e, log(hs)));
    loglog(hs, localfit_e, "r", LineWidth=1);

    loglog(hs, local_errors_m, "k.", MarkerSize=10); hold on
    loglog(hs, diffs_m, "m.", MarkerSize=10);
    coeffs_m = polyfit(log(hs), log(local_errors_m), 1);
    localfit_m = exp(polyval(coeffs_m, log(hs)));
    loglog(hs, localfit_m, "g", LineWidth=1);

    % loglog(hs, local_errors_b, "m.", MarkerSize=10); hold on
    % 
    % loglog(hs, local_errors_i, "c.", MarkerSize=10); hold on

    title("Local Truncation Error for Explicit Methods",'FontSize',13);
    xlabel("$h_{avg} (-)$ ",'FontSize',13);
    ylabel("Local Truncation error $(-)$",'FontSize',13)
    legend("Euler method error", "Euler differences", "Euler fit line", "Midpoint method error", "Midpoint differences", "Midpoint fit line", 'FontSize',11, "Location", "southeast")

    myfig = gcf();
    exportgraphics(myfig , 'local_err_explicit_01.png', 'Resolution', 600);
    

    global_errors_e = zeros(size(hs));
    global_errors_m = zeros(size(hs));
    h_avg_list_e = zeros(size(hs));
    h_avg_list_m = zeros(size(hs));
    evals_e = zeros(size(hs));
    evals_m = zeros(size(hs));
    global_errors_b = zeros(size(hs));
    global_errors_i = zeros(size(hs));
    h_avg_list_b = zeros(size(hs));
    h_avg_list_i = zeros(size(hs));
    evals_e = zeros(size(hs));
    evals_m = zeros(size(hs));
    time_int = [0, 100];
    
    for n = 1:length(hs)
        h = hs(n);
        [g_ee,h_avge, evale] = global_error(@rate_func01, @solution01, solution01(time_int(1)), time_int, h, "euler");
        global_errors_e(n) = g_ee;
        h_avg_list_e(n) = h_avge;
        evals_e(n) = evale;

        [g_em,h_avgm, evalm] = global_error(@rate_func01, @solution01, solution01(time_int(1)), time_int, h, "midpoint");
        global_errors_m(n) = g_em;
        h_avg_list_m(n) = h_avgm;
        evals_m(n) = evalm;

        [g_eb,h_avgb, evalb] = global_error(@rate_func01, @solution01, solution01(time_int(1)), time_int, h, "backward_euler");
        global_errors_b(n) = g_eb;
        h_avg_list_b(n) = h_avgb;
        evals_b(n) = evalb;

        [g_ei,h_avgi, evali] = global_error(@rate_func01, @solution01, solution01(time_int(1)), time_int, h, "implicit_midpoint");
        global_errors_i(n) = g_ei;
        h_avg_list_i(n) = h_avgi;
        evals_i(n) = evali;
    end
    
    figure();
    loglog(h_avg_list_e, global_errors_e, "b.", MarkerSize=10); hold on
    coeffs_e = polyfit(log(hs), log(global_errors_e), 1);
    globalfit_e = exp(polyval(coeffs_e, log(hs)));
    loglog(hs, globalfit_e, "r", LineWidth=1);
    % loglog(evals_e, global_errors_e, "b.", MarkerSize=10); hold on
    % coeffs_e = polyfit(log(evals_e), log(global_errors_e), 1);
    % globalfit_e = exp(polyval(coeffs_e, log(hs)));
    % loglog(evals_e, globalfit_e, "r", LineWidth=1);

    loglog(h_avg_list_m, global_errors_m, "k.", MarkerSize=10); hold on
    coeffs_m = polyfit(log(hs), log(global_errors_m), 1);
    globalfit_m = exp(polyval(coeffs_m, log(hs)));
    loglog(hs, globalfit_m, "g", LineWidth=1);
    % loglog(evals_m, global_errors_m, "k.", MarkerSize=10); hold on
    % coeffs_m = polyfit(log(evals_m), log(global_errors_m), 1);
    % globalfit_m = exp(polyval(coeffs_m, log(hs)));
    % loglog(evals_m, globalfit_m, "g", LineWidth=1);

    % loglog(h_avg_list_b, global_errors_b, "k.", MarkerSize=10); hold on
    % loglog(evals_b, globalfit_b, "g", LineWidth=1);
    % 
    % loglog(h_avg_list_i, global_errors_i, "k.", MarkerSize=10); hold on
    % loglog(evals_i, globalfit_i, "g", LineWidth=1);


    title("Global Truncation Error for Explicit Methods",'FontSize',13);
    xlabel("$h_{avg} (-)$ ",'FontSize',13);
    ylabel("Global Truncation error $(-)$",'FontSize',13)
    legend("Euler method error", "Euler fit line", "Midpoint method error", "Midpoint fit line",'FontSize',11, "Location", "west")

    myfig = gcf();
    exportgraphics(myfig , 'global_err_explicit_01.png', 'Resolution', 600);
end