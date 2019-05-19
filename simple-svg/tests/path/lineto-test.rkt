#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path lineto_svg "../../showcase/path/lineto.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-lineto"

    (let ([actual_svg
           (svg-out
            #:canvas? '(1 "red" "white")
            (lambda ()
              (let ([path
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(10 . 10))
                        (svg-path-lineto '(100 . 100))
                        (svg-path-hlineto '(-100 . 0))
                        (svg-path-lineto '(100 . -100))
                        (svg-path-close)))]
                    [red_dot (svg-circle-def 2)])

                (svg-use path
                         #:fill? "white"
                         #:stroke-width? 1
                         #:stroke? "#7AA20D"
                         #:stroke-linejoin? 'round)

                (svg-use red_dot #:at? '(10 . 10) #:fill? "red")
                (svg-use red_dot #:at? '(110 . 110) #:fill? "red")
                (svg-use red_dot #:at? '(10 . 110) #:fill? "red")
                (svg-use red_dot #:at? '(110 . 10) #:fill? "red")

                (svg-show-default))))])
      
      (call-with-input-file lineto_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
