sj = SlurmJob();
%%sc.debug = 1;
%sj.arrayMax = 2;
sj.add("time", "01:00:00");
sj.handle = @exampleFunction;
%sj.data = [{'one'}, {'two'}, {'three'}, {'three'}, {'three'}, {'three'}, {'three'}];
sj.data = {'one', 'two','three', 'three', 'three', 'three', 'three'};
sj.data = [1, 2, 3, 4, 5];


sj.keepWorkDir=true;

sj.submit();
sj.wait();

function output_=exampleFunction(input_)
    pause(randi([1,100],1));
    disp(input_)
    output_=input_;
end
