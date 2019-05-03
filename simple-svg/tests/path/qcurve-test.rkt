#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path qcurve1_svg "../../showcase/path/qcurve1.svg")
(define-runtime-path qcurve2_svg "../../showcase/path/qcurve2.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-qcurve*"

    (call-with-input-file qcurve1_svg
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
                  (qcurve* '(50 . 0) '(100 . 50))
                  (qcurve* '(150 . 100) '(200 . 50))))
               (circle '(0 . 50) 2 "red")
               (circle '(50 . 0) 2 "red")
               (circle '(100 . 50) 2 "red")
               (circle '(150 . 100) 2 "red")
               (circle '(200 . 50) 2 "red")
               ))))
         (lambda (actual)
           (check-lines? expected actual))))))

   (test-case
    "test-qcurve"

    (call-with-input-file qcurve2_svg
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
                  (qcurve '(50 . -50) '(100 . 0))
                  (qcurve '(50 . 50) '(100 . 0))))
               (circle '(0 . 50) 2 "red")
               (circle '(50 . 0) 2 "red")
               (circle '(100 . 50) 2 "red")
               (circle '(150 . 100) 2 "red")
               (circle '(200 . 50) 2 "red")
               ))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
