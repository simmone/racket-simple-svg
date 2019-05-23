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
                    [red_dot (svg-circle-def 5)]
                    )

                (svg-use arc1 #:stroke? "#ccccff" #:stroke-width? 3)
                (svg-use arc2 #:stroke? "green" #:stroke-width? 3)
                (svg-use arc3 #:stroke? "blue" #:stroke-width? 3)
                (svg-use arc4 #:stroke? "yellow" #:stroke-width? 3)

                (svg-use red_dot #:at? '(130 . 45) #:fill? "red")
                (svg-use red_dot #:at? '(170 . 85) #:fill? "red")

                (svg-show-default))))])
      
      (call-with-input-file arc_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
