abstract final class AppRoutes {
  static const home = '/home';
  static const menu = '/menu';
  static const productDetails = '/products/:id';
  static const cart = '/cart';
  static const checkout = '/checkout';
  static const orders = '/orders';
  static const profile = '/profile';
  static const settings = '/settings';
  static const  register = "/register";
  static const login = "/login";
  static const splash = '/splash';
  static String productDetailsPath(String id) => '/products/$id';
}
