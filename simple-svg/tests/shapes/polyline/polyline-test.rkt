#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path polyline_svg "../../../showcase/shapes/polyline/polyline.svg")

(define test-all
  (test-suite
   "test-polyline"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            #:canvas? '(1 "red" "white")
            (lambda ()
              (let ([polyline
                     (svg-polyline-def
                      '((0 . 0) (40 . 0) (40 . 40) (80 . 40) (80 . 80) (120 . 80) (120 . 120)))])
                (svg-use polyline #:stroke? '(5 . "#BBC42A") #:fill? "blue")
                (svg-show-default))))])
      
      (call-with-input-file polyline_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
