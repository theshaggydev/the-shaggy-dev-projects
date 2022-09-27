Contains the code used for the big key dungeon generator seen in the video [An introduction to procedural lock and key dungeon generation](https://www.youtube.com/watch?v=BM_4Z27d4rI) and [the associated blog post](https://shaggydev.com/2021/12/17/lock-key-dungeon-generation/).

## The generator
The generator has three exported parameters worth playing with:
* Min nodes - The minimum number of nodes a tree can have
* Max nodes - The maximum number of nodes a tree can have
* Max keys per node - A soft limit on how many keys a node should hold. It's not always possible to respect this limit, so there are occasionally nodes with more keys than this number.

## The drawing function
The drawing function is a fairly naive approach to drawing trees, essentially giving each node its own column and then drawing based on depth, but it's enough to get an idea of the outputs possible with this technique.

## Credits
Font used in this project created by [Kenney](https://www.kenney.nl/assets/kenney-fonts)