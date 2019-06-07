#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../src/lib/lib.rkt")
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
            30 70
            (lambda ()
              (let ([path
                     (svg-def-path
                      (lambda ()
                        (svg-path-moveto* '(20 . 60))))]
                    [red_dot (svg-def-circle 5)]
                    [sstyle_path (sstyle-new)]
                    [sstyle_red_dot (sstyle-new)])
                
                (sstyle-set! sstyle_path 'stroke-width 1)
                (sstyle-set! sstyle_path 'stroke "#7AA20D")
                (svg-use-shape path sstyle_path)

                (sstyle-set! sstyle_red_dot 'fill "red")
                (svg-use-shape red_dot sstyle_red_dot #:at? '(20 . 60))

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
            30 70
            (lambda ()
              (let ([path
                     (svg-def-path
                      (lambda ()
                        (svg-path-moveto '(20 . 60))))]
                    [red_dot (svg-def-circle 5)]
                    [sstyle_path (sstyle-new)]
                    [sstyle_red_dot (sstyle-new)])

                (sstyle-set! sstyle_path 'stroke-width 1)
                (sstyle-set! sstyle_path 'stroke "#7AA20D")
                (svg-use-shape path sstyle_path)

                (sstyle-set! sstyle_red_dot 'fill "red")
                (svg-use-shape red_dot sstyle_red_dot #:at? '(20 . 60))

                (svg-show-default))))])
      
      (call-with-input-file moveto2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
