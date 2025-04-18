import 'dart:convert';
import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
import 'package:sixam_mart/features/brands/domain/repositories/brands_repository.dart';
import 'package:sixam_mart/features/brands/domain/repositories/brands_repository_interface.dart';
import 'package:sixam_mart/features/brands/domain/services/brands_service.dart';
import 'package:sixam_mart/features/brands/domain/services/brands_service_interface.dart';
import 'package:sixam_mart/features/business/controllers/business_controller.dart';
import 'package:sixam_mart/features/business/domain/repositories/business_repo.dart';
import 'package:sixam_mart/features/business/domain/repositories/business_repo_interface.dart';
import 'package:sixam_mart/features/business/domain/services/business_service.dart';
import 'package:sixam_mart/features/business/domain/services/business_service_interface.dart';
import 'package:sixam_mart/features/coupon/domain/repositories/coupon_repository.dart';
import 'package:sixam_mart/features/coupon/domain/repositories/coupon_repository_interface.dart';
import 'package:sixam_mart/features/home/controllers/advertisement_controller.dart';
import 'package:sixam_mart/features/home/controllers/home_controller.dart';
import 'package:sixam_mart/features/home/domain/repositories/advertisement_repository.dart';
import 'package:sixam_mart/features/home/domain/repositories/advertisement_repository_interface.dart';
import 'package:sixam_mart/features/home/domain/repositories/home_repository.dart';
import 'package:sixam_mart/features/home/domain/repositories/home_repository_interface.dart';
import 'package:sixam_mart/features/home/domain/services/advertisement_service.dart';
import 'package:sixam_mart/features/home/domain/services/advertisement_service_interface.dart';
import 'package:sixam_mart/features/home/domain/services/home_service.dart';
import 'package:sixam_mart/features/home/domain/services/home_service_interface.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/banner/controllers/banner_controller.dart';
import 'package:sixam_mart/features/banner/domain/repositories/banner_repository.dart';
import 'package:sixam_mart/features/banner/domain/repositories/banner_repository_interface.dart';
import 'package:sixam_mart/features/banner/domain/services/banner_service.dart';
import 'package:sixam_mart/features/banner/domain/services/banner_service_interface.dart';
import 'package:sixam_mart/features/cart/domain/repositories/cart_repository.dart';
import 'package:sixam_mart/features/cart/domain/repositories/cart_repository_interface.dart';
import 'package:sixam_mart/features/cart/domain/services/cart_service.dart';
import 'package:sixam_mart/features/cart/domain/services/cart_service_interface.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/category/domain/reposotories/category_repository.dart';
import 'package:sixam_mart/features/category/domain/reposotories/category_repository_interface.dart';
import 'package:sixam_mart/features/category/domain/services/category_service.dart';
import 'package:sixam_mart/features/category/domain/services/category_service_interface.dart';
import 'package:sixam_mart/features/chat/controllers/chat_controller.dart';
import 'package:sixam_mart/features/chat/domain/repositories/chat_repository.dart';
import 'package:sixam_mart/features/chat/domain/repositories/chat_repository_interface.dart';
import 'package:sixam_mart/features/chat/domain/services/chat_service.dart';
import 'package:sixam_mart/features/chat/domain/services/chat_service_interface.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/coupon/domain/services/coupon_service.dart';
import 'package:sixam_mart/features/coupon/domain/services/coupon_service_interface.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/favourite/domain/repositories/favourite_repository.dart';
import 'package:sixam_mart/features/favourite/domain/repositories/favourite_repository_interface.dart';
import 'package:sixam_mart/features/favourite/domain/services/favourite_service.dart';
import 'package:sixam_mart/features/favourite/domain/services/favourite_service_interface.dart';
import 'package:sixam_mart/features/flash_sale/controllers/flash_sale_controller.dart';
import 'package:sixam_mart/features/flash_sale/domain/repositories/flash_sale_repository.dart';
import 'package:sixam_mart/features/flash_sale/domain/repositories/flash_sale_repository_interface.dart';
import 'package:sixam_mart/features/flash_sale/domain/services/flash_sale_service.dart';
import 'package:sixam_mart/features/flash_sale/domain/services/flash_sale_service_interface.dart';
import 'package:sixam_mart/features/html/controllers/html_controller.dart';
import 'package:sixam_mart/features/html/domain/repositories/html_repository.dart';
import 'package:sixam_mart/features/html/domain/repositories/html_repository_interface.dart';
import 'package:sixam_mart/features/html/domain/services/html_service.dart';
import 'package:sixam_mart/features/html/domain/services/html_service_interface.dart';
import 'package:sixam_mart/features/item/controllers/campaign_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/repositories/campaign_repository.dart';
import 'package:sixam_mart/features/item/domain/repositories/campaign_repository_interface.dart';
import 'package:sixam_mart/features/item/domain/repositories/item_repository.dart';
import 'package:sixam_mart/features/item/domain/repositories/item_repository_interface.dart';
import 'package:sixam_mart/features/item/domain/services/campaign_service.dart';
import 'package:sixam_mart/features/item/domain/services/campaign_service_interface.dart';
import 'package:sixam_mart/features/item/domain/services/item_service.dart';
import 'package:sixam_mart/features/item/domain/services/item_service_interface.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/language/domain/repository/language_repository.dart';
import 'package:sixam_mart/features/language/domain/repository/language_repository_interface.dart';
import 'package:sixam_mart/features/language/domain/service/language_service.dart';
import 'package:sixam_mart/features/language/domain/service/language_service_interface.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/address/domain/repositories/address_repository.dart';
import 'package:sixam_mart/features/address/domain/repositories/address_repository_interface.dart';
import 'package:sixam_mart/features/address/domain/services/address_service.dart';
import 'package:sixam_mart/features/address/domain/services/address_service_interface.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/auth/controllers/deliveryman_registration_controller.dart';
import 'package:sixam_mart/features/auth/controllers/store_registration_controller.dart';
import 'package:sixam_mart/features/auth/domain/reposotories/auth_repository.dart';
import 'package:sixam_mart/features/auth/domain/reposotories/auth_repository_interface.dart';
import 'package:sixam_mart/features/auth/domain/reposotories/deliveryman_registration_repository.dart';
import 'package:sixam_mart/features/auth/domain/reposotories/deliveryman_registration_repository_interface.dart';
import 'package:sixam_mart/features/auth/domain/reposotories/store_registration_repository.dart';
import 'package:sixam_mart/features/auth/domain/reposotories/store_registration_repository_interface.dart';
import 'package:sixam_mart/features/auth/domain/services/auth_service.dart';
import 'package:sixam_mart/features/auth/domain/services/auth_service_interface.dart';
import 'package:sixam_mart/features/auth/domain/services/deliveryman_registration_service.dart';
import 'package:sixam_mart/features/auth/domain/services/deliveryman_registration_service_interface.dart';
import 'package:sixam_mart/features/auth/domain/services/store_registration_service.dart';
import 'package:sixam_mart/features/auth/domain/services/store_registration_service_interface.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:sixam_mart/features/checkout/domain/repositories/checkout_repository_interface.dart';
import 'package:sixam_mart/features/checkout/domain/services/checkout_service.dart';
import 'package:sixam_mart/features/checkout/domain/services/checkout_service_interface.dart';
import 'package:sixam_mart/features/location/domain/repositories/location_repository.dart';
import 'package:sixam_mart/features/location/domain/repositories/location_repository_interface.dart';
import 'package:sixam_mart/features/location/domain/services/location_service.dart';
import 'package:sixam_mart/features/location/domain/services/location_service_interface.dart';
import 'package:sixam_mart/features/loyalty/controllers/loyalty_controller.dart';
import 'package:sixam_mart/features/loyalty/domain/repositories/loyalty_repository.dart';
import 'package:sixam_mart/features/loyalty/domain/repositories/loyalty_repository_interface.dart';
import 'package:sixam_mart/features/loyalty/domain/services/loyalty_service.dart';
import 'package:sixam_mart/features/loyalty/domain/services/loyalty_service_interface.dart';
import 'package:sixam_mart/features/notification/controllers/notification_controller.dart';
import 'package:sixam_mart/features/notification/domain/repository/notification_repository.dart';
import 'package:sixam_mart/features/notification/domain/repository/notification_repository_interface.dart';
import 'package:sixam_mart/features/notification/domain/service/notification_service.dart';
import 'package:sixam_mart/features/notification/domain/service/notification_service_interface.dart';
import 'package:sixam_mart/features/onboard/controllers/onboard_controller.dart';
import 'package:sixam_mart/features/onboard/domain/repository/onboard_repository.dart';
import 'package:sixam_mart/features/onboard/domain/repository/onboard_repository_interface.dart';
import 'package:sixam_mart/features/onboard/domain/service/onboard_service.dart';
import 'package:sixam_mart/features/onboard/domain/service/onboard_service_interface.dart';
import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/features/order/domain/repositories/order_repository.dart';
import 'package:sixam_mart/features/order/domain/repositories/order_repository_interface.dart';
import 'package:sixam_mart/features/order/domain/services/order_service.dart';
import 'package:sixam_mart/features/order/domain/services/order_service_interface.dart';
import 'package:sixam_mart/features/parcel/controllers/parcel_controller.dart';
import 'package:sixam_mart/features/parcel/domain/repositories/parcel_repository.dart';
import 'package:sixam_mart/features/parcel/domain/repositories/parcel_repository_interface.dart';
import 'package:sixam_mart/features/parcel/domain/services/parcel_service.dart';
import 'package:sixam_mart/features/parcel/domain/services/parcel_service_interface.dart';
import 'package:sixam_mart/features/payment/controllers/payment_controller.dart';
import 'package:sixam_mart/features/payment/domain/repositories/payement_repository.dart';
import 'package:sixam_mart/features/payment/domain/repositories/payment_repository_interface.dart';
import 'package:sixam_mart/features/payment/domain/services/payment_service.dart';
import 'package:sixam_mart/features/payment/domain/services/payment_service_interface.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/profile/domain/repositories/profile_repository.dart';
import 'package:sixam_mart/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:sixam_mart/features/profile/domain/services/profile_service.dart';
import 'package:sixam_mart/features/profile/domain/services/profile_service_interface.dart';
import 'package:sixam_mart/features/review/controllers/review_controller.dart';
import 'package:sixam_mart/features/review/domain/repositories/review_repository.dart';
import 'package:sixam_mart/features/review/domain/repositories/review_repository_interface.dart';
import 'package:sixam_mart/features/review/domain/services/review_service.dart';
import 'package:sixam_mart/features/review/domain/services/review_service_interface.dart';
import 'package:sixam_mart/features/search/controllers/search_controller.dart';
import 'package:sixam_mart/features/search/domain/repositories/search_repository.dart';
import 'package:sixam_mart/features/search/domain/repositories/search_repository_interface.dart';
import 'package:sixam_mart/features/search/domain/services/search_service.dart';
import 'package:sixam_mart/features/search/domain/services/search_service_interface.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/splash/domain/repositories/splash_repository.dart';
import 'package:sixam_mart/features/splash/domain/repositories/splash_repository_interface.dart';
import 'package:sixam_mart/features/splash/domain/services/splash_service.dart';
import 'package:sixam_mart/features/splash/domain/services/splash_service_interface.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/repositories/store_repository.dart';
import 'package:sixam_mart/features/store/domain/repositories/store_repository_interface.dart';
import 'package:sixam_mart/features/store/domain/services/store_service.dart';
import 'package:sixam_mart/features/store/domain/services/store_service_interface.dart';
import 'package:sixam_mart/features/rental_module/rental_location_screen/controller/taxi_location_controller.dart';
import 'package:sixam_mart/features/rental_module/home/controllers/taxi_home_controller.dart';
import 'package:sixam_mart/features/rental_module/home/domain/repositories/taxi_home_repository.dart';
import 'package:sixam_mart/features/rental_module/home/domain/repositories/taxi_home_repository_interface.dart';
import 'package:sixam_mart/features/rental_module/home/domain/services/taxi_home_service.dart';
import 'package:sixam_mart/features/rental_module/home/domain/services/taxi_home_service_interface.dart';
import 'package:sixam_mart/features/rental_module/rental_cart_screen/controllers/taxi_cart_controller.dart';
import 'package:sixam_mart/features/rental_module/rental_cart_screen/domain/repository/taxi_cart_repository.dart';
import 'package:sixam_mart/features/rental_module/rental_cart_screen/domain/repository/taxi_cart_repository_interface.dart';
import 'package:sixam_mart/features/rental_module/rental_cart_screen/domain/services/taxi_cart_service.dart';
import 'package:sixam_mart/features/rental_module/rental_cart_screen/domain/services/taxi_cart_service_interface.dart';
import 'package:sixam_mart/features/rental_module/rental_favourite/controllers/taxi_favourite_controller.dart';
import 'package:sixam_mart/features/rental_module/rental_favourite/domain/repositories/taxi_favourite_repository.dart';
import 'package:sixam_mart/features/rental_module/rental_favourite/domain/repositories/taxi_favourite_repository_interface.dart';
import 'package:sixam_mart/features/rental_module/rental_favourite/domain/services/taxi_favourite_service.dart';
import 'package:sixam_mart/features/rental_module/rental_favourite/domain/services/taxi_favourite_service_interface.dart';
import 'package:sixam_mart/features/rental_module/rental_location_screen/domain/repository/taxi_repository.dart';
import 'package:sixam_mart/features/rental_module/rental_location_screen/domain/repository/taxi_repository_interface.dart';
import 'package:sixam_mart/features/rental_module/rental_location_screen/domain/services/taxi_location_service.dart';
import 'package:sixam_mart/features/rental_module/rental_location_screen/domain/services/taxi_location_service_interface.dart';
import 'package:sixam_mart/features/rental_module/rental_order/controllers/taxi_order_controller.dart';
import 'package:sixam_mart/features/rental_module/rental_order/domain/repository/taxi_order_repository.dart';
import 'package:sixam_mart/features/rental_module/rental_order/domain/repository/taxi_order_repository_interface.dart';
import 'package:sixam_mart/features/rental_module/rental_order/domain/services/taxi_order_service.dart';
import 'package:sixam_mart/features/rental_module/rental_order/domain/services/taxi_order_service_interface.dart';
import 'package:sixam_mart/features/rental_module/vendor/controllers/taxi_vendor_controller.dart';
import 'package:sixam_mart/features/rental_module/vendor/domain/repositories/taxi_vendor_repository.dart';
import 'package:sixam_mart/features/rental_module/vendor/domain/repositories/taxi_vendor_repository_interface.dart';
import 'package:sixam_mart/features/rental_module/vendor/domain/services/taxi_vendor_service.dart';
import 'package:sixam_mart/features/rental_module/vendor/domain/services/taxi_vendor_service_interface.dart';
import 'package:sixam_mart/features/verification/controllers/verification_controller.dart';
import 'package:sixam_mart/features/verification/domein/reposotories/verification_repository.dart';
import 'package:sixam_mart/features/verification/domein/reposotories/verification_repository_interface.dart';
import 'package:sixam_mart/features/verification/domein/services/verification_service.dart';
import 'package:sixam_mart/features/verification/domein/services/verification_service_interface.dart';
import 'package:sixam_mart/features/wallet/controllers/wallet_controller.dart';
import 'package:sixam_mart/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:sixam_mart/features/wallet/domain/repositories/wallet_repository_interface.dart';
import 'package:sixam_mart/features/wallet/domain/services/wallet_service.dart';
import 'package:sixam_mart/features/wallet/domain/services/wallet_service_interface.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/features/language/domain/models/language_model.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  /// Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  /// Repository interface
  CheckoutRepositoryInterface checkoutRepositoryInterface = CheckoutRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => checkoutRepositoryInterface);

  AuthRepositoryInterface authRepositoryInterface = AuthRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => authRepositoryInterface);

  LocationRepositoryInterface locationRepositoryInterface = LocationRepository(apiClient: Get.find());
  Get.lazyPut(() => locationRepositoryInterface);

  DeliverymanRegistrationRepositoryInterface deliverymanRegistrationRepositoryInterface = DeliverymanRegistrationRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => deliverymanRegistrationRepositoryInterface);

  StoreRegistrationRepositoryInterface storeRegistrationRepositoryInterface = StoreRegistrationRepository(apiClient: Get.find());
  Get.lazyPut(() => storeRegistrationRepositoryInterface);

  ParcelRepositoryInterface parcelRepositoryInterface = ParcelRepository(apiClient: Get.find());
  Get.lazyPut(() => parcelRepositoryInterface);

  AddressRepositoryInterface addressRepositoryInterface = AddressRepository(apiClient: Get.find());
  Get.lazyPut(() => addressRepositoryInterface);

  OrderRepositoryInterface orderRepositoryInterface = OrderRepository(apiClient: Get.find());
  Get.lazyPut(() => orderRepositoryInterface);

  PaymentRepositoryInterface paymentRepositoryInterface = PaymentRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => paymentRepositoryInterface);

  CampaignRepositoryInterface campaignRepositoryInterface = CampaignRepository(apiClient: Get.find());
  Get.lazyPut(() => campaignRepositoryInterface);

  ChatRepositoryInterface chatRepositoryInterface = ChatRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => chatRepositoryInterface);

  CouponRepositoryInterface couponRepositoryInterface = CouponRepository(apiClient: Get.find());
  Get.lazyPut(() => couponRepositoryInterface);

  FavouriteRepositoryInterface favouriteRepositoryInterface = FavouriteRepository(apiClient: Get.find());
  Get.lazyPut(() => favouriteRepositoryInterface);

  FlashSaleRepositoryInterface flashSaleRepositoryInterface = FlashSaleRepository(apiClient: Get.find());
  Get.lazyPut(() => flashSaleRepositoryInterface);

  HomeRepositoryInterface homeRepositoryInterface = HomeRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => homeRepositoryInterface);

  BannerRepositoryInterface bannerRepositoryInterface = BannerRepository(apiClient: Get.find());
  Get.lazyPut(() => bannerRepositoryInterface);

  HtmlRepositoryInterface htmlRepositoryInterface = HtmlRepository(apiClient: Get.find());
  Get.lazyPut(() => htmlRepositoryInterface);

  LanguageRepositoryInterface languageRepositoryInterface = LanguageRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => languageRepositoryInterface);

  NotificationRepositoryInterface notificationRepositoryInterface = NotificationRepository(sharedPreferences: Get.find(), apiClient: Get.find());
  Get.lazyPut(() => notificationRepositoryInterface);

  OnboardRepositoryInterface onboardRepositoryInterface = OnboardRepository();
  Get.lazyPut(() => onboardRepositoryInterface);

  ProfileRepositoryInterface profileRepositoryInterface = ProfileRepository(apiClient: Get.find());
  Get.lazyPut(() => profileRepositoryInterface);

  SearchRepositoryInterface searchRepositoryInterface = SearchRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => searchRepositoryInterface);

  SplashRepositoryInterface splashRepositoryInterface = SplashRepository(sharedPreferences: Get.find(), apiClient: Get.find());
  Get.lazyPut(() => splashRepositoryInterface);

  ReviewRepositoryInterface reviewRepositoryInterface = ReviewRepository(apiClient: Get.find());
  Get.lazyPut(() => reviewRepositoryInterface);

  StoreRepositoryInterface storeRepositoryInterface = StoreRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => storeRepositoryInterface);

  WalletRepositoryInterface walletRepositoryInterface = WalletRepository(sharedPreferences: Get.find(), apiClient: Get.find());
  Get.lazyPut(() => walletRepositoryInterface);

  ItemRepositoryInterface itemRepositoryInterface = ItemRepository(apiClient: Get.find());
  Get.lazyPut(() => itemRepositoryInterface);

  CategoryRepositoryInterface categoryRepositoryInterface = CategoryRepository(apiClient: Get.find());
  Get.lazyPut(() => categoryRepositoryInterface);

  LoyaltyRepositoryInterface loyaltyRepositoryInterface = LoyaltyRepository(apiClient: Get.find());
  Get.lazyPut(() => loyaltyRepositoryInterface);

  CartRepositoryInterface cartRepositoryInterface = CartRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => cartRepositoryInterface);

  VerificationRepositoryInterface verificationRepositoryInterface = VerificationRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => verificationRepositoryInterface);

  BrandsRepositoryInterface brandsRepositoryInterface = BrandsRepository(apiClient: Get.find());
  Get.lazyPut(() => brandsRepositoryInterface);

  BusinessRepoInterface businessRepoInterface = BusinessRepo(apiClient: Get.find());
  Get.lazyPut(() => businessRepoInterface);

  AdvertisementRepositoryInterface advertisementRepositoryInterface = AdvertisementRepository(apiClient: Get.find());
  Get.lazyPut(() => advertisementRepositoryInterface);

  TaxiRepositoryInterface taxiRepositoryInterface = TaxiRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => taxiRepositoryInterface);
  
  TaxiHomeRepositoryInterface taxiHomeRepositoryInterface = TaxiHomeRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => taxiHomeRepositoryInterface);

  TaxiCartRepositoryInterface taxiCartRepositoryInterface = TaxiCartRepository(apiClient: Get.find());
  Get.lazyPut(() => taxiCartRepositoryInterface);

  TaxiVendorRepositoryInterface taxiVendorRepositoryInterface = TaxiVendorRepository(apiClient: Get.find());
  Get.lazyPut(() => taxiVendorRepositoryInterface);

  TaxiOrderRepositoryInterface taxiOrderRepositoryInterface = TaxiOrderRepository(apiClient: Get.find());
  Get.lazyPut(() => taxiOrderRepositoryInterface);

  TaxiFavouriteRepositoryInterface taxiFavouriteRepositoryInterface = TaxiFavouriteRepository(apiClient: Get.find(), sharedPreferences: Get.find());
  Get.lazyPut(() => taxiFavouriteRepositoryInterface);

  /// Service Interface
  CheckoutServiceInterface checkoutServiceInterface = CheckoutService(checkoutRepositoryInterface: Get.find());
  Get.lazyPut(() => checkoutServiceInterface);

  AuthServiceInterface authServiceInterface = AuthService(authRepositoryInterface: Get.find());
  Get.lazyPut(() => authServiceInterface);

  LocationServiceInterface locationServiceInterface = LocationService(locationRepoInterface: Get.find());

  DeliverymanRegistrationServiceInterface deliverymanRegistrationServiceInterface = DeliverymanRegistrationService(deliverymanRegistrationRepoInterface: Get.find(), authRepositoryInterface: Get.find());
  Get.lazyPut(() => deliverymanRegistrationServiceInterface);

  StoreRegistrationServiceInterface storeRegistrationServiceInterface = StoreRegistrationService(deliverymanRegistrationRepositoryInterface: Get.find(), storeRegistrationRepoInterface: Get.find());
  Get.lazyPut(() => storeRegistrationServiceInterface);

  ParcelServiceInterface parcelServiceInterface = ParcelService(parcelRepositoryInterface: Get.find(), checkoutRepositoryInterface: Get.find());
  Get.lazyPut(() => parcelServiceInterface);

  AddressServiceInterface addressServiceInterface = AddressService(addressRepoInterface: Get.find());
  Get.lazyPut(() => addressServiceInterface);

  OrderServiceInterface orderServiceInterface = OrderService(orderRepositoryInterface: Get.find());
  Get.lazyPut(() => orderServiceInterface);

  PaymentServiceInterface paymentServiceInterface = PaymentService(paymentRepositoryInterface: Get.find());
  Get.lazyPut(() => paymentServiceInterface);

  CampaignServiceInterface campaignServiceInterface = CampaignService(campaignRepositoryInterface: Get.find());
  Get.lazyPut(() => campaignServiceInterface);

  ChatServiceInterface chatServiceInterface = ChatService(chatRepositoryInterface: Get.find());
  Get.lazyPut(() => chatServiceInterface);

  CouponServiceInterface couponServiceInterface = CouponService(couponRepositoryInterface: Get.find());
  Get.lazyPut(() => couponServiceInterface);

  FavouriteServiceInterface favouriteServiceInterface = FavouriteService(favouriteRepositoryInterface: Get.find());
  Get.lazyPut(() => favouriteServiceInterface);

  HomeServiceInterface homeServiceInterface = HomeService(homeRepositoryInterface: Get.find());
  Get.lazyPut(() => homeServiceInterface);

  FlashSaleServiceInterface flashSaleServiceInterface = FlashSaleService(flashSaleRepositoryInterface: Get.find());
  Get.lazyPut(() => flashSaleServiceInterface);

  BannerServiceInterface bannerServiceInterface = BannerService(bannerRepositoryInterface: Get.find());
  Get.lazyPut(() => bannerServiceInterface);

  HtmlServiceInterface htmlServiceInterface = HtmlService(htmlRepositoryInterface: Get.find());
  Get.lazyPut(() => htmlServiceInterface);

  LanguageServiceInterface languageServiceInterface = LanguageService(languageRepositoryInterface: Get.find());
  Get.lazyPut(() => languageServiceInterface);

  NotificationServiceInterface notificationServiceInterface = NotificationService(notificationRepositoryInterface: Get.find());
  Get.lazyPut(() => notificationServiceInterface);

  OnboardServiceInterface onboardServiceInterface = OnboardService(onboardRepositoryInterface: Get.find());
  Get.lazyPut(() => onboardServiceInterface);

  ProfileServiceInterface profileServiceInterface = ProfileService(profileRepositoryInterface: Get.find());
  Get.lazyPut(() => profileServiceInterface);

  SearchServiceInterface searchServiceInterface = SearchService(searchRepositoryInterface: Get.find());
  Get.lazyPut(() => searchServiceInterface);

  SplashServiceInterface splashServiceInterface = SplashService(splashRepositoryInterface: Get.find());
  Get.lazyPut(() => splashServiceInterface);

  ReviewServiceInterface reviewServiceInterface = ReviewService(reviewRepositoryInterface: Get.find());
  Get.lazyPut(() => reviewServiceInterface);

  StoreServiceInterface storeServiceInterface = StoreService(storeRepositoryInterface: Get.find());
  Get.lazyPut(() => storeServiceInterface);

  WalletServiceInterface walletServiceInterface = WalletService(walletRepositoryInterface: Get.find());
  Get.lazyPut(() => walletServiceInterface);

  ItemServiceInterface itemServiceInterface = ItemService(itemRepositoryInterface: Get.find());
  Get.lazyPut(() => itemServiceInterface);

  CategoryServiceInterface categoryServiceInterface = CategoryService(categoryRepositoryInterface: Get.find());
  Get.lazyPut(() => categoryServiceInterface);

  LoyaltyServiceInterface loyaltyServiceInterface = LoyaltyService(loyaltyRepositoryInterface: Get.find());
  Get.lazyPut(() => loyaltyServiceInterface);

  CartServiceInterface cartServiceInterface = CartService(cartRepositoryInterface: Get.find());
  Get.lazyPut(() => cartServiceInterface);

  VerificationServiceInterface verificationServiceInterface = VerificationService(verificationRepoInterface: Get.find(), authRepoInterface: Get.find());
  Get.lazyPut(() => verificationServiceInterface);

  BrandsServiceInterface brandsServiceInterface = BrandsService(brandsRepositoryInterface: Get.find());
  Get.lazyPut(() => brandsServiceInterface);

  BusinessServiceInterface businessServiceInterface = BusinessService(businessRepoInterface: Get.find());
  Get.lazyPut(() => businessServiceInterface);

  AdvertisementServiceInterface advertisementServiceInterface = AdvertisementService(advertisementRepositoryInterface: Get.find());
  Get.lazyPut(() => advertisementServiceInterface);

  TaxiLocationServiceInterface taxiLocationServiceInterface = TaxiLocationService(taxiRepositoryInterface: Get.find());
  Get.lazyPut(() => taxiLocationServiceInterface);

  TaxiHomeServiceInterface taxiHomeServiceInterface = TaxiHomeService(taxiHomeRepositoryInterface: Get.find());
  Get.lazyPut(() => taxiHomeServiceInterface);

  TaxiCartServiceInterface taxiCartServiceInterface = TaxiCartService(taxiCartRepositoryInterface: Get.find());
  Get.lazyPut(() => taxiCartServiceInterface);

  TaxiVendorServiceInterface taxiVendorServiceInterface = TaxiVendorService(taxiVendorRepositoryInterface: Get.find());
  Get.lazyPut(() => taxiVendorServiceInterface);

  TaxiOrderServiceInterface taxiOrderServiceInterface = TaxiOrderService(taxiOrderRepositoryInterface: Get.find());
  Get.lazyPut(() => taxiOrderServiceInterface);

  TaxiFavouriteServiceInterface taxiFavouriteServiceInterface = TaxiFavouriteService(taxiFavouriteRepositoryInterface: Get.find());
  Get.lazyPut(() => taxiFavouriteServiceInterface);


  /// Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashServiceInterface: Get.find()));
  Get.lazyPut(() => AddressController(addressServiceInterface: Get.find()));
  Get.lazyPut(() => LocationController(locationServiceInterface: locationServiceInterface));
  Get.lazyPut(() => LocalizationController(languageServiceInterface: Get.find()));
  Get.lazyPut(() => OnBoardingController(onboardServiceInterface: Get.find()));
  Get.lazyPut(() => AuthController(authServiceInterface: Get.find()));
  Get.lazyPut(() => DeliverymanRegistrationController(deliverymanRegistrationServiceInterface: Get.find()));
  Get.lazyPut(() => StoreRegistrationController(storeRegistrationServiceInterface: Get.find(), locationServiceInterface: locationServiceInterface));
  Get.lazyPut(() => ProfileController(profileServiceInterface: Get.find()));
  Get.lazyPut(() => BannerController(bannerServiceInterface: Get.find()));
  Get.lazyPut(() => CategoryController(categoryServiceInterface: Get.find()));
  Get.lazyPut(() => ItemController(itemServiceInterface: Get.find()));
  Get.lazyPut(() => CartController(cartServiceInterface: Get.find()));
  Get.lazyPut(() => StoreController(storeServiceInterface: Get.find()));
  Get.lazyPut(() => FavouriteController(favouriteServiceInterface: Get.find()));
  Get.lazyPut(() => HomeController(homeServiceInterface: Get.find()));
  Get.lazyPut(() => SearchController(searchServiceInterface: Get.find()));
  Get.lazyPut(() => CouponController(couponServiceInterface: Get.find()));
  Get.lazyPut(() => OrderController(orderServiceInterface: Get.find()));
  Get.lazyPut(() => NotificationController(notificationServiceInterface: Get.find()));
  Get.lazyPut(() => CampaignController(campaignServiceInterface: Get.find()));
  Get.lazyPut(() => ParcelController(parcelServiceInterface: Get.find()));
  Get.lazyPut(() => WalletController(walletServiceInterface: Get.find()));
  Get.lazyPut(() => ChatController(chatServiceInterface: Get.find()));
  Get.lazyPut(() => FlashSaleController(flashSaleServiceInterface: Get.find()));
  Get.lazyPut(() => CheckoutController(checkoutServiceInterface: Get.find()));
  Get.lazyPut(() => PaymentController(paymentServiceInterface: Get.find()));
  Get.lazyPut(() => HtmlController(htmlServiceInterface: Get.find()));
  Get.lazyPut(() => ReviewController(reviewServiceInterface: Get.find()));
  Get.lazyPut(() => CategoryController(categoryServiceInterface: Get.find()));
  Get.lazyPut(() => LoyaltyController(loyaltyServiceInterface: Get.find()));
  Get.lazyPut(() => VerificationController(verificationServiceInterface: Get.find()));
  Get.lazyPut(() => BrandsController(brandsServiceInterface: Get.find()));
  Get.lazyPut(() => BusinessController(businessServiceInterface: Get.find()));
  Get.lazyPut(() => AdvertisementController(advertisementServiceInterface: Get.find()));
  Get.lazyPut(() => TaxiLocationController(taxiLocationServiceInterface: Get.find()));
  Get.lazyPut(() => TaxiHomeController(taxiHomeServiceInterface: Get.find()));
  Get.lazyPut(() => TaxiCartController(taxiCartServiceInterface: Get.find()));
  Get.lazyPut(() => TaxiVendorController(taxiVendorServiceInterface: Get.find()));
  Get.lazyPut(() => TaxiOrderController(taxiOrderServiceInterface: Get.find()));
  Get.lazyPut(() => TaxiFavouriteController(taxiFavouriteServiceInterface: Get.find()));

  /// Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = json;
  }
  return languages;
}
