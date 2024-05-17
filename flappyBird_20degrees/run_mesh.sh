#!/bin/bash

foamCleanTutorials

rm -rf 0

cp geometry/cessna210.stl constant/triSurface/surfacemesh.stl

surfaceTransformPoints 'scale=(0.3 0.3 0.3)' constant/triSurface/surfacemesh.stl constant/triSurface/surfacemesh_scaled.stl

surfaceFeatures



#Run SHM in parallel (4 procs)

blockMesh -dict system/blockMeshDict_V1

decomposePar

mpirun -np 4 snappyHexMesh -parallel -overwrite | tee log.shm

mpirun -np 4 checkMesh -parallel | tee log.checkmesh

reconstructParMesh -constant

createPatch -overwrite

#New way to rename entires in dictionaries
#entry0 is default dictionary block
foamDictionary constant/polyMesh/boundary -entry entry0/cessna/type -set wall
foamDictionary constant/polyMesh/boundary -entry entry0/cessna/inGroups -remove

