#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path rect_svg "../../../showcase/shapes/rect/rect.svg")
(define-runtime-path rect_y_svg "../../../showcase/shapes/rect/rect_y.svg")
(define-runtime-path rect_radius_svg "../../../showcase/shapes/rect/rect_radius.svg")
(define-runtime-path m_rect_svg "../../../showcase/shapes/rect/m_rect.svg")

(define test-all
  (test-suite
   "test-rect"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([rec (svg-rect-def 100 100)])
                (svg-use rec #:fill? "#BBC42A")
                (svg-show-default))))])
      
      (call-with-input-file rect_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-rect-y"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([rec (svg-rect-def 100 100)])
                (svg-use rec #:fill? "#BBC42A" #:at? '(50 . 50))
                (svg-show-default))))])

      (call-with-input-file rect_y_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-rect-radius"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([rec (svg-rect-def 100 100 #:radius? '(5 . 10))])
                (svg-use rec #:fill? "#BBC42A")
                (svg-show-default))))])

      (call-with-input-file rect_radius_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-multiple_rect"

    (let ([actual_svg
           (svg-out
            150 150
            (lambda ()
              (let (
                    [blue_rec (svg-rect-def 150 150)]
                    [green_rec (svg-rect-def 100 100)]
                    [red_rec (svg-rect-def 50 50)]
                    )
                (svg-use blue_rec #:fill? "blue")
                (svg-use green_rec #:fill? "green" #:at? '(25 . 25))
                (svg-use red_rec #:fill? "red" #:at? '(50 . 50))
                (svg-show-default))))])

      (call-with-input-file m_rect_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all) 
