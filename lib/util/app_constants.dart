import 'package:get/get.dart';
import 'package:sixam_mart/common/models/choose_us_model.dart';
import 'package:sixam_mart/features/language/domain/models/language_model.dart';
import 'package:sixam_mart/util/images.dart';

class AppConstants {
  static const String appName = '6amMart';
  static const double appVersion = 3.0; ///Flutter Version: 3.27.4

  static const String fontFamily = 'Roboto';
  static const bool payInWevView = false;
  static const int balanceInputLen = 10;
  static const String webHostedUrl = 'https://6ammart-web.6amtech.com';
  static const bool useReactWebsite = false;

  static const String baseUrl = 'https://6ammart-admin.6amtech.com';
  static const String categoryUri = '/api/v1/categories';
  static const String bannerUri = '/api/v1/banners';
  static const String storeItemUri = '/api/v1/items/latest';
  static const String popularItemUri = '/api/v1/items/popular';
  static const String reviewedItemUri = '/api/v1/items/most-reviewed';
  static const String searchItemUri = '/api/v1/items/details/';
  static const String subCategoryUri = '/api/v1/categories/childes/';
  static const String categoryItemUri = '/api/v1/categories/items/';
  static const String categoryStoreUri = '/api/v1/categories/stores/';
  static const String configUri = '/api/v1/config';
  static const String trackUri = '/api/v1/customer/order/track?order_id=';
  static const String messageUri = '/api/v1/customer/message/get';
  static const String forgetPasswordUri = '/api/v1/auth/forgot-password';
  static const String verifyTokenUri = '/api/v1/auth/verify-token';
  static const String resetPasswordUri = '/api/v1/auth/reset-password';
  static const String verifyPhoneUri = '/api/v1/auth/verify-phone';
  static const String checkEmailUri = '/api/v1/auth/check-email';
  static const String verifyEmailUri = '/api/v1/auth/verify-email';
  static const String registerUri = '/api/v1/auth/sign-up';
  static const String loginUri = '/api/v1/auth/login';
  static const String tokenUri = '/api/v1/customer/cm-firebase-token';
  static const String placeOrderUri = '/api/v1/customer/order/place';
  static const String placePrescriptionOrderUri = '/api/v1/customer/order/prescription/place';
  static const String addressListUri = '/api/v1/customer/address/list';
  static const String zoneUri = '/api/v1/config/get-zone-id';
  static const String checkZoneUri = '/api/v1/zone/check';
  static const String removeAddressUri = '/api/v1/customer/address/delete?address_id=';
  static const String addAddressUri = '/api/v1/customer/address/add';
  static const String updateAddressUri = '/api/v1/customer/address/update/';
  static const String setMenuUri = '/api/v1/items/set-menu';
  static const String customerInfoUri = '/api/v1/customer/info';
  static const String couponUri = '/api/v1/coupon/list';
  static const String couponApplyUri = '/api/v1/coupon/apply?code=';
  static const String runningOrderListUri = '/api/v1/customer/order/running-orders';
  static const String historyOrderListUri = '/api/v1/customer/order/list';
  static const String orderCancelUri = '/api/v1/customer/order/cancel';
  static const String codSwitchUri = '/api/v1/customer/order/payment-method';
  static const String orderDetailsUri = '/api/v1/customer/order/details?order_id=';
  static const String wishListGetUri = '/api/v1/customer/wish-list';
  static const String addWishListUri = '/api/v1/customer/wish-list/add?';
  static const String removeWishListUri = '/api/v1/customer/wish-list/remove?';
  static const String notificationUri = '/api/v1/customer/notifications';
  static const String updateProfileUri = '/api/v1/customer/update-profile';
  static const String searchUri = '/api/v1/';
  static const String reviewUri = '/api/v1/items/reviews/submit';
  static const String itemDetailsUri = '/api/v1/items/details/';
  static const String lastLocationUri = '/api/v1/delivery-man/last-location?order_id=';
  static const String deliveryManReviewUri = '/api/v1/delivery-man/reviews/submit';
  static const String storeUri = '/api/v1/stores/get-stores';
  static const String popularStoreUri = '/api/v1/stores/popular';
  static const String latestStoreUri = '/api/v1/stores/latest';
  static const String topOfferStoreUri = '/api/v1/stores/top-offer-near-me';
  static const String storeDetailsUri = '/api/v1/stores/details/';
  static const String basicCampaignUri = '/api/v1/campaigns/basic';
  static const String itemCampaignUri = '/api/v1/campaigns/item';
  static const String basicCampaignDetailsUri = '/api/v1/campaigns/basic-campaign-details?basic_campaign_id=';
  static const String interestUri = '/api/v1/customer/update-interest';
  static const String suggestedItemUri = '/api/v1/customer/suggested-items';
  static const String storeReviewUri = '/api/v1/stores/reviews';
  static const String distanceMatrixUri = '/api/v1/config/distance-api';
  static const String searchLocationUri = '/api/v1/config/place-api-autocomplete';
  static const String placeDetailsUri = '/api/v1/config/place-api-details';
  static const String geocodeUri = '/api/v1/config/geocode-api';
  static const String socialLoginUri = '/api/v1/auth/social-login';
  static const String socialRegisterUri = '/api/v1/auth/social-register';
  static const String updateZoneUri = '/api/v1/customer/update-zone';
  static const String moduleUri = '/api/v1/module';
  static const String parcelCategoryUri = '/api/v1/parcel-category';
  static const String aboutUsUri = '/api/v1/about-us';
  static const String privacyPolicyUri = '/api/v1/privacy-policy';
  static const String termsAndConditionUri = '/api/v1/terms-and-conditions';
  static const String cancellationUri = '/api/v1/cancelation';
  static const String refundUri = '/api/v1/refund-policy';
  static const String shippingPolicyUri = '/api/v1/shipping-policy';
  static const String subscriptionUri = '/api/v1/newsletter/subscribe';
  static const String customerRemoveUri = '/api/v1/customer/remove-account';
  static const String walletTransactionUri = '/api/v1/customer/wallet/transactions';
  static const String loyaltyTransactionUri = '/api/v1/customer/loyalty-point/transactions';
  static const String loyaltyPointTransferUri = '/api/v1/customer/loyalty-point/point-transfer';
  static const String zoneListUri = '/api/v1/zone/list';
  static const String storeRegisterUri = '/api/v1/auth/vendor/register';
  static const String dmRegisterUri = '/api/v1/auth/delivery-man/store';
  static const String refundReasonUri = '/api/v1/customer/order/refund-reasons';
  static const String supportReasonUri = '/api/v1/customer/automated-message';
  static const String refundRequestUri = '/api/v1/customer/order/refund-request';
  static const String directionUri = '/api/v1/config/direction-api';
  static const String vehicleListUri = '/api/v1/vehicles/list';
  static const String taxiCouponUri = '/api/v1/coupon/list/taxi';
  static const String taxiBannerUri = '/api/v1/banners/taxi';
  static const String topRatedVehiclesListUri = '/api/v1/vehicles/top-rated/list';
  static const String bandListUri = '/api/v1/vehicles/brand/list';
  // static const String taxiCouponApplyUri = '/api/v1/coupon/apply/taxi?code=';
  static const String tripPlaceUri = '/api/v1/trip/place';
  static const String runningTripUri = '/api/v1/trip/list';
  static const String vehicleChargeUri = '/api/v1/vehicle/extra_charge';
  static const String vehiclesUri = '/api/v1/get-vehicles';
  static const String storeRecommendedItemUri = '/api/v1/items/recommended';
  static const String orderCancellationUri = '/api/v1/customer/order/cancellation-reasons';
  static const String cartStoreSuggestedItemsUri = '/api/v1/items/suggested';
  static const String landingPageUri = '/api/v1/flutter-landing-page';
  static const String mostTipsUri = '/api/v1/most-tips';
  static const String addFundUri = '/api/v1/customer/wallet/add-fund';
  static const String walletBonusUri = '/api/v1/customer/wallet/bonuses';
  static const String guestLoginUri = '/api/v1/auth/guest/request';
  static const String offlineMethodListUri = '/api/v1/offline_payment_method_list';
  static const String offlinePaymentSaveInfoUri = '/api/v1/customer/order/offline-payment';
  static const String offlinePaymentUpdateInfoUri = '/api/v1/customer/order/offline-payment-update';
  static const String storeBannersUri = '/api/v1/banners/';
  static const String recommendedItemsUri = '/api/v1/items/recommended?filter=';
  static const String visitAgainStoreUri = '/api/v1/customer/visit-again';
  static const String discountedItemsUri = '/api/v1/items/discounted';
  static const String parcelOtherBannerUri = '/api/v1/other-banners';
  static const String whyChooseUri = '/api/v1/other-banners/why-choose';
  static const String videoContentUri = '/api/v1/other-banners/video-content';
  static const String promotionalBannerUri = '/api/v1/other-banners';
  static const String basicMedicineUri = '/api/v1/items/basic';
  static const String commonConditionUri = '/api/v1/common-condition';
  static const String conditionWiseItemUri = '/api/v1/common-condition/items/';
  static const String flashSaleUri = '/api/v1/flash-sales';
  static const String flashSaleProductsUri = '/api/v1/flash-sales/items';
  static const String featuredCategoriesItemsUri = '/api/v1/categories/featured/items';
  static const String recommendedStoreUri = '/api/v1/stores/recommended';
  static const String parcelInstructionUri = '/api/v1/customer/order/parcel-instructions';
  static const String cashBackOfferListUri = '/api/v1/cashback/list';
  static const String getCashBackAmountUri = '/api/v1/cashback/getCashback';
  static const String brandListUri = '/api/v1/brand';
  static const String brandItemUri = '/api/v1/brand/items';
  static const String advertisementListUri = '/api/v1/advertisement/list';
  static const String searchSuggestionsUri = '/api/v1/items/item-or-store-search';
  static const String searchPopularCategoriesUri = '/api/v1/categories/popular';
  static const String firebaseAuthVerify = '/api/v1/auth/firebase-verify-token';
  static const String personalInformationUri = '/api/v1/auth/update-info';
  static const String firebaseResetPassword = '/api/v1/auth/firebase-reset-password';

