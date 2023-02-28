import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/utilities/custom_appBar.dart';
import 'package:big_wallet/utilities/localization.dart';
import 'package:big_wallet/utilities/text_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecordsManagement extends StatefulWidget {
  const RecordsManagement({super.key});

  @override
  State<RecordsManagement> createState() => _RecordsManagementState();
}

class _RecordsManagementState extends State<RecordsManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          context.l10n?.titleUpdatePassWord ?? '',
          style: TextStyles.h1,
        ),
      ),
      body: Text('Quang Khanh'),
    );
  }
}
