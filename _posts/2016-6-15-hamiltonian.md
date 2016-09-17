---
layout: post
title: Hamiltonian Stroll
tags:
    - graph theory
    - graphs
    - d3
    - graphml
---

Years ago, a good friend and I strolled around the [Morristown Green](http://morristowngreen.com), enjoying the wandering paths and the scenery. We mused on the feasibility of walking around the _entire_ park, hitting each intersection of paths once and only once, in what's known as a [_Hamiltonian Walk_](https://en.wikipedia.org/wiki/Hamiltonian_path).

> **Disclaimer.** This post will not be about presidents or musicals.

If you've ever considered this problem yourself, you know how hard of a problem it is to solve, even for pretty small journeys. In fact, this problem is known in the field of computer science to be ["NP-Hard"](https://en.wikipedia.org/wiki/NP-completeness) (indeed, NP-complete), which means that as the set of edges (more accurately, the 'nodes' between the edges) gets larger, the time it takes to compute a Hamiltonian path increases _exponentially_.

Here's the graph representation of the Morristown Green:

> <img src="/assets/img/mogreen-arch.png" width="47%">
> <img src="/assets/img/mogreen-geo.png" width="47%">
> <small>Note that the graph version has the same layout as the geography of the park. This image is the last place in this post where that will be the case, since the layout and lengths of the edges are completely irrelevant when solving the Hamiltonian-walk problem (and so I ignore them).

I generated this in [yWorks](http://live.yworks.com/yfiles-for-html/1.3/demos/graphviewer/demo.yfiles.graph.fileoperations/index.html), an online platform that spits out GraphML files. But! How do you visualize GraphML files? Naturally there are a million tools for this. But... what if I really really _really_ want to use [d3.js](https://d3js.org/)?

[Here's a script I adopted](https://gist.github.com/j6k4m8/7349fc36476f0b486b489b5a14a03052) from @anderser on GitHub that converts GraphML to JSON, readable in d3.

So now we can use the [demo force-directed graph](https://bl.ocks.org/mbostock/4062045) d3 demo-code — ready to go straight outta the box! When we run that code, we get the following:

> <img src="/assets/img/mogreen-fd.png" width="47%">
> <small>Like I said, we lose geography in favor of having a *tiny* little file with no superfluous data.

Now this is a graph-theory problem! If we had instead asked something like "how far is the shortest Hamiltonian path", then we'd naturally need to hold onto distance data and this would be an inadequate solution. But our question is simply, "does a Hamiltonian path exist"?

## Some priors:

- We know that this graph is 2-cell embeddable on a closed 2D surface. (In english, this means that you can draw this graph on a sheet of paper without ever crossing an old edge.) Why do we know this? Because it's a map! It exists already as a 2D embedding in _real life_. That's an adequate existence-proof.
- The minimum degree of the graph is 3 (that is, the node with the fewest edges has three edges that enter or leave it). This is partially a function of how I designed the problem: If a node has a degree of 2, then it's reducible to a simple edge.
- The maximum degree is 5 (in the center).


> ## Sufficiency
> We can test out a few proofs for how this graph is *sufficient* to be Hamiltonian, even if we can't prove that it _is_. (If we were unable to prove one of these sufficiency-proofs, then we could quickly say that there is no Hamiltonian path, without having to do any more work.)
>
> ### Dirac Theorem
> If the minimum degree of the graph is half of the number of vertices, then it's Hamiltonian. _n_ = 29 here, and 3 is definitely not half of 29... so we don't prove or rule out anything here.

So let's formally define our question. In fact, let's formally define a new type of graph, called an *Enjoyable Stroll* graph, that is at least Hamiltonian (when walking the graph, you encounter every intersection, or node, at least once) or Eulerian (you visit every _edge_ at least once), or *both*.
