# StoryTllrC64 language specifications

Script language works on simple elements: **room** (locations) **obj** (elements you can interact with) and **verb** (commands you can use to play) - plus you can use bit variables (true / false) or numeric variables (0/255). room and obj have a set of properties you can check and set

There are a limited set of instructions and a limited set of metakeywords - using them (and if you want a simple two level class derivation) it's relatively easy to create a game

## Instructions

Current allowed instructions are 

### generic

  quit
  
  start
  
  load
  
  save

### about variables

  setvar
  
  addvar
  
  set
  
  unset
  
### about ui

  clear
  
  getkey
  
  waitkey
  
  msg
  
  list
  
  showobj
  
  setroomimage
  
  setroomoverlayimage
  
### about obj / room  

  goto
  
  put
  
  setattr
  
  unsetattr
  
  setobjname  
  
  setroomname
  
### about conditions  
  
  withobj  
  
  endwith
  
  if
  
  ifis
  
  ifisin
  
  ifisroom
  
  ifkey
  
  ifnot
  
  ifobjinattr
  
  ifvar  

  else
  
  endif
  

