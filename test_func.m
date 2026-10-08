function test_func()
    close all;
    set(groot, 'defaultTextInterpreter', 'latex');
    set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
    set(groot, 'defaultLegendInterpreter', 'latex');

    t = 0.492;
    XA = solution01(t);
    hs = logspace(-4.5,-1,100);
    local_errors = zeros(size(hs));
    
    for n = 1:length(hs)
        h = hs(n);
        l_e = local_error(@rate_func01, @solution01, XA, t, h);
        local_errors(n) = l_e;
    end
    
    figure();
    loglog(hs, local_errors, "b.", MarkerSize=10); hold on
    coeffs = polyfit(log(hs), log(local_errors), 1);
    localfit = exp(polyval(coeffs, log(hs)));
    loglog(hs, localfit, "r", LineWidth=1);
    title("Local Truncation Error for Explicit Midpoint Method",'FontSize',13);
    xlabel("$h_{avg} (-)$ ",'FontSize',13);
    ylabel("Local Truncation error $(-)$",'FontSize',13)
    legend("Errors", "Fit line",'FontSize',11, "Location", "northwest")
    
    global_errors = zeros(size(hs));
    h_avg_list = zeros(size(hs));
    time_int = [0, 100];
    
    for n = 1:length(hs)
        h = hs(n);
        [g_e,h_avg] = global_error(@rate_func01, @solution01, solution01(time_int(1)), time_int, h);
        global_errors(n) = g_e;
        h_avg_list(n) = h_avg;
    end
    
    figure();
    loglog(h_avg_list, global_errors, "b.", MarkerSize=10); hold on
    coeffs = polyfit(log(hs), log(global_errors), 1);
    coeffs
    globalfit = exp(polyval(coeffs, log(hs)));
    loglog(hs, globalfit, "r", LineWidth=1);
    title("Global Truncation Error for Explicit Midpoint Method",'FontSize',13);
    xlabel("$h_{avg} (-)$ ",'FontSize',13);
    ylabel("Global Truncation error $(-)$",'FontSize',13)
    legend("Errors", "Fit line",'FontSize',11, "Location", "northwest")
end







%first order system driven by sinusoid
function dXdt = rate_func01(t,X)
    dXdt = -5*X + 5*cos(t) - sin(t);
end
function X = solution01(t)
    X = cos(t);
end

%undamped second order system 
function dXdt = rate_func02(t,X)
    dXdt = [0,-1;1,0]*X;
end

function X = solution02(t)
    X = [cos(t);sin(t)];
end