#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path table1_svg "../../../showcase/gadget/table/table1.svg")

(define test-all
  (test-suite
   "test-table1"

   (test-case
    "test-table1"

    (let ([actual_svg
           (svg-out
            250 200
            (lambda ()
              (let ([table_id (svg-gadget-table
                               '(("1" "2" "3") ("4" "5" "6") ("7" "8" "9"))
                               (lambda () (void)))])

                (svg-place-widget table_id #:at '(50 . 50)))))])
      
      (call-with-input-file table1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
