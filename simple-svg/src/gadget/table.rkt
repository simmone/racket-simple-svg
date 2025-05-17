#lang racket

(require "../function.rkt")

(provide (contract-out
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
          [get-cells (-> (listof list?) (values (listof (cons/c natural? natural?)) list?))]
          [struct CELL
                  (
                   (start_point (cons/c number? number?))
                   (width number?)
                   (height number?)
                   (color string?)
                   (text string?)
                   (font_size number?)
                   (font_color string?)
                   (margin_top number?)
                   (margin_left number?)
                   )
                  ]
          [matrix-to-cells (-> (listof list?) number? number? string? number? number? number? string? (listof CELL?))]
          [set-table-col-width! (-> (listof natural?) number? any)]
          [set-table-row-height! (-> (listof natural?) number? any)]
          [set-table-col-margin-left! (-> (listof natural?) number? any)]
          [set-table-row-margin-top! (-> (listof natural?) number? any)]
          [set-table-cell-font-size! (-> (listof (cons/c natural? natural?)) number? any)]
          [set-table-cell-font-color! (-> (listof (cons/c natural? natural?)) string? any)]
          [*ROW_HEIGHT_MAP* (parameter/c hash?)]
          [*COL_WIDTH_MAP* (parameter/c hash?)]
          [*ROW_MARGIN_TOP_MAP* (parameter/c hash?)]
          [*COL_MARGIN_LEFT_MAP* (parameter/c hash?)]
          [*CELL_FONT_SIZE_MAP* (parameter/c hash?)]
          [*CELL_FONT_COLOR_MAP* (parameter/c hash?)]
          ))

