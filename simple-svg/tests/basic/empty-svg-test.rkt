#lang racket

(require rackunit/text-ui)

(require "../../lib/lib.rkt")

(require rackunit "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path test1_file "empty-svg.dat")

(define test-basic
  (test-suite
   "test-basic"

   (test-case
    "test-empty-svg"

    (call-with-input-file test1_file
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             (lambda ()
               (void)))))
         (lambda (actual)
           (check-lines? expected actual)))))
    )

   ))

(run-tests test-basic)
