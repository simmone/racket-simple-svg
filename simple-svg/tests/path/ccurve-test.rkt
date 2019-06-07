#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path ccurve1_svg "../../showcase/path/ccurve1.svg")
(define-runtime-path ccurve2_svg "../../showcase/path/ccurve2.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-ccurve*"

    (let ([actual_svg
           (svg-out
            200 120
            (lambda ()
              (let ([path
                     (svg-def-path
                      (lambda ()
                        (svg-path-moveto* '(10 . 60))
                        (svg-path-ccurve* '(30 . 15) '(80 . 15) '(100 . 60))
                        (svg-path-ccurve* '(120 . 105) '(170 . 105) '(190 . 60))
                        ))]
                    [path_style (sstyle-new)]
                    [red_dot (svg-def-circle 5)]
                    [dot_style (sstyle-new)])

                (sstyle-set! path_style 'stroke "#333333")
                (sstyle-set! path_style 'stroke-width 3)
                (svg-use-shape path path_style)

                (sstyle-set! dot_style 'fill "red")
                (svg-use-shape red_dot dot_style #:at? '(10 . 60))
                (svg-use-shape red_dot dot_style #:at? '(30 . 15))
                (svg-use-shape red_dot dot_style #:at? '(80 . 15))
                (svg-use-shape red_dot dot_style #:at? '(100 . 60))
                (svg-use-shape red_dot dot_style #:at? '(120 . 105))
                (svg-use-shape red_dot dot_style #:at? '(170 . 105))
                (svg-use-shape red_dot dot_style #:at? '(190 . 60))

                (svg-show-default))))])
      
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
              (let ([path
                     (svg-def-path
                      (lambda ()
                        (svg-path-moveto* '(10 . 60))
                        (svg-path-ccurve '(20 . -45) '(70 . -45) '(90 . 0))
                        (svg-path-ccurve '(20 . 45) '(70 . 45) '(90 . 0))
                        ))]
                    [path_style (sstyle-new)]
                    [red_dot (svg-def-circle 5)]
                    [dot_style (sstyle-new)])

                (sstyle-set! path_style 'stroke "#333333")
                (sstyle-set! path_style 'stroke-width 3)
                (svg-use-shape path path_style)

                (sstyle-set! dot_style 'fill "red")
                (svg-use-shape red_dot dot_style #:at? '(10 . 60))
                (svg-use-shape red_dot dot_style #:at? '(30 . 15))
                (svg-use-shape red_dot dot_style #:at? '(80 . 15))
                (svg-use-shape red_dot dot_style #:at? '(100 . 60))
                (svg-use-shape red_dot dot_style #:at? '(120 . 105))
                (svg-use-shape red_dot dot_style #:at? '(170 . 105))
                (svg-use-shape red_dot dot_style #:at? '(190 . 60))

                (svg-show-default))))])
      
      (call-with-input-file ccurve2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