(struct CELL (
              [start_point #:mutable]
              [width #:mutable]
              [height #:mutable]
              [color #:mutable]
              [text #:mutable]
              [font_size #:mutable]
              [font_color #:mutable]
              [margin_top #:mutable]
              [margin_left #:mutable]
              )
        #:transparent
        )

(define (get-cells matrix)
  (let ([row_count (length matrix)]
        [col_count (apply max (map (lambda (item) (length item)) matrix))])
    (let loop-row ([loop_row 0]
                   [rows matrix]
                   [axis_list '()]
                   [data_list '()])
      (if (not (null? rows))
          (let-values ([(col_axis_list col_data_list)
                        (let loop-col ([loop_col 0]
                                       [cols (car rows)]
                                       [col_data_list '()]
                                       [col_axis_list '()])
                          (if (< loop_col col_count)
                              (loop-col
                               (add1 loop_col)
                               (if (null? cols) cols (cdr cols))
                               (cons (if (null? cols) "" (car cols)) col_data_list)
                               (cons (cons loop_row loop_col) col_axis_list))
                              (values (reverse col_axis_list) (reverse col_data_list))))])

            (loop-row (add1 loop_row)
                      (cdr rows)
                      `(,@axis_list ,@col_axis_list)
                      `(,@data_list ,@col_data_list)))
          (values axis_list data_list)))))

(define *ROW_HEIGHT_MAP* (make-parameter #f))
(define *COL_WIDTH_MAP* (make-parameter #f))
(define *COL_MARGIN_LEFT_MAP* (make-parameter #f))
(define *ROW_MARGIN_TOP_MAP* (make-parameter #f))
(define *CELL_FONT_SIZE_MAP* (make-parameter #f))
(define *CELL_FONT_COLOR_MAP* (make-parameter #f))

(define (matrix-to-cells matrix col_width row_height color cell_margin_top cell_margin_left font_size font_color)
  (let-values ([(axis_list data_list) (get-cells matrix)])
    (let loop ([axises axis_list]
               [datas data_list]
               [loop_point '(0 . 0)]
               [result_list '()])
      (if (not (null? axises))
          (let* ([row_index (caar axises)]
                 [col_index (cdar axises)]
                 [row (list-ref matrix row_index)]
                 [col_real_width
                  (if (hash-has-key? (*COL_WIDTH_MAP*) col_index)
                      (hash-ref (*COL_WIDTH_MAP*) col_index)
                      col_width)]
                 [row_real_height
                  (if (hash-has-key? (*ROW_HEIGHT_MAP*) row_index)
                      (hash-ref (*ROW_HEIGHT_MAP*) row_index)
                      row_height)]
                 [cell_real_margin_top
                  (if (hash-has-key? (*ROW_MARGIN_TOP_MAP*) row_index)
                      (hash-ref (*ROW_MARGIN_TOP_MAP*) row_index)
                      cell_margin_top)]
                 [cell_real_margin_left
                  (if (hash-has-key? (*COL_MARGIN_LEFT_MAP*) col_index)
                      (hash-ref (*COL_MARGIN_LEFT_MAP*) col_index)
                      cell_margin_left)]
                 [cell_real_font_size
                  (if (hash-has-key? (*CELL_FONT_SIZE_MAP*) (car axises))
                      (hash-ref (*CELL_FONT_SIZE_MAP*) (car axises))
                      font_size)]
                 [cell_real_font_color
                  (if (hash-has-key? (*CELL_FONT_COLOR_MAP*) (car axises))
                      (hash-ref (*CELL_FONT_COLOR_MAP*) (car axises))
                      font_color)]
                 [text (if (>= col_index (length row)) "" (list-ref row col_index))]
                 )
            (loop
             (cdr axises)
             (cdr datas)
             (if (not (null? (cdr axises)))
                 (if (= row_index (caadr axises))
                     (cons
                      (+ (car loop_point) col_real_width)
                      (cdr loop_point))
                     (cons
                      0
                      (+ (cdr loop_point) row_real_height)))
                 null)
             (cons
              (CELL
               loop_point
               col_real_width
               row_real_height
               color
               text
               cell_real_font_size
               cell_real_font_color
               cell_real_margin_top
               cell_real_margin_left)
              result_list)))
          (reverse result_list)))))

(define (set-table-col-width! cols width)
  (map (lambda (col) (hash-set! (*COL_WIDTH_MAP*) col width)) cols))

(define (set-table-row-height! rows height)
  (map (lambda (row) (hash-set! (*ROW_HEIGHT_MAP*) row height)) rows))

(define (set-table-col-margin-left! cols margin)
  (map (lambda (col) (hash-set! (*COL_MARGIN_LEFT_MAP*) col margin)) cols))

(define (set-table-row-margin-top! rows margin)
  (map (lambda (row) (hash-set! (*ROW_MARGIN_TOP_MAP*) row margin)) rows))

(define (set-table-cell-font-size! cells font_size)
  (map (lambda (cell) (hash-set! (*CELL_FONT_SIZE_MAP*) cell font_size)) cells))

(define (set-table-cell-font-color! cells font_color)
  (map (lambda (cell) (hash-set! (*CELL_FONT_COLOR_MAP*) cell font_color)) cells))

(define (svg-gadget-table matrix
                          #:col_width [col_width 50]
                          #:row_height [row_height 30]
                          #:color [color "black"]
                          #:cell_margin_top [cell_margin_top 22]
                          #:cell_margin_left [cell_margin_left 20]
                          #:font_size [font_size 20]
                          #:font_color [font_color "black"]
                          user_proc
                          )
  (svg-def-group
   (lambda ()
     (parameterize
         ([*ROW_HEIGHT_MAP* (make-hash)]
          [*COL_WIDTH_MAP* (make-hash)]
          [*ROW_MARGIN_TOP_MAP* (make-hash)]
          [*COL_MARGIN_LEFT_MAP* (make-hash)]
          [*CELL_FONT_SIZE_MAP* (make-hash)]
          [*CELL_FONT_COLOR_MAP* (make-hash)])

       (user_proc)
       
       (let loop ([cells (matrix-to-cells matrix col_width row_height color cell_margin_top cell_margin_left font_size font_color)])
         (when (not (null? cells))
           (let* ([cell (car cells)]
                  [rect_id (svg-def-shape (new-rect (CELL-width cell) (CELL-height cell)))]
                  [text_id (svg-def-shape (new-text (~a (CELL-text cell)) #:font-size (CELL-font_size cell)))]
                  [font_sstyle (sstyle-new)]
                  [cell_sstyle (sstyle-new)])

             (set-SSTYLE-stroke! cell_sstyle (CELL-color cell))
             (svg-place-widget rect_id #:style cell_sstyle #:at (CELL-start_point cell))

             (set-SSTYLE-fill! font_sstyle (CELL-font_color cell))
             (set-SSTYLE-stroke! font_sstyle (CELL-font_color cell))
             (svg-place-widget text_id
                               #:style font_sstyle
                               #:at
                               (cons
                                (+ (CELL-margin_left cell) (car (CELL-start_point cell)))
                                (+ (CELL-margin_top cell) (cdr (CELL-start_point cell))))))
             (loop (cdr cells))))
         ))))
