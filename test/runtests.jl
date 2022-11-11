using LinearAlgebra
using ProductArrays
using Test

@testset "tuple" begin
    xyz = Base.OneTo(10), -π:0.1:π+2, -1:5

    pa = ProductArray(tuple, xyz)

    @test isequal(pa[5, 1, 3], (5, -π, 1))
    @test isequal(pa[5, 1, 3], pa[CartesianIndex(5, 1, 3)])
end

@testset "CartesianIndex" begin
    xyz = Base.OneTo(10), -1:5
    pa = ProductArray(CartesianIndex, xyz)

    @test isequal(pa[5, 5], CartesianIndex(5, 3))
    @test isequal(pa[5, 5], pa[CartesianIndex(5, 5)])

    d = diag(pa)

    @test isequal(first(d), CartesianIndex(1, -1))
end

@testset "CartesianIndices" begin
    xyz = [Base.OneTo(10), UnitRange(-1, 5)],
          [UnitRange(0, 2), Base.OneTo(3), UnitRange(-1, 1)]
    pa = ProductArray(CartesianIndices, xyz)

    @test isequal(pa[2, 2], CartesianIndices((UnitRange(-1, 5), Base.OneTo(3))))
end

@testset "FlattenedProduct" begin
    xyz = [Base.OneTo(10), UnitRange(-1, 5)],
          [UnitRange(0, 2), Base.OneTo(3), UnitRange(-1, 1)]
    pa = ProductArray(CartesianIndices, xyz)
    fp = FlattenedProduct(pa)

    @test isequal(size(fp), (17, 9))
    @test isequal(fp[1, 1], CartesianIndex(1, 0))
    @test isequal(fp[17, 9], CartesianIndex(5, 1))
    @test isequal(fp[10, 3], CartesianIndex(10, 2))
    @test isequal(fp[11, 3], CartesianIndex(-1, 2))
    @test isequal(fp[11, 4], CartesianIndex(-1, 1))

    xyz = [Base.OneTo(2), UnitRange(3, 4)],
          [UnitRange(-1, 0), Base.OneTo(2)]
    pa = ProductArray(CartesianIndices, xyz)
    fp = FlattenedProduct(pa)

    @test all(isequal.(fp, CartesianIndices((Base.OneTo(4), UnitRange(-1, 2)))))
end
