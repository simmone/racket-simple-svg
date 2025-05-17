#lang racket

(require rackunit
         rackunit/text-ui
         "../../../src/lib.rkt"
         "../../../src/define/shape/text.rkt"
         racket/runtime-path)

(define test-all
  (test-suite
   "test-text-define"

   (test-case
    "test-basic"

    (let ([text (new-text "hello world"
                          #:font-size 1.00001
                          #:font-family "Arial"
                          #:dx 2.00001
                          #:dy 3.00001
                          #:rotate '(4.00001 5.00001 6.0 7.0)
                          #:textLength 8
                          #:kerning 'auto
                          #:letter-space 'normal
                          #:word-space 'inherit
                          #:text-decoration 'underline)])

        (check-equal?
         "    <text id=\"s1\" dx=\"2\" dy=\"3\" font-size=\"1\" font-family=\"Arial\" rotate=\"4 5 6 7\" textLength=\"8\" kerning=\"auto\" letter-space=\"normal\" word-space=\"inherit\" text-decoration=\"underline\">hello world</text>\n"
         (format-text "s1" text))

        (set-TEXT-path! text "9.0, 10.0")
        (set-TEXT-path-startOffset! text 11)
        (check-equal?
         "    <text id=\"s1\" dx=\"2\" dy=\"3\" font-size=\"1\" font-family=\"Arial\" rotate=\"4 5 6 7\" textLength=\"8\" kerning=\"auto\" letter-space=\"normal\" word-space=\"inherit\" text-decoration=\"underline\">\n      <textPath xlink:href=\"#9.0, 10.0\" startOffset=\"11%\" >hello world</textPath>\n    </text>\n"
         (format-text "s1" text))))
   ))


(run-tests test-all)
