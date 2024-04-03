% ���Թ滮�������ȷ���
% �ó���Ҫ�ۼ�ֵϵ�� c�仯ʱ�Ƿ�Ӱ��ԭ��������Ž⣬�����Ž�ı䣬
% ������µ����Ž�
% ���Թ滮��Ҫ���ɱ�׼��ʽ����ʹ�ã���
% max c'x
% s.t.
% Ax=b
% x>=0
% ����A\in R^{m\times n},c,x'\in R^n,b\in R^m, b\geq 0
% ���ۼ�ֵϵ���ı仯ʱ��Ե���δ��Ϊ��׼��ʽǰ��ԭ�����ļ�ֵϵ����
% �������ɳڱ�����ʣ������ļ�ֵϵ����ȫ��Ϊ�㣩
%  By Gongnong Li 2013
function[UOfDeltac,LOfDeltac]=SensitivityOfc(A,b,c)
% ���ȵ���SenSimplex.m ��������Թ滮���⣬���õ�����������Ϣ
[m,n]=size(A);
[IB,IN,SA,IBB,INN,InverseOfB,A0,sigma]=SenSimplex(A,b,c)
% IB��¼���ǻ������±꣬IN��¼���Ƿǻ������±꣬SA��¼�����ɳڱ����±�
% IBB��¼���ǳ�ȥ�ɳڱ�����Ļ������±꣬INN��¼�ĳ�ȥ�ɳڱ�����ķǻ������±�
disp('������ʾ����ԭ��������Ž�(xstar)������ֵ(fxstar)����������(iter)�����Ż��±�(IB)����Ϣ��')
for r=1:length(IN)
    UOfDeltac(IN(r))=-sigma(IN(r));LOfDeltac(IN(r))=-inf;
end
%�������۵��Ƿǻ������ļ�ֵϵ���仯(Deltac)���ϡ�����
%�������۵��ǻ�������ֵϵ���仯���ϡ�����
for r=1:length(IB)
    t1=find(A0(r,IN+1)<0);t2=find(A0(r,IN+1)>0);
    if length(t2)~=0
        for i=1:length(t2)
            b1(i)=sigma(IN(t2(i)))/A0(r,IN(t2(i))+1);
        end
        [LOfDeltac(IB(r)),U1]=max(b1);
    else
        LOfDeltac(IB(r))=-inf;
    end
    if length(t1)~=0
        for i=1:length(t1)
            b2(i)=sigma(IN(t1(i)))/A0(r,IN(t1(i))+1);
        end
        [UOfDeltac(IB(r)),U2]=min(b2);
    else
        UOfDeltac(IB(r))=inf;
    end
end
n0=input('����ԭʼ�����ĸ���');
for i=1:n0
    disp(['c' num2str(i) '�ĵ�ǰֵΪ' num2str(c(i)) ', �仯��ΧΪ[' ...
        num2str(c(i)+LOfDeltac(i)) ',' num2str(c(i)+UOfDeltac(i)) ']' ])
end
Deltac=input('���������������ֵϵ���ı仯��һ��ֻ����һ��c�仯�������Ӧ����Deltac��')
D=find(Deltac~=0);ctemp2=c+Deltac;
if(Deltac(D)>=LOfDeltac(D))&(Deltac(D)<=UOfDeltac(D))
    disp('���Ż�(IB)���䣬���Ž�(xstar)Ҳ���䣬����ֵ(fxstar)��Ϊ��')
    IB,xstar(IB)=A0(:,1)',fxstar=xstar(IB)*ctemp2(IB)
else
    disp('���Ż��ı䡣���Ż������±�(IB)�����Ž�(xstar)������ֵ(fxstar)��Ϊ��')
    c(D)=c(D)+Deltac(D);
    [IB,IN,SA,IBB,INN,InverseOfB,A0]=SenSimplex(A0(:,2:n+1),A0(:,1),c)
end
    
    
    
    
    