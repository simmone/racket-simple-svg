#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "../../../lib/lib.rkt")
(require "../../../main.rkt")

(require racket/runtime-path)
(define-runtime-path path_svg "../../../showcase/shapes/path/path.svg")

(define test-all
  (test-suite
   "test-path"

   (test-case
    "test-basic"

    (call-with-input-file path_svg
      (lambda (expected)
        (call-with-input-string
         (call-with-output-string
          (lambda (output)
            (with-output-to-svg
             output
             #:canvas? '(1 "red" "white")
             (lambda ()
               (path
                "M248.761,92c0,9.801-7.93,17.731-17.71,17.731c-0.319,0-0.617,0-0.935-0.021c-10.035,
                 37.291-51.174,65.206-100.414,65.206 c-49.261,0-90.443-27.979-100.435-65.334c-0.765,
                 0.106-1.531,0.149-2.317,0.149c-9.78,0-17.71-7.93-17.71-17.731 c0-9.78,7.93-17.71,
                 17.71-17.71c0.787,0,1.552,0.042,2.317,0.149C39.238,37.084,80.419,9.083,129.702,
                 9.083c49.24,0,90.379,27.937,100.414,65.228h0.021c0.298-0.021,0.617-0.021,0.914-0.021C240.831,
                 74.29,248.761,82.22,248.761,92z"
                #:width? 258 #:height? 184
                #:stroke-fill? "#7AA20D"
                #:stroke-width? 9
                #:stroke-linejoin? "round")))))
         (lambda (actual)
           (check-lines? expected actual))))))

   ))

(run-tests test-all)