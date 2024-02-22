#lang scribble/manual

@title{svg-path-moveto/svg-path-moveto*}

@codeblock|{
(svg-path-moveto (-> (cons/c number? number?) void?))
(svg-path-moveto* (-> (cons/c number? number?) void?))
}|

  Move to new position.

  moveto* use absolute position.

  moveto use relative position.
