module ProductArrays

using LinearAlgebra
using ZippedArrays
using OnlyArrays

import Base: parent, size, axes, getindex
import LinearAlgebra: diag

export ProductArray, arguments, product
export CartesianPlane

include("array.jl")
include("cartesian.jl")

end
