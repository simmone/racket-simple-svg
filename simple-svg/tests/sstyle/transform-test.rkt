#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path transform1_svg "../../showcase/sstyle/transform1.svg")
(define-runtime-path transform2_svg "../../showcase/sstyle/transform2.svg")

(define test-all
  (test-suite
   "test-sstyle"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            150 150
            (lambda ()
              (let ([rec (svg-def-rect 100 100)]
                    [_sstyle (sstyle-new)])
                (sstyle-set! _sstyle 'fill "#BBC42A")
                (sstyle-set! _sstyle 'translate '(75 . 5))
                (sstyle-set! _sstyle 'rotate 45)
                (svg-use-shape rec _sstyle)
                (svg-show-default))))])

      (call-with-input-file transform1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            250 240
            (lambda ()
              (let ([rec (svg-def-circle 50)]
                    [_sstyle (sstyle-new)])
                (sstyle-set! _sstyle 'fill "#BBC42A")
                (sstyle-set! _sstyle 'scale 2)
                (sstyle-set! _sstyle 'skewX 20)
                (svg-use-shape rec _sstyle #:at? '(40 . 60))
                (svg-show-default))))])

      (call-with-input-file transform2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all) 
