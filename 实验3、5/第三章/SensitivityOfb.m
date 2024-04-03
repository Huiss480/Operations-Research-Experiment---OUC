% ���Թ滮�������ȷ���
% �ó���������Դ����b�б仯ʱ(��øı�Deltab)�Ƿ�Ӱ�����Թ滮�����Ž�
% �����Ž�ı䣬������µ����Ž�
% ���Թ滮��Ҫ���ɱ�׼��ʽ����ʹ�ã���
% max c'x
% s.t.
% Ax=b
% x>=0
% ����A\in R^{m\times n},c,x'\in R^n,b\in R^m, b\geq 0
% ���ۼ�ֵϵ���ı仯ʱ��Ե���δ��Ϊ��׼��ʽǰ��ԭ�����ļ�ֵϵ����
% �������ɳڱ�����ʣ������ļ�ֵϵ����ȫ��Ϊ�㣩
%  By Gongnong Li 2013
function[UOfDeltab,LOfDeltab]=SensitivityOfb(A,b,c)
% ���ȵ���SenSimplex.m ��������Թ滮���⣬���õ�����������Ϣ
[m,n]=size(A);
[IB,IN,SA,IBB,INN,InverseOfB,A0,sigma]=SenSimplex(A,b,c)
% IB��¼���ǻ������±�
% IBB��¼���ǳ�ȥ�ɳڱ�����Ļ������±꣬INN��¼�ĳ�ȥ�ɳڱ�����ķǻ������±�
disp('������ʾ����ԭ��������Ž�(xstar)������ֵ(fxstar)����������(iter)�����Ż��±�(IB)����Ϣ��')
for r=1:m
    t1=find(InverseOfB(:,r)<0);t2=find(InverseOfB(:,r)>0);
    if length(t1)~=0
        for i=1:length(t1)
            b1(i)=-A0(t1(i),1)/InverseOfB(t1(i),r);
        end
        [UOfDeltab(r),U1]=min(b1);
    else
        UOfDeltab(r)=inf;
    end
    if length(t2)~=0
        for i=1:length(t2)
            b2(i)=-A0(t2(i),1)/InverseOfB(t2(i),r);
        end
        [LOfDeltab(r),U2]=max(b2);
    else
        LOfDeltab(r)=-inf;
    end
end
for i=1:length(b)
    disp(['b' num2str(i) '�ĵ�ǰֵΪ' num2str(b(i)) ', �仯��ΧΪ[' ...
        num2str(b(i)+LOfDeltab(i)) ',' num2str(b(i)+UOfDeltab(i)) ']' ])
end
Deltab=input('����������������Դϵ���ı仯��һ��ֻ����һ��b�仯�������Ӧ����Deltab��')
D=find(Deltab~=0);
if(Deltab(D)>=LOfDeltab(D))&(Deltab(D)<=UOfDeltab(D))
    disp('���Ż�(IB)���䣬���Ž�(xstar)Ҳ���䣬����ֵ(fxstar)��Ϊ��')
    A0(:,1)=A0(:,1)+InverseOfB*Deltab;
    IB,xstar(IB)=A0(:,1)',fxstar=xstar(IB)*c(IB)
else
    disp('���Ż��ı䡣���Ż������±�(IB)�����Ž�(xstar)������ֵ(fxstar)��Ϊ��')
    A0(:,1)=A0(:,1)+InverseOfB*Deltab;
    DD=find(A0(:,1)<0);
    if length(DD)~=0
        [xstar,fxstar,A0,IB,iter]=Dsimplex(A0(:,2:n+1),A0(:,1),c)
    else
        [IB,IN,SA,IBB,INN,InverseOfB,A0,sigma]=SenSimplex(A0(:,2:n+1),A0(:,1),c)
    end
end







