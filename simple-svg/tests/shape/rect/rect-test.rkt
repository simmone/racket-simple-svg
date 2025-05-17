#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path rect_svg "../../../showcase/shapes/rect/rect.svg")
(define-runtime-path rect_y_svg "../../../showcase/shapes/rect/rect_y.svg")
(define-runtime-path rect_radius_svg "../../../showcase/shapes/rect/rect_radius.svg")
(define-runtime-path m_rect_svg "../../../showcase/shapes/rect/m_rect.svg")
(define-runtime-path rect_reuse_svg "../../../showcase/shapes/rect/rect_reuse.svg")

(define test-all
  (test-suite
   "test-rect"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let ([rec_id (svg-def-shape (new-rect 100.00001 100.00001))]
                    [_sstyle (sstyle-new)])
                (set-SSTYLE-fill! _sstyle "#BBC42A")
                (svg-place-widget rec_id #:style _sstyle))))])
      
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
              (let ([rec_id (svg-def-shape (new-rect 100 100))]
                    [_sstyle (sstyle-new)])
                (set-SSTYLE-fill! _sstyle "#BBC42A")
                (svg-place-widget rec_id #:style _sstyle #:at '(50 . 50)))))])
      
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
              (let ([rec_id (svg-def-shape (new-rect 100.0 100.0 #:radius_x 5.0 #:radius_y 10.0))]
                    [_sstyle (sstyle-new)])
                (set-SSTYLE-fill! _sstyle "#BBC42A")
                (svg-place-widget rec_id #:style _sstyle))))])

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
                    [blue_rec_id (svg-def-shape (new-rect 150 150))]
                    [_blue_sstyle (sstyle-new)]
                    [green_rec_id (svg-def-shape (new-rect 100 100))]
                    [_green_sstyle (sstyle-new)]
                    [red_rec_id (svg-def-shape (new-rect 50 50))]
                    [_red_sstyle (sstyle-new)])

                (set-SSTYLE-fill! _blue_sstyle "blue")
                (svg-place-widget blue_rec_id #:style _blue_sstyle)

                (set-SSTYLE-fill! _green_sstyle "green")
                (svg-place-widget green_rec_id #:style _green_sstyle #:at '(25 . 25))

                (set-SSTYLE-fill! _red_sstyle "red")
                (svg-place-widget red_rec_id #:style _red_sstyle #:at '(50 . 50)))))])

      (call-with-input-file m_rect_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-reuse-rect"

    (let ([actual_svg
           (svg-out
            190 190
            (lambda ()
              (let (
                    [rec_id (svg-def-shape (new-rect 50 50))]
                    [rec_sstyle (sstyle-new)])

                (set-SSTYLE-fill! rec_sstyle "blue")

                (svg-place-widget rec_id #:style rec_sstyle #:at '(10 . 10))
                (svg-place-widget rec_id #:style rec_sstyle #:at '(70 . 70))
                (svg-place-widget rec_id #:style rec_sstyle #:at '(130 . 130)))))])

      (call-with-input-file rect_reuse_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all) 
