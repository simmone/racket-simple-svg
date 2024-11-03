#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt"
         "../../main.rkt"
         racket/runtime-path)

(define-runtime-path marker1_svg "../../showcase/marker/marker1.svg")
(define-runtime-path marker2_svg "../../showcase/marker/marker2.svg")
(define-runtime-path marker3_svg "../../showcase/marker/marker3.svg")
(define-runtime-path marker4_svg "../../showcase/marker/marker4.svg")

(define test-all
  (test-suite
   "test-marker"

   (test-case
    "test-marker-normal"

    (let ([actual_svg
           (svg-out
            200 120
            (lambda ()
              (let (
                    [_marker (svg-def-shape (new-marker 'triangle))]
                    [line_id (svg-def-shape (new-line '(0 . 0) '(100 . 0)))]
                    [_sstyle (sstyle-new)]
                    )

                (set-SSTYLE-stroke-width! _sstyle 5)
                (set-SSTYLE-stroke! _sstyle "#000000")
                (svg-place-widget line_id #:at '(50 . 50) #:style _sstyle #:marker_end_id _marker)
                )))])
      
      (call-with-input-file marker1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-marker-all-direction"

    (let ([actual_svg
           (svg-out
            300 300
            (lambda ()
              (let (
                    [_marker (svg-def-shape (new-marker 'triangle))]
                    [line1_id (svg-def-shape (new-line '(0 . 0) '(100 . 0)))]
                    [line2_id (svg-def-shape (new-line '(0 . 0) '(70 . 70)))]
                    [line3_id (svg-def-shape (new-line '(0 . 0) '(0 . 100)))]
                    [line4_id (svg-def-shape (new-line '(0 . 0) '(-70 . 70)))]
                    [line5_id (svg-def-shape (new-line '(0 . 0) '(-100 . 0)))]
                    [line6_id (svg-def-shape (new-line '(0 . 0) '(-70 . -70)))]
                    [line7_id (svg-def-shape (new-line '(0 . 0) '(0 . -100)))]
                    [line8_id (svg-def-shape (new-line '(0 . 0) '(70 . -70)))]
                    [_sstyle (sstyle-new)]
                    )

                (set-SSTYLE-stroke-width! _sstyle 5)
                (set-SSTYLE-stroke! _sstyle "#000000")
                (svg-place-widget line1_id #:at '(180 . 150) #:style _sstyle #:marker_end_id _marker #:marker_start_id _marker)
                (svg-place-widget line2_id #:at '(180 . 180) #:style _sstyle #:marker_end_id _marker #:marker_start_id _marker)
                (svg-place-widget line3_id #:at '(150 . 180) #:style _sstyle #:marker_end_id _marker #:marker_start_id _marker)
                (svg-place-widget line4_id #:at '(120 . 180) #:style _sstyle #:marker_end_id _marker #:marker_start_id _marker)
                (svg-place-widget line5_id #:at '(120 . 150) #:style _sstyle #:marker_end_id _marker #:marker_start_id _marker)
                (svg-place-widget line6_id #:at '(120 . 120) #:style _sstyle #:marker_end_id _marker #:marker_start_id _marker)
                (svg-place-widget line7_id #:at '(150 . 120) #:style _sstyle #:marker_end_id _marker #:marker_start_id _marker)
                (svg-place-widget line8_id #:at '(180 . 120) #:style _sstyle #:marker_end_id _marker #:marker_start_id _marker)
                )))])
      
      (call-with-input-file marker2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-marker-all"

    (let ([actual_svg
           (svg-out
            200 200
            (lambda ()
              (let (
                    [arrow_marker (svg-def-shape (new-marker 'triangle))]
                    [circle_marker (svg-def-shape (new-marker 'circle))]
                    [polyline_id
                     (svg-def-shape
                      (new-polyline '((0 . 0) (0 . 100) (100 . 100))))]
                    [_sstyle (sstyle-new)]
                    )

                (set-SSTYLE-stroke-width! _sstyle 5)
                (set-SSTYLE-stroke! _sstyle "#000000")
                (svg-place-widget polyline_id #:at '(50 . 50) #:style _sstyle #:marker_mid_id circle_marker #:marker_end_id arrow_marker #:marker_start_id arrow_marker)
                )))])
      
      (call-with-input-file marker3_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-marker-curve"

    (let ([actual_svg
           (svg-out
            300 300
            (lambda ()
              (let (
                    [curve1_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(100 . 75))
                         (svg-path-ccurve* '(125 . 50) '(150 . 50) '(175 . 75))
                         )))]
                    [curve1_sstyle (sstyle-new)]
                    [curve2_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(175 . 125))
                         (svg-path-ccurve* '(150 . 150) '(125 . 150) '(100 . 125))
                         )))]
                    [curve2_sstyle (sstyle-new)]
                    [arrow_marker (svg-def-shape (new-marker 'triangle))]
                    )

                (set-SSTYLE-stroke-width! curve1_sstyle 10)
                (set-SSTYLE-stroke! curve1_sstyle "crimson")

                (set-SSTYLE-stroke-width! curve2_sstyle 10)
                (set-SSTYLE-stroke! curve2_sstyle "olivedrab")

                (svg-place-widget curve1_id #:at '(0 . 0) #:style curve1_sstyle #:marker_end_id arrow_marker)
                (svg-place-widget curve2_id #:at '(0 . 0) #:style curve2_sstyle #:marker_end_id arrow_marker)
                )))])
      
      (call-with-input-file marker4_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
