#lang racket

(provide (contract-out
          [struct VIEW-BOX
                  (
                   (min_x number?)
                   (min_y number?)
                   (width number?)
                   (height number?)
                   )
                  ]
          [new-view-box (-> number? number? number? number? VIEW-BOX?)]
          ))

(struct VIEW-BOX (
              [min_x #:mutable]
              [min_y #:mutable]
              [width #:mutable]
              [height #:mutable]
              )
        #:transparent
        )

(define (new-view-box min_x min_y width height)
  (VIEW-BOX min_x min_y width height))


