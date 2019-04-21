#lang racket

(require "svg.rkt")

(provide (contract-out
          [with-output-to-svg (->* (output-port? procedure?)
                                   (#:width natural?
                                    #:height natural?
                                    #:viewBoxX natural?
                                    #:viewBoxY natural?
                                    #:viewBoxWidth natural?
                                    #:viewBoxHeight natural?
                                    )
                                   void?)]
          ))
