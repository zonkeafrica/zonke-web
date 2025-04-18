import 'dart:async';
import 'dart:io';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sixam_mart/features/rental_module/common/widgets/taxi_cart_widget.dart';
import 'package:sixam_mart/features/dashboard/widgets/store_registration_success_bottom_sheet.dart';
import 'package:sixam_mart/features/home/controllers/home_controller.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/features/order/domain/models/order_model.dart';
import 'package:sixam_mart/features/address/screens/address_screen.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/dashboard/widgets/bottom_nav_item_widget.dart';
import 'package:sixam_mart/features/parcel/controllers/parcel_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/rental_module/rental_cart_screen/taxi_cart_screen.dart';
import 'package:sixam_mart/features/rental_module/rental_favourite/screens/vehicle_favourite_screen.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/helper/taxi_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/common/widgets/cart_widget.dart';
import 'package:sixam_mart/common/widgets/custom_dialog.dart';
import 'package:sixam_mart/features/checkout/widgets/congratulation_dialogue.dart';
import 'package:sixam_mart/features/dashboard/widgets/address_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/dashboard/widgets/parcel_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/favourite/screens/favourite_screen.dart';
import 'package:sixam_mart/features/home/screens/home_screen.dart';
import 'package:sixam_mart/features/menu/screens/menu_screen.dart';
import 'package:sixam_mart/features/order/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/running_order_view_widget.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  final bool fromSplash;
  const DashboardScreen({super.key, required this.pageIndex, this.fromSplash = false});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  PageController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  bool _canExit = GetPlatform.isWeb ? true : false;

  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();


  late bool _isLogin;
  bool active = false;

  @override
  void initState() {
    super.initState();

    _isLogin = AuthHelper.isLoggedIn();

    _showRegistrationSuccessBottomSheet();

    if(_isLogin){
      if(Get.find<SplashController>().configModel!.loyaltyPointStatus == 1 && Get.find<AuthController>().getEarningPint().isNotEmpty
          && !ResponsiveHelper.isDesktop(Get.context)){
        Future.delayed(const Duration(seconds: 1), () => showAnimatedDialog(Get.context!, const CongratulationDialogue()));
      }
      suggestAddressBottomSheet();
      Get.find<OrderController>().getRunningOrders(1, fromDashboard: true);
    }

    _pageIndex = widget.pageIndex;

    _pageController = PageController(initialPage: widget.pageIndex);

    _screens = [
      const HomeScreen(),
      const FavouriteScreen(),
      const SizedBox(),
      const OrderScreen(),
      const MenuScreen()
    ];
  }

  _showRegistrationSuccessBottomSheet() {
    bool canShowBottomSheet = Get.find<HomeController>().getRegistrationSuccessfulSharedPref();
    if(canShowBottomSheet) {
      Future.delayed(const Duration(seconds: 1), () {
        ResponsiveHelper.isDesktop(Get.context) ? Get.dialog(const Dialog(child: StoreRegistrationSuccessBottomSheet())).then((value) {
          Get.find<HomeController>().saveRegistrationSuccessfulSharedPref(false);
          Get.find<HomeController>().saveIsStoreRegistrationSharedPref(false);
          setState(() {});
        }) : showModalBottomSheet(
          context: Get.context!, isScrollControlled: true, backgroundColor: Colors.transparent,
          builder: (con) => const StoreRegistrationSuccessBottomSheet(),
        ).then((value) {
          Get.find<HomeController>().saveRegistrationSuccessfulSharedPref(false);
          Get.find<HomeController>().saveIsStoreRegistrationSharedPref(false);
          setState(() {});
        });
      });
    }
  }

  Future<void> suggestAddressBottomSheet() async {
    active = await Get.find<LocationController>().checkLocationActive();
    if(widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active) {
      Future.delayed(const Duration(seconds: 1), () {
        showModalBottomSheet(
          context: Get.context!, isScrollControlled: true, backgroundColor: Colors.transparent,
          builder: (con) => const AddressBottomSheetWidget(),
        ).then((value) {
          Get.find<LocationController>().hideSuggestedLocation();
          setState(() {});
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    bool keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return GetBuilder<SplashController>(
      builder: (splashController) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (_pageIndex != 0) {
              _setPage(0);
            } else {
              if(!ResponsiveHelper.isDesktop(context) && Get.find<SplashController>().module != null && Get.find<SplashController>().configModel!.module == null) {
                Get.find<SplashController>().setModule(null);
                Get.find<StoreController>().resetStoreData();
              }else {
                if(_canExit) {
                  if (GetPlatform.isAndroid) {
                    SystemNavigator.pop();
                  } else if (GetPlatform.isIOS) {
                    exit(0);
                  }
                }else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('back_press_again_to_exit'.tr, style: const TextStyle(color: Colors.white)),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                    margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  ));
                  _canExit = true;
                  Timer(const Duration(seconds: 2), () {
                    _canExit = false;
                  });
                }
              }
            }
          },
          child: GetBuilder<OrderController>(
            builder: (orderController) {
              List<OrderModel> runningOrder = orderController.runningOrderModel != null ? orderController.runningOrderModel!.orders! : [];

              List<OrderModel> reversOrder =  List.from(runningOrder.reversed);

              return Scaffold(
                key: _scaffoldKey,
                body: ExpandableBottomSheet(
                  background: Stack(children: [
                    PageView.builder(
                        controller: _pageController,
                        itemCount: _screens.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _screens[index];
                        },
                      ),

                      ResponsiveHelper.isDesktop(context) || keyboardVisible ? const SizedBox() : Align(
                        alignment: Alignment.bottomCenter,
                        child: GetBuilder<SplashController>(
                          builder: (splashController) {
                            bool isParcel = splashController.module != null && splashController.configModel!.moduleConfig!.module!.isParcel!;
                            bool isTaxiWithCache = ((splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.taxi) || (splashController.cacheModule != null && splashController.cacheModule!.moduleType.toString() == AppConstants.taxi)) && TaxiHelper.haveTaxiModule();
                            bool isTaxi = (splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.taxi);
                            isParcel = isParcel && !isTaxiWithCache;

                            _screens = [
                              const HomeScreen(),
                              isParcel ? const AddressScreen(fromDashboard: true)
                                  : isTaxi ? const VehicleFavouriteScreen()
                                  : const FavouriteScreen(),
                              const SizedBox(),
                              OrderScreen(index: isTaxi ? 1 : 0),
                              const MenuScreen()
                            ];
                            return Container(
                              width: size.width, height: GetPlatform.isIOS ? 80 : 65,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
                                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                              ),
                              child: Stack(children: [

                                Center(
                                  heightFactor: 0.6,
                                  child: ResponsiveHelper.isDesktop(context) ? null : (widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active) ? null
                                    : (orderController.showBottomSheet && orderController.runningOrderModel != null && orderController.runningOrderModel!.orders!.isNotEmpty && _isLogin) ? const SizedBox() : Container(
                                      width: 60, height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Theme.of(context).cardColor, width: 5),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                                      ),
                                      child: FloatingActionButton(
                                        backgroundColor: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          if(isParcel) {
                                            showModalBottomSheet(
                                              context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                                              builder: (con) => ParcelBottomSheetWidget(parcelCategoryList: Get.find<ParcelController>().parcelCategoryList),
                                            );
                                          } else if(isTaxiWithCache) {
                                            Get.to(()=> const TaxiCartScreen());
                                          } else {
                                            Get.toNamed(RouteHelper.getCartRoute());
                                          }
                                        },
                                        elevation: 0,
                                        child: isTaxiWithCache ? TaxiCartWidget(color: Theme.of(context).cardColor, size: 22) : isParcel ? Icon(CupertinoIcons.add, size: 34, color: Theme.of(context).cardColor) : CartWidget(color: Theme.of(context).cardColor, size: 22),
                                      ),
                                  ),
                                ),

                                ResponsiveHelper.isDesktop(context) ? const SizedBox() : (widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active) ? const SizedBox()
                                : (orderController.showBottomSheet && orderController.runningOrderModel != null && orderController.runningOrderModel!.orders!.isNotEmpty && _isLogin) ? const SizedBox() : Center(
                                  child: SizedBox(
                                      width: size.width, height: 80,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                        BottomNavItemWidget(
                                          title: 'home'.tr, selectedIcon: Images.homeSelect,
                                          unSelectedIcon: Images.homeUnselect, isSelected: _pageIndex == 0,
                                          onTap: () => _setPage(0),
                                        ),
                                        BottomNavItemWidget(
                                          title: isParcel ? 'address'.tr : isTaxi ? 'wishlist'.tr : 'favourite'.tr,
                                          selectedIcon: isParcel ? Images.addressSelect : Images.favouriteSelect,
                                          unSelectedIcon: isParcel ? Images.addressUnselect : Images.favouriteUnselect,
                                          isSelected: _pageIndex == 1, onTap: () => _setPage(1),
                                        ),
                                        Container(width: size.width * 0.2),
                                        BottomNavItemWidget(
                                          title: isTaxi ? 'trips'.tr : 'orders'.tr, selectedIcon: Images.orderSelect, unSelectedIcon: Images.orderUnselect,
                                          isSelected: _pageIndex == 3, onTap: () => _setPage(3),
                                        ),
                                        BottomNavItemWidget(
                                          title: 'menu'.tr, selectedIcon: Images.menu, unSelectedIcon: Images.menu,
                                          isSelected: _pageIndex == 4, onTap: () => _setPage(4),
                                        ),
                                      ]),
                                  ),
                                ),
                              ],
                              ),
                            );
                          }
                        ),
                      ),
                    ]),

                  persistentContentHeight: (widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active) ? 0 : GetPlatform.isIOS ? 110 : 100,

                  onIsContractedCallback: () {
                    if(!orderController.showOneOrder) {
                      orderController.showOrders();
                    }
                  },
                  onIsExtendedCallback: () {
                    if(orderController.showOneOrder) {
                      orderController.showOrders();
                    }
                  },

                  enableToggle: true,

                  expandableContent: (widget.fromSplash && Get.find<LocationController>().showLocationSuggestion && active && !ResponsiveHelper.isDesktop(context)) ?  const SizedBox()
                  : (ResponsiveHelper.isDesktop(context) || !_isLogin || orderController.runningOrderModel == null
                  || orderController.runningOrderModel!.orders!.isEmpty || !orderController.showBottomSheet) ? const SizedBox()
                  : Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      if(orderController.showBottomSheet){
                        orderController.showRunningOrders();
                      }
                    },
                    child: RunningOrderViewWidget(reversOrder: reversOrder, onOrderTap: () {
                      _setPage(3);
                      if(orderController.showBottomSheet){
                        orderController.showRunningOrders();
                      }
                    }),
                  ),
                ),
              );
            }
          ),
        );
      }
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  Widget trackView(BuildContext context, {required bool status}) {
    return Container(height: 3, decoration: BoxDecoration(color: status ? Theme.of(context).primaryColor
        : Theme.of(context).disabledColor.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)));
  }


}

