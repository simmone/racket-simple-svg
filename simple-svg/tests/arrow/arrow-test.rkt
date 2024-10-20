#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt"
         "../../main.rkt"
         racket/runtime-path)

(define-runtime-path arrow1_svg "../../showcase/arrow/arrow1.svg")

(define test-all
  (test-suite
   "test-arrow"

   (test-case
    "test-arrow1"

    (let ([actual_svg
           (svg-out
            500 500
            (lambda ()
              (let ([arrow1_id (svg-def-shape (new-arrow '(250 . 250) '(450 . 250) 10 20 10))]
                    [arrow2_id (svg-def-shape (new-arrow '(250 . 250) '(450 . 450) 10 20 10))]
                    [arrow3_id (svg-def-shape (new-arrow '(250 . 250) '(250 . 450) 10 20 10))]
                    [arrow4_id (svg-def-shape (new-arrow '(250 . 250) '(50 . 450) 10 20 10))]
                    [arrow5_id (svg-def-shape (new-arrow '(250 . 250) '(50 . 250) 10 20 10))]
                    [arrow6_id (svg-def-shape (new-arrow '(250 . 250) '(50 . 50) 10 20 10))]
                    [arrow7_id (svg-def-shape (new-arrow '(250 . 250) '(250 . 50) 10 20 10))]
                    [arrow8_id (svg-def-shape (new-arrow '(250 . 250) '(450 . 50) 10 20 10))]
                    [sstyle_arrow (sstyle-new)])

                (set-SSTYLE-stroke-width! sstyle_arrow 2)
                (set-SSTYLE-stroke! sstyle_arrow "red")
                (set-SSTYLE-fill! sstyle_arrow "#ED6E46")

                (svg-place-widget arrow1_id #:style sstyle_arrow)
                (svg-place-widget arrow2_id #:style sstyle_arrow)
                (svg-place-widget arrow3_id #:style sstyle_arrow)
                (svg-place-widget arrow4_id #:style sstyle_arrow)
                (svg-place-widget arrow5_id #:style sstyle_arrow)
                (svg-place-widget arrow6_id #:style sstyle_arrow)
                (svg-place-widget arrow7_id #:style sstyle_arrow)
                (svg-place-widget arrow8_id #:style sstyle_arrow)
                )))])

      (printf "~a\n" actual_svg)
      
      (call-with-input-file arrow1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
