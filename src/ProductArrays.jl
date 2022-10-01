module ProductArrays

using LinearAlgebra
using ZippedArrays

import Base: parent, size, axes, getindex
import LinearAlgebra: diag

export ProductArray

include("arrays.jl")

end
