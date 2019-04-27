#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/polyline.rkt")

(require racket/runtime-path)
(define-runtime-path polyline_svg "../../../showcase/shapes/polyline/polyline.svg")

(define test-all
  (test-suite
   "test-polyline"

   (test-case
    "test-basic"

    (call-with-input-file polyline_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:stroke-width? 1
             (lambda ()
               (polyline 
                '((0 . 40) (40 . 40) (40 . 80) (80 . 80) (80 . 120) (120 . 120) (120 . 160))
                "#BBC42A" 6 "blue")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
