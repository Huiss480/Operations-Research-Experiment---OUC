% Ssimplex.m ���õ����η���MATLAB����
% max c'x
% a.t.
% ax=b
% x>=0
% ����A\in R^{m\times n},c,x'\im R^m,b\geq 0
% �Ҿ���A����һ����λ�Ӿ��󣬲���Ҫ�����˹�����
% ��Ҫ�Լ���̹ؼ����봦��%%%% Put the Code for Problem  at below %%%%
function [xstar,fxstar,iter]=pSsimplex(A,b,c)
[A,b]=StMatrix(A,b);
[m,n]=size(A);
E=eye(m);
IB=zeros(1,m);
k=0;

for i = 1:m
    for j=1:n
        if A(:,j)==E(:,i)
            IB(i)=j;SA(i)=j;%IB��¼�������±꣬SA��¼�ɳڱ����±�
        elseif A(:,j)==(-E(:,i))
            SA(i)=j;%SAҲ��¼ʣ��������ɳڱ������±�
        end
    end
end
A0=[b,A];
disp('��ʾԭʼ�����α�');
disp(A0);

%���� b c������������,��������������
[c1, c2]=size(c);
if c1==1
   c=c';
end
[b1, b2]=size(b);
if b1==1
   b=b';
end

N=1:n; %����
N(IB)=[];
IN=N;
x(IB)=A0(:,1)';
x(IN)=zeros(1,length(IN));
disp(IB);
cB=c(IB);

%INΪ�ǻ������±�
sigma=c'-cB'*A0(:,2:n+1);
t=length(find(sigma>0));
%����ԭ����ļ��������������������t��������ļ�����
disp('��ʾ��������sigma��');
disp(sigma);

while t~=0
    [sigma,jj]=max(sigma);
    %�����jj��sigma��ֵ����������У���A0�еĵ�jj+1�У�A0�еĵ�һ��Ϊb����
    %���ж�Ӧ�ķǻ�����x(jj)Ϊ�����������sigmaJ������Ӧ�ļ�����
    tt=find(A0(:,jj+1)>0);
    kk=length(tt);
    %�������ϵ������A0�е�jj+1��Ԫ���Ƿ��д������Ԫ��
    if kk==0
        disp('ԭ����Ϊ�޽��')
    else
        theta =zeros(1,kk);%theta�г�ʼ��Ϊ0
        %%%%TODO Put the Code for Problem  at below %%%%
        %�󵥴��Ա�����һ�У�thetaֵ�У����Ҷ˳�����b��������������еı�ֵ
        for i=1:kk
              theta(i)=A0(tt(i),1)/A0(tt(i),jj+1);
        end
        [thetaI,ii]=min(theta);
        Temp=tt(ii);
        %��ֵ��С��thetaֵ��Temp��ѡ�񻻳����������кš� ��ʱA0(Temp,jj+1)Ϊ��ת��Ԫ
        %TempΪ��תԪ�к�(��A0��)��jj+1Ϊ ��תԪ�к� 
        disp('i=');Temp %i=i+1; ���ĺ�����������һ��
        disp('j=');jj+1 %i=i+1; ���ĺ�����������һ��
        
        %���л�������
        for i=1:m
            if i~=Temp
                %%%%TODO Put the Code for Problem  at below %%%%
                %%%%TODO Put the Code for Problem  at below %%%%
                %��תԪ����������Ԫ�ض���0���������еĵı仯
                A0(i,:)=A0(i,:)-A0(i,jj+1)/A0(Temp,jj+1)*A0(Temp,:);
            else
                %���л�������,��תԪԪ����1����תԪ�����еĵı仯
                A0(Temp,:)=A0(Temp,:)/A0(Temp,jj+1);
            end
        end
        
        TT=IB(Temp);IB(Temp)=jj;IN(jj)=TT;
        x(IB)=A0(:,1)';%������ 
        N=1:n+m;N(IB)=[];IN=N;
        x(IN)=zeros(1,length(IN));%�ǻ����� 
        cB=c(IB);
        %�µĻ����н⼰���ֵϵ��
        sigma=c'-cB'*A0(:,2:n+1);
        t=length(find(sigma>0));
        %�ٴμ�����������������������t��������ļ�����
    end
    k=k+1;
end
%IB
%IN
% B=A(:,IB);
% InverseOfB=inv(B)

%���ǻ�����B����������������ȷ����������������ȷ���������ע�͵�
disp('��ʾ���յ����α�')
disp(A0);
xstar=x;fxstar=x(IB)*c(IB);iter=k;


