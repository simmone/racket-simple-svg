#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path arc_svg "../../showcase/path/arc.svg")

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
                    [arc1
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(130 . 45))
                        (svg-path-arc* '(170 . 85) '(80 . 40) 'left_big)))]
                    [arc2
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(130 . 45))
                        (svg-path-arc* '(170 . 85) '(80 . 40) 'left_small)))]
                    [arc3
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(130 . 45))
                        (svg-path-arc* '(170 . 85) '(80 . 40) 'right_big)))]
                    [arc4
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(130 . 45))
                        (svg-path-arc* '(170 . 85) '(80 . 40) 'right_small)))]
                    [arc_style (new-sstyle)]
                    [red_dot (svg-circle-def 5)]
                    [dot_style (new-sstyle)]
                    )

                (set-sstyle-stroke-width! arc_style 3)
                
                (let ([_arc_style (sstyle-clone arc_style)])
                  (set-sstyle-stroke! _arc_style "#ccccff")
                  (svg-use-shape arc1 _arc_style))

                (let ([_arc_style (sstyle-clone arc_style)])
                  (set-sstyle-stroke! _arc_style "green")
                  (svg-use-shape arc2 _arc_style))

                (let ([_arc_style (sstyle-clone arc_style)])
                  (set-sstyle-stroke! _arc_style "blue")
                  (svg-use-shape arc3 _arc_style))

                (let ([_arc_style (sstyle-clone arc_style)])
                  (set-sstyle-stroke! _arc_style "yellow")
                  (svg-use-shape arc4 _arc_style))

                (set-sstyle-fill! dot_style "red")
                (svg-use-shape red_dot dot_style #:at? '(130 . 45))
                (svg-use-shape red_dot dot_style #:at? '(170 . 85))

                (svg-show-default))))])
      
      (call-with-input-file arc_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
