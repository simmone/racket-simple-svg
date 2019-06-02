#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
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
              (let ([rec (svg-rect-def 100 100)]
                    [gradient
                     (svg-def-lineargradient
                      (list
                       (svg-def-gradient-stop #:offset 0 #:color "#BBC42A")
                       (svg-def-gradient-stop #:offset 100 #:color "#ED6E46")
                       ))]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill-gradient! _sstyle gradient)
                (svg-use-shape rec _sstyle)
                (svg-show-default))))])
      
      (printf "~a\n" actual_svg)

      (call-with-input-file gradient1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all)
