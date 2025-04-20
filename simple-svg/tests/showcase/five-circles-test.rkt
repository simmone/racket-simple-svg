#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt"
         "../../main.rkt"
         racket/runtime-path)

(define-runtime-path five_circles_svg "../../showcase/example/five_circles.svg")

(define test-five-circles
  (test-suite
   "test-five-circles"

   (test-case
    "test-five-circles"

    (let ([svg_str
           (svg-out
            500 300
            (lambda ()
              (let ([circle1_sstyle (sstyle-new)]
                    [circle2_sstyle (sstyle-new)]
                    [circle3_sstyle (sstyle-new)]
                    [circle4_sstyle (sstyle-new)]
                    [circle5_sstyle (sstyle-new)]
                    [circle_id (svg-def-shape (new-circle 60))]
                    [filter_id (svg-def-shape (new-blur-dropdown))]
                    )

                (set-SSTYLE-stroke! circle1_sstyle "rgb(11, 112, 191)")
                (set-SSTYLE-stroke-width! circle1_sstyle 12)

                (set-SSTYLE-stroke! circle2_sstyle "rgb(240, 183, 0)")
                (set-SSTYLE-stroke-width! circle2_sstyle 12)

                (set-SSTYLE-stroke! circle3_sstyle "rgb(0, 0, 0)")
                (set-SSTYLE-stroke-width! circle3_sstyle 12)

                (set-SSTYLE-stroke! circle4_sstyle "rgb(13, 146, 38)")
                (set-SSTYLE-stroke-width! circle4_sstyle 12)

                (set-SSTYLE-stroke! circle5_sstyle "rgb(214, 0, 23)")
                (set-SSTYLE-stroke-width! circle5_sstyle 12)

                (svg-place-widget circle_id #:style circle1_sstyle #:at '(120 . 120) #:filter_id filter_id)
                (svg-place-widget circle_id #:style circle2_sstyle #:at '(180 . 180) #:filter_id filter_id)
                (svg-place-widget circle_id #:style circle3_sstyle #:at '(260 . 120) #:filter_id filter_id)
                (svg-place-widget circle_id #:style circle4_sstyle #:at '(320 . 180) #:filter_id filter_id)
                (svg-place-widget circle_id #:style circle5_sstyle #:at '(400 . 120) #:filter_id filter_id))))])

      (call-with-input-file five_circles_svg
        (lambda (expected)
          (call-with-input-string
           svg_str
           (lambda (actual)
             (check-lines? expected actual)))))))
   ))

(run-tests test-five-circles)
