# Percolation
Based on [CS61B HW2: Percolation](https://sp19.datastructur.es/materials/hw/hw2/hw2)

## Introduction

This program estimates the value of the percolation threshold via [Monte Carlo simulation](https://en.wikipedia.org/wiki/Monte_Carlo_method).

### What is Percolation Problem?

Scientists have defined the following situations to be defined as percolation:

1. Given a composite systems consisting of randomly distributed insulating and metallic materials, what fraction of the materials need to be metallic so that the composite system becomes an electrical conductor? 

2. Given a porous landscape with water on the surface (or oil below), under what conditions will the water be able to drain through the bottom (or oil to gush through the surface)?

## NxN Grid Model

In this project, the percolation system is modeled using an NxN grid of sites where each site is either open or blocked. A full site is an open site that is connected to an open sit ein the top row via a chain of connecting (left, right, above, below) open sites. We say **the system percolates if there is a full site in the bottom row**. Below is a representation when the system **percolates (left)** and **does not percolate (right)**.

![](https://sp19.datastructur.es/materials/hw/hw2/images/percolates.png)

## Probability of the System Percolates
If sites are independently set to be open with probability `p` (and therefore blocked with probability `1-p`), **what is the probability that the system percolates?**
* When `p=0`, system does not percolate
* When `p=1`, system percolates

The plots below show the site vacancy probability `p` versus the percolation probability for **20x20 random grid (left)** and **100x100 random grid (right)**.

![](https://sp19.datastructur.es/materials/hw/hw2/images/percolation-threshold20.png) ![](https://sp19.datastructur.es/materials/hw/hw2/images/percolation-threshold100.png)

When `N` is sufficiently large, there's a threshold value `p*` such that:
* When `p < p*`, a random NxN grid almost never percolates
* When `p > p*`, a random NxN grid almost always percolate.

This program estimates the value of `p*`.