import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:slick_slides/slick_slides.dart';
import 'package:slick_slides_sample/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SlickSlides.initialize();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slick Slides Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const _RootPage(),
    );
  }
}

const _defaultTransition = SlickFadeTransition(
  color: Colors.black,
);

const _codeExampleA = '''class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
  }
}''';

const _codeExampleB = '''class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideDeck(
      slides: [
        Slide(
          builder: (context) {
            return const TitleSlide(
              title: Text('Slick Slides'),
              subtitle: Text('Stunning presentations in Flutter'),
            );
          },
        ),
      ],
    );
  }
}''';

class _RootPage extends StatefulWidget {
  const _RootPage({Key? key}) : super(key: key);

  @override
  __RootPageState createState() => __RootPageState();
}

class __RootPageState extends State<_RootPage> {
  static const _slickSlidesUrl = 'https://pub.dev/packages/slick_slides';

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.asset(
      Assets.video.nightRoad,
    );
    _videoPlayerController.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideDeck(
      slides: [
        FullScreenImageSlide.rich(
          image: Assets.image.backgroundLight.provider(),
          title: const TextSpan(text: 'Slick Slides'),
          subtitle: TextSpan(
            text: 'を使ってスライドを作ってみた\n',
            children: [
              TextSpan(
                text: _slickSlidesUrl,
                mouseCursor: SystemMouseCursors.click,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontSize: 32,
                  height: 3,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchUrl(_slickSlidesUrl);
                  },
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          theme: const SlideThemeData.light(),
          transition: _defaultTransition,
        ),
        BulletsSlide(
          title: 'What is Slick Slides?',
          bulletByBullet: true,
          bullets: const [
            'Slick Slides（スリック スライズ）は、ServerpodがFlutterConカンファレンスでServerpodのために素敵なスライドを作成する必要性から生まれました。',
            '多くの組み込みスライドタイプが付属しており、独自のスライドを簡単に追加できます。',
            'このプレゼンテーションのスライドを閲覧して、Slick Slidesができることを確認してください。',
            'プレゼンテーションでSlick Slidesを使用する場合は、Serverpodに対してこのパッケージに対する取り組みにクレジットを表示してください。また、まだServerpodを試していない場合は、Dartでバックエンドを構築する素晴らしい方法です',
          ],
          notes: 'hoge',
          transition: _defaultTransition,
        ),
        BulletsSlide(
          title: 'Bullets with images',
          image: AssetImage(Assets.image.backgroundDark.path),
          bullets: [
            '1行のコードでプレゼンテーションに画像を追加できます。',
            '箇条書きのスライドにも画像を追加できます。',
          ],
          transition: _defaultTransition,
        ),
        PersonSlide(
          name: 'PersonSlide',
          title: '自己紹介等に使えるスライド',
          image: AssetImage(Assets.image.backgroundDark.path),
          transition: _defaultTransition,
        ),
        BulletsSlide(
          theme: const SlideThemeData.light(),
          title: 'Themes',
          bullets: const [
            '組み込みのテーマを使用するか、独自のテーマを作成してください。',
            'これはデフォルトのライトテーマです。',
          ],
          transition: _defaultTransition,
        ),
        AnimatedCodeSlide(
          title: 'AnimatedCodeSlide',
          subtitle: 'コードをアニメーションで表示することができます',
          formattedCode: [
            FormattedCode(
              code: _codeExampleA,
            ),
            FormattedCode(
              code: _codeExampleB,
              highlightedLines: [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
            ),
          ],
        ),
        VideoSlide(
          videoPlayerController: _videoPlayerController,
          loop: true,
        ),
        FullScreenImageSlide.rich(
          image: Assets.image.backgroundDark.provider(),
          title: const TextSpan(
            children: [
              WidgetSpan(
                child: Text(
                  'FullScreenImageSlide.rich',
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
          subtitle: const TextSpan(
            children: [
              TextSpan(
                text: 'RichTextを使ってスライドを作成することもできます。\n',
                style: TextStyle(height: 3),
              ),
              TextSpan(
                text: 'Hello, ',
                style: TextStyle(color: Colors.red),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Rich',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      children: [TextSpan(text: 'Text')]),
                  TextSpan(text: '!'),
                ],
              ),
            ],
          ),
          alignment: Alignment.topLeft,
          theme: const SlideThemeData.dark(),
          transition: _defaultTransition,
        ),
        FullScreenImageSlide.rich(
          image: Assets.image.backgroundDark.provider(),
          subtitle: TextSpan(
            children: [
              const TextSpan(text: '以上、Slick Slidesを使ってスライドを作ってみた おわり\n'),
              TextSpan(
                text: _slickSlidesUrl,
                style: const TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontSize: 32,
                  height: 3,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchUrl(_slickSlidesUrl);
                  },
              ),
            ],
          ),
          alignment: Alignment.centerLeft,
          theme: const SlideThemeData.dark(),
          transition: _defaultTransition,
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
