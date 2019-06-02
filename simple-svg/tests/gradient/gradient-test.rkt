#lang racket

(require rackunit)
(require rackunit/gradient-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path gradient1_svg "../../showcase/gradient/gradient1.svg")

(define test-all
  (test-suite
   "test-gradient"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([rec (svg-def-rect 100 100)]
                    [gradient (svg-def-linear-gradient '( (0 . "#BBC42A") (100 . "#ED6E46") ))]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill-gradient! _sstyle gradient)
                (svg-use-shape rec _sstyle)
                (svg-show-default))))])

      (call-with-input-file gradient1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
