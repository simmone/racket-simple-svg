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

(define *MAX_WIDTH* 0)

(define *MAX_HEIGHT* 0)

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
         (let ([content
                (call-with-output-string
                 (lambda (svg_output_port)
                   (parameterize
                    ([*svg* svg_output_port]
                     [*padding* padding?]
                     [*size-func* 
                      (lambda (_width _height)
                        (when (> _width *MAX_WIDTH*) (set! *MAX_WIDTH* _width))
                        (when (> _height *MAX_HEIGHT*) (set! *MAX_HEIGHT* _height)))])
                    (write_proc))))])

           (fprintf (*svg*) "    width=\"~a\" height=\"~a\"\n"
                    (if width? width? (+ *MAX_WIDTH* (* padding? 2)))
                    (if height? height? (+ *MAX_HEIGHT* (* padding? 2))))

           (when viewBox?
                 (fprintf (*svg*) "    viewBox=\"~a ~a ~a ~a\"\n"
                          (first viewBox?) (second viewBox?) (third viewBox?) (fourth viewBox?)))
           
           (fprintf (*svg*) "    >\n")
         
           (when canvas?
                 (fprintf (*svg*) "  <rect width=\"~a\" height=\"~a\" stroke-width=\"~a\" stroke=\"~a\" fill=\"~a\" />\n"
                          (if width? width? (+ *MAX_WIDTH* (* padding? 2)))
                          (if height? height? (+ *MAX_HEIGHT* (* padding? 2)))
                    (first canvas?) (second canvas?) (third canvas?)))
          
           (fprintf (*svg*) "~a" content)))
       (lambda ()
         (fprintf (*svg*) "</svg>\n")))))
