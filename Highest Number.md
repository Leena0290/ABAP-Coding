# Code for finding the highest value in an array/ from list of items.

DATA : itab TYPE SORTED TABLE OF i WITH NON-UNIQUE KEY table_line .		
		
itab = VALUE #( ( 9 ) ( 4 )  ( 10 ) ( 12 )  ( 5 ) ( 1 ) ).		
" To get highest no. from internal table
ex. itab = 9,4,10,12,5,1 then count = 6"		
		
DESCRIBE TABLE itab LINES DATA(counts).		
		
READ TABLE itab ASSIGNING FIELD-SYMBOL(<itab>) INDEX counts.		
IF sy-subrc = 0 .		
WRITE : ' Highest value in array/internal table:', <itab>. " 12		
ENDIF.		
		
		
output:		
highest value in array/internal table:         12		
