module AnnealingRollbackAPI

"""
Abstract type for a rollback token returned by `update_corrfns!`.
"""
abstract type AbstractRollbackToken end

"""
    update_corrfns!(tracker, value, index)

This function is equivalent to writing `tracker[index] = value` with
exception that it also returns a rollback handle which can fastly
bring the tracker to the previous state by calling `rollback!`.

See also: [`rollback!`](@ref).
"""
function update_corrfns! end

"""
    rollback!(tracker, token)

Bring the system to the state before `update_corrfns!` was
called. `token` must be an object returned by `update_corrfns!`.

See also: [`update_corrfns!`](@ref).
"""
function rollback! end

function rollback!(array    :: AbstractArray,
                   rollback :: AbstractRollbackToken)
    array[rollback.index] = 1 - array[rollback.index]
end

export AbstractRollbackToken, update_corrfns!, rollback!

end # module
