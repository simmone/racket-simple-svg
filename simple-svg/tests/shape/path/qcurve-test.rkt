#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path qcurve1_svg "../../../showcase/path/qcurve1.svg")
(define-runtime-path qcurve2_svg "../../../showcase/path/qcurve2.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-qcurve*"

    (let ([actual_svg
           (svg-out
            220 120
            (lambda ()
              (let ([path_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(10 . 60))
                         (svg-path-qcurve* '(60 . 10) '(110 . 60))
                         (svg-path-qcurve* '(160 . 110) '(210 . 60)))))]
                    [path_style (sstyle-new)]
                    [red_dot_id (svg-def-shape (new-circle 5))]
                    [dot_style (sstyle-new)])

                (set-SSTYLE-fill! path_style "none")
                (set-SSTYLE-stroke-width! path_style 3)
                (set-SSTYLE-stroke! path_style "#333333")
                (svg-place-widget path_id #:style path_style)

                (set-SSTYLE-fill! dot_style "red")
                (svg-place-widget red_dot_id #:style dot_style #:at '(10 . 60))
                (svg-place-widget red_dot_id #:style dot_style #:at '(60 . 10))
                (svg-place-widget red_dot_id #:style dot_style #:at '(110 . 60))
                (svg-place-widget red_dot_id #:style dot_style #:at '(160 . 110))
                (svg-place-widget red_dot_id #:style dot_style #:at '(210 . 60)))))])
      
      (call-with-input-file qcurve1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-qcurve"

    (let ([actual_svg
           (svg-out
            220 120
            (lambda ()
              (let ([path_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(10 . 60))
                         (svg-path-qcurve '(50 . -50) '(100 . 0))
                         (svg-path-qcurve '(50 . 50) '(100 . 0))
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
                (svg-place-widget red_dot_id #:style dot_style #:at '(60 . 10))
                (svg-place-widget red_dot_id #:style dot_style #:at '(110 . 60))
                (svg-place-widget red_dot_id #:style dot_style #:at '(160 . 110))
                (svg-place-widget red_dot_id #:style dot_style #:at '(210 . 60)))))])
      
      (call-with-input-file qcurve2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
