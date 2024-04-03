% �ó������ڷ���������ʱ����
% ��MMSimplex.m����һ����ֻ�����Ҫ��ͬ
% max c'x
% s.t.
% Ax=b
% x>=0
% ����A\in R^{m\times n},c,x'\in R^n,b\in R^m, b\geq 0
% ����Ҫ����˹�����ʱ���������׶η������������
% By Gongnong li 2013
function[IB,IN,SA,IBB,INN,InverseOfB,A0,sigma]=SenSimplex(A,b,c)
A0=A;[m,n]=size(A0);E=eye(m);IB=zeros(1,m);
SA1=zeros(1,n);IR1=zeros(1,m);IR=1:m;k=0;
%���ԭ����(��׼��ʽ)ϵ���������Ƿ���E(:,i)
for i=1:m
	for j=1:n   
		if A0(:,j)==E(:,i)
			IB(i)=j;IR1(i)=i;SA1(i)=j;
		elseif A(:,j)==(-E(:,i))
			SA1(i)=j;
		end
	end
end
s1=find(SA1~=0);
if length(s1)~=0
	for i=1:length(s1)
		SA(i)=SA1(s1(i));
	end
else
	SA=[];
end
IR=find(IR~=IR1);s=find(IR~=0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IB��¼��ԭ����ϵ�������ж��ٸ�E(:,i)����m-length(s)��,��Ӧ��x(i)Ϊ��ʼ
% ��������IBB��¼��ԭ����������г�ȥ�ɳڱ�����Ļ������±ꡣINN��¼��ԭ�����з�
%��������ȥ�ɳڱ������ķǻ�������IBB��INN���������ȷ����е�ci������SA��¼�ɳڱ����±ꡣ
%IR���¼��ԭ����ϵ������ȱ�ٵ�E(:,i)�±꣬��i����Щ����Ҫͨ���� 
%����������Ĺ�length(s)���˹���������Щ����Ҳ�ǳ�ʼ��������
%SA��¼�ɳڱ���(ʣ�����)�±ꡣ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for p=1:length(s)
	A0(:,n+p)=E(:,IR(p));IB(IR(p))=n+p;IR(p)=n+p;
end
%IB��¼�˻��������±꣬��IR��¼���˹��������±�(����length(s)���˹�����)��
%�˳�ʱ����A0����һ����λ�Ӿ��󣬿��ܺ����˹�������
A0=[b,A0];flag=0;
%���������һ�׶����⣬����õ�ԭ�����һ����ʼ�����н�
while (length(IR)~=0)&(flag==0) %��������˹���������Ҫ����һ�׶�����
	c0=zeros(n+length(s),1);c0(IR)=-one(length(s),1);
	%��һ�׶ε���ؾ��������
	N=1:n+length(s);N(IB)=[];IN=N; %IB��¼�����н���±꣬IN��¼�ǻ����н���±�
	x(IN)=zeros(1,length(IN));x(IB)=A0(:,1)';cB=c0(IB);
	%��һ�׶εĳ�ʼ�����н⼰���ֵϵ��
	sigma=c0'-cB'*A0(:,2:n+length(s)+1); %����������һ��������
	t=length(find(sigma>0)); %�������������t��������ļ�����
	while t~=0
		[sigmaJ,jj]=max(sigma);
		%�����jj��sigma�о���ֵ����������У���A0�еĵ�jj+1��(A0�е�һ��Ϊb)����Ӧ�ķǻ�
	    %����x(jj)Ϊ�����������sigmaJ������Ӧ�ļ�����
		tt=find(A0(:,jj+1)>0);kk=length(tt);
		%�������ϵ������A0�е�jj+1��Ԫ���Ƿ��д������Ԫ��
		if kk==0
			disp('ԭ����Ϊ�޽��'); %��A0�ĵ�jj+1��Ԫ��ȫ��С�ڻ������
			IB=[];IN=[];SA=[];IBB=[];INN=[];InverseOfB=[];A0=[];sigma=[];
			flag=1;
		else
			theta=zeros(1,kk);
			for i=1:kk
				theta(i)=A0(tt(i),1)/A0(tt(i),jj+1);
			end
			[thetaI,ii]=min(theta);Temp=tt(ii);
		%��ֵ��С��thetaֵ��ѡ����������TempΪ���������±ꡣ��ʱA0(Temp,jj+1)Ϊ��ת��Ԫ
			for i=1:m
				if i~=Temp
					A0(i,:)=A0(i,:)-(A0(Temp,:)/A0(Temp,jj+1))*A0(i,jj+1);
				else
					A0(Temp,:)=A0(Temp,:)/A0(Temp,jj+1);
				end
			end
		%����Ϊ��ת����
			TT=IB(Temp);IB(Temp)=jj;
			for i=1:length(IR)
				if IR(i)==TT
					IR(i)=0;
				end
			end
			d=find(IR==0);IR(d)=[]; %�����¼�����˹������ı仯
			IN(jj)==TT;x(IB)=A0(:,1)';x(IN)=zeros(1,length(IN));
			cB=c0(IB);
		%�µĻ����н⼰��ֵϵ��
			sigma=c0'-cB'*A0(:,2:n+length(s)+1);t=length(find(sigma>0));
		%�ٴμ�����������������������t��������ļ�����
		end
		k=k+1;
	end
	if sum(x(IR))~=0
		disp('ԭ�����޽�');%��ʱû�м�����С���㣬����һ�׶������Ž⣬�Ӷ�ԭ�����޽⢘
		IB=[];IN=[];SA=[];IBB=[];INN=[];InverseOfB=[];A0=[];sigma=[];
		flag=2;
	else
		x=x(1:n);
	end
end
%��һ�׶����������ϣ��õ�ԭ�����һ�������н� 
if (flag==1)|(flag==2)
    return
else
    N=1:n; N(IB)=[]; IN=N; x(IN)=zeros(1,length(IN)); cB=c(IB); A0=A0(:,1:n+1); 
    %�ص�ԭ������йؾ��������
    sigma=c'-cB'*A0(:,2:n+1); t=length(find(sigma>0));
    %����ԭ����ļ��������������������t��������ļ�����
    while (t~=0)
        [sigmaJ,jj]=max(sigma);
        %jj��sigma�о���ֵ����������У���A0�еĵ�jj+1��(A0�е�һ��Ϊb)��
        %���ж�Ӧ %�ķǻ�����x(jj)Ϊ�����������sigmaJ������Ӧ�ļ�����
        tt=find(A0(:,jj+1)>0);kk=length(tt);
        %�������ϵ������A0�е�j+1��Ԫ���Ƿ��д������Ԫ��
        if kk==0
            disp('ԭ����Ϊ�޽��'); 
            IB=[];IN=[];SA=[];IBB=[];INN=[];InverseOfB=[];A0=[];sigma=[];
            flag=1;
        else
            theta=zeros(1,kk);
            for i=1:kk
                theta(i)=A0(tt(i),1)/A0(tt(i),jj+1);
            end
            [thetaI,ii]=min(theta); Temp=tt(ii);
            %��ֵ��С��thetaֵ��ѡ�񻻳���������ʱA0(Temp,jj+1)Ϊ��ת��Ԫ
            for i=1:m
                if i~=Temp
                    A0(i,:)=A0(i,:)-(A0(Temp,:)/A0(Temp,jj+1))*A0(i,jj+1);
                else
                    A0(Temp,:)=A0(Temp,:)/A0(Temp,jj+1);
                end
            end
            TT=IB(Temp);IB(Temp)=jj;IN(jj)=TT; x(IB)=A0(:,1)';
            N=1:n;N(IB)=[];IN=N; x(IN)=zeros(1,length(IN));
            cB=c(IB);
            %�µĻ����н⼰���ֵϵ��
            sigma=c'-cB'*A0(:,2:n+1);
            t=length(find(sigma>0)); %�ٴμ���������������������t��������
        end
        k=k+1;
    end
end
IBB=IB;INN=IN;
for i=1:m
    if ismember(IBB(i),SA)
        IBB(i)=0;
    end
end
IBBi=find(IBB==0);IBB(IBBi)=[];
for i=1:length(IN)
    if ismember(INN(i),SA)
        INN(i)=0;
    end
end
if flag==1
    IB=[];IN=[];SA=[];IBB=[];INN=[];InverseOfB=[];A0=[];sigma=[];
    disp('ԭ����Ϊ�޽��');
elseif flag==2
    IB=[];IN=[];SA=[];IBB=[];INN=[];InverseOfB=[];A0=[];sigma=[];
    disp('ԭ����Ϊ�޽��');
else
    INNi=find(INN==0);INN(INNi)=[];
    B=A(:,IB);InverseOfB=inv(B);
    % ���ǻ�����B����������������ȷ���
    xstar=zeros(1,n);xstar(IB)=A0(:,1)';
    fxstar=xstar(IB)*c(IB);
    iter=k;
    disp(newline);
    disp('fxstar = ');
    disp(fxstar);
    disp('xstar = ');
    disp(xstar);
    disp('iter = ');
    disp(iter);
end


	






