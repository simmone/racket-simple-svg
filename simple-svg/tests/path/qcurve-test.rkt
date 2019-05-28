#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path qcurve1_svg "../../showcase/path/qcurve1.svg")
(define-runtime-path qcurve2_svg "../../showcase/path/qcurve2.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-qcurve*"

    (let ([actual_svg
           (svg-out
            220 120
            (lambda ()
              (let ([path
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(10 . 60))
                        (svg-path-qcurve* '(60 . 10) '(110 . 60))
                        (svg-path-qcurve* '(160 . 110) '(210 . 60))))]
                    [path_style (sstyle-new)]
                    [red_dot (svg-circle-def 5)]
                    [dot_style (sstyle-new)])

                (set-sstyle-stroke! path_style "#333333")
                (set-sstyle-stroke-width! path_style 3)
                (svg-use-shape path path_style)

                (set-sstyle-fill! dot_style "red")
                (svg-use-shape red_dot dot_style #:at? '(10 . 60))
                (svg-use-shape red_dot dot_style #:at? '(60 . 10))
                (svg-use-shape red_dot dot_style #:at? '(110 . 60))
                (svg-use-shape red_dot dot_style #:at? '(160 . 110))
                (svg-use-shape red_dot dot_style #:at? '(210 . 60))

                (svg-show-default))))])

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
              (let ([path
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(10 . 60))
                        (svg-path-qcurve '(50 . -50) '(100 . 0))
                        (svg-path-qcurve '(50 . 50) '(100 . 0))
                        ))]
                    [path_style (sstyle-new)]
                    [red_dot (svg-circle-def 5)]
                    [dot_style (sstyle-new)])

                (set-sstyle-stroke! path_style "#333333")
                (set-sstyle-stroke-width! path_style 3)
                (svg-use-shape path path_style)

                (set-sstyle-fill! dot_style "red")
                (svg-use-shape red_dot dot_style #:at? '(10 . 60))
                (svg-use-shape red_dot dot_style #:at? '(60 . 10))
                (svg-use-shape red_dot dot_style #:at? '(110 . 60))
                (svg-use-shape red_dot dot_style #:at? '(160 . 110))
                (svg-use-shape red_dot dot_style #:at? '(210 . 60))

                (svg-show-default))))])
      
      (call-with-input-file qcurve2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
