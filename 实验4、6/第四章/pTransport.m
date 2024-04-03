% 求解运输问题的表上作业法程序
% min sum(c(ij)x(ij))
% s.y.
% sum(x(ij))=bi,i=1,2,...n(n个产地)
% sum(x(ij))=ai,i=1,2,...m(m个销地)
% x(ij)>=0
% 若sum(bi)=sum(aj),则为产销平衡问题
% 若sum(bi)>=sum(aj),则为销大于产问题
% 若sum(bi)<=sum(aj),则为产大于销问题
% 输入项
% Cost为单位运费表(矩阵)，行对应产地，列对应销地
% 若无法从某产地出发到达某销地，将相应的单位运费取做某个很大的正数，如10^5
% Demand为销地需求量(列向量)；Supply为产地供应量或产量(列向量)；
% 输出项
% F为最有运费；X为最优运输分配方案

function [X,F]=pTransport(Cost,Supply,Demand)
[m,n]=size(Cost);m0=m;n0=n;
% disp('使用西北角法求出初始基可行解');
% disp('使用最小元素法求出初始基可行解');
disp('使用伏格尔法求出初始基可行解');
%下面首先判断运输问题的性质并将产销不平衡问题化为产销平衡的运输问题
Temp=sum(Demand)-sum(Supply);
if Temp>0
	disp('这是销大于产的运输问题。最优运输分配方案及最有运费F为：')
	Cost(m+1,:)=zeros(1,n);Supply(m+1)=Temp;m=m+1;
elseif Temp<0
	disp('这是产大于销的运输问题。最优运输分配方案及最有运费F为：')
	Cost(:,n+1)=zeros(m,1);Demand(n+1)=-Temp;n=n+1;
else
	disp('这是产销平衡的运输问题。最优运输分配方案及最有运费F为：')
end
mn=m*n;A=zeros(m+n,m*n); %这里求出运输问题数学模型的约束矩阵A
for k=1:m
	A(k,((k-1)*n+1):(k*n))=1; %这是矩阵A的第k行，对应着第k个产地
end
T=1:n:mn;
for k=1:n
	A((k+m),(T+k-1))=1;%这里对应着销地
end
%下面通过Vogal、西北角法或最小元素法求出初始基可行解(初始运输方案)
%%%%TODO Put the Code for Problem  at below %%%%
% [X,b]=pNorthWest(Supply,Demand);  %利用西北角法求出初始基可行解
% [X,b]=pMinimal(Cost,Supply,Demand);  %利用最小元素法求出初始基可行解
[X,b]=Vogal(Cost,Supply,Demand);  %利用Vogal求出初始基可行解


%下面检查初始基可行解的最优性并将分配矩阵进行更新
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
    disp('中间调运方案：');
    disp(X);
end
% 为避免某些产销不平衡问题的单位运费矩阵中出现inf和在计算总运费时出现NaN,作如下处理
for i=1:m
	for j=1:n
		if Cost(i,j)==inf
			Cost(i,j)=0;
		end
	end
end
%%%%TODO Put the Code for Problem  at below %%%%
%输出最终成本和调运方案
F = sum(sum(Cost .* X));
X=X(1:m0,1:n0);
end

%判断是否最优
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




