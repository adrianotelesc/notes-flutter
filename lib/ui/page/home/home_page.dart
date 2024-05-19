import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols/material_symbols.dart';
import 'package:uuid/uuid.dart';

enum ShortcutMenuItem { copyCode, remove }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _rootScrollController = ScrollController();

  final _codeTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawScrollbar(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        controller: _rootScrollController,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          const SizedBox.square(dimension: 80),
                          Column(
                            children: [
                              Text(
                                'Postnote',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox.square(dimension: 4),
                              Text(
                                'Take notes from anywhere, and effortlessly share with everyone.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                          const SizedBox.square(dimension: 40),
                          TextField(
                            textInputAction: TextInputAction.done,
                            onSubmitted: (code) {
                              if (code.isEmpty) return;
                              context.push('/$code');
                            },
                            decoration: InputDecoration(
                              filled: true,
                              prefixIcon: const Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: 16,
                                  end: 12,
                                ),
                                child: Icon(MaterialSymbols.keyboard),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: 12,
                                  end: 4,
                                ),
                                child: IconButton(
                                  tooltip: 'Generate a code',
                                  onPressed: () {
                                    _codeTextController.text =
                                        const Uuid().v1().toString();
                                  },
                                  icon: const Icon(MaterialSymbols.refresh),
                                ),
                              ),
                              hintText: 'Enter a code',
                              helper: Center(
                                child: Text(
                                  'Feel free to enter anything to access your notes.',
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(64)),
                              ),
                            ).applyDefaults(
                              Theme.of(context).inputDecorationTheme,
                            ),
                            controller: _codeTextController,
                          ),
                          const SizedBox.square(dimension: 32),
                          Center(
                            child: FilledButton.icon(
                              onPressed: () {
                                if (_codeTextController.text.isEmpty) return;
                                context.push('/${_codeTextController.text}');
                              },
                              label: const Text('Go to notes'),
                              icon: const Icon(MaterialSymbols.note_stack),
                            ),
                          ),
                          const SizedBox.square(dimension: 48),
                          ...List.generate(
                            3,
                            (index) {
                              final secret = const Uuid().v1().toString();
                              return Card(
                                child: ListTile(
                                  onTap: () => context.push('/$secret'),
                                  title: const Text('Minhas anotações'),
                                  subtitle: Text(const Uuid().v1().toString()),
                                  contentPadding: const EdgeInsets.only(
                                    left: 24,
                                    right: 8,
                                  ),
                                  trailing: PopupMenuButton<ShortcutMenuItem>(
                                    onSelected: (ShortcutMenuItem item) {},
                                    tooltip: 'More',
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem<ShortcutMenuItem>(
                                          value: ShortcutMenuItem.copyCode,
                                          child: const Row(
                                            children: [
                                              Icon(Icons.copy),
                                              SizedBox.square(dimension: 8),
                                              Text('Copy code')
                                            ],
                                          ),
                                          onTap: () {
                                            Clipboard.setData(
                                                    ClipboardData(text: secret))
                                                .then((_) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text("Code copied."),
                                                ),
                                              );
                                            });
                                          },
                                        ),
                                        const PopupMenuItem<ShortcutMenuItem>(
                                          value: ShortcutMenuItem.remove,
                                          child: Row(
                                            children: [
                                              Icon(Icons.delete),
                                              SizedBox.square(dimension: 8),
                                              Text('Remove')
                                            ],
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48, bottom: 24),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              child: const Text('Terms and Privacy'),
                              onPressed: () {},
                            ),
                            const SizedBox.square(dimension: 8),
                            Text(
                              '© 2024 Drisoft',
                              style: Theme.of(context).textTheme.labelMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
