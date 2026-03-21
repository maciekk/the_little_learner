#lang racket

; Allow later chapters to properly include this one.
(provide (all-defined-out) (all-from-out "chapter-4.rkt"))
(require "chapter-4.rkt")

;; 99:4
(declare-hyper revs)
(declare-hyper α)

; We also need to redefine gradient-descent, so that it uses the revs and α
; hyperparameters, instead of the earlier constants created with (define).
(define gradient-descent-hyper
  (λ (obj θ)
    (let ((f (λ (Θ)
               (map (λ (p g)
                      (- p (* α g)))
                    Θ
                    (gradient-of obj Θ)))))
      (revise f revs θ))))

;; 100:6
(module+ main
  (with-hypers
    ((revs 1000)
     (α 0.01))
    (gradient-descent-hyper
      ((l2-loss line) line-xs line-ys)
      (list 0.0 0.0)))
)

;; 100:8
(define quad-xs
  (tensor -1.0 0.0 1.0 2.0 3.0))
(define quad-ys
  (tensor 2.55 2.1 4.35 10.2 18.25))

;; 102:15
(define quad
  (λ (t)
    (λ (θ)
      (+ (* (ref θ 0) (sqr t))
         (+ (* (ref θ 1) t)
            (ref θ 2))))))

(module+ main
  ;; 102:16
    ((quad 3) (list 4.5 2.1 7.8))

  ;; 104:22
  (with-hypers
    ((revs 1000)
     (α 0.001))
    (gradient-descent-hyper
      ((l2-loss quad) quad-xs quad-ys)
      (list 0.0 0.0 0.0)))
  ;; This example shows why we need to use gradient-descent-hyper: if you use,
  ;; gradient-descent, it will instead still use the earlier (define)
  ;; constants, and α=0.01 in particular, leading to the incorrect/overshot:
  ;;  '(-1.740366442375694e+107 -6.290637687269543e+106 -2.684432967412995e+106)
)

;; 104:23
(define plane-xs
  (tensor
    (tensor 1.0 2.05)
    (tensor 1.0 3.0)
    (tensor 2.0 2.0)
    (tensor 2.0 3.91)
    (tensor 3.0 6.13)
    (tensor 4.0 8.09)))
(define plane-ys
  (tensor
    13.9
    15.99
    18.0
    22.4
    30.2
    37.94))

;; 105:25
(define plane
  (λ (t)
    (λ (θ)
      (+ (dot-product (ref θ 0) t) (ref θ 1)))))

;; 106:26
(define dot-product-1-1
  (λ (w t)
    (sum-1
      (* w t))))

(module+ main
  ;; 106:27
  (dot-product-1-1
    (tensor 2.0 1.0 7.0)
    (tensor 8.0 4.0 3.0))

  ;; 110:38
  (with-hypers
    ((revs 1000)
     (α 0.001))
    (gradient-descent-hyper
      ((l2-loss plane) plane-xs plane-ys)
      (list (tensor 0.0 0.0) 0.0)))
  ; I actually get sliiightly different numbers, perhaps due to extra precision:
  ;   '((tensor 3.990072856772255 2.0498795979307993) 5.74470738841384)
  ; vs book:
  ;   '((tensor 3.98 2.04) 5.78)

  ;; 110:40
  ((plane (tensor 2.0 3.91))
   ; using book values
   (list (tensor 3.98 2.04) 5.78))
   ; -> 21.7164

  ((plane (tensor 2.0 3.91))
   ; using my earlier output values
   (list (tensor 3.99 2.05) 5.7447))
   ; -> 21.7402 (better? closer to the 22.4 in plane-ys)
)
