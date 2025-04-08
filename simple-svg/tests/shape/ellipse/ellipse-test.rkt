#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

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
              (let ([ellipse_id (svg-def-shape (new-ellipse 100 50))]
                    [_sstyle (sstyle-new)])
                
                (set-SSTYLE-fill! _sstyle "#7AA20D")
                (svg-place-widget ellipse_id #:style _sstyle #:at '(100 . 50)))))])
      
      (call-with-input-file ellipse_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
