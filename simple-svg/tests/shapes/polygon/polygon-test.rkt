#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/polygon.rkt")

(require racket/runtime-path)
(define-runtime-path polygon_svg "../../../showcase/shapes/polygon/polygon.svg")

(define test-all
  (test-suite
   "test-polygon"

   (test-case
    "test-basic"

    (call-with-input-file polygon_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:background? '(1 "red" "white")
             (lambda ()
               (polygon 
                '((50 . 5) (100 . 5) (125 . 30) (125 . 80) (100 . 105) (50 . 105) (25 . 80) (25 . 30))
                "#ED6E46")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
