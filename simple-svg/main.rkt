#lang racket

(require "svg.rkt")
(require "shapes/rect.rkt")

(provide (contract-out
          [with-output-to-svg (->* (output-port? procedure?)
                                   (#:width? natural?
                                    #:height? natural?
                                    #:viewBoxX? natural?
                                    #:viewBoxY? natural?
                                    #:viewBoxWidth? natural?
                                    #:viewBoxHeight? natural?
                                    )
                                   void?)]
          [rect (->* 
                 (natural? natural? string?)
                 (
                  #:start_point pair?
                  #:radius pair?
                  )
                 void?)]
          ))
