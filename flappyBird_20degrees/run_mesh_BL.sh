#!/bin/bash

#foamListTimes -rm -processor

#snappyHexMesh -dict system/snappyHexMeshDict_BL
mpirun -np 4 snappyHexMesh -dict system/snappyHexMeshDict_BL -parallel
