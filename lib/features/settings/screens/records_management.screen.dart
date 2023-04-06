import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/settings/blocs/profiles_blocs/profiles.bloc.dart';
import 'package:big_wallet/features/settings/screens/widgets/item_management.widget.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/custom_color.dart';
import 'package:big_wallet/utilities/custom_style.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:big_wallet/utilities/widgets/loanding_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecordsManagement extends StatefulWidget {
  const RecordsManagement({super.key});

  @override
  State<RecordsManagement> createState() => _RecordsManagementState();
}

class _RecordsManagementState extends State<RecordsManagement> {
  @override
  void initState() {
    context.read<ProfilesBloc>().add(ListProfiles(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.manageProfile ?? '',
          style: TextStyles.h1,
        ),
        // routerName: Routes.settingScreen,
      ),
      body: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          margin: const EdgeInsets.only(top: 46),
          child: BlocBuilder<ProfilesBloc, ProfilesBlocsState>(
            builder: (context, state) {
              if (state is ProfilesInitial) {
                return const LoadingScreens();
              } else if (state is ProfilesLoading) {
                return const LoadingScreens();
              } else if (state is ListProfilesLoaded) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemExtent: 75,
                  itemCount: state.dataProfiles.length,
                  itemBuilder: (context, index) {
                    return ItemManagement(
                      name: "${state.dataProfiles[index].displayName}",
                      onClickedEdit: () {
                        Navigator.pushNamed(context, Routes.createManagement,
                            arguments: "${state.dataProfiles[index].id}");
                      },
                      onClicked: () {},
                      imagePath:
                          "https://ucarecdn.com/8f8ecee1-a569-4a35-afa0-8647f4244f6b/",
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.createManagement,
              arguments: "new");
        },
        backgroundColor: CustomColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
