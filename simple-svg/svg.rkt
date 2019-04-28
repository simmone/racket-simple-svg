#lang racket

(provide (contract-out
          [with-output-to-svg (->* (output-port? procedure?)
                                   (#:padding? natural?
                                    #:width? natural?
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
                            #:width? [width? 0]
                            #:height? [height? 0]
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

           (fprintf (*svg*) "~a"
                    (if (or
                         (not (= width? 0))
                         (not (= height? 0)))
                        (format "    width=\"~a\" height=\"~a\"\n" width? height?)
                        (format "    width=\"~a\" height=\"~a\"\n"
                                (+ *MAX_WIDTH* (* padding? 2))
                                (+ *MAX_HEIGHT* (* padding? 2)))))

           (when 
            (or
             (not (= viewBoxX? 0))
             (not (= viewBoxY? 0))
             (not (= viewBoxWidth? width?))
             (not (= viewBoxHeight? height?)))
            (fprintf (*svg*) "    viewBox=\"~a ~a ~a ~a\"\n" viewBoxX? viewBoxY? viewBoxWidth? viewBoxHeight?))
           
           (fprintf (*svg*) "    >\n")
         
           (when (not (= stroke-width? 0))
                 (fprintf (*svg*) "~a stroke-width=\"~a\" stroke=\"~a\" fill=\"~a\" />\n"
                    (if (or
                         (not (= width? 0))
                         (not (= height? 0)))
                        (format "  <rect width=\"~a\" height=\"~a\"" width? height?)
                        (format "  <rect width=\"~a\" height=\"~a\""
                                (+ *MAX_WIDTH* (* padding? 2))
                                (+ *MAX_HEIGHT* (* padding? 2))))
                    stroke-width? stroke-fill? fill?))
          
           (fprintf (*svg*) "~a" content)))
       (lambda ()
         (fprintf (*svg*) "</svg>\n")))))
