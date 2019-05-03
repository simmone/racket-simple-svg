#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path ccurve*_svg "../../showcase/path/ccurve*.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-basic"

    (call-with-input-file ccurve*_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:canvas? '(1 "red" "white")
             (lambda ()
               (path
                #:stroke-fill? "#333333"
                #:stroke-width? 3
                (lambda ()
                  (moveto* '(0 . 50))
                  (ccurve* '(20 . 5) '(70 . 5) '(90 . 50))
                  (ccurve* '(110 . 95) '(160 . 95) '(180 . 50))))
               (circle '(0 . 50) 2 "red")
               (circle '(20 . 5) 2 "red")
               (circle '(70 . 5) 2 "red")
               (circle '(90 . 50) 2 "red")
               (circle '(110 . 95) 2 "red")
               (circle '(160 . 95) 2 "red")
               (circle '(180 . 50) 2 "red")
               ))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
