function f = asymptotefcn(x, t_data, v_data)
%Determines the asymptotic velocity based on velcoity vs time data.
    y_data=x-v_data;
    fit = polyfit(log(t_data),log(y_data), 1);
    m = fit(1);
    k = fit(2);
    y_fit = t_data.^m.*exp(k);
    f=sum((y_fit-y_data).^2);
    if ~isreal(f)
        f=10;
    end
end