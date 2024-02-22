#lang scribble/manual

@title{svg-path-lineto/lineto*/hlineto/vlineto}

@codeblock|{
(svg-path-lineto (-> (cons/c number? number?) void?))
(svg-path-lineto* (-> (cons/c number? number?) void?))
(svg-path-hlineto (-> number? void?))
(svg-path-vlineto (-> number? void?))
}|

Draw a line.

svg-path-lineto: use absolute position.

svg-path-lineto: use relative postion.

svg-path-hlineto: horizontal distince.

svg-path-vlineto: vertical distince.

@codeblock|{
(svg-out
 110 160
 (lambda ()
   (let ([path_id
          (svg-def-shape
            (new-path
              (lambda ()
                (svg-path-moveto* '(5 . 5))
                  (svg-path-hlineto 100)
                  (svg-path-vlineto 100)
                  (svg-path-lineto '(-50 . 50))
                  (svg-path-lineto '(-50 . -50))
                  (svg-path-close))))]
         [sstyle_path (sstyle-new)])

     (set-SSTYLE-fill! sstyle_path "none")
     (set-SSTYLE-stroke-width! sstyle_path 5)
     (set-SSTYLE-stroke! sstyle_path "#7AA20D")
     (set-SSTYLE-stroke-linejoin! sstyle_path 'round)
     (svg-place-widget path_id #:style sstyle_path))))
}|
@image{showcase/path/lineto.svg}
