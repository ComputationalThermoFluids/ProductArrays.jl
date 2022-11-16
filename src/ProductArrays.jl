module ProductArrays

using LinearAlgebra
using ZippedArrays

import Base: parent, size, axes, getindex
import LinearAlgebra: diag

export ProductArray
export FlattenedProduct
export Slurped
export CartesianPlane

include("array.jl")
include("flattened.jl")
include("slurped.jl")
include("cartesian.jl")

end
