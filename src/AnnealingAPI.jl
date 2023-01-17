module AnnealingAPI

include("api.jl")
include("instances.jl")

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
