# matlab-tag-reader
Take a SliceOMatic .TAG file and read it as a uint16 array in MATLAB.

I was surprised to see no existing code to do this online.

I decided to make my own.

SliceOmatic 5.0 docs: https://www.tomovision.com/SliceO_Help/index.htm?context=570

Essentially, in this script, we trim out the header by reading the bytes only after a certain point.
Then, it's easy because the rest is a 1-dimensional array containing all the data.

Simply resize this array into the shape you need, e.g. 512x512.

Voila! It's as simple as that.

I used this for a segmentation problem, so I read my DICOMs:
```imds = imageDatastore('my dir would be right here', ...
    'FileExtensions', '.dcm', 'ReadFcn',@(x) dicomread(x));
```
    
and my pxds:
```
pxds = pixelLabelDatastore('folder where I stored the tiffs', classNames, labelIDs,'FileExtensions','.tiff');
```

One thing to look into is instead saving the labels you have (the .TAG)s into a .mat and then use the matReader as a function in your pxds.
This would potentially save time and compute resources.

However, since these are simple 2D slices, it was fine saving it as a .tiff for me.
