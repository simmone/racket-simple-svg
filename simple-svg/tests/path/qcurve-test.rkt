#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../lib/lib.rkt")
(require "../../main.rkt")

(require racket/runtime-path)
(define-runtime-path qcurve1_svg "../../showcase/path/qcurve1.svg")
(define-runtime-path qcurve2_svg "../../showcase/path/qcurve2.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-qcurve*"

    (let ([actual_svg
           (svg-out
            #:canvas? '(1 "red" "white")
            (lambda ()
              (let ([path
                     (svg-path-def
                      200 100
                      (lambda ()
                        (svg-path-moveto* '(0 . 50))
                        (svg-path-qcurve* '(50 . 0) '(100 . 50))
                        (svg-path-qcurve* '(150 . 100) '(200 . 50))))]
                    [red_dot (svg-circle-def 2)])

                (svg-use path
                         #:fill? "white"
                         #:stroke? "#333333"
                         #:stroke-width? 3)

                (svg-use red_dot #:at? '(0 . 50) #:fill? "red")
                (svg-use red_dot #:at? '(50 . 0) #:fill? "red")
                (svg-use red_dot #:at? '(100 . 50) #:fill? "red")
                (svg-use red_dot #:at? '(150 . 100) #:fill? "red")
                (svg-use red_dot #:at? '(200 . 50) #:fill? "red")

                (svg-show-default))))])
      
      (call-with-input-file qcurve1_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   (test-case
    "test-qcurve"

    (let ([actual_svg
           (svg-out
            #:canvas? '(1 "red" "white")
            (lambda ()
              (let ([path
                     (svg-path-def
                      200 100
                      (lambda ()
                        (svg-path-moveto* '(0 . 50))
                        (svg-path-qcurve '(50 . -50) '(100 . 0))
                        (svg-path-qcurve '(50 . 50) '(100 . 0))
                        ))]
                    [red_dot (svg-circle-def 2)])

                (svg-use path
                         #:fill? "white"
                         #:stroke? "#333333"
                         #:stroke-width? 3)

                (svg-use red_dot #:at? '(0 . 50) #:fill? "red")
                (svg-use red_dot #:at? '(50 . 0) #:fill? "red")
                (svg-use red_dot #:at? '(100 . 50) #:fill? "red")
                (svg-use red_dot #:at? '(150 . 100) #:fill? "red")
                (svg-use red_dot #:at? '(200 . 50) #:fill? "red")

                (svg-show-default))))])
      
      (call-with-input-file qcurve2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