  ///Subscription
  static const String businessPlanUri = '/api/v1/vendor/business_plan';
  static const String businessPlanPaymentUri = '/api/v1/vendor/subscription/payment/api';
  static const String storePackagesUri = '/api/v1/vendor/package-view';

  /// MESSAGING
  static const String conversationListUri = '/api/v1/customer/message/list';
  static const String searchConversationListUri = '/api/v1/customer/message/search-list';
  static const String messageListUri = '/api/v1/customer/message/details';
  static const String sendMessageUri = '/api/v1/customer/message/send';

  /// Cart
  static const String getCartListUri = '/api/v1/customer/cart/list';
  static const String addCartUri = '/api/v1/customer/cart/add';
  static const String updateCartUri = '/api/v1/customer/cart/update';
  static const String removeAllCartUri = '/api/v1/customer/cart/remove';
  static const String removeItemCartUri = '/api/v1/customer/cart/remove-item';

  ///taxi
  static const String getTopRatedCarsUri = '/api/v1/rental/vehicle/top-rated';
  static const String getTaxiBannerUri = '/api/v1/rental/banners';
  static const String getTaxiCouponUri = '/api/v1/rental/coupon/list';
  static const String taxiCouponApplyUri = '/api/v1/rental/coupon/apply';
  static const String getVehicleDetailsUri = '/api/v1/rental/vehicle/get-vehicle-details';
  static const String getVehicleCategoriesUri = '/api/v1/rental/vehicle/category-list';
  static const String getSelectVehiclesUri = '/api/v1/rental/vehicle/search/';
  static const String getSearchVehicleSuggestionUri = '/api/v1/rental/vehicle/search/suggestion';
  static const String addToCarCartUri = '/api/v1/rental/user/cart/add-to-cart';
  static const String updateCarCartUri = '/api/v1/rental/user/cart/update-cart';
  static const String removeCarCartUri = '/api/v1/rental/user/cart/remove-vehicle';
  static const String getCarCartListUri = '/api/v1/rental/user/cart/get-cart';
  static const String tripBookingUri = '/api/v1/rental/user/trip/trip-booking';
  static const String tripUpdateUserDataUri = '/api/v1/rental/user/cart/update-user-data';
  static const String removeAllCarCartUri = '/api/v1/rental/user/cart/remove-cart';
  static const String removeMultipleCarCartUri = '/api/v1/rental/user/cart/remove-multiple-cart';
  static const String tripListUri = '/api/v1/rental/user/trip/get-trip-list';
  static const String tripDetailsUri = '/api/v1/rental/user/trip/get-trip-details';
  static const String tripCancelUri = '/api/v1/rental/user/trip/cancel-trip';
  static const String getProviderDetailsUri = '/api/v1/rental/provider/get-provider-details';
  static const String getProviderVehicleListUri = '/api/v1/rental/vehicle/get-provider-vehicles';
  static const String getProviderVehicleCategoryListUri = '/api/v1/rental/vehicle/category-list';
  static const String tripPaymentUri = '/api/v1/rental/user/trip/payment';
  static const String addTaxiWishListUri = '/api/v1/rental/user/wish-list/add';
  static const String removeTaxiWishListUri = '/api/v1/rental/user/wish-list/remove';
  static const String getTaxiWishListUri = '/api/v1/rental/user/wish-list';
  static const String getTaxiBrandListUri = '/api/v1/rental/vehicle/brand-list';
  static const String getTaxiProviderReviewUri = '/api/v1/rental/provider/get-provider-reviews';
  static const String addTaxiReviewUri = '/api/v1/rental/user/review/add';
  static const String getPopularTaxiSuggestionUri = '/api/v1/rental/vehicle/popular-suggestion/';
  static const String getProviderBannerUri = '/api/v1/rental/banners';

