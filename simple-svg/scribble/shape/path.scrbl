#lang scribble/manual

@title{Path}

@codeblock|{
(new-path (-> procedure? PATH?))
}|

Path is a shape, combinated some path actions, include moveto, lineto, arc, ccurve etc.

All the path actions should be include in this procedure.

@include-section{raw-path.scrbl}
@include-section{moveto.scrbl}
@include-section{close.scrbl}
@include-section{lineto.scrbl}
@include-section{qcurve.scrbl}
@include-section{ccurve.scrbl}
@include-section{arc.scrbl}
