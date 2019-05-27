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
            30 70
            (lambda ()
              (let ([path
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto* '(20 . 60))))]
                    [red_dot (svg-circle-def 5)]
                    [svgview_path (new-svgview)]
                    [svgview_red_dot (new-svgview)])
                
                (set-svgview-stroke-width! svgview_path 1)
                (set-svgview-stroke! svgview_path "#7AA20D")
                (svg-use-shape path svgview_path)

                (set-svgview-pos! svgview_red_dot '(20 . 60))
                (set-svgview-fill! svgview_red_dot "red")
                (svg-use-shape red_dot svgview_red_dot)

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
                     (svg-path-def
                      (lambda ()
                        (svg-path-moveto '(20 . 60))))]
                    [red_dot (svg-circle-def 5)]
                    [svgview_path (new-svgview)]
                    [svgview_red_dot (new-svgview)])
                
                (set-svgview-stroke-width! svgview_path 1)
                (set-svgview-stroke! svgview_path "#7AA20D")
                (svg-use-shape path svgview_path)

                (set-svgview-pos! svgview_red_dot '(20 . 60))
                (set-svgview-fill! svgview_red_dot "red")
                (svg-use-shape red_dot svgview_red_dot)

                (svg-show-default))))])
      
      (call-with-input-file moveto2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
