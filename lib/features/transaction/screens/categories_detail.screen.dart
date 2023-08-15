import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/transaction/blocs/category_blocs/category_blocs_bloc.dart';
import 'package:big_wallet/features/transaction/model/categorys_model.dart';
import 'package:big_wallet/utilities/constants.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/toast.dart';
import 'package:big_wallet/utilities/widgets/loanding_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesDetail extends StatefulWidget {
  final String titleApp;
  const CategoriesDetail({super.key, this.titleApp = 'new'});

  @override
  State<CategoriesDetail> createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _search = TextEditingController();
  late bool _isLoading;
  late String _image;
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    _image = Constants.DEFAULT_IMAGE;
    _isLoading = false;
    context.read<CategoriesBlocsBloc>().add(GetCategoriesIcon(context, ''));
    if (widget.titleApp != 'new') {
      context
          .read<CategoriesBlocsBloc>()
          .add(GetDetailCategories(context, widget.titleApp));
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.titleApp == 'new'
            ? Text(
                context.l10n?.createCategories ?? '',
                style: TextStyles.h1,
              )
            : BlocBuilder<CategoriesBlocsBloc, CategoriesBlocsState>(
                buildWhen: (previous, current) {
                  return current is CategoriesDetailLoaded;
                },
                builder: (context, state) {
                  if (state is CategoriesDetailLoaded) {
                    return Text(
                      state.dataCategoriesDetail.name != null
                          ? state.dataCategoriesDetail.name!
                          : '',
                      style: TextStyles.h1,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
        checkClickRouter: true,
        onClickedRouter: () {
          Navigator.pop(context);
          context.read<CategoriesBlocsBloc>().add(GetCategories(context, ''));
        },
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: SingleChildScrollView(
            child: BlocListener<CategoriesBlocsBloc, CategoriesBlocsState>(
              listenWhen: (previous, current) {
                return current is CategoriesDetailLoaded;
              },
              listener: (context, state) {
                if (state is CategoriesDetailLoaded) {
                  _name.text = state.dataCategoriesDetail.name!;
                  _description.text = state.dataCategoriesDetail.description!;
                  setState(() {
                    _image = state.dataCategoriesDetail.icon!;
                  });
                }
              },
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: _name,
                          decoration: InputDecoration(
                              hintText: context.l10n?.nameCategories ?? '',
                              filled: true,
                              fillColor: CustomColors.backgroundTextFormField,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      CustomStyle.borderRadiusFormFieldStyle),
                              labelStyle: TextStyles.labelTextStyle),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${context.l10n?.requiredMessage('${context.l10n?.nameCategories}')} ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: _description,
                          decoration: InputDecoration(
                              hintText: context.l10n?.descCategories ?? '',
                              filled: true,
                              fillColor: CustomColors.backgroundTextFormField,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder(
                                  borderRadius:
                                      CustomStyle.borderRadiusFormFieldStyle),
                              labelStyle: TextStyles.labelTextStyle),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${context.l10n?.requiredMessage('${context.l10n?.descCategories}')} ';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black54,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                          onTap: showIcon,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(image: NetworkImage(_image)),
                              const Icon(
                                Icons.expand_more,
                              ),
                            ],
                          ),
                        ),
                      ),
                      _btnSubmitDetail()
                    ],
                  )),
            ),
          )),
    );
  }

  // btn submit
  Widget _btnSubmitDetail() {
    return BlocListener<CategoriesBlocsBloc, CategoriesBlocsState>(
      listener: (context, state) {
        if (state is CreateCategoriesLoaded) {
          if (state.isSuccess) {
            Toast.show(context, '${context.l10n?.messageCreateCategories}',
                backgroundColor: Colors.green);
            Navigator.pushNamed(context, Routes.categoriesScreen);
          }
        }
        if (state is EditCategoriesLoaded) {
          if (state.isSuccess) {
            Toast.show(context, '${context.l10n?.messageEditCategories}',
                backgroundColor: Colors.green);
            Navigator.pushNamed(context, Routes.categoriesScreen);
          }
        }
        if (state is DeleteCategoriesLoaded) {
          if (state.isSuccess) {
            Toast.show(context, '${context.l10n?.messageDeleteCategories}',
                backgroundColor: Colors.green);
            Navigator.pushNamed(context, Routes.categoriesScreen);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: widget.titleApp == 'new'
            ? Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  context.read<CategoriesBlocsBloc>().add(
                                      CreateCategoriesState(
                                          context,
                                          RequestCategories(
                                              description: _description.text,
                                              icon: _image,
                                              name: _name.text)));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                        style: CustomStyle.primaryButtonStyle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(context.l10n?.btnSaveProfile ?? ''),
                        )),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  context.read<CategoriesBlocsBloc>().add(
                                      EditCategoriesState(
                                          context,
                                          RequestPutCategories(
                                              id: widget.titleApp,
                                              requestCategories:
                                                  RequestCategories(
                                                      description:
                                                          _description.text,
                                                      icon: _image,
                                                      name: _name.text))));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                        style: CustomStyle.primaryButtonStyle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(context.l10n?.btnUpdateProfile ?? ''),
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  context.read<CategoriesBlocsBloc>().add(
                                      DeleteCategoriesState(
                                          context, widget.titleApp));
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                        style: CustomStyle.deleteButtonStyle,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            context.l10n?.deleteCategories ?? '',
                            style: const TextStyle(color: Colors.red),
                          ),
                        )),
                  ),
                ],
              ),
      ),
    );
  }

  // menu icon
  void showIcon() => showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  controller: _search,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.search,
                      ),
                      hintText: context.l10n?.search ?? '',
                      filled: true,
                      fillColor: CustomColors.backgroundTextFormField,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: CustomStyle.borderRadiusFormFieldStyle),
                      labelStyle: TextStyles.labelTextStyle),
                  onChanged: (value) {
                    context
                        .read<CategoriesBlocsBloc>()
                        .add(GetCategoriesIcon(context, _search.text));
                  },
                )),
            Expanded(
              child: BlocBuilder<CategoriesBlocsBloc, CategoriesBlocsState>(
                  buildWhen: (previousState, currentState) {
                return currentState is CategoriesIconLoaded;
              }, builder: (context, state) {
                if (state is CategoriesBlocsInitial) {
                  return const LoadingScreens();
                } else if (state is CategoriesLoading) {
                  return const LoadingScreens();
                } else if (state is CategoriesIconLoaded) {
                  return ListView.builder(
                      itemCount: state.dataCategoriesIcon.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  state.dataCategoriesIcon[index].uri!)),
                          visualDensity:
                              const VisualDensity(horizontal: -4, vertical: 0),
                          title: Text(state.dataCategoriesIcon[index].name!,
                              style: TextStyles.text.copyWith(
                                  color: const Color(0xFF008889),
                                  fontSize: 18)),
                          dense: true,
                          shape: const Border(
                              bottom:
                                  BorderSide(width: 0.5, color: Colors.grey)),
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _image = state.dataCategoriesIcon[index].uri!;
                            });
                          },
                        );
                      });
                } else {
                  return Container();
                }
              }),
            ),
          ],
        ));
      });
}
