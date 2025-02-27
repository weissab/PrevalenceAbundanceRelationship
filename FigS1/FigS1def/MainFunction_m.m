clear;
clc;
Nts=10:20:100;
d=10.^[-6];
ms=0.2:0.2:1;
CC=linspecer(length(ms));

ps=[0.001:0.001:0.05];

for hjk=1:length(ms)
    m=ms(hjk);
    slope=0;
    for j=1:length(Nts)
        occu=0;
        abun=0;
        Nt=Nts(j);
        for i=1:length(ps)
            p=ps(i);
            fun = @(x) x.^(Nt*m*p-1).*(1-x).^(Nt*m*(1-p)-1);
            c=gamma(Nt*m)/gamma(Nt*m*(1-p))/gamma(Nt*m*p);
            occu(i)=c*integral(fun,d,1);
            fun2 = @(x) x.*x.^(Nt*m*p-1).*(1-x).^(Nt*m*(1-p)-1);
            abun(i)=c*integral(fun2,d,1);
        end
        %plot(log(-log(1-occu(occu>0&occu<1)))',log(ps(occu>0&occu<1)),'.','markersize',20,'color',CC(j,:));hold on;
        ss=polyfit(log(-log(1-occu(occu>0&occu<1)))',log(abun(occu>0&occu<1)),1);
        slope(j)=ss(1);
    end
    plot(Nts,slope,'o-','markersize',10,'linewidth',2,'color',CC(hjk,:));hold on;
end
set(gca,'fontsize',16);
% legend({'','',''});
% legend boxoff;
xlabel('population size N_t','fontsize',24);
ylabel('scaling exponent \theta','fontsize',24);
axis([0 max(Nts) 0.8 1.2]);
set(gcf,'position',[100 100 270 270]);

saveas(gcf,'MainFunction_m.fig');
saveas(gcf,'MainFunction_m.pdf');