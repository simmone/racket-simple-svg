#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt"
         "../../main.rkt"
         racket/runtime-path)

(define-runtime-path group1_svg "../../showcase/group/group1.svg")
(define-runtime-path group2_svg "../../showcase/group/group2.svg")
(define-runtime-path group3_svg "../../showcase/group/group3.svg")

(define test-all
  (test-suite
   "test-group"

   (test-case
    "test-basic"

    (let ([actual_svg
           (svg-out
            220 280
            (lambda ()
              (let (
                    [line1_id (svg-def-shape (new-line '(0 . 0) '(30 . 30)))]
                    [line2_id (svg-def-shape (new-line '(0 . 15) '(30 . 15)))]
                    [line3_id (svg-def-shape (new-line '(15 . 0) '(15 . 30)))]
                    [line4_id (svg-def-shape (new-line '(30 . 0) '(0 . 30)))]
                    [_sstyle (sstyle-new)]
                    [group_sstyle (sstyle-new)])

                (set-SSTYLE-stroke-width! _sstyle 5)
                (set-SSTYLE-stroke! _sstyle "#765373")
                (let ([pattern_id 
                       (svg-def-group
                        (lambda ()
                          (svg-place-widget line1_id #:style _sstyle #:at '(5 . 5))
                          (svg-place-widget line2_id #:style _sstyle #:at '(5 . 5))
                          (svg-place-widget line3_id #:style _sstyle #:at '(5 . 5))
                          (svg-place-widget line4_id #:style _sstyle #:at '(5 . 5))))])

                  (svg-place-widget pattern_id #:at '(50 . 50))
                  (svg-place-widget pattern_id #:at '(100 . 100))
                  (svg-place-widget pattern_id #:at '(80 . 200))
                  (svg-place-widget pattern_id #:at '(150 . 100))))))])
      
      (call-with-input-file group1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-pattern"

    (let ([actual_svg
           (svg-out
            100 100
            (lambda ()
              (let (
                    [rect_id (svg-def-shape (new-rect 50 50))]
                    [line1_id (svg-def-shape (new-line '(10 . 0) '(0 . 50)))]
                    [line2_id (svg-def-shape (new-line '(0 . 0) '(10 . 50)))]
                    [rect_sstyle (sstyle-new)]
                    [line_sstyle (sstyle-new)]
                    [cross_line_id #f]
                    [pattern_id #f]
                    )

                (set-SSTYLE-stroke-width! line_sstyle 1)
                (set-SSTYLE-stroke! line_sstyle "black")
                (set! cross_line_id
                      (svg-def-group
                       (lambda ()
                         (svg-place-widget line1_id #:style line_sstyle)
                         (svg-place-widget line2_id #:style line_sstyle)
                         )))

                (set-SSTYLE-stroke-width! rect_sstyle 2)
                (set-SSTYLE-stroke! rect_sstyle "red")
                (set-SSTYLE-fill! rect_sstyle "orange")
                (set! pattern_id
                      (svg-def-group
                       (lambda ()
                         (svg-place-widget rect_id #:style rect_sstyle)
                         (svg-place-widget cross_line_id #:at '(0 . 0))
                         (svg-place-widget cross_line_id #:at '(10 . 0))
                         (svg-place-widget cross_line_id #:at '(20 . 0))
                         (svg-place-widget cross_line_id #:at '(30 . 0))
                         (svg-place-widget cross_line_id #:at '(40 . 0)))))

                (svg-place-widget pattern_id #:at '(0 . 0))
                (svg-place-widget pattern_id #:at '(50 . 0))
                (svg-place-widget pattern_id #:at '(0 . 50))
                (svg-place-widget pattern_id #:at '(50 . 50))
                )))])
      
      (call-with-input-file group2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-five-circles-pattern"

    (let ([actual_svg
           (svg-out
            1000 600
            (lambda ()
              (define pattern_id
                (svg-def-group
                 (lambda ()
                   (let ([circle1_sstyle (sstyle-new)]
                         [circle2_sstyle (sstyle-new)]
                         [circle3_sstyle (sstyle-new)]
                         [circle4_sstyle (sstyle-new)]
                         [circle5_sstyle (sstyle-new)]
                         [circle_id (svg-def-shape (new-circle 60))])

                     (set-SSTYLE-stroke! circle1_sstyle "rgb(11, 112, 191)")
                     (set-SSTYLE-stroke! circle2_sstyle "rgb(240, 183, 0)")
                     (set-SSTYLE-stroke! circle3_sstyle "rgb(0, 0, 0)")
                     (set-SSTYLE-stroke! circle4_sstyle "rgb(13, 146, 38)")
                     (set-SSTYLE-stroke! circle5_sstyle "rgb(214, 0, 23)")

                     (svg-place-widget circle_id #:style circle1_sstyle #:at '(120 . 120))
                     (svg-place-widget circle_id #:style circle2_sstyle #:at '(180 . 180))
                     (svg-place-widget circle_id #:style circle3_sstyle #:at '(260 . 120))
                     (svg-place-widget circle_id #:style circle4_sstyle #:at '(320 . 180))
                     (svg-place-widget circle_id #:style circle5_sstyle #:at '(400 . 120))
                     ))))

              (let ([group_style (sstyle-new)]
                    [filter_id (svg-def-shape (new-blur-dropdown))])
                (set-SSTYLE-stroke-width! group_style 12)

                (svg-place-widget pattern_id #:style group_style #:filter_id filter_id #:at '(0 . 0))
                (svg-place-widget pattern_id #:style group_style #:filter_id filter_id #:at '(0 . 300))
                (svg-place-widget pattern_id #:style group_style #:filter_id filter_id #:at '(500 . 0))
                (svg-place-widget pattern_id #:style group_style #:filter_id filter_id #:at '(500 . 300)))
              ))])

      (call-with-input-file group3_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
