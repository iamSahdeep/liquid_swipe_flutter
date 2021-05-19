<h1 align="center" xmlns="http://www.w3.org/1999/html">
  <br>
   <img src="https://raw.githubusercontent.com/iamSahdeep/liquid_swipe_flutter/master/assets/page1.png" alt="Liquid Swipe" title="Logo" />
  <br>
</h1>

<p align="center">  
  <a href="https://github.com/iamSahdeep/liquid_swipe_flutter/releases" <img height="20" alt="GitHub All Releases" src="https://img.shields.io/github/downloads/iamSahdeep/liquid_swipe_flutter/total.svg?style=for-the-badge">
  </a>
  <a href="https://www.codacy.com/app/iamSahdeep/liquid_swipe_flutter?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=iamSahdeep/liquid_swipe_flutter&amp;utm_campaign=Badge_Grade"><img src="https://api.codacy.com/project/badge/Grade/ccdaffb33883461b8570cd80f5051631"/>
  </a>
  <a href="https://pub.dev/packages/liquid_swipe"> <img height="20" alt="Pub" src="https://img.shields.io/pub/v/liquid_swipe.svg?style=for-the-badge">
  </a>
  <a href="https://github.com/iamSahdeep/liquid_swipe_flutter/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-APACHE2.0-blue.svg?longCache=true&style=flat-square">
  </a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Built%20for-Flutter-blue.svg?longCache=true&style=flat-square" ">
  </a>
  <a href="https://github.com/Solido/awesome-flutter">
   <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
  </a>
  <a href="https://codecov.io/gh/iamSahdeep/liquid_swipe_flutter">
  <img src="https://codecov.io/gh/iamSahdeep/liquid_swipe_flutter/branch/master/graph/badge.svg?token=lGlgjaHbqJ"/>
  </a>
</p>

<p align="center">
  This repository contains the <strong>Liquid Swipe Flutter</strong> source code.
  Liquid swipe is the revealing clipper to bring off amazing liquid like swipe to stacked Container/Widgets and inspired by <a href="https://github.com/Cuberto/liquid-swipe"> Cuberto's liquid swipe</a> and <a href="https://github.com/aagarwal1012/IntroViews-Flutter">IntroViews</a>.
</p>