  /// Shared Key
  static const String theme = '6ammart_theme';
  static const String token = '6ammart_token';
  static const String countryCode = '6ammart_country_code';
  static const String languageCode = '6ammart_language_code';
  static const String cacheCountryCode = 'cache_country_code';
  static const String cacheLanguageCode = 'cache_language_code';
  static const String cartList = '6ammart_cart_list';
  static const String userPassword = '6ammart_user_password';
  static const String userAddress = '6ammart_user_address';
  static const String userNumber = '6ammart_user_number';
  static const String userCountryCode = '6ammart_user_country_code';
  static const String notification = '6ammart_notification';
  static const String notificationIdList = 'notification_id_list';
  static const String searchHistory = '6ammart_search_history';
  static const String intro = '6ammart_intro';
  static const String notificationCount = '6ammart_notification_count';
  static const String dmTipIndex = '6ammart_dm_tip_index';
  static const String earnPoint = '6ammart_earn_point';
  static const String acceptCookies = '6ammart_accept_cookies';
  static const String suggestedLocation = '6ammart_suggested_location';
  static const String walletAccessToken = '6ammart_wallet_access_token';
  static const String guestId = '6ammart_guest_id';
  static const String guestNumber = '6ammart_guest_number';
  static const String referBottomSheet = '6ammart_reffer_bottomsheet_show';
  static const String dmRegisterSuccess = '6ammart_dm_registration_success';
  static const String isRestaurantRegister = '6ammart_store_registration';

