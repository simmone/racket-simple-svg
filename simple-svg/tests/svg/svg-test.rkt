#lang racket

(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
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
            20 20
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
            640 320
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
            100 100
            #:viewBox? '(50 0 100 100)
            (lambda ()
              (let ([rec (svg-def-rect 100 100)]
                    [_sstyle (sstyle-new)])
                (sstyle-set! _sstyle 'fill "#BBC42A")
                (svg-use-shape rec _sstyle)
                (svg-show-default))))])
      
      (call-with-input-file viewBox_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-basic)
