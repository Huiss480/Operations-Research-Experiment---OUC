% �ó�����������ƽ�������ʼ�����н�������Ƿ�
% ������
% DemandΪ������������(������)��SupplyΪ��Ӧ������ز���(������)
% �����
% XΪ������䷽��;b��¼�����ָ�(1��ʾ��Ӧ���ǻ����������ָ�0��ʾ�ǻ�����)


function [X,b]=pNorthWest(Supply,Demand)
m=length(Supply);
n=length(Demand);
i=1;j=1;
X=zeros(m,n);b=zeros(m,n);
while((i<=m)&&(j<=n))
    if Supply(i)<Demand(j)
        X(i,j)=Supply(i);
        b(i,j)=1;
    %%%%TODO Put the Code for Problem  at below %%%%
	%Demand�������ı仯���
        Demand(j) = Demand(j) - Supply(i);
        i=i+1;
    else
        X(i,j)=Demand(j);
        b(i,j)=1;
    %%%%TODO Put the Code for Problem  at below %%%%
	%Supply��Ӧ���ı仯���
        Supply(i) = Supply(i) - Demand(j);
        j=j+1;
    end
end
        





