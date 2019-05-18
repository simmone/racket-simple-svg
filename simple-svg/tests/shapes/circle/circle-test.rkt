#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path circle_svg "../../../showcase/shapes/circle/circle.svg")
(define-runtime-path circle3_svg "../../../showcase/shapes/circle/circle3.svg")

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
                (svg-use circle #:at? '(50 . 50) #:fill? "#ED6E46")
                (svg-show-default))))])
      
      (call-with-input-file circle_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-circle3"

    (let ([actual_svg
           (svg-out
            #:canvas? '(1 "red" "white")
            (lambda ()
              (let ([circle (svg-circle-def 50)])
                (svg-use circle #:at? '(50 . 50) #:fill? "red")
                (svg-use circle #:at? '(150 . 50) #:fill? "yellow")
                (svg-use circle #:at? '(50 . 150) #:fill? "blue")
                (svg-use circle #:at? '(150 . 150) #:fill? "green")
                (svg-show-default))))])

      (call-with-input-file circle3_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
