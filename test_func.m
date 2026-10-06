close all;
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');

%first order system driven by sinusoid
function dXdt = rate_func01(t,X)
    dXdt = -5*X + 5*cos(t) - sin(t);
end
function X = solution01(t)
    X = cos(t);
end

t = 0.492;
XA = solution01(t);
hs = logspace(10e-5, 10, 100);
local_errors = [];

% for h = hs
%     e = local_error(@rate_func01, XA, t, h);
%     local_errors = [local_errors, e];
% end

% figure();
% loglog(hs, local_errors, "b.", MarkerSize=10); hold on
% coeffs = polyfit(log(hs), log(local_errors), 1)
% yfit = exp(polyval(coeffs, log(hs)));
% loglog(hs, yfit, "r", LineWidth=1)
% title("Local Truncation Error for Explicit Midpoint Function");
% xlabel("h (step size) (-)");
% ylabel("Local step error (-)")
% legend("Errors", "Fit line")

global_errors = [];
time_int = [0, 100];

for h = hs
    e = global_error(@rate_func01, XA, time_int, h);
    global_errors = [global_errors, e]
end

figure();
loglog(hs, global_errors, "b.", MarkerSize=10); hold on
coeffs = polyfit(log(hs), log(global_errors), 1)
yfit = exp(polyval(coeffs, log(hs)));
loglog(hs, yfit, "r", LineWidth=1)
title("Local Truncation Error for Explicit Midpoint Function");
xlabel("h (step size) (-)");
ylabel("Global step error (-)")
legend("Errors", "Fit line")

%undamped second order system 
function dXdt = rate_func02(t,X)
    dXdt = [0,-1;1,0]*X;
end
function X = solution02(t)
    X = [cos(t);sin(t)];
end