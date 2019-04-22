#lang racket

(require rackunit/text-ui)

(require "../../lib/lib.rkt")

(require rackunit "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path emty_svg "empty.svg")
(define-runtime-path size_svg "size.svg")

(define test-basic
  (test-suite
   "test-basic"

   (test-case
    "test-empty-svg"

    (call-with-input-file emty_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             (lambda ()
               (void)))))
         (lambda (actual)
           (check-lines? expected actual))))))

   (test-case
    "test-size-svg"

    (call-with-input-file size_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             #:width 640
             #:height 320
             output
             (lambda ()
               (void)))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-basic)
