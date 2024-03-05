import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proyecto_pasantia/layers/presentation/ui/widgets/components/tales_grid/grid_app_bar.dart';

class TalesReaderScreen extends StatefulWidget {
  const TalesReaderScreen({super.key});

  @override
  State<TalesReaderScreen> createState() => _TalesReaderScreenState();
}

class _TalesReaderScreenState extends State<TalesReaderScreen> {
  int chapter = 1;
  final ScrollController _scrollController = ScrollController();
  IconData icon = Icons.arrow_drop_down;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels - 100 >=
          (_scrollController.position.maxScrollExtent / 3)) {
        setState(() {
          icon = Icons.arrow_drop_up;
        });
      } else {
        setState(() {
          icon = Icons.arrow_drop_down;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const String imageUrl =
        'https://firebasestorage.googleapis.com/v0/b/proyectopasantiatales.appspot.com/o/tales%2Fcovers%2Fportada3.jpg?alt=media&token=d7f743a3-59e3-434d-a220-fe08fc27b268';
    final buttonStyle = ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue.shade100));
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            const GridAppBar(
              isSearching: false,
              isPinned: false,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Text(
                      'Chapter $chapter',
                      style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '''Content of the chapter $chapter.
                    Nulla et ullamco proident duis magna quis ut deserunt nulla esse quis. Dolore in dolore ut est ut et aliquip laborum. Consectetur officia consectetur qui occaecat ea laborum magna minim duis ex duis ullamco. Eu id aliqua dolor pariatur aliqua laborum.
      
      Fugiat cillum occaecat eu cillum duis sint ipsum irure sint aliqua non. Sunt aliquip labore magna ad. Est exercitation in nisi do nostrud commodo magna pariatur adipisicing ipsum ullamco. Cupidatat id Lorem adipisicing exercitation aute dolore. Ea ipsum nisi anim id sit et nulla officia elit enim. Voluptate cillum nulla velit cillum tempor ad ullamco. Amet in do ipsum amet duis.
                    ''',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        chapter--;
                      });
                    },
                    style: buttonStyle,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Opcion A',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        chapter++;
                      });
                    },
                    style: buttonStyle,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Opcion B',
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Icon(
                  icon,
                  size: 40,
                ),
              ),
            ),
            SliverFillRemaining(
              child: SizedBox(
                height: 100,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
