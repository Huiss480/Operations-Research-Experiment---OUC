% �ó�����������ƽ�������ʼ�����н�ķ������
% ������
% CostΪ��λ�˷ѱ�(����)���ж�Ӧ���أ��ж�Ӧ����
% SupplyΪ��Ӧ������ز���(������)��DemandΪ������������(������)
% �����
% XΪ������䷽��;b��¼�����ָ�(1��ʾ��Ӧ���ǻ����������ָ�0��ʾ�ǻ�����)
% By Gongnong Li 2013
function [X,b]=Vogal(Cost,Supply,Demand)
[m,n]=size(Cost);  m=length(Supply);n=length(Demand);
X=zeros(m,n);b=zeros(m,n);I=[1:m];
flag=0;
while flag==0
    TRC=Cost;TCC=Cost;
    for k=1:m %���ÿ����СԪ�غʹ���СԪ�ص��б�J1(k)��J2(k)
        [T1(k),J1(k)]=min(TRC(k,:));
        TRC(k,J1(k))=inf;
        [T2(k),J2(k)]=min(TRC(k,:));
    end
    for s=1:n %���ÿ����СԪ�غʹ���СԪ�ص��б�JJ1(s)��JJ2(s)
         [TT1(s),JJ1(s)]=min(TCC(:,s));
         TCC(JJ1(s),s)=inf;
         [TT2(s),JJ2(s)]=min(TCC(:,s));
    end
    % ���ÿ��(��)��СԪ�غʹ���СԪ�صĲ�������������
    for i=1:m
        if (T2(i)==inf)&(T1(i)~=inf)
            Trow(i)=T1(i);
        elseif T2(i)==inf
            Trow(i)=-inf;
        else
            Trow(i)=T2(i)-T1(i);
        end
    end
    for i=1:n
        if (TT2(i)==inf)&(TT1(i)~=inf)
            Tcolumn(i)=TT1(i);
        elseif TT2(i)==inf
            Tcolumn(i)=-inf;
        else
            Tcolumn(i)=TT2(i)-TT1(i);
        end
    end
    [TrowM,kk1]=max(Trow);[TcolumnM,kk2]=max(Tcolumn);
    %����������kk1�У�������СԪ��Ϊ��J1(kk1)��Ԫ��
    if((TrowM>TcolumnM) | (TrowM==TcolumnM))
        kk=kk1;Jkk=J1(kk1);
    else %�����������У�������СԪ����С��Ϊ��JJ1(kk1)��Ԫ��
        kk=JJ1(kk2);Jkk=kk2;
    end
    %������X(kk,J(kk))Ԫ���Ƿ�����������ȿ��ǰ��ŵ�Ԫ��
    %���ǿ���Supply(kk)��Demand(J(kk))֮��Ĺ�ϵ���������䷽����
    %����Jkk�����ص�����������kk�����صĲ�������
    %����kk�����صĲ���Supply(kk)ȫ����Ӧ����Jkk�����أ�Ȼ��Cost�еĵ�kk
    %�л�ȥ(ͨ����ֵinf���)������kk�����صĲ���������Jkk�����ص�������
    %���kk�����صĲ���ȫ�������Jkk�����ء�Ȼ��Cost�еĵ�Jkk�л�ȥ(ͨ����ֵinf���)
     if Supply(kk)<Demand(Jkk)
        X(kk,Jkk)=Supply(kk);        
        Demand(Jkk)=Demand(Jkk)-Supply(kk);
        Supply(kk)=0;
        b(kk,Jkk)=1;
        Cost(kk,:)=inf*ones(1,n);
    elseif Supply(kk)>Demand(Jkk)
        X(kk,Jkk)=Demand(Jkk);        
        Supply(kk)=Supply(kk)-Demand(Jkk);
        Demand(Jkk)=0;
        b(kk,Jkk)=1;
        Cost(:,Jkk)=inf*ones(m,1);
    else
        X(kk,Jkk)=Demand(Jkk);
        b(kk,Jkk)=1;
        % ��ʱ�����˻��������Ҫ��0��Ϊĳ����������ȡֵ
        Supply(kk)=0;
        Demand(Jkk)=0;
        Cost(:,Jkk)=inf*ones(m,1);
        Cost(kk,:)=inf*ones(1,n);
        if (length(find(b==1))==(m+n-1))
            flag=1;
        else
            I=find(I~=Jkk);
            if length(I)~=0
                b(I(1),Jkk)=1;
            else
                return;
            end
        end
     end
     if (length(find(b==1))==(m+n-1))
         flag=1;
     else
         flag=0;
     end
end

         
          
        
        
           
          
    
    
            
        
        
        
        
        
        
        
        
        
        
        