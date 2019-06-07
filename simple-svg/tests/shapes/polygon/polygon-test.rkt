#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../src/lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path polygon_svg "../../../showcase/shapes/polygon/polygon.svg")

(define test-all
  (test-suite
   "test-polygon"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            110 110
            (lambda ()
              (let ([polygon
                     (svg-def-polygon
                      '((0 . 25) (25 . 0) (75 . 0) (100 . 25) (100 . 75) (75 . 100) (25 . 100) (0 . 75)))]
                    [_sstyle (sstyle-new)])

                (sstyle-set! _sstyle 'stroke-width 5)
                (sstyle-set! _sstyle 'stroke "#765373")
                (sstyle-set! _sstyle 'fill "#ED6E46")

                (svg-use-shape polygon _sstyle #:at? '(5 . 5))
                (svg-show-default))))])
      
      (call-with-input-file polygon_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
