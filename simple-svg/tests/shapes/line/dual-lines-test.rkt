#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path line_svg "../../../showcase/shapes/line/dual.svg")

(define test-all
  (test-suite
   "test-line"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            800 600
            #:background "#eeeeee"
            (thunk
             (define line-h (svg-def-shape (new-line '(100 . 300) '(700 . 300))))
             (define line-v (svg-def-shape (new-line '(400 . 100) '(400 . 500))))
    
             (define line-h-style (sstyle-new))
             (set-SSTYLE-stroke-width! line-h-style 2)
             (set-SSTYLE-stroke! line-h-style "#5c3d19")
    
             (define line-v-style (sstyle-new))
             (set-SSTYLE-stroke-width! line-v-style 2)
             (set-SSTYLE-stroke! line-v-style "#5c3d19")

             (svg-place-widget line-h #:style line-h-style)
             (svg-place-widget line-v #:style line-v-style)))])

      (call-with-input-file line_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
