#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

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
              (let ([polygon_id
                     (svg-def-shape
                      (new-polygon
                       '((0.00001 . 25.00001) (25 . 0) (75 . 0) (100 . 25) (100 . 75) (75 . 100) (25 . 100) (0 . 75))))]
                    [_sstyle (sstyle-new)])

                (set-SSTYLE-stroke-width! _sstyle 5)
                (set-SSTYLE-stroke! _sstyle "#765373")
                (set-SSTYLE-fill! _sstyle "#ED6E46")

                (svg-place-widget polygon_id #:style _sstyle #:at '(5 . 5)))))])

      (call-with-input-file polygon_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
