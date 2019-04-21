#lang racket

(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require rackunit "../../../shapes/rect.rkt")

(require racket/runtime-path)
(define-runtime-path rect_file "rect.dat")
(define-runtime-path rect_y_file "rect_y.dat")

(define test-all
  (test-suite
   "test-rect"

   (test-case
    "test-basic"

    (call-with-input-file rect_file
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             (lambda ()
               (rect 100 100 "#000000")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   (test-case
    "test-rect-y"

    (call-with-input-file rect_y_file
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             (lambda ()
               (rect 100 100 "#000000" #:y 50)))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
