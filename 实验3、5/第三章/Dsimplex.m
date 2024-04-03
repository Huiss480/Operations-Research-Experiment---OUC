% Dsimplex.m ��ż�����η�������Թ滮����
% max c'x
% s.t.
% Ax=b
% x>=0
% ����A\in R^{m\times n},c,x'\in R^n,b\in R^m
% ����A����һ����λ�Ӿ��󣬲���Ҫ�����˹��������ǻ��������������������Թ��򣬵���Դ�����и�ֵ
%  By Gongnong Li 2013
function[xstar,fxstar,A0,IB,iter]=Dismplex(A,b,c)
[m,n]=size(A);E=eye(m);IB=zeros(1,m);k=0;
for i=1:m
    for j=1:n
        if A(:,j)==E(:,i)
            IB(i)=j;SA(i)=j; % IB��¼�������±꣬SA��¼�ɳڱ����±�
        elseif A(:,j)==(-E(:,i))
            SA(i)=j; % SAҲ��¼ʣ�����(�ɳڱ���)�±�
        end
    end
end
A0=[b,A];N=1:n;IB;N(IB)=[]; IN=N;x(IB)=A0(:,1)';
x(IN)=zeros(1,length(IN)); cB=c(IB);
%INΪ�ǻ������±�
sigma=c'-cB' * A0(:,2:n+1);
%��������������ڶ�ż�����η���Ҫ������sigmaȫ��С�ڻ������
t=find(A0(:,1)<0); %���b�еĸ���
flag=0;
while (t~=0)&(flag==0)
    [bjj,jj]=min(A0(:,1));
% �����jj��A0(:,1)�о���ֵ����������У���A0�еĵ�jj�У����ж�Ӧ�Ļ�����
% x(IB(jj))Ϊ������������bjj������Ӧ����ֵ
tt=find(A0(jj,2:n+1)<0);kk=length(tt);
% �������ϵ������A0�е�jj��Ԫ���Ƿ���С�����Ԫ��
        if kk==0
            disp('ԭ�����޽�')
            xstar=[];fxstar=[];A0=[];IB=[];iter=k;
            flag=1;
        else
            theta=zeros(1,kk);
            for i=1:kk
                theta(i)=sigma(tt(i))/A0(jj,tt(i)+1);
            end
            [thetaI,ii]=min(abs(theta));Temp=tt(ii);
% ��ֵ��С��thetaֵ��ѡ������������ʱx(Temp)Ϊ���������A0(jj,Temp+1)Ϊ��ת��Ԫ
            for i=1:m
                if i ~=jj
                    A0(i,:)=A0(i,:)-(A0(jj,:)/A0(jj,Temp+1))*A0(i,Temp+1);
                else
                    A0(jj,:)=A0(jj,:)/A0(jj,Temp+1);
                end
            end
            TT=IB(jj);IB(jj)=Temp;IN(Temp)=TT;x(IB)=A0(:,1)';
            N=1:n;N(IB)=[];IN=N;x(IN)=zeros(1,length(IN));cB=c(IB);
% �µĻ����н⼰���ֵϵ��
            t=find(A0(:,1)<0);sigma=c'-cB'*A0(:,2:n+1);
% �ٴμ��b�еĸ������ٴμ��������
        end
        k=k+1;
end
disp('���Ż������±�Ϊ�� '),IB
disp('�ǻ������±�Ϊ��'),IN
disp('���յ����Ա�Ϊ����һ��Ϊ��Դ��������'),A0
disp('���յ����Ա��еļ�������'),sigma
if flag==1
    xstar=[];fxstar=[];iter=k;
    disp('ԭ�����޽��')
else
    B=A(:,IB);
    xstar=x;fxstar=x(IB)*c(IB);iter=k;
end

% ��������
% A=[-1 -2 -1 1 0;-2 1 -3 0 1];
% b=[-3 -4]';
% c=[-2 -3 -4 0 0]';
% [xstar,fxstar,A0,IB,iter]=Dsimplex(A,b,c)    
    

                     
                    
           

            

