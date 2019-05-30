#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path text1_svg "../../showcase/text/text1.svg")

(define test-all
  (test-suite
   "test-text"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            310 70
            (lambda ()
              (let ([text (svg-text-def "城春草木深" #:font-size? 50)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#ED6E46")
                (svg-use-shape text _sstyle #:at? '(30 . 60))
                (svg-show-default))))])

      (call-with-input-file text1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all) 
