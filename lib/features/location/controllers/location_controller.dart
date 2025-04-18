import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/location/screens/pick_map_screen.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/location/domain/models/prediction_model.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/home/screens/home_screen.dart';
import 'package:sixam_mart/features/location/domain/models/zone_response_model.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/location/domain/services/location_service_interface.dart';
import 'package:sixam_mart/features/location/widgets/module_dialog_widget.dart';
import 'package:sixam_mart/features/rental_module/rental_cart_screen/controllers/taxi_cart_controller.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/common/widgets/custom_loader.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/helper/taxi_helper.dart';

class LocationController extends GetxController implements GetxService {
  final LocationServiceInterface locationServiceInterface;

  LocationController({required this.locationServiceInterface});

  Position _position = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1);
  Position get position => _position;

  Position _pickPosition = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1);
  Position get pickPosition => _pickPosition;

  bool _loading = false;
  bool get loading => _loading;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _address = '';
  String? get address => _address;

  String? _pickAddress = '';
  String? get pickAddress => _pickAddress;

  bool _inZone = false;
  bool get inZone => _inZone;

  int _zoneID = 0;
  int get zoneID => _zoneID;

  bool _buttonDisabled = true;
  bool get buttonDisabled => _buttonDisabled;

  bool _showLocationSuggestion = true;
  bool get showLocationSuggestion => _showLocationSuggestion;

  bool _updateAddAddressData = true;
  bool _changeAddress = true;

  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  final List<String?> _addressTypeList = ['home', 'office', 'others'];
  List<String?> get addressTypeList => _addressTypeList;

  GoogleMapController? _mapController;
  GoogleMapController? get mapController => _mapController;

  List<PredictionModel> _predictionList = [];
  List<PredictionModel> get predictionList => _predictionList;

  void hideSuggestedLocation(){
    _showLocationSuggestion = !_showLocationSuggestion;
  }

  void setAddressTypeIndex(int index, {bool isUpdate = true}) {
    _addressTypeIndex = index;
    if(isUpdate) {
      update();
    }
  }

  void disableButton() {
    _buttonDisabled = true;
    _inZone = true;
    update();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    _address = _pickAddress;
    _updateAddAddressData = false;
    update();
  }

  void setUpdateAddress(AddressModel address){
    _position = Position(
      latitude: double.parse(address.latitude!), longitude: double.parse(address.longitude!), timestamp: DateTime.now(),
      altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, floor: 1, accuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1,
    );
    _address = address.address;
    _addressTypeIndex = _addressTypeList.indexOf(address.addressType);
  }

  void setPickData() {
    _pickPosition = _position;
    _pickAddress = _address;
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  Future<AddressModel> getCurrentLocation(bool fromAddress, {GoogleMapController? mapController, LatLng? defaultLatLng, bool notify = true}) async {
    _loading = true;
    if(notify) {
      update();
    }
    AddressModel addressModel;
    Position myPosition = await locationServiceInterface.getPosition(defaultLatLng, LatLng(
      double.parse(Get.find<SplashController>().configModel!.defaultLocation!.lat ?? '0'),
      double.parse(Get.find<SplashController>().configModel!.defaultLocation!.lng ?? '0'),
    ));
    fromAddress ? _position = myPosition : _pickPosition = myPosition;

    locationServiceInterface.handleMapAnimation(mapController, myPosition);
    String addressFromGeocode = await getAddressFromGeocode(LatLng(myPosition.latitude, myPosition.longitude));
    fromAddress ? _address = addressFromGeocode : _pickAddress = addressFromGeocode;
    ZoneResponseModel responseModel = await getZone(myPosition.latitude.toString(), myPosition.longitude.toString(), true);
    _buttonDisabled = !responseModel.isSuccess;

    addressModel = AddressModel(
      latitude: myPosition.latitude.toString(), longitude: myPosition.longitude.toString(), addressType: 'others',
      zoneId: responseModel.isSuccess ? responseModel.zoneIds[0] : 0, zoneIds: responseModel.zoneIds,
      address: addressFromGeocode, zoneData: responseModel.zoneData, areaIds: responseModel.areaIds,
    );
    _loading = false;
    update();
    return addressModel;
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    return await locationServiceInterface.getAddressFromGeocode(latLng);

  }

  Future<ZoneResponseModel> getZone(String? lat, String? lng, bool markerLoad, {bool updateInAddress = false, bool handleError = false}) async {
    if(markerLoad) {
      _loading = true;
    }else {
      _isLoading = true;
    }
    if(!updateInAddress){
      update();
    }
    ZoneResponseModel responseModel = await locationServiceInterface.getZone(lat, lng, handleError: handleError);
    _inZone = responseModel.isSuccess;
    _zoneID = responseModel.zoneIds.isNotEmpty ? responseModel.zoneIds[0] : 0;
    if(updateInAddress && responseModel.isSuccess) {
      AddressModel address = AddressHelper.getUserAddressFromSharedPref()!;
      address.zoneData = responseModel.zoneData;
      AddressHelper.saveUserAddressInSharedPref(address);
    }
    if(markerLoad) {
      _loading = false;
    }else {
      _isLoading = false;
    }
    update();
    return responseModel;
  }

  Future<void> syncZoneData() async {
    ZoneResponseModel response = await getZone(AddressHelper.getUserAddressFromSharedPref()!.latitude, AddressHelper.getUserAddressFromSharedPref()!.longitude, false, updateInAddress: true);
    if(response.zoneIds.isEmpty) {
      await AddressHelper.saveUserAddressInSharedPref(AddressModel());
      Get.toNamed(RouteHelper.getAccessLocationRoute(RouteHelper.splash));
    } else {
      AddressModel address = AddressHelper.getUserAddressFromSharedPref()!;
      address.zoneId = response.zoneIds[0];
      address.zoneIds = [];
      address.zoneIds!.addAll(response.zoneIds);
      address.zoneData = [];
      address.zoneData!.addAll(response.zoneData);
      address.areaIds = [];
      address.areaIds!.addAll(response.areaIds);
      await AddressHelper.saveUserAddressInSharedPref(address);
    }
    update();
  }

  void updatePosition(CameraPosition? position, bool fromAddress) async {
    if(_updateAddAddressData) {
      _loading = true;
      update();

      if (fromAddress) {
        _position = Position(
          latitude: position!.target.latitude, longitude: position.target.longitude, timestamp: DateTime.now(),
          heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1, altitudeAccuracy: 1, headingAccuracy: 1,
        );
      } else {
        _pickPosition = Position(
          latitude: position!.target.latitude, longitude: position.target.longitude, timestamp: DateTime.now(),
          heading: 1, accuracy: 1, altitude: 1, speedAccuracy: 1, speed: 1, altitudeAccuracy: 1, headingAccuracy: 1,
        );
      }
      ZoneResponseModel responseModel = await getZone(position.target.latitude.toString(), position.target.longitude.toString(), true);
      _buttonDisabled = !responseModel.isSuccess;
      if (_changeAddress) {
        String addressFromGeocode = await getAddressFromGeocode(LatLng(position.target.latitude, position.target.longitude));
        fromAddress ? _address = addressFromGeocode : _pickAddress = addressFromGeocode;
      } else {
        _changeAddress = true;
      }

      _loading = false;
      update();
    }else {
      _updateAddAddressData = true;
    }
  }

  void saveAddressAndNavigate(AddressModel? address, bool fromSignUp, String? route, bool canRoute, bool isDesktop) {
    _prepareZoneData(address!, fromSignUp, route, canRoute, isDesktop);
  }

  void _prepareZoneData(AddressModel address, bool fromSignUp, String? route, bool canRoute, bool isDesktop) {
    getZone(address.latitude, address.longitude, false).then((response) async {
      if (response.isSuccess) {
        Get.find<CartController>().getCartDataOnline();
        address.zoneId = response.zoneIds[0];
        address.zoneIds = [];
        address.zoneIds!.addAll(response.zoneIds);
        address.zoneData = [];
        address.zoneData!.addAll(response.zoneData);
        address.areaIds = [];
        address.areaIds!.addAll(response.areaIds);
        print('=======zone its : ${address.zoneIds} // previous: ${{AddressHelper.getUserAddressFromSharedPref()?.zoneIds}}');
        autoNavigate(address, fromSignUp, route, canRoute, isDesktop);
      } else {
        if (response.statusCode == 404) {
          Get.toNamed(RouteHelper.getPickMapRoute(route, false));
        } else {
          Get.back();
          showCustomSnackBar(response.message);
          if(route == 'splash') {
            Get.toNamed(RouteHelper.getPickMapRoute(route, false));
          }
        }
      }
    });
  }

  void autoNavigate(AddressModel? address, bool fromSignUp, String? route, bool canRoute, bool isDesktop) async {
    if (isDesktop && Get.find<SplashController>().module == null/* && Get.find<SplashController>().configModel!.module == null*/) {
      List<int>? zoneIds = address!.zoneIds;
      Map<String, String> header = locationServiceInterface.prepareHeader(zoneIds);
      await Get.find<SplashController>().getModules(headers: header);
      if (Get.isDialogOpen!) {
        Get.back();
      }
      Get.dialog(ModuleDialogWidget(callback: () {
        _saveDataAndFirebaseConfig(address, fromSignUp, route, canRoute, isDesktop);
      }), barrierDismissible: false, barrierColor: Colors.black.withValues(alpha: 0.7));
    } else {
      _saveDataAndFirebaseConfig(address!, fromSignUp, route, canRoute, isDesktop);
    }
  }

  void _saveDataAndFirebaseConfig(AddressModel address, bool fromSignUp, String? route, bool canRoute, bool isDesktop) async {
    locationServiceInterface.configureFirebaseMessaging(address);

    await _handleTaxiModuleCart(address);

    await AddressHelper.saveUserAddressInSharedPref(address);
    if(AuthHelper.isLoggedIn()) {
      if(Get.find<SplashController>().module != null) {
        await Get.find<FavouriteController>().getFavouriteList();
      } else {
        Get.find<SplashController>().getConfigData();
      }
      Get.find<AuthController>().updateZone();
    }
    HomeScreen.loadData(true);
    Get.find<CheckoutController>().clearPrevData();

    if(ResponsiveHelper.isDesktop(Get.context) && AuthHelper.isLoggedIn() && Get.find<SplashController>().module != null) {
      if(Get.find<ProfileController>().userInfoModel == null) {
        Get.dialog(const CustomLoaderWidget(), barrierDismissible: false);
        await Get.find<ProfileController>().getUserInfo();
        Get.back();
      }
      if(!Get.find<ProfileController>().userInfoModel!.selectedModuleForInterest!.contains(Get.find<SplashController>().module!.id)
          && (Get.find<SplashController>().module!.moduleType == 'food' || Get.find<SplashController>().module!.moduleType == 'grocery' || Get.find<SplashController>().module!.moduleType == 'ecommerce')
      ) {
        await Get.toNamed(RouteHelper.getInterestRoute());
      } else {
        locationServiceInterface.handleRoute(fromSignUp, route, canRoute);
      }
    } else {
      locationServiceInterface.handleRoute(fromSignUp, route, canRoute);
    }
  }

  Future<void> _handleTaxiModuleCart(AddressModel address) async{
    if(TaxiHelper.haveTaxiModule() && address.zoneIds != null && Get.find<TaxiCartController>().cartList.isNotEmpty) {
      List<int>? providerZones = Get.find<TaxiCartController>().cartList[0].provider!.pickupZoneId??[];

      if(!_hasIntersection(providerZones, address.zoneIds!)) {
        showCustomSnackBar('your_cart_has_been_cleared_as_the_selected_zone_does_not_support_the_previous_pickup_point'.tr, showDuration: 10);
        Get.find<TaxiCartController>().clearTaxiCart();
      }
    }
  }

  bool _hasIntersection(List<int> list1, List<int> list2) {
    return list1.toSet().intersection(list2.toSet()).isNotEmpty;
  }

  Future<AddressModel> setLocation(String? placeID, String? address, GoogleMapController? mapController) async {
    _loading = true;
    update();

    LatLng latLng = await locationServiceInterface.getLatLng(placeID);

    _pickPosition = Position(
      latitude: latLng.latitude, longitude: latLng.longitude,
      timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1,
    );

    _pickAddress = address;
    _changeAddress = false;

    if(mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: latLng, zoom: 17)));
    }
    _loading = false;
    update();
    return AddressModel(
      latitude: _pickPosition.latitude.toString(), longitude: _pickPosition.longitude.toString(),
      addressType: 'others', address: _pickAddress,
    );
  }

  Future<List<PredictionModel>> searchLocation(BuildContext context, String text) async {
    if(text.isNotEmpty) {
      _predictionList = await locationServiceInterface.searchLocation(text);
    }
    return _predictionList;
  }

  void setPlaceMark(String address) {
    _address = address;
  }

  void checkPermission(Function onTap) async {
    locationServiceInterface.checkLocationPermission(onTap);
  }

  Future<bool> checkLocationActive() async {
    bool isActiveLocation = await Geolocator.isLocationServiceEnabled();

    if(isActiveLocation) {
      Position myPosition = await locationServiceInterface.getPosition(null, LatLng(
        double.parse(Get.find<SplashController>().configModel!.defaultLocation!.lat ?? '0'),
        double.parse(Get.find<SplashController>().configModel!.defaultLocation!.lng ?? '0'),
      ));

      double distance = Geolocator.distanceBetween(
        double.parse(AddressHelper.getUserAddressFromSharedPref()!.latitude!), double.parse(AddressHelper.getUserAddressFromSharedPref()!.longitude!), myPosition.latitude, myPosition.longitude,
      ) / 1000;

      if (kDebugMode) {
        print('======== distance is : $distance');
      }
      if(distance > 1){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  Future<void> navigateToLocationScreen(String page, {bool offNamed = false, bool offAll = false}) async {
    bool fromSignup = page == RouteHelper.signUp;
    bool fromHome = page == 'home';

    if(!fromHome && AddressHelper.getUserAddressFromSharedPref() != null) {
      Get.dialog(const CustomLoaderWidget(), barrierDismissible: false);
      autoNavigate(AddressHelper.getUserAddressFromSharedPref(), fromSignup, null, false, ResponsiveHelper.isDesktop(Get.context));
    }else if(AuthHelper.isLoggedIn()) {
      Get.dialog(const CustomLoaderWidget(), barrierDismissible: false);
      await Get.find<AddressController>().getAddressList();
      Get.back();
      locationServiceInterface.authorizeNavigation(page, Get.find<AddressController>().addressList, mapController, offNamed: offNamed, offAll: offAll);
    }else {
      // locationServiceInterface.defaultNavigation(page, mapController);
      if(ResponsiveHelper.isDesktop(Get.context)) {
        showGeneralDialog(context: Get.context!, pageBuilder: (_,__,___) {
          return SizedBox(
            height: Get.context!.height * 0.75, width: 300,
            child: PickMapScreen(
              fromSignUp: (page == RouteHelper.signUp),
              canRoute: false, fromAddAddress: false, route: null,
              googleMapController: mapController,
            ),
          );
        });
      } else {
        _checkPermission(page);
      }
    }
  }

  void _checkPermission(String page) async {

    LocationPermission permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      Get.toNamed(RouteHelper.getPickMapRoute(page, false));
    } else {
      if(page == 'home'){
        Get.toNamed(RouteHelper.getPickMapRoute(page, false));
      } else if(await _locationCheck()) {
        Get.dialog(const CustomLoaderWidget(), barrierDismissible: false);
        await Get.find<LocationController>().getCurrentLocation(false).then((value) {
          if (value.latitude != null) {
            _onPickAddressButtonPressed(Get.find<LocationController>(), page);
          }
        });
      } else {
        Get.toNamed(RouteHelper.getPickMapRoute(page, false));
      }
    }
  }

  Future<bool> _locationCheck() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  void _onPickAddressButtonPressed(LocationController locationController, String page) {
    if(locationController.pickPosition.latitude != 0 && locationController.pickAddress!.isNotEmpty) {
      AddressModel address = AddressModel(
        latitude: locationController.pickPosition.latitude.toString(),
        longitude: locationController.pickPosition.longitude.toString(),
        addressType: 'others', address: locationController.pickAddress,
      );
      locationController.saveAddressAndNavigate(address, false, page, false, ResponsiveHelper.isDesktop(Get.context));
    } else {
      showCustomSnackBar('pick_an_address'.tr);
    }
  }

  Future<void> setStoreAddressToUserAddress(LatLng storeAddress) async {
    Position storePosition = Position(
      latitude: storeAddress.latitude, longitude: storeAddress.longitude,
      timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1, altitudeAccuracy: 1, headingAccuracy: 1,
    );
    String addressFromGeocode = await getAddressFromGeocode(LatLng(storeAddress.latitude, storeAddress.longitude));
    ZoneResponseModel responseModel = await getZone(storePosition.latitude.toString(), storePosition.longitude.toString(), true);
    _buttonDisabled = !responseModel.isSuccess;
    AddressModel addressModel = AddressModel(
      latitude: storePosition.latitude.toString(), longitude: storePosition.longitude.toString(), addressType: 'others',
      zoneId: responseModel.isSuccess ? responseModel.zoneIds[0] : 0, zoneIds: responseModel.zoneIds,
      address: addressFromGeocode, zoneData: responseModel.zoneData, areaIds: responseModel.areaIds,
    );
    await AddressHelper.saveUserAddressInSharedPref(addressModel);

    await Get.find<SplashController>().getModules();
    List<ModuleModel>? modules = Get.find<SplashController>().moduleList;
    for(ModuleModel m in modules!){
      if(m.id == Get.find<StoreController>().store!.moduleId) {
        Get.find<SplashController>().setModule(m);
      }
    }

  }

}