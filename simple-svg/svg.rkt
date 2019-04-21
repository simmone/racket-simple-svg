#lang racket

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
          [*svg* parameter?]
          ))

(define *svg* (make-parameter #f))

(define (with-output-to-svg output_port write_proc
                            #:width [width 300]
                            #:height [height 300]
                            #:viewBoxX [viewBoxX 0]
                            #:viewBoxY [viewBoxY 0]
                            #:viewBoxWidth [viewBoxWidth width]
                            #:viewBoxHeight [viewBoxHeight height]
                            )
  (parameterize 
   ([*svg* output_port])
   (dynamic-wind
       (lambda () 
         (fprintf (*svg*) "<svg ~a>\n"
           (with-output-to-string
             (lambda ()
               (printf "width=\"~a\" height=\"~a\"" width height)
               
               (when 
                (or
                 (not (= viewBoxX 0))
                 (not (= viewBoxY 0))
                 (not (= viewBoxWidth width))
                 (not (= viewBoxHeight height)))
                (printf " viewBox=\"~a ~a ~a ~a\"" viewBoxX viewBoxY viewBoxWidth viewBoxHeight))))))
       (lambda () (write_proc))
       (lambda ()
         (fprintf (*svg*) "</svg>\n")))))


  
