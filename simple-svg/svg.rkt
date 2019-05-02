#lang racket

(provide (contract-out
          [with-output-to-svg (->* (output-port? procedure?)
                                   (#:padding? natural?
                                    #:width? (or/c #f natural?)
                                    #:height? (or/c #f natural?)
                                    #:viewBox? (or/c #f (list/c natural? natural? natural? natural?))
                                    #:canvas? (or/c #f (list/c natural? string? string?))
                                    )
                                   void?)]
          [*svg* parameter?]
          [*padding* parameter?]
          [*size-func* parameter?]
          ))

(define *svg* (make-parameter #f))
(define *padding* (make-parameter #f))
(define *size-func* (make-parameter #f))

(define (with-output-to-svg output_port write_proc
                            #:padding? [padding? 10]
                            #:width? [width? #f]
                            #:height? [height? #f]
                            #:viewBox? [viewBox? #f]
                            #:canvas? [canvas? #f]
                            )
  (parameterize 
   ([*svg* output_port])
   (dynamic-wind
       (lambda () 
         (fprintf 
          (*svg*)
          "<svg\n    version=\"1.1\"\n    xmlns=\"http://www.w3.org/2000/svg\"\n"))
       (lambda ()
         (let* ([max_width 0]
                [max_height 0]
                [content
                 (call-with-output-string
                  (lambda (svg_output_port)
                    (parameterize
                        ([*svg* svg_output_port]
                         [*padding* padding?]
                         [*size-func* 
                          (lambda (_width _height)
                            (when (> _width max_width) (set! max_width _width))
                            (when (> _height max_height) (set! max_height _height)))])
                      (write_proc))))])
           
           (fprintf (*svg*) "    width=\"~a\" height=\"~a\"\n"
                    (if width? width? (+ max_width (* padding? 2)))
                    (if height? height? (+ max_height (* padding? 2))))

           (when viewBox?
                 (fprintf (*svg*) "    viewBox=\"~a ~a ~a ~a\"\n"
                          (first viewBox?) (second viewBox?) (third viewBox?) (fourth viewBox?)))
           
           (fprintf (*svg*) "    >\n")
         
           (when canvas?
                 (fprintf (*svg*) "  <rect width=\"~a\" height=\"~a\" stroke-width=\"~a\" stroke=\"~a\" fill=\"~a\" />\n"
                          (if width? width? (+ max_width (* padding? 2)))
                          (if height? height? (+ max_height (* padding? 2)))
                    (first canvas?) (second canvas?) (third canvas?)))
          
           (fprintf (*svg*) "~a" content)))
       (lambda ()
         (fprintf (*svg*) "</svg>\n")))))
