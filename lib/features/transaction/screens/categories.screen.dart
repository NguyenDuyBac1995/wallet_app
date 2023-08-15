import 'dart:io';
import 'dart:ui';

import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/transaction/blocs/category_blocs/category_blocs_bloc.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/loanding_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    context.read<CategoriesBlocsBloc>().add(GetCategories(context, ''));
    super.initState();
  }

  String languageCode = Platform.localeName;
  String localeName = Platform.localeName;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.categories ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: BlocBuilder<CategoriesBlocsBloc, CategoriesBlocsState>(
          buildWhen: (previous, current) {
            return current is CategoriesLoaded;
          },
          builder: (context, state) {
            if (state is CategoriesBlocsInitial) {
              return const LoadingScreens();
            } else if (state is CategoriesLoading) {
              return const LoadingScreens();
            } else if (state is CategoriesLoaded) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.dataCategories.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 24,
                            height: 24,
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    state.dataCategories[index].icon!))),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.categoriesDetailScreen,
                                        arguments:
                                            "${state.dataCategories[index].id}");
                                  },
                                  child: Text(
                                    state.dataCategories[index].name!,
                                    style: TextStyles.h1.copyWith(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  state.dataCategories[index].description!,
                                  style: TextStyles.text.copyWith(
                                      fontSize: 9,
                                      color: const Color(0xFF6E7191)),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.categoriesDetailScreen,
                                arguments: "${state.dataCategories[index].id}");
                          },
                          child: const Icon(
                            Icons.more_vert,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.categoriesDetailScreen,
              arguments: "new");
        },
        backgroundColor: CustomColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
