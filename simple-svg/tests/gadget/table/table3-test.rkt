#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path table3_svg "../../../showcase/gadget/table/table3.svg")

(define test-all
  (test-suite
   "test-table3"

   (test-case
    "test-table3"

    (let ([actual_svg
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

                (svg-place-widget table_id))))])
      
      (call-with-input-file table3_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
