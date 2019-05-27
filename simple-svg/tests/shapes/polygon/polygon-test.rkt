#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
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
                     (svg-polygon-def
                      '((0 . 25) (25 . 0) (75 . 0) (100 . 25) (100 . 75) (75 . 100) (25 . 100) (0 . 75)))]
                    [_svgview (new-svgview)])
                (set-svgview-pos! _svgview '(5 . 5))
                (set-svgview-stroke-width! _svgview 5)
                (set-svgview-stroke! _svgview "#765373")
                (set-svgview-fill! _svgview "#ED6E46")
                (svg-use-shape polygon _svgview)
                (svg-show-default))))])
      
      (call-with-input-file polygon_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
