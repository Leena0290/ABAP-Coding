// Code to find the highest value in an array/ from a list of items.

DATA : itab TYPE SORTED TABLE OF i WITH NON-UNIQUE KEY table_line .		
		
itab = VALUE #( ( 9 ) ( 4 )  ( 10 ) ( 12 )  ( 5 ) ( 1 ) ).		
"Sorted table = 1,4,5,9,10,12		
		
DESCRIBE TABLE itab LINES DATA(counts).	"The count should be 6"	
		
READ TABLE itab ASSIGNING FIELD-SYMBOL(<itab>) INDEX counts.		
IF sy-subrc = 0 .		
WRITE : ' The highest value in array/internal table:', <itab>. " 12		
ENDIF.	
	
// Output:		
The highest value in array/internal table: 12	
