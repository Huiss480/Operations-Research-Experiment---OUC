%�ó����ǵ������䷽���ıջ�·�������ݸ������������,ȷ���˳�������������䷽�����и��¡�
%������
%X:��ǰ������䷽��(m*n����);b:��������־����,��1��Ӧ���ָ�,0��Ӧ�ո�(m*n����);
%row,co1:������б���бꡣ
%�����
%Y:���º��������䷽��(m*n����);bout:���º���»�����(m*n����,�������ʽͬb)��
% ��������
function [Y,bout]=Loop(X,row,col,b)
bout=b;
Y=X;
[m,n]=size(X);
loop=[row,col];
X(row,col)=Inf;
b(row,col)=Inf;
rowsearch=1; %��ʼ���бջ�·��������

while(loop(1,1)~=row || loop(1,2)~=col || length(loop)==2)
if rowsearch%��ʼ�ջ�·����������
    j=1;
    while rowsearch
        if(b(loop(1,1),j)~=0)&&(j~=loop(1,2))
            loop=[loop(1,1) j;loop];%���빹�ɱջ�·��ָ�ꡣ
            rowsearch=0;%��ʼ�ջ�·����������
        elseif j==n,
            b(loop(1,1),loop(1,2))=0;
            loop=loop(2:length(loop),:);%���ݡ�
            rowsearch=0;
        else
            j=j+1;
        end
    end
else %������(Ҳ���ܴ��п�ʼ����)��
    i=1;
    while ~rowsearch
        if(b(i,loop(1,2))~=0)&&(i~=loop(1,1))
            loop=[i loop(1,2);loop];
            rowsearch=1;
        elseif i==m
            b(loop(1,1), loop(1,2))=0;
            loop=loop(2:length(loop),:);
            rowsearch=1;
        else
            i=i+1;
        end
    end
end
end
l=length(loop); %����������������
%disp(l)
theta=Inf;
minindex=Inf;
for i=2:2:l
    if X(loop(i,1),loop(i,2))<theta
        theta=X(loop(i,1),loop(i,2));
        minindex=i;
    end;
end

%disp('Before disp(Y)��');
%disp(Y);
Y(row,col)=theta;%�������µ�������䷽�������󣩡�
for i=2:l-1
    Y(loop(i,1),loop(i,2))=Y(loop(i,1),loop(i,2))+(-1)^(i-1)*theta;
end
bout(row,col)=1;
%disp('After disp(Y)��');
%disp(Y);
bout(loop(minindex,1),loop(minindex,2))=0;
