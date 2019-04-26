#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/ellipse.rkt")

(define test-all
  (test-suite
   "test-ellipse"

   (test-case
    "test-basic"

    (call-with-input-file "../../../showcase/shapes/ellipse/ellipse.svg"
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
