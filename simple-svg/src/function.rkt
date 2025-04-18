#lang racket

(require "define/svg.rkt"
         "define/view-box.rkt"
         "define/sstyle.rkt"
         "define/widget.rkt"
         "define/group.rkt"
         "define/shape/rect.rkt"
         "define/shape/circle.rkt"
         "define/shape/ellipse.rkt"
         "define/shape/line.rkt"
         "define/shape/polygon.rkt"
         "define/shape/polyline.rkt"
         "define/shape/gradient.rkt"
         "define/shape/filter.rkt"
         "define/shape/path/path.rkt"
         "define/shape/path/moveto.rkt"
         "define/shape/path/arc.rkt"
         "define/shape/path/lineto.rkt"
         "define/shape/path/close-path.rkt"
         "define/shape/path/ccurve.rkt"
         "define/shape/path/qcurve.rkt"
         "define/shape/path/raw-path.rkt"
         "define/shape/text.rkt"
         "define/shape/arrow.rkt"
         "define/shape/marker.rkt")

(require racket/serialize
         racket/fasl
         )

(provide (contract-out
          [svg-out (->* (number? number? procedure?)
                        (
                         #:background (or/c #f string?)
                         #:viewBox (or/c #f VIEW-BOX?)
                         )
                        string?)]
          [struct VIEW-BOX
                  (
                   (min_x number?)
                   (min_y number?)
                   (width number?)
                   (height number?)
                   )
                  ]
          [new-view-box (-> number? number? number? number? VIEW-BOX?)]
          [struct RECT
                  (
                   (width number?)
                   (height number?)
                   (radius_x (or/c #f number?))
                   (radius_y (or/c #f number?))
                   )
                  ]
          [new-rect (->* (number? number?)
                         (
                          #:radius_x (or/c #f number?)
                          #:radius_y (or/c #f number?)
                          )
                         RECT?
                         )]
          [struct CIRCLE
                  (
                   (radius number?)
                   )
                  ]
          [new-circle (-> number? CIRCLE?)]
          [struct ELLIPSE
                  (
                   (radius_x number?)
                   (radius_y number?)
                   )
                  ]
          [new-ellipse (-> number? number? ELLIPSE?)]
          [struct LINE
                  (
                   (start_x number?)
                   (start_y number?)
                   (end_x number?)
                   (end_y number?)
                   )
                  ]
          [new-line (-> (cons/c number? number?) (cons/c number? number?) LINE?)]
          [struct POLYGON
                  (
                   (points (listof (cons/c number? number?)))
                   )
                  ]
          [new-polygon (-> (listof (cons/c number? number?)) POLYGON?)]
          [struct POLYLINE
                  (
                   (points (listof (cons/c number? number?)))
                   )
                  ]
          [new-polyline (-> (listof (cons/c number? number?)) POLYLINE?)]
          [struct LINEAR-GRADIENT
                  (
                   (stops (listof (list/c (between/c 0 100) string? (between/c 0 1))))
                   (x1 (or/c #f number?))
                   (y1 (or/c #f number?))
                   (x2 (or/c #f number?))
                   (y2 (or/c #f number?))
                   (gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox))
                   (spreadMethod (or/c #f 'pad 'repeat 'reflect))
                   )
                  ]
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
          [struct RADIAL-GRADIENT
                  (
                   (stops (listof (list/c (between/c 0 100) string? (between/c 0 1))))
                   (cx (or/c #f (between/c 0 100)))
                   (cy (or/c #f (between/c 0 100)))
                   (fx (or/c #f (between/c 0 100)))
                   (fy (or/c #f (between/c 0 100)))
                   (r (or/c #f number?))
                   (gradientUnits (or/c #f 'userSpaceOnUse 'objectBoundingBox))
                   (spreadMethod (or/c #f 'pad 'repeat 'reflect))
                  )
                  ]
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
          [struct BLUR-DROPDOWN
                  (
                   (blur (or/c #f number?))
                   (dropdown_offset (or/c #f number?))
                   (dropdown_color (or/c #f string?))
                   )
                  ]
          [new-blur-dropdown (->*
                              ()
                              (
                               #:blur (or/c #f number?)
                               #:dropdown_offset (or/c #f number?)
                               #:dropdown_color (or/c #f string?)
                               )
                              BLUR-DROPDOWN?)]
          [struct PATH
                  (
                   (defs (listof string?))
                   )
                  ]
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
          [struct TEXT
                  (
                   (text string?)
                   (font-size (or/c #f number?))
                   (font-family (or/c #f string?))
                   (dx (or/c #f number?))
                   (dy (or/c #f number?))
                   (rotate (or/c #f (listof number?)))
                   (textLength (or/c #f number?))
                   (kerning (or/c #f number? 'auto 'inherit))
                   (letter-space (or/c #f number? 'normal 'inherit))
                   (word-space (or/c #f number? 'normal 'inherit))
                   (text-decoration (or/c #f 'overline 'underline 'line-through))
                   (path (or/c #f string?))
                   (path-startOffset (or/c #f (between/c 0 100)))
                   )]
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
          [struct ARROW
                  (
                   (start_x number?)
                   (start_y number?)
                   (end_x number?)
                   (end_y number?)
                   (handle_base number?)
                   (head_base number?)
                   (head_height number?)
                   )
                  ]
          [new-arrow (-> (cons/c number? number?) (cons/c number? number?) number? number? number? ARROW?)]
          [struct MARKER
                  (
                   (type (or/c 'triangle1 'triangle2 'circle 'indent1 'indent2 'diamond1 'diamond2 'curve1 'curve2))
                   (size number?)
                   (x number?)
                   (shape string?)
                   )
                  ]
          [new-marker (->*
                       ((or/c 'triangle1 'triangle2 'circle 'indent1 'indent2 'diamond1 'diamond2 'curve1 'curve2))
                       (
                        #:size (or/c #f number?)
                        #:x (or/c #f number?)
                       )
                       MARKER?)]
          [svg-def-shape (-> (or/c RECT? CIRCLE? ELLIPSE? LINE? POLYGON?
                                   POLYLINE? LINEAR-GRADIENT? RADIAL-GRADIENT? PATH? TEXT?
                                   BLUR-DROPDOWN? ARROW? MARKER?) string?)]
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
                                  #:filter_id string?
                                  #:marker_start_id string?
                                  #:marker_mid_id string?
                                  #:marker_end_id string?
                                  )
                                 void?)]
          ))

(define BACKGROUND_GROUP_ID "g1")
(define DEFAULT_GROUP_ID "g0")

(define (svg-out width height write_proc
                 #:background [background #f]
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
              (when background
                (svg-def-name-group
                 BACKGROUND_GROUP_ID
                 (lambda ()
                   (let ([rec_id (svg-def-shape (new-rect width height))]
                         [_sstyle (sstyle-new)])
                     (set-SSTYLE-fill! _sstyle background)
                     (svg-place-widget rec_id #:style _sstyle)))))

              (svg-def-name-group
               DEFAULT_GROUP_ID
               write_proc)

              (let ([default_not_null (> (length (GROUP-widget_list (hash-ref (SVG-group_define_map (*SVG*)) DEFAULT_GROUP_ID))) 0)])
                (set-SVG-group_show_list!
                 (*SVG*)
                 (append
                  (if background
                      (list (cons BACKGROUND_GROUP_ID (cons 0 0)))
                      '())
                  (if default_not_null
                      (list (cons DEFAULT_GROUP_ID (cons 0 0)))
                      '())))))
            (lambda ()
              (flush-data)
              (printf "</svg>\n")))))))

(define (svg-def-shape shape)
  (let ([serialized_shape (s-exp->fasl (serialize shape))])
    (if (hash-has-key? (SVG-serialized_to_shape_id_map (*SVG*)) serialized_shape)
        (hash-ref (SVG-serialized_to_shape_id_map (*SVG*)) serialized_shape)
        (let* ([new_widget_index (add1 (SVG-shape_id_count (*SVG*)))]
               [shape_id (format "s~a" new_widget_index)])

          (set-SVG-shape_id_count! (*SVG*) new_widget_index)

          (hash-set! (SVG-serialized_to_shape_id_map (*SVG*)) serialized_shape shape_id)
          
          shape_id))))

(define (svg-def-group user_proc)
  (let* ([new_widget_index (add1 (SVG-group_id_count (*SVG*)))]
         [group_id (format "g~a" new_widget_index)])

    (set-SVG-group_id_count! (*SVG*) new_widget_index)
    
    (svg-def-name-group group_id user_proc)))

(define (svg-def-name-group group_id user_proc)
  (parameterize
      ([*GROUP* (new-group)])

    (hash-set! (SVG-group_define_map (*SVG*)) group_id (*GROUP*))

    (user_proc)
    
    group_id))

(define (svg-place-widget widget_id
                          #:style [style #f]
                          #:filter_id [filter_id #f]
                          #:marker_start_id [marker_start_id #f]
                          #:marker_mid_id [marker_mid_id #f]
                          #:marker_end_id [marker_end_id #f]
                          #:at [at #f])
  (set-GROUP-widget_list! (*GROUP*)
                          `(
                            ,@(GROUP-widget_list (*GROUP*))
                            ,(WIDGET widget_id at style filter_id marker_start_id marker_mid_id marker_end_id))))

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

  (when (not (= (hash-count (SVG-serialized_to_shape_id_map (*SVG*))) 0))
    (printf "  <defs>\n")
    (let loop-def ([shapes (sort (hash->list (SVG-serialized_to_shape_id_map (*SVG*))) < #:key (lambda (item) (string->number (substring (cdr item) 1))))])
      (when (not (null? shapes))
        (let* ([shape (deserialize (fasl->s-exp (caar shapes)))]
               [shape_id (cdar shapes)])
          (printf "~a"
                  (cond
                   [(RECT? shape)
                    (format-rect shape_id shape)]
                   [(CIRCLE? shape)
                    (format-circle shape_id shape)]
                   [(ELLIPSE? shape)
                    (format-ellipse shape_id shape)]
                   [(LINE? shape)
                    (format-line shape_id shape)]
                   [(POLYGON? shape)
                    (format-polygon shape_id shape)]
                   [(POLYLINE? shape)
                    (format-polyline shape_id shape)]
                   [(LINEAR-GRADIENT? shape)
                    (format-linear-gradient shape_id shape)]
                   [(RADIAL-GRADIENT? shape)
                    (format-radial-gradient shape_id shape)]
                   [(BLUR-DROPDOWN? shape)
                    (format-blur-dropdown shape_id shape)]
                   [(PATH? shape)
                    (format-path shape_id shape)]
                   [(TEXT? shape)
                    (format-text shape_id shape)]
                   [(ARROW? shape)
                    (format-arrow shape_id shape)]
                   [(MARKER? shape)
                    (format-marker shape_id shape)]
                   )))

        (loop-def (cdr shapes))))
    (printf "  </defs>\n"))

  (let ([all_group_ids
         (filter (lambda (id) (not (string=? id DEFAULT_GROUP_ID))) (sort (hash-keys (SVG-group_define_map (*SVG*))) < #:key (lambda (item) (string->number (substring item 1)))))])

    (let loop-group ([group_ids all_group_ids])
      (when (not (null? group_ids))
        (printf "\n")
        (printf "  <symbol id=\"~a\">\n" (car group_ids))
        (show-group-widgets (car group_ids) "    ")
        (printf "  </symbol>\n")
        (loop-group (cdr group_ids)))))
  
  (let ([all_group_shows
         (filter (lambda (group_show) (not (string=? (car group_show) DEFAULT_GROUP_ID))) (SVG-group_show_list (*SVG*)))])

    (when (not (null? all_group_shows)) (printf "\n"))

    (let loop-show ([group_shows all_group_shows])
      (when (not (null? group_shows))
        (let* ([group_show (car group_shows)]
               [group_id (car group_show)]
               [group_pos (cdr group_show)])
          (printf "  <use xlink:href=\"#~a\" " group_id)
          
          (when (and group_pos (not (equal? group_pos '(0 . 0))))
            (printf "x=\"~a\" y=\"~a\" " (~r (car group_pos)) (~r (cdr group_pos))))
          
          (printf "/>\n"))
        (loop-show (cdr group_shows)))))

  (let ([group (hash-ref (SVG-group_define_map (*SVG*)) DEFAULT_GROUP_ID)])
        (when (> (length (GROUP-widget_list group)) 0)
          (printf "\n")
          (show-group-widgets DEFAULT_GROUP_ID "  ")))
)

(define (show-group-widgets group_id prefix)
  (let ([group (hash-ref (SVG-group_define_map (*SVG*)) group_id)])
        (when (> (length (GROUP-widget_list group)) 0)
          (let loop-widget ([widget_list (GROUP-widget_list group)])
            (when (not (null? widget_list))
              (let* (
                     [widget (car widget_list)]
                     [widget_id (WIDGET-id widget)]
                     [widget_at (WIDGET-at widget)]
                     [widget_style (WIDGET-style widget)]
                     [widget_filter_id (WIDGET-filter_id widget)]
                     [widget_marker_start_id (WIDGET-marker_start_id widget)]
                     [widget_marker_mid_id (WIDGET-marker_mid_id widget)]
                     [widget_marker_end_id (WIDGET-marker_end_id widget)]
                     )
                (printf "~a<use xlink:href=\"#~a\"" prefix widget_id)
                
                (when (and widget_at (not (equal? widget_at '(0 . 0))))
                  (printf " x=\"~a\" y=\"~a\"" (~r (car widget_at)) (~r (cdr widget_at))))
                
                (when widget_style
                  (printf "~a" (sstyle-format widget_style)))

                (when widget_filter_id
                  (printf " filter=\"url(#~a)\"" widget_filter_id))

                (when widget_marker_start_id
                  (printf " marker-start=\"url(#~a)\"" widget_marker_start_id))

                (when widget_marker_mid_id
                  (printf " marker-mid=\"url(#~a)\"" widget_marker_mid_id))

                (when widget_marker_end_id
                  (printf " marker-end=\"url(#~a)\"" widget_marker_end_id))
                
                (printf " />\n")
                )
              (loop-widget (cdr widget_list)))))))
