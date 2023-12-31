import 'package:big_wallet/core/routes/page.route.dart';
import 'package:big_wallet/core/routes/routes.dart';
import 'package:big_wallet/features/auth/screens/auth.screen.dart';
import 'package:big_wallet/features/auth/screens/forgot.new.password.screen.dart';
import 'package:big_wallet/features/settings/screens/currency_setting.screen.dart';
import 'package:big_wallet/features/settings/screens/general.screen.dart';
import 'package:big_wallet/features/auth/screens/information.screen.dart';
import 'package:big_wallet/features/bottom_bar/screens/bottom_bar.screen.dart';
import 'package:big_wallet/features/settings/screens/create_management.dart';
import 'package:big_wallet/features/settings/screens/edit_profile.screen.dart';
import 'package:big_wallet/features/settings/screens/language.screen.dart';
import 'package:big_wallet/features/settings/screens/records_management.screen.dart';
import 'package:big_wallet/features/settings/screens/setting.screen.dart';
import 'package:big_wallet/features/auth/screens/signin.screen.dart';
import 'package:big_wallet/features/auth/screens/signup.information.screen.dart';
import 'package:big_wallet/features/auth/screens/signup.screen.dart';
import 'package:big_wallet/features/auth/screens/verify.otp.screen.dart';
import 'package:big_wallet/features/otp/screens/otp.screen.dart';
import 'package:big_wallet/features/settings/screens/time_format.screent.dart';
import 'package:big_wallet/features/settings/screens/update_password.screen.dart';
import 'package:big_wallet/features/splash/screens/splash.screen.dart';
import 'package:big_wallet/features/transaction/screens/add_spending.screen.dart';
import 'package:big_wallet/features/transaction/screens/categories.screen.dart';
import 'package:big_wallet/features/transaction/screens/categories_detail.screen.dart';
import 'package:big_wallet/features/transaction/screens/spending.screen.dart';
import 'package:big_wallet/features/transaction/screens/spending_filter.screen.dart';
import 'package:big_wallet/features/wallet/screens/add_saving.screen.dart';
import 'package:big_wallet/features/wallet/screens/add_wallet.screen.dart';
import 'package:big_wallet/features/wallet/screens/detail_wallet.screen.dart';
import 'package:big_wallet/features/wallet/screens/filter_wallet.screen.dart';
import 'package:big_wallet/features/wallet/screens/income.screen.dart';
import 'package:big_wallet/features/wallet/screens/transfer.screen.dart';
import 'package:big_wallet/models/bundle.model.dart';
import 'package:flutter/material.dart';
import 'package:big_wallet/features/auth/screens/forgot.password.phone.screen.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.splashScreen:
        return GeneratePageRoute(
            widget: const SplashScreen(), routeName: settings.name);
      case Routes.authScreen:
        return GeneratePageRoute(
            widget: const AuthScreen(), routeName: settings.name);
      case Routes.signInScreen:
        return GeneratePageRoute(
            widget: const SignInScreen(), routeName: settings.name);
      case Routes.signUpScreen:
        return GeneratePageRoute(
            widget: const SignUpScreen(), routeName: settings.name);
      case Routes.otpScreen:
        final callback = settings.arguments as Function(Object?);
        return GeneratePageRoute(
            widget: OtpScreen(callback: callback), routeName: settings.name);
      case Routes.authInformation:
        return GeneratePageRoute(
            widget: const AuthInformationScreen(), routeName: settings.name);
      case Routes.forgotPasswordPhoneScreen:
        return GeneratePageRoute(
            widget: const ForgotPasswordPhoneScreen(),
            routeName: settings.name);
      case Routes.verifyOtpScreen:
        final callback = settings.arguments as Function(Object?);
        return GeneratePageRoute(
            widget: VerifyOtpScreen(callback: callback),
            routeName: settings.name);
      // if (args is BundleData) {
      //   return GeneratePageRoute(
      //       widget: VerifyOtpScreen(verifyCase: args.verifyCase),
      //       routeName: settings.name);
      // }
      // return GeneratePageRoute(
      //     widget: const VerifyOtpScreen(), routeName: settings.name);
      case Routes.forgotNewPasswordScreen:
        return GeneratePageRoute(
            widget: const ForgotNewPasswordScreen(), routeName: settings.name);
      case Routes.signupInformationScreen:
        return GeneratePageRoute(
            widget: const SignupInformationScreen(), routeName: settings.name);
      case Routes.bottomBarScreen:
        return GeneratePageRoute(
            widget: const BottomBarScreen(), routeName: settings.name);
      case Routes.settingScreen:
        return GeneratePageRoute(
            widget: const SettingsScreen(), routeName: settings.name);
      case Routes.updatePassWordScreen:
        return GeneratePageRoute(
            widget: const UpdatePasswordScreen(), routeName: settings.name);
      case Routes.editProfileScreen:
        if (args is String) {
          return GeneratePageRoute(
              widget: EditProfileScreen(idProfile: args),
              routeName: settings.name);
        }
        return GeneratePageRoute(
            widget: const EditProfileScreen(), routeName: settings.name);
      case Routes.recordsManagement:
        return GeneratePageRoute(
            widget: const RecordsManagement(), routeName: settings.name);
      case Routes.createManagement:
        if (args is String) {
          return GeneratePageRoute(
              widget: CreateManagement(
                titleApp: args,
              ),
              routeName: settings.name);
        }
        return GeneratePageRoute(
            widget: const CreateManagement(), routeName: settings.name);
      case Routes.generalScreen:
        return GeneratePageRoute(
            widget: const GeneralScreen(), routeName: settings.name);
      case Routes.languageScreen:
        return GeneratePageRoute(
            widget: const LanguageScreen(), routeName: settings.name);
      case Routes.timeFormatScreen:
        return GeneratePageRoute(
            widget: const TimeFormatScreen(), routeName: settings.name);
      case Routes.currencySettingScreen:
        return GeneratePageRoute(
            widget: const CurrencySettingScreen(), routeName: settings.name);
      case Routes.addWalletScreen:
        if (args is String) {
          return GeneratePageRoute(
              widget: AddWallet(
                titleApp: args,
              ),
              routeName: settings.name);
        }
        return GeneratePageRoute(
            widget: const AddWallet(), routeName: settings.name);
        ;
      case Routes.spendingScreen:
        return GeneratePageRoute(
            widget: const SpendingScreen(), routeName: settings.name);
      case Routes.addSpendingScreen:
        return GeneratePageRoute(
            widget: const AddSpendingScreen(), routeName: settings.name);
      case Routes.spendingFilterScreen:
        return GeneratePageRoute(
            widget: const SpendingFilterScreen(), routeName: settings.name);
      case Routes.addSavingScreen:
        return GeneratePageRoute(
            widget: const AddSavingScreen(), routeName: settings.name);
      case Routes.transferScreen:
        return GeneratePageRoute(
            widget: const TransferScreen(), routeName: settings.name);
      case Routes.incomeScreen:
        return GeneratePageRoute(
            widget: const IncomeScreen(), routeName: settings.name);
      case Routes.detailWalletScreen:
        return GeneratePageRoute(
            widget: const DetailWalletScreen(), routeName: settings.name);
      case Routes.filterWalletScreen:
        return GeneratePageRoute(
            widget: const FilterWalletScreen(), routeName: settings.name);
      case Routes.categoriesScreen:
        return GeneratePageRoute(
            widget: const CategoriesScreen(), routeName: settings.name);
      case Routes.categoriesDetailScreen:
        if (args is String) {
          return GeneratePageRoute(
              widget: CategoriesDetail(
                titleApp: args,
              ),
              routeName: settings.name);
        }
        return GeneratePageRoute(
            widget: const CategoriesDetail(), routeName: settings.name);
      default:
        return GeneratePageRoute(
            widget: Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
            routeName: settings.name);
    }
  }
}
