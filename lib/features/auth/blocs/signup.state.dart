part of 'signup.bloc.dart';

class SignUpState extends Equatable {
  final bool verificationRequired;
  final String token;
  final FormSubmissionStatus formtatus;
  const SignUpState(
      {this.verificationRequired = true,
      this.token = '',
      this.formtatus = const InitialFormStatus()});

  SignUpState copyWith(
      {bool verificationRequired = true,
      String token = '',
      FormSubmissionStatus status = const InitialFormStatus()}) {
    return SignUpState(
        verificationRequired: verificationRequired, token: token);
  }

  @override
  List<Object> get props => [];
}
