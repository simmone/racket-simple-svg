#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../src/lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path line_svg "../../../showcase/shapes/line/line.svg")

(define test-all
  (test-suite
   "test-line"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            110 110
            (lambda ()
              (let ([line (svg-def-line '(0 . 0) '(100 . 100))]
                    [_sstyle (sstyle-new)])
                (set-sstyle-stroke-width! _sstyle 10)
                (set-sstyle-stroke! _sstyle "#765373")
                (svg-use-shape line _sstyle #:at? '(5 . 5))
                (svg-show-default))))])
      
      (call-with-input-file line_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
