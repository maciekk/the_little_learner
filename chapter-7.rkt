#lang racket

; Allow later chapters to properly include this one.
(provide (all-defined-out) (all-from-out "chapter-6.rkt"))
(require "chapter-6.rkt")

;; 134:13
(define lonely-i
  (λ (θ)
    (map (λ (p)
           (list p))
         θ)))

;; 134:14
(define lonely-d
  (λ (Θ)
    (map (λ (P)
           ; CAUTION: not `tref`... P is an "accompanied parameter"
           (ref P 0))
         Θ)))

;; 135:17
(define lonely-u
  (λ (Θ gs)
    (map (λ (P g)
           ; CAUTION: not `tref`... P is an "accompanied parameter"
           (list (- (ref P 0) (* α g))))
         Θ
         gs)))

;; 136:21
(define gradient-descent-ate
  (λ (inflate deflate update)
    (λ (obj θ)
      (let ((f (λ (Θ)
                 (update
                   Θ
                   (gradient-of obj
                                (deflate Θ))))))
        (deflate
          (revise f revs
                  (inflate θ)))))))

;; 136:20 - needs to be out of order so that gradient-descent is define first
(define lonely-gradient-descent
  (gradient-descent-ate
    lonely-i lonely-d lonely-u))

;; 137:23
(define try-plane
  (λ (a-gradient-descent)
    (with-hypers
      ((revs 15000)
       (α 0.001)
       (batch-size 4))
      (a-gradient-descent
        (sampling-obj
          (l2-loss plane) plane-xs plane-ys)
        (list (tensor 0.0 0.0) 0.0)))))

(module+ main
  ;; 137:24
  (try-plane lonely-gradient-descent)
)

;; 138:26
(define naked-i
  (λ (θ)
    (map (λ (p)
           (let ((P p))
             P))
         θ)))

;; 138:27
(define naked-d
  (λ (Θ)
    (map (λ (P)
           (let ((p P))
             p))
         Θ)))

;; 138:28
(define naked-u
  (λ (Θ gs)
    (map (λ (P g)
           (- P (* α g)))
         Θ
         gs)))

;; 139:30
(define naked-gradient-descent
  (gradient-descent-ate
    naked-i naked-d naked-u))

;; 139:31
(module+ main
  (try-plane naked-gradient-descent)
)

;; 141:38
(define gradient-descent-crazy
  (λ (inflate deflate update)
    (λ (obj θ)
      (let ((f (λ (Θ)
                 (map update
                   Θ
                   (gradient-of obj
                                (map deflate Θ))))))
        (map deflate
          (revise f revs
                  (map inflate θ)))))))

;; 141:39
(define lonely-i-crazy
  (λ (p)
    (list p)))

;; 141:40
(define lonely-d-crazy
  (λ (P)
    ; CAUTION: not `tref`... P is an "accompanied parameter"
    (ref P 0)))

(define lonely-u-crazy
  (λ (P g)
    ; CAUTION: not `tref`... P is an "accompanied parameter"
    (list (- (ref P 0) (* α g)))))

;; 142:41
(define lonely-gradient-descent-crazy
  (gradient-descent-crazy
    lonely-i-crazy lonely-d-crazy lonely-u-crazy))

(module+ main
  (try-plane lonely-gradient-descent-crazy)
)

;; 142:42
(define naked-i-crazy
  (λ (p)
    (let ((P p))
      P)))

(define naked-d-crazy
  (λ (P)
    (let ((p P))
      p)))

(define naked-u-crazy
  (λ (P g)
    (- P (* α g))))

;; 143:43
(define naked-gradient-descent-crazy
  (gradient-descent-crazy
    naked-i-crazy naked-d-crazy naked-u-crazy))

(module+ main
  (try-plane naked-gradient-descent-crazy))
