#lang racket

(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require rackunit "../../shapes/rect.rkt")

(require racket/runtime-path)
(define-runtime-path rect_file "rect.dat")

(define test-all
  (test-suite
   "test-rect"

   (test-case
    "test-basic"

    (call-with-input-file rect_file
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             (lambda ()
               (rect 100 100 "#000000")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
