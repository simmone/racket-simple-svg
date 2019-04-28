#lang racket

(require rackunit/text-ui)

(require "../../lib/lib.rkt")

(require rackunit "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path empty_svg "../../showcase/basic/empty.svg")
(define-runtime-path size_svg "../../showcase/basic/size.svg")
(define-runtime-path viewBox_svg "../../showcase/basic/viewBox.svg")

(define test-basic
  (test-suite
   "test-basic"

   (test-case
    "test-empty-svg"

    (call-with-input-file empty_svg
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
             #:width? 640
             #:height? 320
             #:stroke-width? 1
             output
             (lambda ()
               (void)))))
         (lambda (actual)
           (check-lines? expected actual))))))

   (test-case
    "test-size-svg"

    (call-with-input-file viewBox_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:stroke-width? 1
             #:viewBoxX? 60
             #:viewBoxY? 0
             #:viewBoxWidth? 120
             #:viewBoxHeight? 120
             (lambda ()
               (rect 100 100 "#BBC42A")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-basic)
