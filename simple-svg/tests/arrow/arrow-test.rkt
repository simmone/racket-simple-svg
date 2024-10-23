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
              (let (
                    [arrow1_id (svg-def-shape (new-arrow '(250 . 250) '(350 . 350) 10 20 10))]
                    [arrow11_id (svg-def-shape (new-arrow '(250 . 250) '(300 . 375) 10 20 10))]
                    [arrow2_id (svg-def-shape (new-arrow '(250 . 250) '(250 . 400) 10 20 10))]
                    [arrow22_id (svg-def-shape (new-arrow '(250 . 250) '(200 . 375) 10 20 10))]
                    [arrow3_id (svg-def-shape (new-arrow '(250 . 250) '(150 . 350) 10 20 10))]
                    [arrow33_id (svg-def-shape (new-arrow '(250 . 250) '(125 . 300) 10 20 10))]
                    [arrow4_id (svg-def-shape (new-arrow '(250 . 250) '(100 . 250) 10 20 10))]
                    [arrow44_id (svg-def-shape (new-arrow '(250 . 250) '(125 . 200) 10 20 10))]
                    [arrow5_id (svg-def-shape (new-arrow '(250 . 250) '(150 . 150) 10 20 10))]
                    [arrow55_id (svg-def-shape (new-arrow '(250 . 250) '(200 . 125) 10 20 10))]
                    [arrow6_id (svg-def-shape (new-arrow '(250 . 250) '(250 . 100) 10 20 10))]
                    [arrow66_id (svg-def-shape (new-arrow '(250 . 250) '(200 . 125) 10 20 10))]
                    [sstyle_arrow (sstyle-new)]
                    )

                (set-SSTYLE-stroke-width! sstyle_arrow 2)
                (set-SSTYLE-stroke! sstyle_arrow "red")
                (set-SSTYLE-fill! sstyle_arrow "#ED6E46")

                (svg-place-widget arrow1_id #:style sstyle_arrow)
                (svg-place-widget arrow11_id #:style sstyle_arrow)
                (svg-place-widget arrow2_id #:style sstyle_arrow)
                (svg-place-widget arrow22_id #:style sstyle_arrow)
                (svg-place-widget arrow3_id #:style sstyle_arrow)
                (svg-place-widget arrow33_id #:style sstyle_arrow)
                (svg-place-widget arrow4_id #:style sstyle_arrow)
                (svg-place-widget arrow44_id #:style sstyle_arrow)
                (svg-place-widget arrow5_id #:style sstyle_arrow)
                (svg-place-widget arrow55_id #:style sstyle_arrow)
                (svg-place-widget arrow6_id #:style sstyle_arrow)
                (svg-place-widget arrow66_id #:style sstyle_arrow)
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
