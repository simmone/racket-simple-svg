#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path ccurve1_svg "../../showcase/path/ccurve1.svg")
(define-runtime-path ccurve2_svg "../../showcase/path/ccurve2.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-ccurve*"

    (let ([actual_svg
           (svg-out
            200 120
            (lambda ()
              (let ([path
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(10 . 60))
                        (svg-path-ccurve* '(30 . 15) '(80 . 15) '(100 . 60))
                        (svg-path-ccurve* '(120 . 105) '(170 . 105) '(190 . 60))
                        ))]
                    [red_dot (svg-circle-def 5)])

                (svg-use path
                         #:stroke? "#333333"
                         #:stroke-width? 3)

                (svg-use red_dot #:at? '(10 . 60) #:fill? "red")
                (svg-use red_dot #:at? '(30 . 15) #:fill? "red")
                (svg-use red_dot #:at? '(80 . 15) #:fill? "red")
                (svg-use red_dot #:at? '(100 . 60) #:fill? "red")
                (svg-use red_dot #:at? '(120 . 105) #:fill? "red")
                (svg-use red_dot #:at? '(170 . 105) #:fill? "red")
                (svg-use red_dot #:at? '(190 . 60) #:fill? "red")

                (svg-show-default))))])
      
      (call-with-input-file ccurve1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-ccurve"

    (let ([actual_svg
           (svg-out
            200 120
            (lambda ()
              (let ([path
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(10 . 60))
                        (svg-path-ccurve '(20 . -45) '(70 . -45) '(90 . 0))
                        (svg-path-ccurve '(20 . 45) '(70 . 45) '(90 . 0))
                        ))]
                    [red_dot (svg-circle-def 5)])

                (svg-use path
                         #:stroke? "#333333"
                         #:stroke-width? 3)

                (svg-use red_dot #:at? '(10 . 60) #:fill? "red")
                (svg-use red_dot #:at? '(30 . 15) #:fill? "red")
                (svg-use red_dot #:at? '(80 . 15) #:fill? "red")
                (svg-use red_dot #:at? '(100 . 60) #:fill? "red")
                (svg-use red_dot #:at? '(120 . 105) #:fill? "red")
                (svg-use red_dot #:at? '(170 . 105) #:fill? "red")
                (svg-use red_dot #:at? '(190 . 60) #:fill? "red")

                (svg-show-default))))])
      
      (call-with-input-file ccurve2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
