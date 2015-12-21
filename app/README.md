SpatialViewer
=============

This is a Leaflet / AngularJS project that can be used as the viewer for SpatialServer.

The JavaScript gets compiled to a single file with browserify as `dist/spatial-viewer.js`. 

I recommend installing watchify and running the following:

```
npm install -g watchify
```

```
watchify scripts/app.js -o dist/spatial-viewer.js -v
```

This will automatically compile as you shred your code.
