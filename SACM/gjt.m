%x=random('Poisson',5,1000,1);
%x=unifrnd (0,100,1000,1);
x=[randn(300,1); 5+randn(300,1)];
%���������ĸ����ܶ�
bandwidth=std(x)*(length(x))^(-1/5);
xi=-5:0.1:10;
[f,xi,bw]=ksdensity(x,xi,'width',bandwidth);
f2=my_ksdensity(x,xi,bandwidth);
% for k=1:length(x)
%     f2=f2+Gaussian_kernel((x(k)-xi),bandwidth);
% end
% f2=f2/length(x);
%����ͼ��
subplot(211)
plot(x)
title('��������(Sample Data)')
subplot(212)
plot(xi,f,'r')
title('�����ܶȷֲ�(PDF)')
hold on;
plot(xi,f2,'x')
hold off;

