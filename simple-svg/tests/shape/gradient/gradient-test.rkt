#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path linear_gradient_svg "../../../showcase/gradient/linear_gradient.svg")
(define-runtime-path radial_gradient_svg "../../../showcase/gradient/radial_gradient.svg")

(define test-all
  (test-suite
   "test-gradient"
   
   (test-case
    "test-linearGradient"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([rec_id (svg-def-shape (new-rect 100 100))]
                    [gradient_id
                     (svg-def-shape
                      (new-linear-gradient
                       '(
                        (0 "#BBC42A" 1)
                        (100 "#ED6E46" 1))))]
                    [_sstyle (sstyle-new)])

                (set-SSTYLE-fill-gradient! _sstyle gradient_id)
                (svg-place-widget rec_id #:style _sstyle))))])
      
      (call-with-input-file linear_gradient_svg
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
              (let ([rec_id (svg-def-shape (new-rect 100 100))]
                    [gradient_id
                     (svg-def-shape
                      (new-radial-gradient
                       '(
                         (0 "#BBC42A" 1)
                         (100 "#ED6E46" 1))))]
                    [_sstyle (sstyle-new)])

                (set-SSTYLE-fill-gradient! _sstyle gradient_id)
                (svg-place-widget rec_id #:style _sstyle))))])
      
      (call-with-input-file radial_gradient_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
