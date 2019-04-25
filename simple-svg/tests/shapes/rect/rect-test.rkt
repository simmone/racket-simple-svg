#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(define test-all
  (test-suite
   "test-rect"

   (test-case
    "test-basic"

    (call-with-input-file "../../../showcase/shapes/rect/rect.svg"
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:stroke-width? 1
             (lambda ()
               (rect 100 100 "#BBC42A")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   (test-case
    "test-rect-y"

    (call-with-input-file "../../../showcase/shapes/rect/rect_y.svg"
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:stroke-width? 1
             (lambda ()
               (rect 100 100 "#BBC42A" #:start_point '(50 . 50))))))
         (lambda (actual)
           (check-lines? expected actual))))))

   (test-case
    "test-rect-radius"

    (call-with-input-file "../../../showcase/shapes/rect/rect_radius.svg"
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:stroke-width? 1
             (lambda ()
               (rect 100 100 "#BBC42A" #:start_point '(50 . 50) #:radius '(5 . 10))))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
