CartesianIndices(args::OrdinalRange{<:Integer,<:Integer}...) =
    CartesianIndices(args)
CartesianIndices{N,T}(args...) where {N,T<:NTuple{N,OrdinalRange{<:Integer,<:Integer}}} =
    CartesianIndices(args)
