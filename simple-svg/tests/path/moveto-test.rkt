#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt"
         "../../main.rkt"
         racket/runtime-path)

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
              (let ([path_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto* '(20 . 60)))))]
                    [red_dot_id (svg-def-shape (new-circle 5))]
                    [sstyle_path (sstyle-new)]
                    [sstyle_red_dot (sstyle-new)])
                
                (set-SSTYLE-stroke-width! sstyle_path 1)
                (set-SSTYLE-stroke! sstyle_path "#7AA20D")
                (svg-place-widget path_id #:style sstyle_path)

                (set-SSTYLE-fill! sstyle_red_dot "red")
                (svg-place-widget red_dot_id #:style sstyle_red_dot #:at '(20 . 60)))))])
      
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
              (let ([path_id
                     (svg-def-shape
                      (new-path
                       (lambda ()
                         (svg-path-moveto '(20 . 60)))))]
                    [red_dot_id (svg-def-shape (new-circle 5))]
                    [sstyle_path (sstyle-new)]
                    [sstyle_red_dot (sstyle-new)])

                (set-SSTYLE-stroke-width! sstyle_path 1)
                (set-SSTYLE-stroke! sstyle_path "#7AA20D")
                (svg-place-widget path_id #:style sstyle_path)

                (set-SSTYLE-fill! sstyle_red_dot "red")
                (svg-place-widget red_dot_id #:style sstyle_red_dot #:at '(20 . 60)))))])

      (call-with-input-file moveto2_svg
        (lambda (expected)
          (call-with-input-string
           actual_svg
           (lambda (actual)
             (check-lines? expected actual)))))))

   ))

(run-tests test-all)
