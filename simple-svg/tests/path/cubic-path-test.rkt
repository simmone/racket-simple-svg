#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path cubic_path_svg "../../showcase/path/cubic_path.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-basic"

    (call-with-input-file cubic_path_svg
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
                  (moveto* '(10 . 50))
                  (cubic-curve* '(30 . 5) '(80 . 5) '(100 . 50))
                  (cubic-curve* '(120 . 95) '(170 . 95) '(190 . 50)))))))
         (lambda (actual)
           (check-lines? expected actual)))))))

   ))

(run-tests test-all)
