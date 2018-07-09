#lang racket

(require (for-syntax racket/list))
(require (for-syntax syntax/parse))

;; SYNTAX
;; (define-hello world good bye damn it)
;; means the identifier 'world' 'good' 'bye' 'damn' and 'it'
;; are bound to "good bye"
;; translate this to code of the shape
;; (define world "good")
;; (define good "good")
;; (define bye "good")
;; ...        

(println "compile time")

(define-syntax (define-world* stx)
  (syntax-parse stx
    [(_ the-identifier:id ...)
     (let ([len (length (syntax->list stx))])
       #`(define-values (the-identifier ...) (apply values #,(datum->syntax stx (cons 'list (build-list (- len 1) values))))))]))

(define-world* won too tree)
won too tree

(println "run time")

(define-syntax (def-worlds stx)
  (syntax-parse stx
    [(_ x ...)
     #'(begin
         (define counter -1)
         (define x (begin (set! counter (+ counter 1)) counter))
         ...)]))

(def-worlds one two three)
one two three


