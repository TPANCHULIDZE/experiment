# README

# installation
  rails db:create db:migrate 

# run application
  rails s

# plate size
  first input option is plate size: **96 or 384**

# samples array 
  Second input field is samples array, which have a format like this ```[["sample-1", "sample-2"], ["sample-3"]]```
  Please noticed that input format have to be use "" not '', like this ```[["sample-1"]]``` not like this ```[['sample-1']]```

# reagentes array
  Third input field is reagents array, which have a format like this ```[["blue"], ["red", "green"]]```, please input colors name for better visualization
  Please noticed that input format have to be use **""** not **''**, like this ```[["blue"]]``` not like this ```[['blue']]```
  Also a size of reagents have to be equal size of samples

# replicates array
  Fourth input field is replicates array, which contain **Integers** like this ```[1, 3]```
  A size of replicates array have to be equal size of samples 