#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path filter_blur_dropdown_svg "../../../showcase/filter/filter_blur_dropdown.svg")

(define test-all
  (test-suite
   "test-filter-blur-dropdown"

   (test-case
    "test-filter-blue-dropdown"

    (let ([actual_svg
           (svg-out
            140 140
            (lambda ()
              (let ([circle_id (svg-def-shape (new-circle 50))]
                    [filter_id (svg-def-shape (new-blur-dropdown))]
                    [_sstyle (sstyle-new)])

                (set-SSTYLE-stroke! _sstyle "red")
                (set-SSTYLE-stroke-width! _sstyle 12)

                (svg-place-widget circle_id #:style _sstyle #:filter_id filter_id #:at '(70 . 70)))))])

      (call-with-input-file filter_blur_dropdown_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
