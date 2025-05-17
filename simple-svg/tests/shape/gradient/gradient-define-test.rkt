#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib.rkt"
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
              (0.00001 "#BBC42A" 1.00000)
              (100.00000 "#ED6E46" 1.00000))
            #:x1 0.00001
            #:y1 1.00001
            #:x2 2.00001
            #:y2 3.00001
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
              (0.00001 "#BBC42A" 1.00000)
              (100.00000 "#ED6E46" 1.00000))
            #:cx 0.00001
            #:cy 1.00001
            #:fx 2.00001
            #:fy 3.00001
            #:r  4.00001
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
