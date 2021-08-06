# AnnealingRollbackAPI

This package provides an API used in `CorrelationTrackers.jl` and
`MaterialReconstruction.jl` packages which is used to make small modifications
to annealed arrays and be able to roll back a bad modification. This API
consists of two functions: `update_corrfns!` and `rollback!`. The first function
must behave like `setindex!` but return a rollback token of type
`AbstractRollbackToken` which can be used by the second function to bring an
array to the previous state.

Typically, annealed arrays have type `CorrelationTracker` which uses this
mechanism to track a set of correlation functions.
