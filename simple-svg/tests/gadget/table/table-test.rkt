#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib/lib.rkt"
         "../../../src/function.rkt"
         "../../../src/gadget/table.rkt"
         racket/runtime-path)

(define test-all
  (test-suite
   "test-table"

   (test-case
    "test-get-cells"

    (let-values ([(seqs vals) (get-cells '(("1" "2") ("3")))])
      (check-equal? (length seqs) 4)
      (check-equal? (length vals) 4)
      (check-equal? seqs '((0 . 0) (0 . 1) (1 . 0) (1 . 1)))
      (check-equal? vals '("1" "2" "3" ""))
      )

    (let-values ([(seqs vals) (get-cells '(("1" "2" "3")))])
      (check-equal? (length seqs) 3)
      (check-equal? (length vals) 3)
      (check-equal? seqs '((0 . 0) (0 . 1) (0 . 2)))
      (check-equal? vals '("1" "2" "3"))
      )

    (let-values ([(seqs vals) (get-cells '(("1") ("2") ("3")))])
      (check-equal? (length seqs) 3)
      (check-equal? (length vals) 3)
      (check-equal? seqs '((0 . 0) (1 . 0) (2 . 0)))
      (check-equal? vals '("1" "2" "3"))
      )
    )
   
   (test-case
    "test-matrix-to-cells"

    (parameterize
        ([*ROW_HEIGHT_MAP* (make-hash)]
         [*COL_WIDTH_MAP* (make-hash)]
         [*ROW_MARGIN_TOP_MAP* (make-hash)]
         [*COL_MARGIN_LEFT_MAP* (make-hash)]
         [*CELL_FONT_SIZE_MAP* (make-hash)]
         [*CELL_FONT_COLOR_MAP* (make-hash)])
      
      (let ([cells
             (matrix-to-cells
              '(("1" "2") ("3" "4")) 5 5 "black" 1 1 '(0 . 0) 10 "red")])
        (check-equal? (length cells) 4)
        (check-equal? cells
                      (list
                       (CELL '(0 . 0) '(0 . 0) 5 5 "black" "1" 10 "red" 1 1)
                       (CELL '(0 . 1) '(5 . 0) 5 5 "black" "2" 10 "red" 1 1)
                       (CELL '(1 . 0) '(0 . 5) 5 5 "black" "3" 10 "red" 1 1)
                       (CELL '(1 . 1) '(5 . 5) 5 5 "black" "4" 10 "red" 1 1)
                       ))))

    (parameterize
        ([*ROW_HEIGHT_MAP* (make-hash)]
         [*COL_WIDTH_MAP* (make-hash)]
         [*ROW_MARGIN_TOP_MAP* (make-hash)]
         [*COL_MARGIN_LEFT_MAP* (make-hash)]
         [*CELL_FONT_SIZE_MAP* (make-hash)]
         [*CELL_FONT_COLOR_MAP* (make-hash)])

      (let ([cells
             (matrix-to-cells
              '(("1" "2" "3") ("4" "5") ("6" "7" "8" "9")) 4 5 "black" 1 2 '(1 . 2) 10 "red")])
        (check-equal? (length cells) 12)
        (check-equal? cells
                      (list
                       (CELL '(0 . 0) '(1 . 2) 4 5 "black" "1" 10 "red" 1 2)
                       (CELL '(0 . 1) '(5 . 2) 4 5 "black" "2" 10 "red" 1 2)
                       (CELL '(0 . 2) '(9 . 2) 4 5 "black" "3" 10 "red" 1 2)
                       (CELL '(0 . 3) '(13 . 2) 4 5 "black" "" 10 "red" 1 2)
                       (CELL '(1 . 0) '(1 . 7) 4 5 "black" "4" 10 "red" 1 2)
                       (CELL '(1 . 1) '(5 . 7) 4 5 "black" "5" 10 "red" 1 2)
                       (CELL '(1 . 2) '(9 . 7) 4 5 "black" "" 10 "red" 1 2)
                       (CELL '(1 . 3) '(13 . 7) 4 5 "black" "" 10 "red" 1 2)
                       (CELL '(2 . 0) '(1 . 12) 4 5 "black" "6" 10 "red" 1 2)
                       (CELL '(2 . 1) '(5 . 12) 4 5 "black" "7" 10 "red" 1 2)
                       (CELL '(2 . 2) '(9 . 12) 4 5 "black" "8" 10 "red" 1 2)
                       (CELL '(2 . 3) '(13 . 12) 4 5 "black" "9" 10 "red" 1 2)
                       ))))

    (parameterize
         ([*ROW_HEIGHT_MAP* (make-hash)]
          [*COL_WIDTH_MAP* (make-hash)]
          [*ROW_MARGIN_TOP_MAP* (make-hash)]
          [*COL_MARGIN_LEFT_MAP* (make-hash)]
          [*CELL_FONT_SIZE_MAP* (make-hash)]
          [*CELL_FONT_COLOR_MAP* (make-hash)])
      
      (set-table-col-width! '(0) 100)
      (set-table-row-height! '(1) 100)
      (set-table-col-margin-left! '(0) 70)
      (set-table-row-margin-top! '(1) 80)
      
      (let ([cells (matrix-to-cells '(("1" "2" "1") ("3" "4" "1") ("5" "6" "1")) 5 5 "black" 1 1 '(0 . 0) 10 "red")])
        (check-equal? (length cells) 9)
        (check-equal? cells
                      (list
                       (CELL '(0 . 0) '(0 . 0) 100 5 "black" "1" 10 "red" 1 70)
                       (CELL '(0 . 1) '(100 . 0) 5 5 "black" "2" 10 "red" 1 1)
                       (CELL '(0 . 2) '(105 . 0) 5 5 "black" "1" 10 "red" 1 1)
                       (CELL '(1 . 0) '(0 . 5) 100 100 "black" "3" 10 "red" 80 70)
                       (CELL '(1 . 1) '(100 . 5) 5 100 "black" "4" 10 "red" 80 1)
                       (CELL '(1 . 2) '(105 . 5) 5 100 "black" "1" 10 "red" 80 1)
                       (CELL '(2 . 0) '(0 . 105) 100 5 "black" "5" 10 "red" 1 70)
                       (CELL '(2 . 1) '(100 . 105) 5 5 "black" "6" 10 "red" 1 1)
                       (CELL '(2 . 2) '(105 . 105) 5 5 "black" "1" 10 "red" 1 1)
                       )))
      ))
   ))

(run-tests test-all)
