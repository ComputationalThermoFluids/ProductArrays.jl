using LinearAlgebra
using ProductArrays
using Test

using Base: OneTo

@testset "tuple" begin
    xyz = OneTo(10), -π:0.1:π+2, -1:5

    pa = product(xyz)

    @test isequal(pa[5, 1, 3], (5, -π, 1))
    @test isequal(pa[5, 1, 3], pa[CartesianIndex(5, 1, 3)])
end

@testset "CartesianIndex" begin
    xyz = OneTo(10), -1:5
    pa = product(CartesianIndex, xyz)

    @test isequal(pa[5, 5], CartesianIndex(5, 3))
    @test isequal(pa[5, 5], pa[CartesianIndex(5, 5)])

    d = diag(pa)

    @test isequal(first(d), CartesianIndex(1, -1))
end

@testset "CartesianIndices" begin
    xyz = [OneTo(10), UnitRange(-1, 5)],
          [UnitRange(0, 2), OneTo(3), UnitRange(-1, 1)]
    pa = product(CartesianIndices, xyz)

    @test isequal(pa[2, 2], CartesianIndices((UnitRange(-1, 5), OneTo(3))))

    pa = product(CartesianIndex{2}, (Base.OneTo(4), 2:4:6))
    @test isequal(first(pa), CartesianIndex(1, 2))
    @test isequal(last(pa), CartesianIndex(4, 6))
    @test isa(pa, CartesianIndices)

    pa = product(CartesianIndex, (Base.OneTo(4), 2:4:6))
    @test isequal(first(pa), CartesianIndex(1, 2))
    @test isequal(last(pa), CartesianIndex(4, 6))
    @test isa(pa, CartesianIndices)
end

@testset "CartesianPlane" begin
    i = 3
    n = (4, 8)
    plane = CartesianPlane{2}(i, CartesianIndices(n))

    @test (===)(size(plane), n)
    @test (===)(first(plane), CartesianIndex(1, i, 1))
    @test (===)(plane[i-1, i+1], CartesianIndex(i-1, i, i+1))
    @test (===)(last(plane), CartesianIndex(n[1], i, n[2]))
end
