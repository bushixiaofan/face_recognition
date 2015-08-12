function diginto(thestruct, level)

if nargin < 2
    level = 0;
end

fn = fieldnames(thestruct);
for n = 1:length(fn)
    tabs = '';
    for m = 1:level
        tabs = [tabs '    '];
    end
    rr  = fn{n};
    fn2 = getfield(thestruct,fn{n});
    if ~isstruct(fn2)
        disp([tabs fn2]);
    end
    if isstruct(fn2)
        diginto(fn2, level+1);
    else
        if iscell(fn2)&&isstruct(fn2{1}) %Modified: In case of a struct array.
            for h=1:length(fn2)
                diginto(fn2{h},level+1);
            end
        end
    end
end