module ProductArrays

using LinearAlgebra
using ZippedArrays

import Base: parent, size, axes, getindex, CartesianIndices
import LinearAlgebra: diag

export ProductArray, FlattenedProduct

include("cartesian.jl")
include("arrays.jl")
include("flattened.jl")

end
