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
              (let ([rec (svg-rect-def 100 100)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#BBC42A")
                (svg-use-shape rec _sstyle)
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
              (let ([rec (svg-rect-def 100 100)]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#BBC42A")
                (svg-use-shape rec _sstyle #:at? '(50 . 50))
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
              (let ([rec (svg-rect-def 100 100 #:radius? '(5 . 10))]
                    [_sstyle (sstyle-new)])
                (set-sstyle-fill! _sstyle "#BBC42A")
                (svg-use-shape rec _sstyle)
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
                    [_blue_sstyle (sstyle-new)]
                    [green_rec (svg-rect-def 100 100)]
                    [_green_sstyle (sstyle-new)]
                    [red_rec (svg-rect-def 50 50)]
                    [_red_sstyle (sstyle-new)])

                (set-sstyle-fill! _blue_sstyle "blue")
                (svg-use-shape blue_rec _blue_sstyle)

                (set-sstyle-fill! _green_sstyle "green")
                (svg-use-shape green_rec _green_sstyle #:at? '(25 . 25))

                (set-sstyle-fill! _red_sstyle "red")
                (svg-use-shape red_rec _red_sstyle #:at? '(50 . 50))

                (svg-show-default))))])

      (call-with-input-file m_rect_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all) 
