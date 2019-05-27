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
            130 130
            (lambda ()
              (let ([polyline
                     (svg-polyline-def
                      '((0 . 0) (40 . 0) (40 . 40) (80 . 40) (80 . 80) (120 . 80) (120 . 120)))]
                    [_svgview (new-svgview)])
                (set-svgview-pos! _svgview '(5 . 5))
                (set-svgview-stroke-width! _svgview 5)
                (set-svgview-stroke! _svgview "#BBC42A")
                (set-svgview-fill! _svgview "blue")
                (svg-use-shape polyline _svgview)
                (svg-show-default))))])
      
      (call-with-input-file polyline_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
