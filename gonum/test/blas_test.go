package main

import (
	"testing"
	"math/rand"
	"gonum.org/v1/gonum/blas/gonum"
	"gonum.org/v1/netlib/blas/netlib"
	"gonum.org/v1/gonum/blas"
	"gonum.org/v1/gonum/blas/blas64"
)

const M = 300
const N = 300
const K = 300

func BenchmarkGoBlas64(b *testing.B) {
	blas64.Use(gonum.Implementation{})
	in1 := make([]float64, M * K)
	in2 := make([]float64, K * N)
	for i := range in1 {
		in1[i] = rand.NormFloat64()
		in2[i] = rand.NormFloat64()
	}
	out := make([]float64, M * N)
	b.SetBytes(M*K*N)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		blas64.Gemm(blas.NoTrans, blas.NoTrans, 1, blas64.General{
			Rows:   M,
			Cols:   K,
			Stride: K,
			Data:   in1,
		}, blas64.General{
			Rows:   K,
			Cols:   N,
			Stride: N,
			Data:   in2,
		}, 1, blas64.General{
			Rows:   M,
			Cols:   N,
			Stride: N,
			Data:   out,
		})
	}
}

func BenchmarkCBlas64(b *testing.B) {
	blas64.Use(netlib.Implementation{})
	in1 := make([]float64, M * K)
	in2 := make([]float64, K * N)
	for i := range in1 {
		in1[i] = rand.NormFloat64()
		in2[i] = rand.NormFloat64()
	}
	out := make([]float64, M * N)
	b.SetBytes(M*K*N)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		blas64.Gemm(blas.NoTrans, blas.NoTrans, 1, blas64.General{
			Rows:   M,
			Cols:   K,
			Stride: K,
			Data:   in1,
		}, blas64.General{
			Rows:   K,
			Cols:   N,
			Stride: N,
			Data:   in2,
		}, 1, blas64.General{
			Rows:   M,
			Cols:   N,
			Stride: N,
			Data:   out,
		})
	}
}
