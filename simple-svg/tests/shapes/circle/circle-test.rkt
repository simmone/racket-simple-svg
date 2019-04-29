#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/circle.rkt")

(require racket/runtime-path)
(define-runtime-path circle_svg "../../../showcase/shapes/circle/circle.svg")

(define test-all
  (test-suite
   "test-circle"

   (test-case
    "test-basic"

    (call-with-input-file circle_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:canvas? '(1 "red" "white")
             (lambda ()
               (circle '(100 . 100) 50 "#ED6E46")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