<p align="center">
<img src="https://raw.githubusercontent.com/iamSahdeep/liquid_swipe_flutter/master/assets/example.gif" width="310" height="640">
<img src="https://raw.githubusercontent.com/iamSahdeep/liquid_swipe_flutter/master/assets/another.gif" width="310" height="640">
</p>

 
# Table of contents
  * [Getting Started](#getting-started)
  * [Usage](#usage)
  * [Migration](#migration) 
  * [Sample APK](#sample-apk)
  * [Documentation](#documentation)
    * [LiquidSwipe](#liquidswipe)
  	* [LiquidController](#liquidcontroller)  
  * [Credits](#credits )
  * [Author & Support](#author--support)
  * [Contributors](#contributors-)


# Getting Started

* Add this to your pubspec.yaml
  ```
  dependencies:
  liquid_swipe: ^2.1.0
  
  ```
* Get the package from Pub:

  ```
  flutter packages get
  ```
* Import it in your file

  ```
  import 'package:liquid_swipe/liquid_swipe.dart';
  ```
  
# Usage

 - *`Liquid Swipe`* just requires the list of [`Widgets like Container`](https://api.flutter.dev/flutter/widgets/Container-class.html). Just to provide flexibity to the developer to design its own UI through it.
 ```dart
 final pages = [
    Container(...),
    Container(...),
    Container(...),
  ];
 ```
 
 * Now just pass these pages to LiquidSwipe widget.
 ```dart
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Builder(
          builder: (context) =>
              LiquidSwipe(
                  pages: pages
              )),
    );
  }
 ```

 * Check out the complete [Example](https://github.com/iamSahdeep/liquid_swipe_flutter/tree/master/example)

# Migration

Some things to keep in mind while updating to v2.0.0 from any version.
 * v2.0.0 is migrated to null safety. See [migration](https://dart.dev/null-safety/migration-guide)
 * Attribute `enableSlideIcon` is removed from LiquidSwipe. You can simply pass `null` to `slideIconWidget` to enable and disable it.
 * Attribute `positionSlideIcon` is now ranged from 0.0 to 1.0.
 * Next Reveal is there by default. If you want to disable it you might want to make changes in your fork. Create an issue I will help.

That's it ;)

# Sample APK

Please download apk from [Releases](https://github.com/iamSahdeep/liquid_swipe_flutter/releases) or [Assets](https://github.com/iamSahdeep/liquid_swipe_flutter/tree/master/assets) folder

 
# Documentation  

## LiquidSwipe

Please Refer to [API documentation](https://pub.dev/documentation/liquid_swipe/latest/liquid_swipe/LiquidSwipe-class.html) for more details. 

| Property | Type | Description | Default Value |
|-|:-:|-|:-:|
| pages | `List<Widget>` | Set Pages/Views/Containers. See complete example for usage. | @required value |
| fullTransitionValue | `double` | Handle swipe sensitivity  through it. Lower the value faster the animation | 400.0 |
| initialPage | `int` | Set initial page value, wrong position will throw exception. | 0 |
| slideIconWidget | `Widget` | Icon/Widget you want to display for swipe indication. Remember the curve will be created according to it. | null |
| positionSlideIcon | `double` | Icon position on vertical axis. Must satisfy this condition `0.0 <= value <= 1.0` | 0.8 |
| enableLoop | `bool` | Whether you want to loop through all those `pages`.  | true |
| liquidController | `LiquidController` | Controller to handle some runtime changes. [Refer](#liquidcontroller) | null |
| waveType | `WaveType enum` | Type of clipper you want to use. | WaveType.liquidReveal |
| onPageChangeCallback | `Callback` | Triggered whenever page changes. | null |
| currentUpdateTypeCallback | `Callback` | Triggered whenever UpdateType changes. [Refer](https://pub.dev/documentation/liquid_swipe/latest/Helpers_Helpers/UpdateType-class.html) | null |
| slidePercentCallback | `Callback` | Triggered on Swipe animation. Use carefully as its quite frequent on swipe. | null |
| ignoreUserGestureWhileAnimating | `bool` | If you want to block gestures while swipe is still animating. See #5 | false |
| disableUserGesture | `bool` | Disable user gesture, always. | false |
| enableSideReveal | `bool` | Enable/Disable side reveal | false |

## LiquidController

A Controller class with some utility fields and methods.

Simple Usage :

Firstly make an Object of LiquidController and initialize it in initState()
```dart
   LiquidController liquidController;

   @override
   void initState() {
   super.initState();
   liquidController = LiquidController();
   }
```

Now simply add it to LiquidSwipe's Constructor
```dart
   LiquidSwipe(
        pages: pages,
        LiquidController: liquidController,
    ),
```

Only Rules/Limitation to its Usage is, you can't use any method in Liquid Controller before build method is being called in which LiquidSwipe is initialized. So we have to use them after LiquidSwipe is Built

- Properties
  - `currentPage` - Getter to get current Page. Default value is 0.
  - `isUserGestureDisabled` - If somehow you want to check if gestures are disabled or not. Default value is false;
- Methods
  - `animateToPage({required int page, int duration = 600})` 
     Animate to mentioned page within given Duration Remember the duration here is the total duration in which it will animate though all pages not the single page.
  - `jumpToPage({required int page})` 
    Jump Directly to mentioned Page index but without Animation.
  -  `shouldDisableGestures({required bool disable})`
      Use this method to disable gestures during runtime, like on certain pages using OnPageChangeCallback.

Please Refer to [API documentation](https://pub.dev/documentation/liquid_swipe/latest/PageHelpers_LiquidController/LiquidController-class.html) for more details. 


# Credits
   - [Cuberto](https://github.com/Cuberto) for awesome implemented [Liquid Swipe](https://github.com/Cuberto/liquid-swipe) in Swift.
   - [@aagarwal1012](https://github.com/aagarwal1012) for [IntroViews](https://github.com/aagarwal1012/IntroViews-Flutter), it made my work too easy.

### Disclaimer : This project is not anyhow connected to Cuberto, but have apprised them through this [issue](https://github.com/Cuberto/liquid-swipe/issues/10).  
 
# Author & support
This project is created by [Sahdeep Singh](https://github.com/iamSahdeep) but with lots of support and help. See credits.
> If you appreciate my work, consider buying me a cup of :coffee: to keep me recharged :metal:
>  + [PayPal](https://www.paypal.me/sahdeep)
>
> Or you can also connect/endorse me on [LinkedIn](https://www.linkedin.com/in/iamsahdeep/) to keep me motivated.


<img src="https://cdn-images-1.medium.com/max/1200/1*2yFbiGdcACiuLGo4dMKmJw.jpeg" width="90" height="35">

# Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://sahdeepsingh.com"><img src="https://avatars1.githubusercontent.com/u/26563213?v=4" width="100px;" alt=""/><br /><sub><b>Sahdeep Singh</b></sub></a><br /><a href="https://github.com/iamSahdeep/liquid_swipe_flutter/commits?author=iamSahdeep" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/YasserOJ"><img src="https://avatars0.githubusercontent.com/u/26030291?v=4" width="100px;" alt=""/><br /><sub><b>Yasser Omar Jammeli</b></sub></a><br /><a href="https://github.com/iamSahdeep/liquid_swipe_flutter/commits?author=YasserOJ" title="Code">💻</a> <a href="https://github.com/iamSahdeep/liquid_swipe_flutter/issues?q=author%3AYasserOJ" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/mourad-brahim"><img src="https://avatars1.githubusercontent.com/u/17046133?v=4" width="100px;" alt=""/><br /><sub><b>Mourad Brahim</b></sub></a><br /><a href="https://github.com/iamSahdeep/liquid_swipe_flutter/commits?author=mourad-brahim" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/heshesh2010"><img src="https://avatars1.githubusercontent.com/u/16393042?v=4" width="100px;" alt=""/><br /><sub><b>heshesh2010</b></sub></a><br /><a href="https://github.com/iamSahdeep/liquid_swipe_flutter/issues?q=author%3Aheshesh2010" title="Bug reports">🐛</a> <a href="#userTesting-heshesh2010" title="User Testing">📓</a></td>
    <td align="center"><a href="https://github.com/ssoldy"><img src="https://avatars2.githubusercontent.com/u/45917574?v=4" width="100px;" alt=""/><br /><sub><b>Federico Tarascio</b></sub></a><br /><a href="https://github.com/iamSahdeep/liquid_swipe_flutter/commits?author=ssoldy" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
