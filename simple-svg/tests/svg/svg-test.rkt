
#lang racket

(require rackunit/text-ui)

(require "../../lib/lib.rkt")

(require rackunit "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path empty_file "empty-svg.dat")
(define-runtime-path size_file "size-svg.dat")

(define test-basic
  (test-suite
   "test-basic"

   (test-case
    "test-empty-svg"

    (call-with-input-file empty_file
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

    (call-with-input-file size_file
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
