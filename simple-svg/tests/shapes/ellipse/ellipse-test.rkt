#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/ellipse.rkt")

(require racket/runtime-path)
(define-runtime-path ellipse_svg "../../../showcase/shapes/ellipse/ellipse.svg")

(define test-all
  (test-suite
   "test-ellipse"

   (test-case
    "test-basic"

    (call-with-input-file ellipse_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:stroke-width? 1
             (lambda ()
               (ellipse '(150 . 150) 100 50 "#7AA20D")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
