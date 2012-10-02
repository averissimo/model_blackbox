function in = isoctave ()
  persistent inout;

  if isempty(inout),
    inout = exist('OCTAVE_VERSION','builtin') ~= 0;
  end;
  in = inout;
return; 
