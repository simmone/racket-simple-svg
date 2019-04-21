#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/circle.rkt")

(require racket/runtime-path)
(define-runtime-path circle_file "circle.dat")

(define test-all
  (test-suite
   "test-circle"

   (test-case
    "test-basic"

    (call-with-input-file circle_file
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             (lambda ()
               (circle 100 100 50 "#ff0000")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
