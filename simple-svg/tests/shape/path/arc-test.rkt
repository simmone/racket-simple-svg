#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib.rkt"
         "../../../main.rkt"
         racket/runtime-path)

(define-runtime-path arc_svg "../../../showcase/path/arc.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-arc"

    (let ([actual_svg
           (svg-out
            300 130
            (lambda ()
              (let (
                    [arc1_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(130.00001 . 45.00001))
                         (svg-path-arc* '(170.00001 . 85.00001) '(80.00001 . 40.00001) 'left_big))))]
                    [arc2_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(130 . 45))
                         (svg-path-arc* '(170 . 85) '(80 . 40) 'left_small))))]
                    [arc3_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(130 . 45))
                         (svg-path-arc* '(170 . 85) '(80 . 40) 'right_big))))]
                    [arc4_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(130 . 45))
                         (svg-path-arc* '(170 . 85) '(80 . 40) 'right_small))))]
                    [arc_style (sstyle-new)]
                    [red_dot_id (svg-def-shape (new-circle 5))]
                    [dot_style (sstyle-new)]
                    )

                (set-SSTYLE-stroke-width! arc_style 3)
                (set-SSTYLE-fill! arc_style "none")
                
                (let ([_arc_style (struct-copy SSTYLE arc_style)])
                  (set-SSTYLE-stroke! _arc_style "#ccccff")
                  (svg-place-widget arc1_id #:style _arc_style))

                (let ([_arc_style (struct-copy SSTYLE arc_style)])
                  (set-SSTYLE-stroke! _arc_style "green")
                  (svg-place-widget arc2_id #:style _arc_style))

                (let ([_arc_style (struct-copy SSTYLE arc_style)])
                  (set-SSTYLE-stroke! _arc_style "blue")
                  (svg-place-widget arc3_id #:style _arc_style))

                (let ([_arc_style (struct-copy SSTYLE arc_style)])
                  (set-SSTYLE-stroke! _arc_style "yellow")
                  (svg-place-widget arc4_id #:style _arc_style))

                (set-SSTYLE-fill! dot_style "red")
                (svg-place-widget red_dot_id #:style dot_style #:at '(130 . 45))
                (svg-place-widget red_dot_id #:style dot_style #:at '(170 . 85)))))])

      (call-with-input-file arc_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
