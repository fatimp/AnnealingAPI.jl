# Most used instances of AbstractTracker

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
