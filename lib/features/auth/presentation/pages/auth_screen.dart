import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_tech/core/constants/app_colors.dart';
import 'package:legal_tech/core/constants/app_icons.dart';
import 'package:legal_tech/core/helper/size_extension.dart';
import 'package:legal_tech/core/widgets/global_button.dart';
import 'package:legal_tech/core/widgets/global_text.dart';
import 'package:legal_tech/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:legal_tech/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:legal_tech/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:legal_tech/features/auth/presentation/widgets/auth_widgets.dart';
import 'package:legal_tech/core/router/app_route_names.dart';
import 'package:toastification/toastification.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginController.addListener(_onTextChanged);
    _passwordController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  bool get _isFormValid =>
      _loginController.text.trim().length >= 3 &&
      _passwordController.text.length >= 3;

  @override
  void dispose() {
    _loginController.removeListener(_onTextChanged);
    _passwordController.removeListener(_onTextChanged);
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cB8001F,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            toastification.show(
              context: context,
              title: GlobalText(
                text: state.errorMessage!,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
              type: ToastificationType.error,
              style: ToastificationStyle.fillColored,
              autoCloseDuration: const Duration(seconds: 3),
            );
          } else if (state.isSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteNames.tabBox,
              (route) => false,
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 20,
                      left: 24,
                      right: 24,
                    ),
                    child: SvgPicture.asset(
                      AppIcons.satashkentFullIcn,
                      height: 50,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(36),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.1),
                            blurRadius: 16,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(36),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 32,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: GlobalText(
                                  text: "Sign In",
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.c1E293B,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              28.g,
                              LoginInputField(
                                label: "Login",
                                hintText: "Email, phone number or username",
                                controller: _loginController,
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                              18.g,
                              LoginInputField(
                                label: "Password",
                                hintText: "Password",
                                controller: _passwordController,
                                textInputType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) {
                                  if (_isFormValid && !state.isLoading) {
                                    _submitForm(context);
                                  }
                                },
                              ),
                              16.g,
                              RememberMeRow(
                                rememberMe: state.rememberMe,
                                onRememberMeTap: () {
                                  context.read<AuthBloc>().add(
                                    ToggleRememberMe(),
                                  );
                                },
                                onForgotPasswordTap: () => _showToast(
                                  context,
                                  "Forgot Password tapped",
                                ),
                              ),
                              28.g,
                              GlobalButton(
                                onTap: (state.isLoading || !_isFormValid)
                                    ? null
                                    : () => _submitForm(context),
                                isLoading: state.isLoading,
                                color: AppColors.c1E293B,
                                textColor: AppColors.white,
                                title: "Submit",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                radius: 14,
                              ),
                              24.g,
                              const OrSeparator(),
                              24.g,
                              GoogleLoginButton(
                                onTap: state.isLoading
                                    ? null
                                    : () => _showToast(
                                        context,
                                        "Google Sign In simulation",
                                      ),
                              ),
                              16.g,
                              TelegramLoginButton(
                                onTap: state.isLoading
                                    ? null
                                    : () => _showToast(
                                        context,
                                        "Telegram Sign In simulation",
                                      ),
                              ),
                              28.g,
                              FooterLinks(
                                onTap: () =>
                                    _showToast(context, "Register link tapped"),
                              ),
                              28.g,
                              LegalFooter(
                                onTermsTap: () =>
                                    _showToast(context, "Terms of Use tapped"),
                                onPrivacyTap: () => _showToast(
                                  context,
                                  "Privacy Policy tapped",
                                ),
                              ),
                              24.g,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (!_isFormValid) return;
    FocusScope.of(context).unfocus();
    context.read<AuthBloc>().add(
      SubmitLogin(
        login: _loginController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    toastification.show(
      context: context,
      title: GlobalText(
        text: message,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: const Duration(seconds: 2),
    );
  }
}
