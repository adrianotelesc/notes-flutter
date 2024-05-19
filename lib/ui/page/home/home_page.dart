import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols/material_symbols.dart';
import 'package:uuid/uuid.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RawScrollbar(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        controller: _scrollController,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 520),
              child: SizedBox(
                width: 520,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  controller: _scrollController,
                  children: [
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
                      onSubmitted: (value) {
                        if (value.isEmpty) return;
                        context.push('/$value');
                      },
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Padding(
                          padding:
                              EdgeInsetsDirectional.only(start: 16, end: 12),
                          child: Icon(MaterialSymbols.keyboard),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 12, end: 4),
                          child: IconButton(
                            tooltip: 'Generate a code',
                            onPressed: () {
                              _textEditingController.text =
                                  const Uuid().v1().toString();
                            },
                            icon: const Icon(MaterialSymbols.refresh),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        hintText: 'Enter a code',
                        helperStyle: Theme.of(context).textTheme.labelMedium,
                        helperText:
                            'This code can be anything you\'d like to use to access the notes.',
                        helperMaxLines: 2,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(64)),
                        ),
                      ),
                      controller: _textEditingController,
                    ),
                    const SizedBox.square(dimension: 32),
                    Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 8,
                      spacing: 8,
                      children: [
                        FilledButton.icon(
                          onPressed: () {
                            if (_textEditingController.text.isEmpty) return;
                            context.push('/${_textEditingController.text}');
                          },
                          label: const Text('Go to notes'),
                          icon: const Icon(MaterialSymbols.note_stack),
                        ),
                      ],
                    ),
                    const SizedBox.square(dimension: 48),
                    ...List.generate(
                      5,
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
                            trailing: PopupMenuButton<SampleItem>(
                              onSelected: (SampleItem item) {},
                              tooltip: 'More',
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemThree,
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
                                            content: Text("Code copied"),
                                          ),
                                        );
                                      });
                                    },
                                  ),
                                  const PopupMenuItem<SampleItem>(
                                    value: SampleItem.itemTwo,
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
                    const SizedBox.square(dimension: 80),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
