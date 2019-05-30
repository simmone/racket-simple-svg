#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path text1_svg "../../../showcase/shapes/text/text1.svg")

(define test-all
  (test-suite
   "test-text"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([text (svg-text-def "城春草木深" 50)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#BBC42A")
                (svg-use-shape rec _sstyle)
                (svg-show-default))))])
      
      (call-with-input-file text_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-all) 
