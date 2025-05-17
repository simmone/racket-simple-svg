#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path table2_svg "../../../showcase/gadget/table/table2.svg")

(define test-all
  (test-suite
   "test-table2"

   (test-case
    "test-table2"

    (let ([actual_svg
           (svg-out
            250 200
            (lambda ()
              (let ([table_id (svg-gadget-table
                               '(("1" "2" "3") ("4" "5" "6") ("7" "8" "9"))
                               (lambda ()
                                 (set-table-col-width! '(1) 80.00001)
                                 (set-table-row-height! '(1) 50.00001)
                                 (set-table-col-margin-left! '(1) 35.00001)
                                 (set-table-row-margin-top! '(1) 30.00001)
                                 ))])

                (svg-place-widget table_id #:at '(50 . 50)))))])
      
      (call-with-input-file table2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
