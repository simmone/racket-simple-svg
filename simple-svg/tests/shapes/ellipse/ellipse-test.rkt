#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path ellipse_svg "../../../showcase/shapes/ellipse/ellipse.svg")

(define test-all
  (test-suite
   "test-ellipse"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            200 100
            (lambda ()
              (let ([ellipse (svg-ellipse-def '(100 . 50))]
                    [_display (new-display)])
                (set-display-fill! _display "#7AA20D")
                (set-display-pos! _display '(100 . 50))
                (svg-use-shape ellipse _display)
                (svg-show-default))))])
      
      (call-with-input-file ellipse_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
