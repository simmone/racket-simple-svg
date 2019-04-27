#lang racket

(provide (contract-out
          [with-output-to-svg (->* (output-port? procedure?)
                                   (#:width? natural?
                                    #:height? natural?
                                    #:viewBoxX? natural?
                                    #:viewBoxY? natural?
                                    #:viewBoxWidth? natural?
                                    #:viewBoxHeight? natural?
                                    #:stroke-width? natural?
                                    #:stroke-fill? string?
                                    #:fill? string?
                                    )
                                   void?)]
          [*svg* parameter?]
          ))

(define *svg* (make-parameter #f))

(define (with-output-to-svg output_port write_proc
                            #:padding? [padding? 10]
                            #:width? [width? 300]
                            #:height? [height? 300]
                            #:viewBoxX? [viewBoxX? 0]
                            #:viewBoxY? [viewBoxY? 0]
                            #:viewBoxWidth? [viewBoxWidth? width?]
                            #:viewBoxHeight? [viewBoxHeight? height?]
                            #:stroke-width? [stroke-width? 0]
                            #:stroke-fill? [stroke-fill? "red"]
                            #:fill? [fill? "white"]
                            )
  (parameterize 
   ([*svg* output_port])
   (dynamic-wind
       (lambda () 
         (fprintf 
          (*svg*)
          "<svg\n    version=\"1.1\"\n    xmlns=\"http://www.w3.org/2000/svg\"\n    ~a>\n"
          (with-output-to-string
            (lambda ()
              (printf "width=\"~a\" height=\"~a\"" width? height?)
              
              (when 
               (or
                (not (= viewBoxX? 0))
                (not (= viewBoxY? 0))
                (not (= viewBoxWidth? width?))
                (not (= viewBoxHeight? height?)))
               (printf " viewBox=\"~a ~a ~a ~a\"" viewBoxX? viewBoxY? viewBoxWidth? viewBoxHeight?)))))
         
         (when (not (= stroke-width? 0))
               (fprintf (*svg*)
                        "  <rect width=\"~a\" height=\"~a\" stroke-width=\"~a\" stroke=\"~a\" fill=\"~a\" />\n"
                        width? height? stroke-width? stroke-fill? fill?)))
       (lambda () (write_proc))
       (lambda ()
         (fprintf (*svg*) "</svg>\n")))))


  
