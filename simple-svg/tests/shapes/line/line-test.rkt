#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/line.rkt")

(require racket/runtime-path)
(define-runtime-path line_svg "line.svg")

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
             (lambda ()
               (line '(5 . 5) '(100 . 100) "#765373" 8)))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)