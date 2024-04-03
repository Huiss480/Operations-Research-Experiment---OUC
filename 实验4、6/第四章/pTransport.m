% �����������ı�����ҵ������
% min sum(c(ij)x(ij))
% s.y.
% sum(x(ij))=bi,i=1,2,...n(n������)
% sum(x(ij))=ai,i=1,2,...m(m������)
% x(ij)>=0
% ��sum(bi)=sum(aj),��Ϊ����ƽ������
% ��sum(bi)>=sum(aj),��Ϊ�����ڲ�����
% ��sum(bi)<=sum(aj),��Ϊ������������
% ������
% CostΪ��λ�˷ѱ�(����)���ж�Ӧ���أ��ж�Ӧ����
% ���޷���ĳ���س�������ĳ���أ�����Ӧ�ĵ�λ�˷�ȡ��ĳ���ܴ����������10^5
% DemandΪ����������(������)��SupplyΪ���ع�Ӧ�������(������)��
% �����
% FΪ�����˷ѣ�XΪ����������䷽��

function [X,F]=pTransport(Cost,Supply,Demand)
[m,n]=size(Cost);m0=m;n0=n;
% disp('ʹ�������Ƿ������ʼ�����н�');
% disp('ʹ����СԪ�ط������ʼ�����н�');
disp('ʹ�÷�����������ʼ�����н�');
%���������ж�������������ʲ���������ƽ�����⻯Ϊ����ƽ�����������
Temp=sum(Demand)-sum(Supply);
if Temp>0
	disp('���������ڲ����������⡣����������䷽���������˷�FΪ��')
	Cost(m+1,:)=zeros(1,n);Supply(m+1)=Temp;m=m+1;
elseif Temp<0
	disp('���ǲ����������������⡣����������䷽���������˷�FΪ��')
	Cost(:,n+1)=zeros(m,1);Demand(n+1)=-Temp;n=n+1;
else
	disp('���ǲ���ƽ����������⡣����������䷽���������˷�FΪ��')
end
mn=m*n;A=zeros(m+n,m*n); %�����������������ѧģ�͵�Լ������A
for k=1:m
	A(k,((k-1)*n+1):(k*n))=1; %���Ǿ���A�ĵ�k�У���Ӧ�ŵ�k������
end
T=1:n:mn;
for k=1:n
	A((k+m),(T+k-1))=1;%�����Ӧ������
end
%����ͨ��Vogal�������Ƿ�����СԪ�ط������ʼ�����н�(��ʼ���䷽��)
%%%%TODO Put the Code for Problem  at below %%%%
% [X,b]=pNorthWest(Supply,Demand);  %���������Ƿ������ʼ�����н�
% [X,b]=pMinimal(Cost,Supply,Demand);  %������СԪ�ط������ʼ�����н�
[X,b]=Vogal(Cost,Supply,Demand);  %����Vogal�����ʼ�����н�


%�������ʼ�����н�������Բ������������и���
flag=0;
while flag==0
	[optflag,entB]=IsOptimal(b,Cost,A);
	if optflag
		break;
    end  
	[Y,Bout]=Loop(X,entB(1),entB(2),b);
	b=Bout;
    X=Y;
    %%%%TODO Put the Code for Problem  at below %%%%
    disp('�м���˷�����');
    disp(X);
end
% Ϊ����ĳЩ������ƽ������ĵ�λ�˷Ѿ����г���inf���ڼ������˷�ʱ����NaN,�����´���
for i=1:m
	for j=1:n
		if Cost(i,j)==inf
			Cost(i,j)=0;
		end
	end
end
%%%%TODO Put the Code for Problem  at below %%%%
%������ճɱ��͵��˷���
F = sum(sum(Cost .* X));
X=X(1:m0,1:n0);
end

%�ж��Ƿ�����
function[optflag,entB]=IsOptimal(b,Cost,A)
[m,n]=size(Cost);
mn=m*n;
blst=reshape(b',1,mn);
Clst=reshape(Cost',1,mn);
A=A(1:(end-1),:);
B=A(:,logical(blst));
Cb=Clst(logical(blst));
nidx=find(~blst);
N=A(:,nidx);
Cn=Clst(nidx);
sigma=Cn-Cb*inv(B)*N;
NegFlag=sigma<0;
if sum(NegFlag)==0
	optflag=1;
    entB=[];
else
	optflag=0;
	[tmp,tmpidx]=min(sigma);
    tmp=nidx(tmpidx);
    col=mod(tmp,n);
	if col==0
		entB(1)=tmp/n;
        entB(2)=n;
	else
		entB(1)=ceil(tmp/n);
        entB(2)=col;
	end
end
end




