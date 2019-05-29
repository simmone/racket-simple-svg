#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path transform1_svg "../../showcase/sstyle/transform1.svg")

(define test-all
  (test-suite
   "test-sstyle"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            150 150
            (lambda ()
              (let ([rec (svg-rect-def 100 100)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#BBC42A")
                (set-sstyle-translate! _sstyle '(75 . 5))
                (set-sstyle-rotate! _sstyle 45)
                (svg-use-shape rec _sstyle)
                (svg-show-default))))])

      (call-with-input-file transform1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all) 
