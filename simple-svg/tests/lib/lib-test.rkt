#lang racket

(require rackunit
         rackunit/text-ui
         "../../src/lib/lib.rkt")

(define test-all
  (test-suite
   "test-tool"

   (test-case
    "test-svg-round"

    (check-equal? (svg-round 30.0) "30")
    (check-equal? (svg-round 30) "30")
    (check-equal? (svg-round 30.0000) "30")
    (check-equal? (svg-round 30.0001) "30.0001")
    (check-equal? (svg-round 30.00001) "30")
    (check-equal? (svg-round 30) "30")
    (check-equal? (svg-round 30.123) "30.123")
    (check-equal? (svg-round 30.1234) "30.1234")
    (check-equal? (svg-round 30.12344) "30.1234")
    (check-equal? (svg-round 30.12345) "30.1235")
    (check-equal? (svg-round 167.88854381999835) "167.8885")
    (check-equal? (svg-round 167.88855) "167.8886")
    )

   ))

(run-tests test-all) 
