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
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#7AA20D")
                (svg-use-shape ellipse _sstyle #:at? '(100 . 50))
                (svg-show-default))))])
      
      (call-with-input-file ellipse_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
