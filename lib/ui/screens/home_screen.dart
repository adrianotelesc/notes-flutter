import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols/material_symbols.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _rootScrollController = ScrollController();

  final _boardIdTextController = TextEditingController();

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
                controller: _rootScrollController,
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
                                AppLocalizations.of(context)!.slogan,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ],
                          ),
                          const SizedBox.square(dimension: 40),
                          TextField(
                            textInputAction: TextInputAction.done,
                            onSubmitted: (collectionId) {
                              if (collectionId.isEmpty) return;
                              context.push('/$collectionId');
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
                                  tooltip: AppLocalizations.of(context)!
                                      .generateCode,
                                  onPressed: () {
                                    _boardIdTextController.text =
                                        const Uuid().v1().toString();
                                  },
                                  icon: const Icon(MaterialSymbols.refresh),
                                ),
                              ),
                              hintText: AppLocalizations.of(context)!.enterCode,
                              helper: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.codeHelp,
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
                            controller: _boardIdTextController,
                          ),
                          const SizedBox.square(dimension: 32),
                          Center(
                            child: FilledButton.icon(
                              onPressed: () {
                                if (_boardIdTextController.text.isEmpty) {
                                  return;
                                }
                                context.push('/${_boardIdTextController.text}');
                              },
                              label: Text(
                                AppLocalizations.of(context)!.goToNotes,
                              ),
                              icon: const Icon(MaterialSymbols.note_stack),
                            ),
                          ),
                          const SizedBox.square(dimension: 48),
                          ...List.generate(
                            3,
                            (index) {
                              final collectionId = const Uuid().v1().toString();
                              return Card(
                                child: ListTile(
                                  onTap: () => context.push('/$collectionId'),
                                  title: const Text('Minhas anotações'),
                                  subtitle: Text(const Uuid().v1().toString()),
                                  contentPadding: const EdgeInsets.only(
                                    left: 24,
                                    right: 8,
                                  ),
                                  trailing: PopupMenuButton(
                                    tooltip: AppLocalizations.of(context)!.more,
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          child: Row(
                                            children: [
                                              const Icon(Icons.copy),
                                              const SizedBox.square(
                                                  dimension: 8),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .copyCode,
                                              )
                                            ],
                                          ),
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                    text: collectionId))
                                                .then((_) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .codeCopied,
                                                  ),
                                                ),
                                              );
                                            });
                                          },
                                        ),
                                        PopupMenuItem(
                                          child: Row(
                                            children: [
                                              const Icon(Icons.delete),
                                              const SizedBox.square(
                                                  dimension: 8),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .remove,
                                              )
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
                              child: Text(
                                AppLocalizations.of(context)!.termsAndPrivacy,
                              ),
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
