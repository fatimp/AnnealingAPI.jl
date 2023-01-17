"""
Abstract type for a rollback token returned by `update_corrfns!`.
"""
abstract type AbstractRollbackToken end


"""
    SimpleRollbackToken(value, index)

Create a simple rollback token which just holds an index and an old
value at that index.
"""
struct SimpleRollbackToken{T, N} <: AbstractRollbackToken
    value :: T
    index :: CartesianIndex{N}
end

"""
    update_corrfns!(tracker, value, index)

This function is equivalent to writing `tracker[index] = value` with
exception that it also returns a rollback handle which can fastly
bring the tracker to the previous state by calling `rollback!`.

See also: [`rollback!`](@ref).
"""
function update_corrfns! end

function update_corrfns!(array :: AbstractArray{T, N},
                         val,
                         index :: CartesianIndex{N}) where {T, N}
    token = SimpleRollbackToken(array[index], index)
    array[index] = val
    return token
end

"""
    rollback!(tracker, token)

Bring the system to the state before `update_corrfns!` was
called. `token` must be an object returned by `update_corrfns!`.

See also: [`update_corrfns!`](@ref).
"""
function rollback! end

rollback!(array :: AbstractArray, rollback :: AbstractRollbackToken) =
    array[rollback.index] = 1 - array[rollback.index]

rollback!(array    :: AbstractArray{T, N},
          rollback :: SimpleRollbackToken{T, N}) where {T, N} =
    array[rollback.index] = rollback.value

"""
    Generic type for correlation function tracker.

See also: [`L2Tracker`](@ref), [`S2Tracker`](@ref),
[`SSTracker`](@ref).
"""
abstract type AbstractTracker{T} end

"""
    tracked_data(x :: AbstractArray)

Return an iterator over correlation function descriptors which are
tracked by the tracker `x`.
"""
function tracked_data end

"""
    tracked_length(x :: AbstractArray)

Return maximal tracked correlation length
"""
function tracked_length end

"""
    tracked_directions(x :: AbstractArray)

Return directions along which correlation functions are tracked.
"""
function tracked_directions end
