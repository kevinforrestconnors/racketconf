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

(define-syntax (define-world* stx)
  (syntax-parse stx
    [(_ the-identifier:id ...)
     (let ([len (length (syntax->list stx))])
       #`(define-values (the-identifier ...) (apply values #,(datum->syntax stx (cons 'list (build-list (- len 1) values))))))]))


(define-syntax (def-worlds stx)
  (syntax-parse stx
    [(_ x ...)
     #'(begin
         (define counter 0)
         (define x (begin (set! counter (+ counter 1)) counter))
         ...)]))

(println "run time")

(def-worlds one two three)
one two three

(println "compile time")

(define-world* world* won too tree)
won too tree

