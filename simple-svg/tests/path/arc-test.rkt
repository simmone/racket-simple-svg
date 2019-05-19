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
            #:canvas? '(1 "red" "white")
            (lambda ()
              (let (
                    [arc1
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(120 . 35))
                        (svg-path-arc* '(160 . 75) '(80 . 40) 'left_big '(160 . 75))))]
                    [arc2
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(120 . 35))
                        (svg-path-arc* '(160 . 75) '(80 . 40) 'left_small '(160 . 75))))]
                    [arc3
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(120 . 35))
                        (svg-path-arc* '(160 . 75) '(80 . 40) 'right_big '(280 . 110))))]
                    [arc4
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(120 . 35))
                        (svg-path-arc* '(160 . 75) '(80 . 40) 'right_small '(160 . 75))))]
                    [red_dot (svg-circle-def 2)]
                    )

                (svg-use arc1 #:stroke? "#ccccff" #:stroke-width? 3)
                (svg-use arc2 #:stroke? "green" #:stroke-width? 3)
                (svg-use arc3 #:stroke? "blue" #:stroke-width? 3)
                (svg-use arc4 #:stroke? "yellow" #:stroke-width? 3)

                (svg-use red_dot #:at? '(120 . 35) #:fill? "red")
                (svg-use red_dot #:at? '(160 . 75) #:fill? "red")

                (svg-show-default))))])

    (call-with-input-file arc_svg
      (lambda (expected)
        (call-with-input-string
         actual_svg
         (lambda (actual)
           (check-lines? expected actual)))))))

   ))

(run-tests test-all)
