% �ó�����������ƽ�������ʼ�����н����СԪ�ط�
% ������
% CostΪ��λ�˷ѱ�(����)���ж�Ӧ���أ��ж�Ӧ����
% SupplyΪ��Ӧ������ز���(������)��DemandΪ������������(������)
% �����
% XΪ������䷽��;b��¼�����ָ�(1��ʾ��Ӧ���ǻ����������ָ�0��ʾ�ǻ�����)

function [X,b]=pMinimal(Cost,Supply,Demand)
[m,n]=size(Cost); 
m=length(Supply);
n=length(Demand);
X=zeros(m,n);b=zeros(m,n);I=[1:m];
flag=0;
while flag==0
    for k=1:m
        [T(k),J(k)]=min(Cost(k,:));
    end
    [TT,kk]=min(T);
    %Cost(kk,J(kk))Ԫ����Cost����С�ߡ����ǿ���Supply(kk)��Demand(J(kk))֮
    %��Ĺ�ϵ���������䷽��������J(kk)�����ص�����������kk�����صĲ�������
    %����kk�����صĲ���Supply(kk)ȫ����Ӧ����J(kk)�����أ�Ȼ��Cost�еĵ�kk
    %�л�ȥ(ͨ����ֵinf���)������kk�����صĲ���������J(kk)�����ص�������
    %���kk�����صĲ���ȫ�������J(kk)�����ء�Ȼ��Cost�еĵ�J(kk)�л�ȥ(ͨ����ֵinf���)
    if Supply(kk)<Demand(J(kk))
        X(kk,J(kk))=Supply(kk);   
    %%%%TODO Put the Code for Problem  at below %%%%
	%Demand�������ı仯��� Supply��Ӧ���ı仯���
        Demand(J(kk)) = Demand(J(kk)) - Supply(kk);
        Supply(kk) = 0;
        
        b(kk,J(kk))=1;
        Cost(kk,:)=inf*ones(1,n);
    elseif Supply(kk)>Demand(J(kk))
        X(kk,J(kk))=Demand(J(kk));  
    %%%%TODO Put the Code for Problem  at below %%%%
	%Demand�������ı仯��� Supply��Ӧ���ı仯���
        Supply(kk) = Supply(kk) - Demand(J(kk));
        Demand(J(kk)) = 0;
        
        b(kk,J(kk))=1;
        Cost(:,J(kk))=inf*ones(m,1);
    else
        X(kk,J(kk))=Demand(J(kk));
        b(kk,J(kk))=1;
        % ��ʱ�����˻��������Ҫ��0��Ϊĳ����������ȡֵ
        Supply(kk)=0;Demand(J(kk))=0;Cost(:,J(kk))=inf*ones(m,1);Cost(kk,:)=inf*ones(1,n);
        % Ϊ�˷�ֹ�ಹ0��Ϊĳ����������ȡֵ�������´���
        if length(find(b==1))<m+n-2
            I1=find(I~=kk);b(I1(end),J(kk))=1;
        end
    end
    if length(find(b==1))==m+n-1
        flag=1;
    else
        flag=0;
    end
end

