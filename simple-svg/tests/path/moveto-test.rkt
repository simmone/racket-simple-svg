#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path moveto1_svg "../../showcase/path/moveto1.svg")
(define-runtime-path moveto2_svg "../../showcase/path/moveto2.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-moveto*"

    (let ([actual_svg
           (svg-out
            #:canvas? '(1 "red" "white")
            (lambda ()
              (let ([path
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(20 . 60))))]
                    [red_dot (svg-circle-def 2)])

                (svg-use path
                         #:fill? "white"
                         #:stroke-width? 1
                         #:stroke? "#7AA20D"
                         #:stroke-linejoin? 'round)

                (svg-use red_dot #:at? '(20 . 60) #:fill? "red")

                (svg-show-default))))])
      
      (call-with-input-file moveto1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-moveto"

    (let ([actual_svg
           (svg-out
            #:canvas? '(1 "red" "white")
            (lambda ()
              (let ([path
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto '(20 . 60))))]
                    [red_dot (svg-circle-def 2)])

                (svg-use path
                         #:fill? "white"
                         #:stroke-width? 1
                         #:stroke? "#7AA20D"
                         #:stroke-linejoin? 'round)

                (svg-use red_dot #:at? '(20 . 60) #:fill? "red")

                (svg-show-default))))])
      
      (call-with-input-file moveto2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
