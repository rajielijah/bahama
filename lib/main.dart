import 'package:flutter/material.dart';
import 'package:randomfood/pages/sign_in.dart';
import 'package:randomfood/pages/signup.dart';
import 'package:randomfood/pages/splashscreen.dart';
import 'package:randomfood/providers/app.dart';
import 'package:randomfood/providers/category.dart';
import 'package:randomfood/providers/product.dart';
import 'package:randomfood/providers/restaurant.dart';
import 'package:randomfood/providers/user.dart';
import 'package:randomfood/screens/homepage.dart';
import 'package:randomfood/screens/login.dart';
// import 'package:randomfood/screens/splash.dart';
import 'package:randomfood/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

void main() {
  GoogleMap.init('AIzaSyBRkt1qgj3Papix-SvI-p7RXC2jmIfHmsQ');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Unauthenticated:
        return SplashScreen();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return SignUpPage();
      case Status.Authenticated:
        return Home();
      default:
        return LoginPage();
    }
  }
}
