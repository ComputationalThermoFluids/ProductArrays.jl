module ProductArrays

using LinearAlgebra
using ZippedArrays

import Base: parent, size, axes, getindex
import LinearAlgebra: diag

export ProductArray, FlattenedProduct, Slurped

include("arrays.jl")
include("flattened.jl")
include("slurped.jl")
include("cartesian.jl")

end
