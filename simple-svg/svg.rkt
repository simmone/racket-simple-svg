#lang racket

(provide (contract-out
          [with-output-to-svg (->* (natural? natural? output-port? procedure?)
                                   (
                                    #:viewBoxX natural?
                                    #:viewBoxY natural?
                                    #:viewBoxWidth natural?
                                    #:viewBoxHeight natural?
                                    )
                                   void?)]
          [*svg* parameter?]
          ))

(define *svg* (make-parameter #f))

(define (with-output-to-svg width height output_port write_proc
                            #:viewBoxX [viewBoxX 0]
                            #:viewBoxY [viewBoxY 0]
                            #:viewBoxWidth [viewBoxWidth width]
                            #:viewBoxHeight [viewBoxHeight height]
                            )
  (parameterize 
   ([*svg* output_port])
   (dynamic-wind
       (lambda () 
           (fprintf (*svg*) "<svg>\n"))
         )
       (lambda () (write_proc))
       (lambda ()
         (fprintf (*svg*) "</svg>\n")))


  
