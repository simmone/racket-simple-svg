#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt"
         "../../main.rkt"
         racket/runtime-path)

(define-runtime-path arrow1_svg "../../showcase/arrow/arrow1.svg")
(define-runtime-path arrow2_svg "../../showcase/arrow/arrow2.svg")

(define test-all
  (test-suite
   "test-arrow"

   (test-case
    "test-arrow1"

    (let ([actual_svg
           (svg-out
            300 300
            (lambda ()
              (let (
                    [arrow_id (svg-def-shape (new-arrow '(50 . 50) '(280 . 280) 40 40 80))]
                    [sstyle_arrow (sstyle-new)]
                    )

                (set-SSTYLE-stroke-width! sstyle_arrow 5)
                (set-SSTYLE-stroke! sstyle_arrow "teal")
                (set-SSTYLE-fill! sstyle_arrow "lavender")
                (svg-place-widget arrow_id #:style sstyle_arrow)
                )))])
      
      (call-with-input-file arrow1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-arrow2"

    (let ([actual_svg
           (svg-out
            400 400
            (lambda ()
              (let (
                    [arrow10_id (svg-def-shape (new-arrow '(200 . 200) '(200 . 350) 10 10 20))]
                    [arrow11_id (svg-def-shape (new-arrow '(200 . 200) '(150 . 300) 10 10 20))]
                    [arrow12_id (svg-def-shape (new-arrow '(200 . 200) '(100 . 250) 10 10 20))]
                    [arrow20_id (svg-def-shape (new-arrow '(200 . 200) '(50 . 200) 10 10 20))]
                    [arrow21_id (svg-def-shape (new-arrow '(200 . 200) '(100 . 150) 10 10 20))]
                    [arrow22_id (svg-def-shape (new-arrow '(200 . 200) '(150 . 100) 10 10 20))]
                    [arrow30_id (svg-def-shape (new-arrow '(200 . 200) '(200 . 50) 10 10 20))]
                    [arrow31_id (svg-def-shape (new-arrow '(200 . 200) '(250 . 100) 10 10 20))]
                    [arrow32_id (svg-def-shape (new-arrow '(200 . 200) '(300 . 150) 10 10 20))]
                    [arrow40_id (svg-def-shape (new-arrow '(200 . 200) '(350 . 200) 10 10 20))]
                    [arrow41_id (svg-def-shape (new-arrow '(200 . 200) '(300 . 250) 10 10 20))]
                    [arrow42_id (svg-def-shape (new-arrow '(200 . 200) '(250 . 300) 10 10 20))]
                    [sstyle_arrow (sstyle-new)]
                    )

                (set-SSTYLE-stroke-width! sstyle_arrow 2)
                (set-SSTYLE-stroke! sstyle_arrow "green")
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
      
      (call-with-input-file arrow2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
