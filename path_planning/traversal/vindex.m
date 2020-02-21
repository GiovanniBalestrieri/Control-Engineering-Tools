function index = vindex(vec, value)
  index = -1;
  for i=1:size(vec,2)
    if isequal(vec{i},value)
       index = i;
    endif
  endfor
endfunction