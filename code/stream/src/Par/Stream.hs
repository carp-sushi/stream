module Par.Stream where

import Control.DeepSeq
import Control.Monad.Par

-- IList is a parallel data structure.
data IList a
    = Nil
    | Cons a (IVar (IList a))
    | Fork (Par ()) (IList a)

-- Stream is an IList that can be read (blocking) and written in parallel.
type Stream a = IVar (IList a)

-- Describe how to fully evaluate an IList
instance (NFData a) => NFData (IList a) where
    rnf Nil = ()
    rnf (Cons a b) = rnf a `seq` rnf b
    rnf (Fork op a) = seq op $ rnf a
