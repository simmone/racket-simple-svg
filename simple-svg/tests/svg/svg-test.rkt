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

    (let ([actual_svg
           (svg-out
            (lambda ()
              (void)))])

      (call-with-input-file empty_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-size-svg"

    (let ([actual_svg
           (svg-out
            #:width? 640
            #:height? 320
            #:canvas? '(1 "red" "white")
            (lambda ()
              (void)))])
      
      (call-with-input-file size_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-viewbox-svg"

    (let ([actual_svg
           (svg-out
            #:canvas? '(1 "red" "white")
            #:viewBox? '(60 0 120 120)
            (lambda ()
              (let ([rec (svg-rect-def 100 100)])
                (svg-use rec #:fill? "#BBC42A")
                (svg-show-default))))])

      (call-with-input-file viewBox_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-basic)
