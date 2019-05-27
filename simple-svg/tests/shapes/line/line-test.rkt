#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path line_svg "../../../showcase/shapes/line/line.svg")

(define test-all
  (test-suite
   "test-line"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            110 110
            (lambda ()
              (let ([line (svg-line-def '(0 . 0) '(100 . 100))]
                    [_svgview (new-svgview)])
                (set-svgview-pos! _svgview '(5 . 5))
                (set-svgview-stroke-width! _svgview 10)
                (set-svgview-stroke! _svgview "#765373")
                (svg-use-shape line _svgview)
                (svg-show-default))))])
      
      (call-with-input-file line_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
