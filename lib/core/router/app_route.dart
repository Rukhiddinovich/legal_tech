part of 'app_route_part.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.authScreen:
        return CupertinoPageRoute(builder: (context) => const AuthScreen());
      case RouteNames.tabBox:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider<TabBoxBloc>(
            create: (context) => sl<TabBoxBloc>(),
            child: const TabBox(),
          ),
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => _buildUnknownRoutePage(),
        );
    }
  }

  static Widget _buildUnknownRoutePage() {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: GlobalText(
              text: "Route da xatolik sodir bo'ldi",
              fontSize: 20.sp,
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop,
            child: const GlobalText(text: "Back", color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
