#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/ellipse.rkt")

(require racket/runtime-path)
(define-runtime-path ellipse_file "ellipse.dat")

(define test-all
  (test-suite
   "test-ellipse"

   (test-case
    "test-basic"

    (call-with-input-file ellipse_file
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             (lambda ()
               (ellipse 150 150 100 50 "#ff0000")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
