#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../src/lib/lib.rkt")
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
                     (svg-def-polyline
                      '((0 . 0) (40 . 0) (40 . 40) (80 . 40) (80 . 80) (120 . 80) (120 . 120)))]
                    [_sstyle (sstyle-new)])
                (set-sstyle-stroke-width! _sstyle 5)
                (set-sstyle-stroke! _sstyle "#BBC42A")
                (set-sstyle-fill! _sstyle "blue")
                (svg-use-shape polyline _sstyle #:at? '(5 . 5))
                (svg-show-default))))])
      
      (call-with-input-file polyline_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
