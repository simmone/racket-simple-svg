#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path line_svg "../../../showcase/shapes/line/line.svg")

(define test-all
  (test-suite
   "test-line"

   (test-case
    "test-basic"

    (call-with-input-file line_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:canvas? '(1 "red" "white")
             (lambda ()
               (line '(0 . 0) '(100 . 100) "#765373" 8)))))
         (lambda (actual)
           (check-lines? expected actual))))))
   ))

(run-tests test-all)