  ///taxi
  static const String taxiSearchHistory = '6ammart_taxi_search_history';
  static const String taxiSearchAddressHistory = '6ammart_taxi_search_address_history';

  static const String topic = 'all_zone_customer';
  static const String zoneId = 'zoneId';
  static const String operationAreaId = 'operationAreaId';
  static const String moduleId = 'moduleId';
  static const String cacheModuleId = 'cacheModuleId';
  static const String localizationKey = 'X-localization';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String cookiesManagement = 'cookies_management';


  ///Refer & Earn work flow list..
  static final dataList = [
    'invite_your_friends_and_business'.tr,
    '${'they_register'.tr} ${AppConstants.appName} ${'with_special_offer'.tr}',
    'you_made_your_earning'.tr,
  ];

  /// Delivery Tips
  static List<String> tips = ['0' ,'15', '10', '20', '40', 'custom'];
  static List<String> deliveryInstructionList = [
    'deliver_to_front_door'.tr,
    'deliver_the_reception_desk'.tr,
    'avoid_calling_phone'.tr,
    'come_with_no_sound'.tr,
  ];

  static List<ChooseUsModel> whyChooseUsList = [
    ChooseUsModel(icon: Images.landingTrusted, title: 'trusted_by_customers_and_store_owners'),
    ChooseUsModel(icon: Images.landingStores, title: 'thousands_of_stores'),
    ChooseUsModel(icon: Images.landingExcellent, title: 'excellent_shopping_experience'),
    ChooseUsModel(icon: Images.landingCheckout, title: 'easy_checkout_and_payment_system'),
  ];

  /// order status..
  static const String pending = 'pending';
  static const String accepted = 'accepted';
  static const String processing = 'processing';
  static const String confirmed = 'confirmed';
  static const String handover = 'handover';
  static const String pickedUp = 'picked_up';
  static const String delivered = 'delivered';

  ///modules..
  static const String pharmacy = 'pharmacy';
  static const String food = 'food';
  static const String parcel = 'parcel';
  static const String ecommerce = 'ecommerce';
  static const String grocery = 'grocery';
  static const String taxi = 'rental';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.english, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.arabic, languageName: 'عربى', countryCode: 'SA', languageCode: 'ar'),
    LanguageModel(imageUrl: Images.spanish, languageName: 'Spanish', countryCode: 'ES', languageCode: 'es'),
    LanguageModel(imageUrl: Images.bengali, languageName: 'Bengali', countryCode: 'BN', languageCode: 'bn'),
  ];

  static List<String> joinDropdown = [
    'join_us',
    'become_a_seller',
    'become_a_delivery_man'
  ];

  static final List<Map<String, String>> walletTransactionSortingList = [
    {
      'title' : 'all_transactions',
      'value' : 'all'
    },
    {
      'title' : 'order_transactions',
      'value' : 'order'
    },
    {
      'title' : 'converted_from_loyalty_point',
      'value' : 'loyalty_point'
    },
    {
      'title' : 'added_via_payment_method',
      'value' : 'add_fund'
    },
    {
      'title' : 'earned_by_referral',
      'value' : 'referrer'
    },
    {
      'title' : 'cash_back_transactions',
      'value' : 'CashBack'
    },
  ];

  //taxi seats..
  static List<String> seats = ['1-4', '5-8', '9-13', '14+'];

}
