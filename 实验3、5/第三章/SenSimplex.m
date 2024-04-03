% 该程序用于分析灵敏度时调用
% 与MMSimplex.m基本一样，只是输出要求不同
% max c'x
% s.t.
% Ax=b
% x>=0
% 这里A\in R^{m\times n},c,x'\in R^n,b\in R^m, b\geq 0
% 在需要添加人工变量时将采用两阶段法求解上述问题
% By Gongnong li 2013
function[IB,IN,SA,IBB,INN,InverseOfB,A0,sigma]=SenSimplex(A,b,c)
A0=A;[m,n]=size(A0);E=eye(m);IB=zeros(1,m);
SA1=zeros(1,n);IR1=zeros(1,m);IR=1:m;k=0;
%检查原问题(标准形式)系数矩阵中是否含有E(:,i)
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
% IB记录了原问题系数矩阵有多少个E(:,i)，即m-length(s)个,对应的x(i)为初始
% 基变量。IBB记录了原问题基变量中除去松弛变量后的基变量下标。INN记录了原问题中非
%基变量除去松弛变量够的非基变量。IBB和INN用于灵敏度分析中的ci分析。SA记录松弛变量下标。
%IR则记录了原问题系数矩阵缺少的E(:,i)下标，即i，这些是需要通过人 
%工变量补齐的共length(s)个人工变量，这些变量也是初始基变量。
%SA记录松弛变量(剩余变量)下标。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for p=1:length(s)
	A0(:,n+p)=E(:,IR(p));IB(IR(p))=n+p;IR(p)=n+p;
end
%IB记录了基变量的下标，而IR记录了人工变量的下标(共有length(s)个人工变量)。
%退出时矩阵A0具有一个单位子矩阵，可能含有人工变量。
A0=[b,A0];flag=0;
%下面先求第一阶段问题，将会得到原问题的一个初始基可行解
while (length(IR)~=0)&(flag==0) %这表明有人工变量才需要求解第一阶段问题
	c0=zeros(n+length(s),1);c0(IR)=-one(length(s),1);
	%第一阶段的相关矩阵和向量
	N=1:n+length(s);N(IB)=[];IN=N; %IB记录基可行解的下标，IN记录非基可行解的下标
	x(IN)=zeros(1,length(IN));x(IB)=A0(:,1)';cB=c0(IB);
	%第一阶段的初始基可行解及其价值系数
	sigma=c0'-cB'*A0(:,2:n+length(s)+1); %检验数，是一个行向量
	t=length(find(sigma>0)); %假设检验数中有t个大于零的检验数
	while t~=0
		[sigmaJ,jj]=max(sigma);
		%这里的jj是sigma中绝对值最大者所在列，即A0中的第jj+1列(A0中第一列为b)，对应的非基
	    %变量x(jj)为换入变量，而sigmaJ则是相应的检验数
		tt=find(A0(:,jj+1)>0);kk=length(tt);
		%检查增广系数矩阵A0中第jj+1列元素是否有大于零的元素
		if kk==0
			disp('原问题为无界解'); %即A0的第jj+1列元素全部小于或等于零
			IB=[];IN=[];SA=[];IBB=[];INN=[];InverseOfB=[];A0=[];sigma=[];
			flag=1;
		else
			theta=zeros(1,kk);
			for i=1:kk
				theta(i)=A0(tt(i),1)/A0(tt(i),jj+1);
			end
			[thetaI,ii]=min(theta);Temp=tt(ii);
		%比值最小的theta值，选换出变量，Temp为换出变量下标。这时A0(Temp,jj+1)为旋转主元
			for i=1:m
				if i~=Temp
					A0(i,:)=A0(i,:)-(A0(Temp,:)/A0(Temp,jj+1))*A0(i,jj+1);
				else
					A0(Temp,:)=A0(Temp,:)/A0(Temp,jj+1);
				end
			end
		%以上为旋转运算
			TT=IB(Temp);IB(Temp)=jj;
			for i=1:length(IR)
				if IR(i)==TT
					IR(i)=0;
				end
			end
			d=find(IR==0);IR(d)=[]; %这里记录的是人工变量的变化
			IN(jj)==TT;x(IB)=A0(:,1)';x(IN)=zeros(1,length(IN));
			cB=c0(IB);
		%新的基可行解及价值系数
			sigma=c0'-cB'*A0(:,2:n+length(s)+1);t=length(find(sigma>0));
		%再次计算检验数并假设检验数中有t个大于零的检验数
		end
		k=k+1;
	end
	if sum(x(IR))~=0
		disp('原问题无解');%此时没有检验数小于零，但第一阶段有最优解，从而原问题无解
		IB=[];IN=[];SA=[];IBB=[];INN=[];InverseOfB=[];A0=[];sigma=[];
		flag=2;
	else
		x=x(1:n);
	end
end
%第一阶段问题求解完毕，得到原问题的一个基可行解 
if (flag==1)|(flag==2)
    return
else
    N=1:n; N(IB)=[]; IN=N; x(IN)=zeros(1,length(IN)); cB=c(IB); A0=A0(:,1:n+1); 
    %回到原问题的有关矩阵和向量
    sigma=c'-cB'*A0(:,2:n+1); t=length(find(sigma>0));
    %计算原问题的检验数并假设检验数中有t个大于零的检验数
    while (t~=0)
        [sigmaJ,jj]=max(sigma);
        %jj是sigma中绝对值最大者所在列，即A0中的第jj+1列(A0中第一列为b)，
        %该列对应 %的非基变量x(jj)为换入变量，而sigmaJ则是相应的检验数
        tt=find(A0(:,jj+1)>0);kk=length(tt);
        %检查增广系数矩阵A0中第j+1列元素是否有大于零的元素
        if kk==0
            disp('原问题为无界解'); 
            IB=[];IN=[];SA=[];IBB=[];INN=[];InverseOfB=[];A0=[];sigma=[];
            flag=1;
        else
            theta=zeros(1,kk);
            for i=1:kk
                theta(i)=A0(tt(i),1)/A0(tt(i),jj+1);
            end
            [thetaI,ii]=min(theta); Temp=tt(ii);
            %比值最小的theta值，选择换出变量。这时A0(Temp,jj+1)为旋转主元
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
            %新的基可行解及其价值系数
            sigma=c'-cB'*A0(:,2:n+1);
            t=length(find(sigma>0)); %再次计算检验数并设检验数中有t个大于零
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
    disp('原问题为无界解');
elseif flag==2
    IB=[];IN=[];SA=[];IBB=[];INN=[];InverseOfB=[];A0=[];sigma=[];
    disp('原问题为无界解');
else
    INNi=find(INN==0);INN(INNi)=[];
    B=A(:,IB);InverseOfB=inv(B);
    % 这是基矩阵B的逆矩阵，用于灵敏度分析
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


	






