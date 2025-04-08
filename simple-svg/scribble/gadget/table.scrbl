#lang scribble/manual

@title{Table}

Give a two-dimensional list, generate a table.

@codeblock|{
[svg-gadget-table (->* (
                        (listof (listof string?))
                        procedure?
                        )
                       (
                        #:col_width number?
                        #:row_height number?
                        #:color string?
                        #:cell_margin_top number?
                        #:cell_margin_left number?
                        #:font_size number?
                        #:font_color string?
                        )
                       string?)]
}|

Give a two-dimensional list as rows and cols to generate a table.

Example: (svg-gadget-table '((1 2) (3 4))), generate a 2 rows and 2 cols table.

@codeblock|{
(svg-out
 250 200
 (lambda ()
   (let ([table_id (svg-gadget-table
                    '(("1" "2" "3") ("4" "5" "6") ("7" "8" "9"))
                    #:at '(50 . 50)
                    (lambda () (void)))])

     (svg-place-widget table_id))))
}|

@image{showcase/gadget/table/table1.svg}

You can use set-table-col-width, set-table-row-height, set-table-col-margin-left, set-table-row-margin-top to justify the table and content.

Below example set second column width and margin left, second row height and margin top.

@codeblock|{
(svg-out
 250 200
 (lambda ()
   (let ([table_id (svg-gadget-table
                    '(("1" "2" "3") ("4" "5" "6") ("7" "8" "9"))
                    #:at '(50 . 50)
                    (lambda ()
                      (set-table-col-width! '(1) 80)
                      (set-table-row-height! '(1) 50)
                      (set-table-col-margin-left! '(1) 35)
                      (set-table-row-margin-top! '(1) 30)
                      ))])

     (svg-place-widget table_id))))
}|

@image{showcase/gadget/table/table2.svg}

You can set table font size and color.

@codeblock|{
(svg-out
 400 300
 (lambda ()
   (let ([table_id (svg-gadget-table
                    '(("1" "2" "3") ("4" "5" "6") ("7" "8" "9"))
                    #:col_width 100
                    #:row_height 60
                    #:color "green"
                    #:font_color "blue"
                    #:cell_margin_top 44
                    #:cell_margin_left 40
                    #:at '(50 . 50)
                    (lambda ()
                      (set-table-cell-font-size! '((0 . 0) (1 . 1) (2 . 2)) 40)
                      (set-table-cell-font-color! '((0 . 0) (1 . 1) (2 . 2)) "red")
                      ))])

     (svg-place-widget table_id))))
}|


@image{showcase/gadget/table/table3.svg}