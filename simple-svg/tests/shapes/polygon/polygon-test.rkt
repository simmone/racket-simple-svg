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
                    [_sstyle (new-sstyle)])
                (set-sstyle-pos! _sstyle '(5 . 5))
                (set-sstyle-stroke-width! _sstyle 5)
                (set-sstyle-stroke! _sstyle "#765373")
                (set-sstyle-fill! _sstyle "#ED6E46")
                (svg-use-shape polygon _sstyle)
                (svg-show-default))))])
      
      (call-with-input-file polygon_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
