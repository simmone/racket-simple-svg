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

    (call-with-input-file rect_svg
      (lambda (expected)
        (call-with-input-string
         (svg-out
          #:canvas? '(1 "red" "white")
          (lambda ()
            (let ([rec (svg-rect-def 100 100)])
              (svg-set-property rec 'fill "#BBC42A")
              (svg-use rec #:at '(0 . 0))
              (svg-show-default))))
         (lambda (actual)
           (check-lines? expected actual))))))

;   (test-case
;    "test-rect-y"
;
;    (call-with-input-file rect_y_svg
;      (lambda (expected)
;        (call-with-input-string
;         (call-with-output-string
;          (lambda (output)
;            (with-output-to-svg
;             output
;             #:padding? 0
;             #:canvas? '(1 "red" "white")
;             (lambda ()
;               (rect 100 100 "#BBC42A" #:start_point? '(50 . 50))))))
;         (lambda (actual)
;           (check-lines? expected actual))))))
;
;   (test-case
;    "test-rect-radius"
;
;    (call-with-input-file rect_radius_svg
;      (lambda (expected)
;        (call-with-input-string
;         (call-with-output-string
;          (lambda (output)
;            (with-output-to-svg
;             output
;             #:canvas? '(1 "red" "white")
;             (lambda ()
;               (rect 100 100 "#BBC42A" #:radius? '(5 . 10))))))
;         (lambda (actual)
;           (check-lines? expected actual))))))
;
;   (test-case
;    "test-multiple_rect"
;
;    (call-with-input-file m_rect_svg
;      (lambda (expected)
;        (call-with-input-string
;         (call-with-output-string
;          (lambda (output)
;            (with-output-to-svg
;             output
;             #:canvas? '(1 "red" "white")
;             (lambda ()
;               (rect 150 150 "blue")
;               (rect 100 100 "green")
;               (rect 50 50 "red")
;               ))))
;         (lambda (actual)
;           (check-lines? expected actual))))))

   ))

(run-tests test-all) 
