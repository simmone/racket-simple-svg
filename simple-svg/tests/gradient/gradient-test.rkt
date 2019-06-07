#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path gradient1_svg "../../showcase/gradient/gradient1.svg")
(define-runtime-path gradient2_svg "../../showcase/gradient/gradient2.svg")

(define test-all
  (test-suite
   "test-gradient"

   (test-case
    "test-linearGradient"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([rec (svg-def-rect 100 100)]
                    [gradient
                     (svg-def-linear-gradient
                      (list
                       (svg-def-gradient-stop #:offset 0 #:color "#BBC42A")
                       (svg-def-gradient-stop #:offset 100 #:color "#ED6E46")
                       ))]
                    [_sstyle (sstyle-new)])
                (sstyle-set! _sstyle 'fill-gradient gradient)
                (svg-use-shape rec _sstyle)
                (svg-show-default))))])
      
      (call-with-input-file gradient1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-radialGradient"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([rec (svg-def-rect 100 100)]
                    [gradient
                     (svg-def-radial-gradient
                      (list
                       (svg-def-gradient-stop #:offset 0 #:color "#BBC42A")
                       (svg-def-gradient-stop #:offset 100 #:color "#ED6E46")
                       ))]
                    [_sstyle (sstyle-new)])
                (sstyle-set! _sstyle 'fill-gradient gradient)
                (svg-use-shape rec _sstyle)
                (svg-show-default))))])
      
      (call-with-input-file gradient2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
