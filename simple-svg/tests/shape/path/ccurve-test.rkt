#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path ccurve1_svg "../../../showcase/path/ccurve1.svg")
(define-runtime-path ccurve2_svg "../../../showcase/path/ccurve2.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-ccurve*"

    (let ([actual_svg
           (svg-out
            200 120
            (lambda ()
              (let ([path_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(10 . 60))
                         (svg-path-ccurve* '(30.00001 . 15.00001) '(80 . 15) '(100 . 60))
                         (svg-path-ccurve* '(120 . 105) '(170 . 105) '(190 . 60))
                         )))]
                    [path_style (sstyle-new)]
                    [red_dot_id (svg-def-shape (new-circle 5))]
                    [dot_style (sstyle-new)])

                (set-SSTYLE-fill! path_style "none")
                (set-SSTYLE-stroke-width! path_style 3)
                (set-SSTYLE-stroke! path_style "#333333")
                (svg-place-widget path_id #:style path_style)

                (set-SSTYLE-fill! dot_style "red")
                (svg-place-widget red_dot_id #:style dot_style #:at '(10 . 60))
                (svg-place-widget red_dot_id #:style dot_style #:at '(30 . 15))
                (svg-place-widget red_dot_id #:style dot_style #:at '(80 . 15))
                (svg-place-widget red_dot_id #:style dot_style #:at '(100 . 60))
                (svg-place-widget red_dot_id #:style dot_style #:at '(120 . 105))
                (svg-place-widget red_dot_id #:style dot_style #:at '(170 . 105))
                (svg-place-widget red_dot_id #:style dot_style #:at '(190 . 60)))))])
          
      (call-with-input-file ccurve1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-ccurve"

    (let ([actual_svg
           (svg-out
            200 120
            (lambda ()
              (let ([path_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(10 . 60))
                         (svg-path-ccurve '(20.00001 . -45.00001) '(70 . -45) '(90 . 0))
                         (svg-path-ccurve '(20 . 45) '(70 . 45) '(90 . 0))
                         )))]
                    [path_style (sstyle-new)]
                    [red_dot_id (svg-def-shape (new-circle 5))]
                    [dot_style (sstyle-new)])

                (set-SSTYLE-fill! path_style "none")
                (set-SSTYLE-stroke-width! path_style 3)
                (set-SSTYLE-stroke! path_style "#333333")
                (svg-place-widget path_id #:style path_style)

                (set-SSTYLE-fill! dot_style "red")
                (svg-place-widget red_dot_id #:style dot_style #:at '(10 . 60))
                (svg-place-widget red_dot_id #:style dot_style #:at '(30 . 15))
                (svg-place-widget red_dot_id #:style dot_style #:at '(80 . 15))
                (svg-place-widget red_dot_id #:style dot_style #:at '(100 . 60))
                (svg-place-widget red_dot_id #:style dot_style #:at '(120 . 105))
                (svg-place-widget red_dot_id #:style dot_style #:at '(170 . 105))
                (svg-place-widget red_dot_id #:style dot_style #:at '(190 . 60)))))])

      (call-with-input-file ccurve2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
