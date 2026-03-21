#lang racket

; Allow later chapters to properly include this one.
(provide (all-defined-out) (all-from-out "chapter-4.rkt"))
(require "chapter-4.rkt")

;; 94:8
(declare-hyper smaller)
(declare-hyper larger)
;; Causes error
;(+ smaller larger)

;; 94:9
(module+ main
  (with-hypers
    ((smaller 1)
     (larger 2000))
    (+ smaller larger))
)

;; 95:13
(define nonsense?
  (λ (x)
    (= (sub1 x) smaller)))

(module+ main
  ;; 95:13
  ; error
  ;(nonsense? 6)

  ;; 96:14
  (with-hypers
    ((smaller 5))
    (nonsense? 6))
)
