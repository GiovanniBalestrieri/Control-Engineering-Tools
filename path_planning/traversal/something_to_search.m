function val = something_to_search(list)
  val = 0;
  for i=1:size(list,2)
    if ~isempty(list{i})
      val = 1;
     break 
    endif
  endfor
endfunction