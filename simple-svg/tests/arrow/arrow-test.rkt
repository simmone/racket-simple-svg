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
                    [arrow10_id (svg-def-shape (new-arrow '(250 . 250) '(250 . 400) 10 20 10))]
                    [arrow11_id (svg-def-shape (new-arrow '(250 . 250) '(200 . 350) 10 20 10))]
                    [arrow12_id (svg-def-shape (new-arrow '(250 . 250) '(150 . 300) 10 20 10))]
                    [arrow20_id (svg-def-shape (new-arrow '(250 . 250) '(100 . 250) 10 20 10))]
                    [arrow21_id (svg-def-shape (new-arrow '(250 . 250) '(150 . 200) 10 20 10))]
                    [arrow22_id (svg-def-shape (new-arrow '(250 . 250) '(200 . 150) 10 20 10))]
                    [arrow30_id (svg-def-shape (new-arrow '(250 . 250) '(250 . 100) 10 20 10))]
                    [arrow31_id (svg-def-shape (new-arrow '(250 . 250) '(300 . 150) 10 20 10))]
                    [arrow32_id (svg-def-shape (new-arrow '(250 . 250) '(350 . 200) 10 20 10))]
                    [arrow40_id (svg-def-shape (new-arrow '(250 . 250) '(400 . 250) 10 20 10))]
                    [arrow41_id (svg-def-shape (new-arrow '(250 . 250) '(350 . 300) 10 20 10))]
                    [arrow42_id (svg-def-shape (new-arrow '(250 . 250) '(300 . 350) 10 20 10))]
                    [sstyle_arrow (sstyle-new)]
                    )

                (set-SSTYLE-stroke-width! sstyle_arrow 2)
                (set-SSTYLE-stroke! sstyle_arrow "red")
                (set-SSTYLE-fill! sstyle_arrow "#ED6E46")

                (svg-place-widget arrow10_id #:style sstyle_arrow)
                (svg-place-widget arrow11_id #:style sstyle_arrow)
                (svg-place-widget arrow12_id #:style sstyle_arrow)
                (svg-place-widget arrow20_id #:style sstyle_arrow)
                (svg-place-widget arrow21_id #:style sstyle_arrow)
                (svg-place-widget arrow22_id #:style sstyle_arrow)
                (svg-place-widget arrow30_id #:style sstyle_arrow)
                (svg-place-widget arrow31_id #:style sstyle_arrow)
                (svg-place-widget arrow32_id #:style sstyle_arrow)
                (svg-place-widget arrow40_id #:style sstyle_arrow)
                (svg-place-widget arrow41_id #:style sstyle_arrow)
                (svg-place-widget arrow42_id #:style sstyle_arrow)
                )))])

      (call-with-input-file arrow1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
