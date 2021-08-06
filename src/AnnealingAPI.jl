module AnnealingAPI

using CorrelationFunctions: Directional

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

"""
    Generic type for correlation function tracker.

See also: [`L2Tracker`](@ref), [`S2Tracker`](@ref),
[`SSTracker`](@ref).
"""
abstract type AbstractTracker{T} end

"""
    L2Tracker(phase)

Descriptor for line-segment correlation function for the phase
`phase`.

See also: [`S2Tracker`](@ref), [`SSTracker`](@ref),
[`AbstractTracker`](@ref).
"""
struct L2Tracker{T} <: AbstractTracker{T}
    phase :: T
end

"""
    S2Tracker(phase)

Descriptor for two-point correlation function for the phase
`phase`.

See also: [`L2Tracker`](@ref), [`SSTracker`](@ref),
[`AbstractTracker`](@ref).
"""
struct S2Tracker{T} <: AbstractTracker{T}
    phase :: T
end

"""
    SSTracker(phase)

Descriptor for surface-surface correlation function for the phase
`phase`.

See also: [`S2Tracker`](@ref), [`L2Tracker`](@ref),
[`AbstractTracker`](@ref).
"""
struct SSTracker{T} <: AbstractTracker{T}
    phase :: T
end

"""
    SVTracker(phase)

Descriptor for surface-void correlation function for the phase
`phase`.

See also: [`S2Tracker`](@ref), [`L2Tracker`](@ref),
[`SSTracker`](@ref), [`AbstractTracker`](@ref).
"""
struct SVTracker{T} <: AbstractTracker{T}
    phase :: T
end

(tracked :: L2Tracker{T})(system :: AbstractArray{T}; kwargs...) where T =
    Directional.l2(system, tracked.phase; kwargs...)
(tracked :: S2Tracker{T})(system :: AbstractArray{T}; kwargs...) where T =
    Directional.s2(system, tracked.phase; kwargs...)
(tracked :: SSTracker{T})(system :: AbstractArray{T}; kwargs...) where T =
    Directional.surfsurf(system, tracked.phase; kwargs...)
(tracked :: SVTracker{T})(system :: AbstractArray{T}; kwargs...) where T =
    Directional.surfvoid(system, tracked.phase; kwargs...)

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

export
    AbstractRollbackToken,
    update_corrfns!,
    rollback!,

    AbstractTracker,
    S2Tracker,
    L2Tracker,
    SSTracker,
    SVTracker,

    tracked_data,
    tracked_length,
    tracked_directions

end # module
