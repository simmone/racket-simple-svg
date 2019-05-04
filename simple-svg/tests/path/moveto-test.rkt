#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path moveto1_svg "../../showcase/path/moveto1.svg")
(define-runtime-path moveto2_svg "../../showcase/path/moveto2.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-moveto*"

    (call-with-input-file moveto1_svg
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
                  (moveto* '(20 . 60))))
               (circle '(20 . 60) 1 "red")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   (test-case
    "test-moveto"

    (call-with-input-file moveto2_svg
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
                  (moveto '(20 . 60))))
               (circle '(20 . 60) 1 "red")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
