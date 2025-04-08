#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib/lib.rkt"
         "../../../src/define/shape/gradient.rkt"
         racket/runtime-path)

(define-runtime-path linear_gradient_define "linear_gradient_define.svg")
(define-runtime-path radial_gradient_define "radial_gradient_define.svg")

(define test-all
  (test-suite
   "test-gradient"
   
   (test-case
    "test-linear-define"

    (let ([linear_gradient
           (new-linear-gradient
            '(
              (0 "#BBC42A" 1)
              (100 "#ED6E46" 1))
            #:x1 0
            #:y1 1
            #:x2 2
            #:y2 3
            #:gradientUnits 'userSpaceOnUse
            #:spreadMethod 'repeat
            )])
      
      (call-with-input-file linear_gradient_define
        (lambda (expected)
          (call-with-input-string
           (format-linear-gradient "s1" linear_gradient)
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-radial-define"

    (let ([radial_gradient
           (new-radial-gradient
            '(
              (0 "#BBC42A" 1)
              (100 "#ED6E46" 1))
            #:cx 0
            #:cy 1
            #:fx 2
            #:fy 3
            #:r  4
            #:gradientUnits 'userSpaceOnUse
            #:spreadMethod 'repeat
            )])
      
      (call-with-input-file radial_gradient_define
        (lambda (expected)
          (call-with-input-string
           (format-radial-gradient "s1" radial_gradient)
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
