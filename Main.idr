data Sym = Z | O

record DFA where
  constructor MkDFA
  nStates : Nat
  {auto nPos : IsSucc nStates}
  delta : Fin nStates -> Sym -> Fin nStates
  start : Fin nStates
  accept : Fin nStates -> Bool

run : (d : DFA) -> Fin d.nStates -> List Sym -> Fin d.nStates
run d q []        = q
run d q (s :: ss) = run d (d.delta q s) ss

-- "L is regular": there EXISTS a DFA deciding it (a dependent pair)
IsRegular : (List Sym -> Bool) -> Type
IsRegular l = (d : DFA ** (w : List Sym) -> d.accept (run d d.start w) = l w)

-- constructive pigeonhole over Fin (prove by induction, ~30 lines)
pigeonhole : (f : Fin (S n) -> Fin n) ->
             (i : Fin (S n) ** (j : Fin (S n) ** (Not (i = j), f i = f j)))

l01 : List Sym -> Bool
l01 w = case splitZerosOnes w of   -- w = 0ᵃ1ᵇ with a == b
          ...

notRegular : IsRegular l01 -> Void
notRegular (d ** spec) =
  let (i ** (j ** (ineq, eq))) = pigeonhole (\k => run d d.start (replicate (finToNat k) Z))
  in -- run d start (0ʲ ++ 1ⁱ) = run d (run d start 0ʲ) 1ⁱ
     --                        = run d (run d start 0ⁱ) 1ⁱ   (by eq)
     -- hence d accepts 0ʲ1ⁱ, but l01 (0ʲ1ⁱ) = False — contradiction with spec
     ?finish