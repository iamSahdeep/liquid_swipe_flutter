<h1 align="center" xmlns="http://www.w3.org/1999/html">
  <br>
   <img src="https://github.com/iamSahdeep/liquid_swipe_flutter/blob/master/assets/page1.png" alt="Logo Liquid Swipe" title="Logo by  FotoJet ( https://www.fotojet.com/ )" />
  <br>
</h1>
<p align="center">  
 <a href="https://github.com/iamSahdeep/liquid_swipe_flutter/releases" <img height="20" alt="GitHub All Releases" src="https://img.shields.io/github/downloads/iamSahdeep/liquid_swipe_flutter/total.svg?style=for-the-badge"></a>
<a href="https://www.codacy.com/app/iamSahdeep/liquid_swipe_flutter?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=iamSahdeep/liquid_swipe_flutter&amp;utm_campaign=Badge_Grade"><img src="https://api.codacy.com/project/badge/Grade/ccdaffb33883461b8570cd80f5051631"/></a>
 <a href="https://pub.dev/packages/liquid_swipe"> <img height="20" alt="Pub" src="https://img.shields.io/pub/v/liquid_swipe.svg?style=for-the-badge"></a>
 <a href="https://github.com/iamSahdeep/liquid_swipe_flutter/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-APACHE2.0-blue.svg?longCache=true&style=flat-square"></a>
   <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Built%20for-Flutter-blue.svg?longCache=true&style=flat-square" "></a>
  <a href="https://github.com/Solido/awesome-flutter">
   <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
</a>
</p>

<p align="center">
  This repository contains the <strong>Liquid Swipe</strong> source code.
  Liquid swipe is the revealing clipper to bring off amazing liquid like swipe to stacked Container and inspired by <a href="https://github.com/Cuberto/liquid-swipe"> Cuberto's liquid swipe</a> and <a href="https://github.com/aagarwal1012/IntroViews-Flutter">IntroViews</a>.

</p>

<p align="center">
<img src="https://github.com/iamSahdeep/liquid_swipe_flutter/blob/master/assets/example.gif" width="330" height="640">
<img src="https://github.com/iamSahdeep/liquid_swipe_flutter/blob/master/assets/another.gif" width="330" height="640">
</p>

### Sample APK

Download sample apk as shown in example from releases.

<a href='https://github.com/iamSahdeep/liquid_swipe_flutter/releases'><img alt='Get it from Github Releases' src='https://i0.wp.com/dimitrology.com/wp-content/uploads/2017/02/download-apk.png?resize=172%2C100&ssl=1' width="200" height="100"/></a>
 

## Getting Started
* Add this to your pubspec.yaml
  ```
  dependencies:
  liquid_swipe: ^1.4.0
  
  ```
* Get the package from Pub:

  ```
  flutter packages get
  ```
* Import it in your file

  ```
  import 'package:liquid_swipe/liquid_swipe.dart';
  ```
  
## Usage

 - *`Liquid Swipe`* just requires the list of [`containers`](https://api.flutter.dev/flutter/widgets/Container-class.html). Just to provide flexibity to the developer to design its own view through it.
 ```
 final pages = [
    Container(...),
    Container(...),
    Container(...),
  ];
 ```
 
 * Now just pass these pages to LiquidSwipe widget.
 ```
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
 
### Attributes  
  
| Attribute        | Datatype       |     Description                                                                                   |                                          Default Value                                          |                                          Comments                                          |
| :-------------------- | :------------- | :------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------: |:---------------------------------------------------------------------------------------------: |
| pages             | `List<Container>`         | Set the Pages/ views/ Containers                   |                                              Null                                               | A Page can contain anything, look for an example|
| fullTransitionValue             | `double` | Sets the scroll distance or sensitivity for a complete swipe.                                       |                                              400.0 | This transition value can be used to increase or decrease the sensitivity of the swipe. 100.0 would make swipe really fast with even a bit of drag                                               |
| initialPage                 | `int`  | Set the initial Page                                       |                                              0   | Should not be >= no.of pages or smaller than 0                                               |
| enableSlideIcon                  |`bool`  | Used to enable Slide icon to the right for where the wave would originate                                       |                                              false   | Gives a ios style arrow to right side of the screen. Might include modification to it soon.                                               |
| slideIconWidget                 |`Widget`  | Create your own icon and add here                                       |                                              Icon(Icons.arrow_back_ios)   | You can use icons from Icons package. Thanks to PR #10                                               |
| positionSlideIcon                  |`double`  | Position your icon in y-axis at right side of the screen                               |                                              0.54   | Range from -1 to 1, -1 represents extreme top and 1 represent extreme bottom. Soon add x-axis position, if required!                                        |
| enableLoop                 |`bool`  | Enable or disable pages recurrence.                                      |                                              true   | If you dont want to make pages to be in the loop, use this attribute.                                               |
| waveType                 |`WaveType`  | Select the type of reveal you want.                                      |                                              WaveType.liquidReveal   | You can use circularReveal, more coming soon. Import Helpers.dart file if Autoimport doesn't work.                                              |
| onPageChangeCallback                 |`CallBack`  | Pass your method as a callback, it will return a pageNo.                                     |                                              None   | see Example                                              |
| currentUpdateTypeCallback                 |`CallBack`  | same  Callback but returns an UpdateType                                     |                                              None   |  see Example                                            |



# Contributors

Thanks to all these wonderful people and everyone that created issues.
([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<table>
  <tr>
    <td align="center"><a href="https://github.com/mourad-brahim"><img src="https://avatars1.githubusercontent.com/u/17046133?s=400&v=4" width="100px;" alt="mourad-brahim"/><br /><sub><b>Mourad</b></sub></a><br /><a href="https://github.com/iamSahdeep/liquid_swipe_flutter/commits?author=mourad-brahim" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/YasserOJ"><img src="https://avatars2.githubusercontent.com/u/26030291?s=400&v=4" width="100px;" alt="YasserOJ"/><br /><sub><b>YasserOJ</b></sub></a><br /><a href="https://github.com/iamSahdeep/liquid_swipe_flutter/issues/created_by/yasseroj" title="Bug reports">🐛</a><a href="https://github.com/iamSahdeep/liquid_swipe_flutter/commits?author=yasseroj" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/JJCLane"><img src="https://avatars0.githubusercontent.com/u/3543345?s=400&v=4" width="100px;" alt="JJCLane"/><br /><sub><b>Jordon</b></sub></a><br /><a href="https://github.com/iamSahdeep/liquid_swipe_flutter/commits?author=JJCLane" title="Content">🖋</a></td>
  </tr>
</table>

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

### Credits
   - [Cuberto](https://github.com/Cuberto) for awesome [Liquid Swipe](https://github.com/Cuberto/liquid-swipe) in Swift.
   - [@aagarwal1012](https://github.com/aagarwal1012) for [IntroViews](https://github.com/aagarwal1012/IntroViews-Flutter), it made my work too easy.
 
 
## Author & support
This project is created by [Sahdeep Singh](https://github.com/iamSahdeep) but with lots of support and help. See credits.
> If you appreciate my work, consider buying me a cup of :coffee: to keep me recharged :metal:
>  + [PayPal](https://www.paypal.me/sahdeep)
>
> Or you can also endorse me on [LinkedIn](https://www.linkedin.com/in/iamsahdeep/) to keep me motivated.
>
> I love my work and I'm available for freelance work. Contact me on my email: sahdeepsingh98@gmail.com


<img src="https://cdn-images-1.medium.com/max/1200/1*2yFbiGdcACiuLGo4dMKmJw.jpeg" width="90" height="35">
