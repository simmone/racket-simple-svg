#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path lineto_svg "../../showcase/path/lineto.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-lineto"

    (call-with-input-file lineto_svg
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
                  (moveto* '(0 . 0))
                  (lineto '(100 . 100))
                  (hlineto '(-100 . 0))
                  (lineto '(100 . -100))
                  (close-path)))
               (circle '(0 . 0) 2 "red")
               (circle '(100 . 100) 2 "red")
               (circle '(0 . 100) 2 "red")
               (circle '(100 . 0) 2 "red")
               ))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
