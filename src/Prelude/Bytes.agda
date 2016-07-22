module Prelude.Bytes where

{-# IMPORT Data.ByteString #-}

postulate
  Bytes : Set
{-# COMPILED_TYPE Bytes Data.ByteString.ByteString #-}


private
  module Internal where
    postulate
      empty : Bytes
      append : Bytes → Bytes → Bytes
    {-# COMPILED empty Data.ByteString.empty #-}
    {-# COMPILED append Data.ByteString.append #-}


open import Prelude.Monoid
instance
  MonoidBytes : Monoid Bytes
  MonoidBytes = record { mempty = Internal.empty; _<>_ = Internal.append }


