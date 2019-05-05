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

    (call-with-input-file arc_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:canvas? '(1 "red" "white")
             (lambda ()
               (path
                #:stroke-fill? "#ccccff"
                #:stroke-width? 3
                (lambda ()
                  (moveto* '(120 . 35))
                  (arc* '(160 . 75) '(80 . 40) 'left_big '(160 . 75))))

               (path
                #:stroke-fill? "green"
                #:stroke-width? 3
                (lambda ()
                  (moveto* '(120 . 35))
                  (arc* '(160 . 75) '(80 . 40) 'left_small '(160 . 75))))

               (path
                #:stroke-fill? "blue"
                #:stroke-width? 3
                (lambda ()
                  (moveto* '(120 . 35))
                  (arc* '(160 . 75) '(80 . 40) 'right_big '(280 . 80))))

               (path
                #:stroke-fill? "yellow"
                #:stroke-width? 3
                (lambda ()
                  (moveto* '(120 . 35))
                  (arc* '(160 . 75) '(80 . 40) 'right_small '(160 . 75))))

               (circle '(120 . 35) 2 "red")
               (circle '(160 . 75) 2 "red")
               ))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)
