To use these Vector Tile mbtiles sources, place them in the `data/pbf_mbtiles` directory of SpatialServer
and then restart.

The corresponding endpoint to get the tiles will be:

```
http://spatial-server-url.com/services/vector-tiles/[vector-tile-set-name]/{z}/{x}/{y}.pbf
```

If the mbtiles is `gadm2014kenya.tm2source.mbtiles`, then the `vector-tile-set-name` would be `gadm2014kenya`:

```
http://localhost:3001/services/vector-tiles/gadm2014kenya/{z}/{x}/{y}.pbf
```
