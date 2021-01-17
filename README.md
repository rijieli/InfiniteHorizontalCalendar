#  Infinite Horizontal Calendar

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A horizontal calendar view, slide both left and right infinitely, using `UICollectionView`.

## Demo

![Demo Image](https://github.com/rijieli/InfiniteHorizontalCalendar/raw/main/Demo.gif)

## Key Point

The key point is to add extra cell to both edge, when the view goes to edge cell, update data source and jump to the cell closer to center using `collectionView.setContentOffSet(_, animated)`.

```
 3 ,[4], 5 , 6 , 7 
    <<< Slide
[3], 4 , 5 , 6 , 7 
 3 , 4 , 2 ,[3], 4 
```

## Next Step

- [ ] Fix blink on first launch
- [ ] Make it configurable
- [ ] Fix when sliding too fast, view updated lag

## Enviroment

- Swift 5.0
- iOS 13.0+

## Related Links

[WWDC 2011: Advanced ScrollView Techniques](https://developer.apple.com/videos/play/wwdc2011/104/)

## License
This project is licensed under the terms of the MIT license.
