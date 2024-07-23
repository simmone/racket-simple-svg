#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt"
         "../../main.rkt"
         racket/runtime-path)

(define-runtime-path filter_blur_dropdown_svg "../../showcase/filter/filter_blur_dropdown.svg")

(define test-all
  (test-suite
   "test-filter-blur-dropdown"

   (test-case
    "test-filter-blue-dropdown"

    (let ([actual_svg
           (svg-out
            120 120
            (lambda ()
              (let ([circle_id (svg-def-shape (new-circle 50))]
                    [filter_id (svg-def-filter (new-blur-dropdown 2 3 "black"))]
                    [_sstyle (sstyle-new)])

                (set-SSTYLE-fill! _sstyle "red")

                (svg-place-widget circle_id #:style _sstyle #:filter filter_id #:at '(60 . 60)))))])
      
      (call-with-input-file filter_blur_dropdown_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
