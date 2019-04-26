#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/circle.rkt")

(define test-all
  (test-suite
   "test-circle"

   (test-case
    "test-basic"

    (call-with-input-file "../../../showcase/shapes/circle/circle.svg"
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:stroke-width? 1
             (lambda ()
               (circle '(100 . 100) 50 "#ED6E46")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
