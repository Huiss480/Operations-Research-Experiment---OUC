%Simplex Method  ���õ����η���MATLAB����
function [xstar,fxstar,iter]=pStandSimplex(A,b,c)
%����f�Ǽ����������飬1*nά
%����A��Լ������ m*nά
%����b��Լ�������� 1*mά
%���x�ǽ�����
%���y�����Ž�
%�ж�����ά���Ƿ����
%����ʼ�����α�
% ��Ҫ�Լ���̹ؼ����봦��%%%% Put the Code for Problem  at below %%%%
xstar=0;fxstar=0;iter=0;
format rat %������Է�����ʾ

% M ��ؾ�������Թ滮����
[m, n] = size(A);
% ��ÿ��Լ�����б�׼����
for i = 1:m
    if b(i) < 0
        A(i, :) = -A(i, :);
        b(i) = -b(i);
    end
end
% �ھ�������ӶԽ��ߣ�ʹԼ��������Ϊ��ʽ
SP = [A eye(m) b; c'  zeros(1, m) 0];
disp('��׼������');
%disp(SP);

%���� b c������������,b������������,c��������
[c1, c2]=size(c);
if c2==1
   f=c';
else
    f=c;
end
[b1, b2]=size(b);
if b1==1
   b=b';
end

%S=[f 0;A b]; ���ĺ�����������һ��
S=[A b;f 0]; 
%[Sm, Sn]=size(S);
%��ʾ��ʼ�����α�
disp('��ʾ��ʼ�����α�:')
disp(S)
[n,m]=size(S)
%�жϼ����� r<=0
r=find(f>0);
disp('�Ǹ�������������:');
disp(r);
len=length(r);
%�д���0�ļ����������ѭ��
lk=0;
while(len)
    %���Ǹ�����������������Ԫ���Ƿ�С�ڵ���0
    for k=1:length(r)
        d=find(S(:,r(k))>0);
        %disp('�Ǹ�����������������Ԫ�ش�����:');
        %disp(d);
        if(length(d)+1==2)
        error('�����Ž⣡����')  
        %break;
        end
    end
    %�ҵ������������ֵ Rk����Ӧ�ļ����� ���ֵ������j���ҵ��������
    [Rk,j]=max(S(n,1:m-1)); %[Rk,j]=max(S(1,1:m-1));
    
    %%%%TODO Put the Code for Problem  at below %%%%
    %%%%TODO Put the Code for Problem  at below %%%%
    %�󵥴��Ա�����һ�У�thetaֵ�У����Ҷ˳�����b���������������j�ı�ֵ
    rb=������
    %rb�ǵ����Ա�����һ��thetaֵ�У��ҵ���ֵ��С�ģ��ѱ�ֵ�еĸ����������� 
    for p=1:length(rb)
        if(rb(p)<0) 
            rb(p)=Inf;
        end
    end
    %��ʾthetaֵ�еı仯
    disp('��ʾthetaֵ�еı仯');
    disp(rb);
    
    [h,i]=min(rb);%��������ֵ��Сֵ 
    % iΪ��תԪ�����к�(��S��)��jΪ��תԪ�����к� 
    disp('i=');i %�����������һ��
   
    %���л�������,��תԪԪ����1����תԪ�����еĵı仯
    S(i,:)=S(i,:)./S(i,j);
    
    %%%%TODO Put the Code for Problem  at below %%%%
    %%%%TODO Put the Code for Problem  at below %%%%
    %��תԪ����������Ԫ�ض���0���������еĵı仯
    for k=1:n
        if(k~=i)
            %%%% Put the Code for Problem  at below %%%%
            S(k,:)=%������
        end   
    end
    %�жϼ����� r<=0
    r=find(S(n,1:m-1)>0);%r=find(S(1,1:m-1)>0);
    len=length(r);
    lk=lk+1;
    %չʾ�����α�ı仯
    disp(S);
end
    %������ȫ���������ҵ����Ž�
    %�ǻ�������0
    x=zeros(1,m-1);
    for i=1:m-1
        %�ҵ�������
        j=find(S(:,i)==1);%ÿ����1�ĸ���
        k=find(S(:,i)==0);%ÿ����0�ĸ���
        if((length(j)+1==2)&&(length(k)+1==n))
            %iΪ����Ԫ�кţ�j���к� ������ֵ
            x(i)=S(j,m);
        end
    end
     %���ĵ����α�
    y=S(n,m)%���Ž�y=S(1,m)
    S
    %m
    xstar=x;
    fxstar=-y;
    iter=lk;
end
