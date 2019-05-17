#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path circle_svg "../../../showcase/shapes/circle/circle.svg")

(define test-all
  (test-suite
   "test-circle"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            #:canvas? '(1 "red" "white")
            (lambda ()
              (let ([circle (svg-circle-def 50)])
                (svg-use circle #:at? '(100 . 100) #:fill? "#ED6E46")
                (svg-show-default))))])

    (call-with-input-file circle_svg
      (lambda (expected)
        actual_svg
        (lambda (actual)
          (check-lines? expected actual))))))

   ))

(run-tests test-all)
