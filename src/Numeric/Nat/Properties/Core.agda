
module Numeric.Nat.Properties.Core where

open import Prelude

add-0-r : ∀ n → n + 0 ≡ n
add-0-r  0 = refl
add-0-r (suc n) rewrite add-0-r n = refl

private
  add-suc-r : (n m : Nat) → n + suc m ≡ suc n + m
  add-suc-r zero m = refl
  add-suc-r (suc n) m rewrite add-suc-r n m = refl

add-commute : (x y : Nat) → x + y ≡ y + x
add-commute zero y = sym (add-0-r _)
add-commute (suc x) y rewrite add-commute x y = sym (add-suc-r y _)

add-assoc : (x y z : Nat) → x + (y + z) ≡ x + y + z
add-assoc zero y z = refl
add-assoc (suc x) y z rewrite add-assoc x y z = refl

mul-1-r : (x : Nat) → x * 1 ≡ x
mul-1-r zero = refl
mul-1-r (suc x) rewrite mul-1-r x = refl

mul-0-r : (x : Nat) → x * 0 ≡ 0
mul-0-r zero = refl
mul-0-r (suc x) rewrite mul-0-r x = refl

mul-distr-r : (x y z : Nat) → (x + y) * z ≡ x * z + y * z
mul-distr-r zero y z = refl
mul-distr-r (suc x) y z rewrite mul-distr-r x y z
                              | sym (add-assoc (x * z) (y * z) z)
                              | add-commute (y * z) z
                              = add-assoc z _ _

mul-distr-l : (x y z : Nat) → x * (y + z) ≡ x * y + x * z
mul-distr-l zero y z = refl
mul-distr-l (suc x) y z rewrite mul-distr-l x y z
                              | add-assoc (y + x * y) z (x * z)
                              | add-assoc (y + z) (x * y) (x * z)
                              | sym (add-assoc y z (x * y))
                              | add-commute z (x * y)
                              | add-assoc y (x * y) z
                        = refl

mul-assoc : (x y z : Nat) → x * (y * z) ≡ x * y * z
mul-assoc zero y z = refl
mul-assoc (suc x) y z rewrite mul-distr-r y (x * y) z
                            | mul-assoc x y z
                            = refl

mul-commute : (x y : Nat) → x * y ≡ y * x
mul-commute zero y = sym (mul-0-r y)
mul-commute (suc x) y rewrite mul-commute x y
                            | mul-distr-l y 1 x
                            | mul-1-r y
                            = refl

add-inj₂ : (x y z : Nat) → x + y ≡ x + z → y ≡ z
add-inj₂  zero   y z p = p
add-inj₂ (suc x) y z p = add-inj₂ x y z (suc-inj p)

add-inj₁ : ∀ x y z → x + z ≡ y + z → x ≡ y
add-inj₁ x y z rewrite add-commute x z | add-commute y z = add-inj₂ z x y
