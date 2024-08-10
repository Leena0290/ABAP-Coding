<a name="top"></a>

# Examples
 - [Duplicates](#duplicates)
 - [Highest Number](#highest-number)
 - [Length of Last Word](https://github.com/Leena0290/ABAP-Coding/blob/main/string.abap)
 
## Duplicates
## Find duplicate values and count them in an array or internal table 

``` abap
DATA: itab    TYPE SORTED TABLE OF i WITH NON-UNIQUE KEY table_line,
      old_val TYPE i.

"Sorted table {1,4,4,5,9,10,12,12,12 }
itab = VALUE #( ( 9 ) ( 4 )  ( 10 ) ( 12 )  ( 5 ) ( 1 ) ( 12 ) ( 12 ) ( 4 ) ).

LOOP AT itab ASSIGNING FIELD-SYMBOL(<itab_wa>).
  " Switch every time to count duplicates
  AT NEW table_line.
    IF <itab_wa> <> old_val.
      DATA(count) = 1.
    ENDIF.
  ENDAT.

  IF <itab_wa> = old_val.
    count = count + 1.
  ENDIF.

  " Collect the Counts of duplicates
  AT END OF table_line.
    IF <itab_wa> = old_val.
      NEW-LINE.
      WRITE : 'Duplicate value', <itab_wa>, 'Count:',count .
    ENDIF.
  ENDAT.
  old_val = <itab_wa>.
ENDLOOP.
``` 

## Highest Number
## Code to find the highest value in an array/ from a list of items.
``` abap
DATA : itab TYPE SORTED TABLE OF i WITH NON-UNIQUE KEY table_line .		
		
itab = VALUE #( ( 9 ) ( 4 )  ( 10 ) ( 12 )  ( 5 ) ( 1 ) ).		
"Sorted table = 1,4,5,9,10,12		
		
DESCRIBE TABLE itab LINES DATA(counts).	"The count should be 6"	
		
READ TABLE itab ASSIGNING FIELD-SYMBOL(<itab>) INDEX counts.		
IF sy-subrc = 0 .		
WRITE : ' The highest value in array/internal table:', <itab>. " 12		
ENDIF.	
	
Output:		
The highest value in array/internal table: 12		
``` 

<p align="right"><a href="#top">⬆️ back to top</a></p>
