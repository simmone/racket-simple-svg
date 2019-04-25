#lang racket

(require rackunit/text-ui)

(require "../../lib/lib.rkt")

(require rackunit "../../main.rkt")

(define test-basic
  (test-suite
   "test-basic"

   (test-case
    "test-empty-svg"

    (call-with-input-file "../../showcase/basic/empty.svg"
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

    (call-with-input-file "../../showcase/basic/size.svg"
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             #:width? 640
             #:height? 320
             #:stroke-width? 1
             output
             (lambda ()
               (void)))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-basic)
