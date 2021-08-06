# AnnealingAPI

This package provides an API used in `CorrelationTrackers.jl` and
`MaterialReconstruction.jl`. There are two kinds of functions and types.

The first kind is used to make small modifications to annealed arrays and be
able to roll back a bad modification. This API consists of two functions:
`update_corrfns!` and `rollback!`. The first function must behave like
`setindex!` but return a rollback token of type `AbstractRollbackToken` which
can be used by the second function to bring an array to the previous state.

The second kind contains types like `AbstractTracker`, `S2Tracker`, `L2Tracker`
and so on which are used to designate a correlation function plus phase which
must be used in the annealing process. There are also `tracked_data`,
`tracked_length` and `tracked_directions` functions which you may wish to
implement in correlation tracker.
