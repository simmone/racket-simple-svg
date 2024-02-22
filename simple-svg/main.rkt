#lang racket

(require "src/defines/view-box.rkt")
(require "src/defines/rect.rkt")
(require "src/defines/circle.rkt")
(require "src/defines/ellipse.rkt")
(require "src/defines/line.rkt")
(require "src/defines/polygon.rkt")
(require "src/defines/polyline.rkt")
(require "src/defines/gradient.rkt")
(require "src/defines/path/path.rkt")
(require "src/defines/path/moveto.rkt")
(require "src/defines/path/arc.rkt")
(require "src/defines/path/lineto.rkt")
(require "src/defines/path/close-path.rkt")
(require "src/defines/path/ccurve.rkt")
(require "src/defines/path/qcurve.rkt")
(require "src/defines/path/raw-path.rkt")
(require "src/defines/text.rkt")
(require "src/defines/svg.rkt")
(require "src/defines/sstyle.rkt")
(require "src/defines/group.rkt")

(provide (contract-out
          [svg-out (->* (number? number? procedure?)
                        (
                         #:viewBox (or/c #f VIEW-BOX?)
                        )
                        string?)]
          [new-view-box (-> number? number? number? number? VIEW-BOX?)]
          [new-rect (->* (number? number?)
                         (
                          #:radius_x (or/c #f number?)
                          #:radius_y (or/c #f number?)
                         )
                         RECT?
                         )]
          [new-circle (-> number? CIRCLE?)]
          [new-ellipse (-> number? number? ELLIPSE?)]
          [new-line (-> (cons/c number? number?) (cons/c number? number?) LINE?)]
          [new-polygon (-> (listof (cons/c number? number?)) POLYGON?)]
          [new-polyline (-> (listof (cons/c number? number?)) POLYLINE?)]
          [new-linear-gradient (->*
                                ((listof (list/c (between/c 0 100) string? (between/c 0 1))))
                                (
                                 #:x1 (or/c #f number?)
                                 #:y1 (or/c #f number?)
                                 #:x2 (or/c #f number?)
                                 #:y2 (or/c #f number?)
                                 #:gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox)
                                 #:spreadMethod (or/c #f 'pad 'repeat 'reflect)
                                 )
                                LINEAR-GRADIENT?)]
          [new-radial-gradient (->*
                                ((listof (list/c (between/c 0 100) string? (between/c 0 1))))
                                (
                                 #:cx (or/c #f (between/c 0 100))
                                 #:cy (or/c #f (between/c 0 100))
                                 #:fx (or/c #f (between/c 0 100))
                                 #:fy (or/c #f (between/c 0 100))
                                 #:r (or/c #f number?)
                                 #:gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox)
                                 #:spreadMethod (or/c #f 'pad 'repeat 'reflect)
                                 )
                                RADIAL-GRADIENT?)]
          [new-path (-> procedure? PATH?)]
          [svg-path-moveto (-> (cons/c number? number?) void?)]
          [svg-path-moveto* (-> (cons/c number? number?) void?)]
          [svg-path-arc (->
                (cons/c number? number?)
                (cons/c number? number?)
                (or/c 'left_big 'left_small 'right_big 'right_small)
                void?)]
          [svg-path-arc* (->
                 (cons/c number? number?)
                 (cons/c number? number?)
                 (or/c 'left_big 'left_small 'right_big 'right_small)
                 void?)]
          [svg-path-lineto (-> (cons/c number? number?) void?)]
          [svg-path-lineto* (-> (cons/c number? number?) void?)]
          [svg-path-hlineto (-> number? void?)]
          [svg-path-vlineto (-> number? void?)]
          [svg-path-close (-> void?)]
          [svg-path-ccurve (-> 
                            (cons/c number? number?)
                            (cons/c number? number?)
                            (cons/c number? number?)
                            void?)]
          [svg-path-ccurve* (->
                             (cons/c number? number?)
                             (cons/c number? number?)
                             (cons/c number? number?)
                             void?)]
          [svg-path-qcurve (-> 
                            (cons/c number? number?)
                            (cons/c number? number?)
                            void?)]
          [svg-path-qcurve* (->
                             (cons/c number? number?)
                             (cons/c number? number?)
                             void?)]
          [svg-path-raw (-> string? void?)]
          [new-text (->*
                     (string?)
                     (
                      #:font-size (or/c #f number?)
                      #:font-family (or/c #f string?)
                      #:dx (or/c #f number?)
                      #:dy (or/c #f number?)
                      #:rotate (or/c #f (listof number?))
                      #:textLength (or/c #f number?)
                      #:kerning (or/c #f number? 'auto 'inherit)
                      #:letter-space (or/c #f number? 'normal 'inherit)
                      #:word-space (or/c #f number? 'normal 'inherit)
                      #:text-decoration (or/c #f 'overline 'underline 'line-through)
                      #:path (or/c #f string?)
                      #:path-startOffset (or/c #f (between/c 0 100))
                      )
                     TEXT?)]
          [format-text (-> string? TEXT? string?)]
          [svg-def-shape (-> (or/c RECT? CIRCLE? ELLIPSE? LINE? POLYGON?
                                   POLYLINE? LINEAR-GRADIENT? RADIAL-GRADIENT? PATH? TEXT?) string?)]
          [svg-def-group (-> procedure? string?)]
          [struct SSTYLE
                  (
                   (fill (or/c #f string?))
                   (fill-rule (or/c #f 'nonzero 'evenodd 'inerit))
                   (fill-opacity (or/c #f (between/c 0 1)))
                   (stroke (or/c #f string?))
                   (stroke-width (or/c #f number?))
                   (stroke-linecap (or/c #f 'butt 'round 'square 'inherit))
                   (stroke-linejoin (or/c #f 'miter 'round 'bevel))
                   (stroke-miterlimit (or/c #f (>=/c 1)))
                   (stroke-dasharray (or/c #f string?))
                   (stroke-dashoffset (or/c #f number?))
                   (translate (or/c #f (cons/c number? number?)))
                   (rotate (or/c #f number?))
                   (scale (or/c #f number? (cons/c number? number?)))
                   (skewX (or/c #f number?))
                   (skewY (or/c #f number?))
                   (fill-gradient (or/c #f string?))
                   )]
          [sstyle-new (-> SSTYLE?)]
          [svg-place-widget (->* (string?)
                                 (
                                  #:style SSTYLE?
                                          #:at (cons/c number? number?)
                                          )
                                 void?)]
          [svg-show-group-on-bottom (->* (string?)
                               (
                                #:at (cons/c number? number?)
                               )
                               void?)]
          ))

(define (svg-out width height write_proc
                 #:viewBox [viewBox #f]
                 )
  (parameterize
      ([*SVG* (new-svg width height viewBox)])
    (with-output-to-string
      (lambda ()
        (dynamic-wind
            (lambda () 
              (printf 
               "<svg\n    ~a\n    ~a\n    ~a\n"
               "version=\"1.1\""
               "xmlns=\"http://www.w3.org/2000/svg\""
               "xmlns:xlink=\"http://www.w3.org/1999/xlink\""))
            (lambda ()
              (let ([default_group_id (svg-def-group write_proc)])
                (svg-show-group-on-bottom default_group_id)))
            (lambda ()
              (flush-data)
              (printf "</svg>\n")))))))

(define (svg-def-shape shape)
  (let* ([new_widget_index (add1 (SVG-widget_id_count (*SVG*)))]
         [shape_id (format "s~a" new_widget_index)])

    (set-SVG-widget_id_count! (*SVG*) new_widget_index)

    (hash-set! (SVG-shape_define_map (*SVG*)) shape_id shape)

    shape_id))

(define (svg-def-group user_proc)
  (let* ([new_widget_index (add1 (SVG-widget_id_count (*SVG*)))]
         [group_id (format "g~a" new_widget_index)])

    (set-SVG-widget_id_count! (*SVG*) new_widget_index)
    
    (parameterize
        ([*GROUP* (new-group)])

      (hash-set! (SVG-group_define_map (*SVG*)) group_id (*GROUP*))

      (user_proc)
      
      group_id)))

(define (svg-place-widget widget_id
                          #:style [style #f]
                          #:at [at #f])
  (set-GROUP-widget_list! (*GROUP*)
                          `(
                            ,@(GROUP-widget_list (*GROUP*))
                            ,(WIDGET widget_id at style))))

(define (svg-show-group-on-bottom group_id #:at [at '(0 . 0)])
  (set-SVG-group_show_list! (*SVG*) `(,(cons group_id at) ,@(SVG-group_show_list (*SVG*)))))

(define (flush-data)
  (printf "    width=\"~a\" height=\"~a\"\n" (~r (SVG-width (*SVG*))) (~r (SVG-height (*SVG*))))

  (when (SVG-view_box (*SVG*))
    (let ([view_box (SVG-view_box (*SVG*))])
      (printf "    viewBox=\"~a ~a ~a ~a\"\n"
              (~r (VIEW-BOX-min_x view_box))
              (~r (VIEW-BOX-min_y view_box))
              (~r (VIEW-BOX-width view_box))
              (~r (VIEW-BOX-height view_box)))))
  
  (printf "    >\n")

  (when (not (= (hash-count (SVG-shape_define_map (*SVG*))) 0))
    (printf "  <defs>\n")
    (let loop-def ([shape_ids (sort (hash-keys (SVG-shape_define_map (*SVG*))) string<?)])
      (when (not (null? shape_ids))
        (let ([shape (hash-ref (SVG-shape_define_map (*SVG*)) (car shape_ids))])
          (printf "~a"
                  (cond
                   [(RECT? shape)
                    (format-rect (car shape_ids) shape)]
                   [(CIRCLE? shape)
                    (format-circle (car shape_ids) shape)]
                   [(ELLIPSE? shape)
                    (format-ellipse (car shape_ids) shape)]
                   [(LINE? shape)
                    (format-line (car shape_ids) shape)]
                   [(POLYGON? shape)
                    (format-polygon (car shape_ids) shape)]
                   [(POLYLINE? shape)
                    (format-polyline (car shape_ids) shape)]
                   [(LINEAR-GRADIENT? shape)
                    (format-linear-gradient (car shape_ids) shape)]
                   [(RADIAL-GRADIENT? shape)
                    (format-radial-gradient (car shape_ids) shape)]
                   [(PATH? shape)
                    (format-path (car shape_ids) shape)]
                   [(TEXT? shape)
                    (format-text (car shape_ids) shape)]
                   )))

        (loop-def (cdr shape_ids))))
    (printf "  </defs>\n\n"))

  (when (> (length (GROUP-widget_list (hash-ref (SVG-group_define_map (*SVG*)) "g1"))) 0)
    (let loop-group ([group_ids `(,@(sort (rest (hash-keys (SVG-group_define_map (*SVG*)))) string<?) "g1")])
      (when (not (null? group_ids))
        (let* ([group_id (car group_ids)]
               [group (hash-ref (SVG-group_define_map (*SVG*)) group_id)])
          (printf "  <symbol id=\"~a\">\n" group_id)
          (let loop-widget ([widget_list (GROUP-widget_list group)])
            (when (not (null? widget_list))
              (let* ([widget (car widget_list)]
                     [widget_id (WIDGET-id widget)]
                     [widget_at (WIDGET-at widget)]
                     [widget_style (WIDGET-style widget)])
                (printf "    <use xlink:href=\"#~a\"" widget_id)
                  
                (when (and widget_at (not (equal? widget_at '(0 . 0))))
                  (printf " x=\"~a\" y=\"~a\"" (~r (car widget_at)) (~r (cdr widget_at))))
                  
                (when widget_style
                  (printf "~a" (sstyle-format widget_style)))
                
                (printf " />\n")
                )
              (loop-widget (cdr widget_list))))
          (printf "  </symbol>\n\n")
          (loop-group (cdr group_ids))))))
  
  (when (> (length (GROUP-widget_list (hash-ref (SVG-group_define_map (*SVG*)) "g1"))) 0)
    (let loop-show ([group_shows (SVG-group_show_list (*SVG*))])
      (when (not (null? group_shows))
        (let* ([group_show (car group_shows)]
               [group_id (car group_show)]
               [group_pos (cdr group_show)])
          (printf "  <use xlink:href=\"#~a\" " group_id)
          
          (when (and group_pos (not (equal? group_pos '(0 . 0))))
            (printf "x=\"~a\" y=\"~a\" " (~r (car group_pos)) (~r (cdr group_pos))))
          
          (printf "/>\n"))
        (loop-show (cdr group_shows))))))
