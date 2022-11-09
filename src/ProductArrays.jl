module ProductArrays

using LinearAlgebra
using ZippedArrays

import Base: size, axes, getindex, CartesianIndices
import LinearAlgebra: diag

export ProductArray

include("cartesian.jl")
include("arrays.jl")

end
