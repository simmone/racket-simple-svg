#lang racket

(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
(require rackunit "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path empty_svg "../../showcase/basic/empty.svg")
(define-runtime-path background_svg "../../showcase/basic/background.svg")
(define-runtime-path rect_svg "../../showcase/shapes/rect/rect.svg")
(define-runtime-path rect_in_background_svg "../../showcase/basic/rect_in_background.svg")
(define-runtime-path viewBox_svg "../../showcase/basic/viewBox.svg")

(define test-basic
  (test-suite
   "test-basic"

   (test-case
    "test-empty-svg"

    (let ([svg_str
           (svg-out
            20 20
            (lambda ()
              (void)))])

      (call-with-input-file empty_svg
        (lambda (expected)
          (call-with-input-string
           svg_str
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-background"

    (let ([svg_str
           (svg-out
            100 100
            #:background "#BBC42A"
            (lambda ()
              (void)))])
      
      (call-with-input-file background_svg
        (lambda (expected)
          (call-with-input-string
           svg_str
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-basic"

    (let ([svg_str
           (svg-out
            100 100
            (lambda ()
              (let ([rec_id (svg-def-shape (new-rect 100 100))]
                    [_sstyle (sstyle-new)])
                (set-SSTYLE-fill! _sstyle "#BBC42A")
                (svg-place-widget rec_id #:style _sstyle))))])

      (call-with-input-file rect_svg
        (lambda (expected)
          (call-with-input-string
           svg_str
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-rect-in-background"

    (let ([svg_str
           (svg-out
            100 100
            #:background "#BBC42A"
            (lambda ()
              (let ([rec_id (svg-def-shape (new-rect 50 50))]
                    [_sstyle (sstyle-new)])
                (set-SSTYLE-fill! _sstyle "#FFFFFF")
                (svg-place-widget rec_id #:style _sstyle #:at '(25 . 25)))))])

      (call-with-input-file rect_in_background_svg
        (lambda (expected)
          (call-with-input-string
           svg_str
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-viewbox-svg"

    (let ([svg_str
           (svg-out
            100 100
            #:viewBox (new-view-box 50 0 100 100)
            (lambda ()
              (let ([rec_id (svg-def-shape (new-rect 100 100))]
                    [_sstyle (sstyle-new)])
                (set-SSTYLE-fill! _sstyle "#BBC42A")
                (svg-place-widget rec_id #:style _sstyle))))])

      (call-with-input-file viewBox_svg
        (lambda (expected)
          (call-with-input-string
           svg_str
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-basic)
