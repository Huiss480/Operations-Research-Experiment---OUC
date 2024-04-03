%����������Թ滮�ķ�֧���編�������������ʽ��ȫ�������Ի����������Թ滮����
%max c'x
%s.t.
%Ax<=b,Aeq x=beq.
%lb<=x<=ub.
%xΪ�����򲿷���������������
%���������MATLAB�Դ���linprog�������ÿ�ε��ɳ����⣬������ʽ��linprog��Ҫ����ͬ
%���ø�ʽ
%[xstar,fxstar,iter]=BranchBound(c,A,b)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq,lb,ub)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq,lb,ub,x0)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq,lb,ub,x0,I)
%[xstar,fxstar,iter]=BranchBound(c,A,b,Aeq,beq,lb,ub,x0,I,options)
%���У������:
%xstarΪ���Ž���������fxstarΪĿ�꺯����Сֵ��slackΪ�ɳ�(ʣ��)����
%�����cΪĿ�꺯����ֵϵ��������AΪ����ʽԼ��ϵ������bΪ����ʽԼ�������Ҷ���
%����;AeqΪ��ʽԼ������ϵ������beqΪ��ʽԼ�������Ҷ���
%lbΪ���߱����½���������ubΪ���߱����Ͻ�������
%x0Ϊ����ֵ(��ȱʡ);IΪ��������ָ����������1��ʾ������0��ʾʵ��
%options��������μ�optimset��linprog

function [xstar,fxstar,iter]=pBranchBound(c,A,b,Aeq,beq,lb,ub,x0,I,options)
global  z2 opt c1 x01 A1 b1 Aeq1 beq1 I options iter;
[m1,n1]=size(A);
[m2,n2]=size(Aeq);
iter=1;
if nargin<10
    options=optimset({});
    options.Display='off';
    options.LargeScale='on';
end
if nargin<9
    I=ones(size(c));
end
if nargin<8
    x0=[];
end
if nargin<7|isempty(ub)
    ub=inf*ones(size(c));
end
if nargin<6|isempty(lb)
    lb=zeros(size(c));
end
if nargin<5
    beq=[];
end
if nargin<4
    Aeq=[];
end
z2=inf;c1=c;x01=x0;A1=A;b1=b;Aeq1=Aeq;beq1=beq;I=I;
z1=BranchBound1(lb(:),ub(:));
xstar=opt;
[mm,nn]=size(xstar);
fxstar=-z2;
if mm>1
    disp('���Ž��ж����xstar����ÿ�ж�Ӧһ�����Ž⣩�Լ�����Ŀ�꺯��ֵfxstar������������iter��Ϊ��')
else
    disp('���Ž�xstar�Լ�����Ŀ�꺯��ֵfxstar����������(iterΪ)��')
end
%����Ϊ���������Ҫ���õ��Ӻ���
function z1=BranchBound1(vlb,vub)
global  z2 opt c1 x01 A1 b1 Aeq1 beq1 I options iter;
[x,z1,exitflag]=linprog(-c1,A1,b1,Aeq1,beq1,vlb,vub,x01,options);
if exitflag<=0
    return
end
if z1-z2>1e-3
    return
end

if max(abs(x.*I-round(x.*I)))<1e-3
    %%%%TODO Put the Code for Problem  at below %%%%
    %�Ƚ�����ֵ�Ĵ�С���жϸ�С������ֵ���ܳ��ֵķ�Χ
    if (z2 - z1)>1e-3
        opt=x';
        disp('----------------------------');
        disp('ǰz2:');
        disp(z2);
        disp('z1:');
        disp(z1);
        z2=z1;
        disp('��z2:');
        disp(z2);
        return
    else
        opt=[opt;x'];
        return
    end
end
notintx=find(abs(x-round(x))>1e-3);
intx=fix(x);%��xС������
tempvlb=vlb;tempvub=vub;

disp('++++++++++++++++++');
disp('vub��');
disp(vub);
disp('vlb��');
disp(vlb);
disp('notintx:');
disp(notintx);
%��֧���� ����
if vub(notintx(1,1),1)>=intx(notintx(1,1),1)+1
    tempvlb(notintx(1,1),1)=intx(notintx(1,1),1)+1;%��֧ ȡ��Сֵ���ֵķ�Χ
    %%%%TODO Put the Code for Problem  at below %%%%
    %�ݹ����BranchBound1��֧���
    z1=BranchBound1(tempvlb,vub);
    iter=iter+1;
end
if vlb(notintx(1,1),1)<=intx(notintx(1,1),1)
    tempvub(notintx(1,1),1)=intx(notintx(1,1),1);%��֧ ȡ��Сֵ���ֵķ�Χ
    %%%%TODO Put the Code for Problem  at below %%%%
    %�ݹ����BranchBound1��֧���
    z1=BranchBound1(vlb,tempvub);
    iter=iter+1;
    
end









����һ����ʹ�÷�֧���編��������滮����ʱ�����ѡ����ʵķ�֧���Ժͼ�֦���ԣ�������㷨��Ч�ʺ�׼ȷ�ԣ�

�����������֧������ָ��ν�ԭ����ֽ�Ϊ�����⣬��֦������ָ����ų������ܸ��ŵ������⡣һ����˵����֧���Ժͼ�֦���Ե�ѡ��ȡ����������ص��Ŀ�꺯�������ʡ��ڱ�ʵ���У����ǲ��������µķ�֧���Ժͼ�֦���ԣ�

��֧���ԣ�ѡ���һ���������������ֱ����Ͻ���½�����ȡ��������ȡ�����õ����������⡣2�������Ա�֤ÿ��������Ŀ�������ԭ����Ŀ�������Ӽ�����ÿ���������Ŀ�꺯��ֵ���ᳬ��ԭ�����Ŀ�꺯��ֵ��
��֦���ԣ������ÿ����������ɳ�����ʱ������õ���Ŀ�꺯��ֵ���ڻ���ڵ�ǰ������ֵ�����ߵõ��Ľⲻ���У�����û���ҵ��⣬�����ֱ�������������⣬���ٽ��з�֧���������Ա�����Ч����������С�����ռ䣬�ӿ������ٶȡ�
���������ʹ�������������ָ������ʱ����δ���ɱ������еķ�����Ԫ�أ��Ա�֤�㷨����ȷ�Ժ��ȶ��ԣ�

����������ɱ������еķ�����Ԫ�أ��� NaN������ֵ���� Inf�����������ʾĳЩ������ĳЩ������֮��ķ����ǲ����ܵĻ򲻺���ġ��ڱ�ʵ���У����ǲ��������µĴ�������

���ɱ������е����з�����Ԫ���滻Ϊ������ Inf��3�������Ա�֤�ڽ��о���������͵���ʱ������Ӱ������Ԫ�ص�ֵ��Ҳ���ᱻѡΪ��Сֵ�����ŷ���ĺ�ѡֵ��
�ڹ�������������ʱ�����Գɱ������е�������Ԫ�أ�ֻ�������޵�����Ԫ�ء��������Ա�֤�õ���������䷽���ǿ��еģ��Ҳ����������ܵĻ򲻺���ķ��䡣


