# oru_demo

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/RawatDevanshu/oru_demo.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

in terminal type `flutter run `to execute the project

* Memory management:
   * I utilized the flutter dev-tools to check for any memory leaks,and resolved some memory leak issues by properly disposing the scroll controllers and text editing controllers used in the program
   * also where the grid and list widgets were required i used the `.builder` widgets as they are said to be more memory efficient than the normal ones
   * other than that inside the grid/list views i set the `addAutomaticKeepAlives` and `addRepaintBoundaries` to `false`
* Image Caching:
    * for this i used the `cached_image_network` package which had the `CachedNetworkImage` widget