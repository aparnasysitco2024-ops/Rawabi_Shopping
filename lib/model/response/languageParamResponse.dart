class LanguageParamResponse {
  String? code;
  List<LanguageParam>? res;

  LanguageParamResponse({this.code, this.res});

  LanguageParamResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['res'] != null) {
      res = <LanguageParam>[];
      json['res'].forEach((v) {
        res!.add(new LanguageParam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.res != null) {
      data['res'] = this.res!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LanguageParam {
  String? s0;
  String? profile;
  String? myOrders;
  String? ahlanRewards;
  String? myOffers;
  String? myCart;
  String? ourLatestDealsHere;
  String? view;
  String? eReceipt;
  String? wishlist;
  String? address;
  String? language;
  String? giftCards;
  String? notifications;
  String? ourStore;
  String? myReturns;
  String? feedback;
  String? help;
  String? aboutUs;
  String? returnPolicy;
  String? signIn;
  String? rawabiShopping;
  String? no;
  String? yes;
  String? signOut;
  String? addNewAddress;
  String? addressName;
  String? pleaseEnterAddressName;
  String? pleaseEnterAddress;
  String? mobileNumber;
  String? zone;
  String? pleaseEnterZone;
  String? buildingNumber;
  String? pleaseEnterBuildingNumber;
  String? apartmentBuildingBlock;
  String? pleaseEnterApartmentBuildingBlock;
  String? floor;
  String? locationType;
  String? work;
  String? home;
  String? myAddresses;
  String? cart;
  String? change;
  String? yourOrders;
  String? items;
  String? contactlessDelivery;
  String? selectPaymentMethod;
  String? addNewCard;
  String? cashOnDelivery;
  String? applyCoupon;
  String? apply;
  String? orderSummary;
  String? cartTotal;
  String? delivery;
  String? bagFee;
  String? grandTotal;
  String? inclusiveOfAllTaxes;
  String? totalAmount;
  String? placeOrder;
  String? deliveryMode;
  String? homeDelivery;
  String? storePickup;
  String? searchLocation;
  String? confirmLocation;
  String? search;
  String? expressDelivery;
  String? scheduledDelivery;
  String? flayer;
  String? filter;
  String? sort;
  String? searchOrders;
  String? orders;
  String? delivered;
  String? cancelled;
  String? returns;
  String? cancelOrder;
  String? trackYourOrder;
  String? trackOrder;
  String? changeTime;
  String? orderPlaced;
  String? itemProcessed;
  String? baggedFromShopAt245Pm;
  String? delivering;
  String? yourDeliveryIsOnTheWay;
  String? itemDelivered;
  String? expectedAt300PmToday;
  String? explore;
  String? offers;
  String? account;
  String? chicken;
  String? oil;
  String? soap;
  String? fish;
  String? sandwitch;
  String? categories;
  String? changePassword;
  String? enterCurrentPassword;
  String? enterNewPassword;
  String? thePasswordMustBeBetween6To20;
  String? charactersAndMustContainAtLeast;
  String? confirmPassword;
  String? reset;
  String? filters;
  String? productType;
  String? category;
  String? brand;
  String? price;
  String? choosePriceRange;
  String? min;
  String? max;
  String? clear;
  String? skip;
  String? enterMobileNumberOrEmail;
  String? pleaseEnterMobileNumberOrEmail;
  String? proceed;
  String? myProfile;
  String? name;
  String? email;
  String? mobile;
  String? saveAndUpdate;
  String? deleteAccount;
  String? searchNotification;
  String? orderPlacedSuccessfully;
  String? continueShopping;
  String? overview;
  String? details;
  String? addToCart;
  String? enterYourName;
  String? pleaseEnterYourName;
  String? enterMobileNumber;
  String? pleaseEnterMobileNumber;
  String? enterMobileOrEmail;
  String? pleaseEnterMobileOrEmail;
  String? pleaseEnterYourMobileNumber;
  String? pleaseEnterYourEmail;
  String? signUp;
  String? getYourGroceriesDeliveredToYourHome;
  String? theBestDeliveryAppInTownForDeliveringYourDailyFreshGroceries;
  String? verificationCode;
  String? an4DigitCodeHasBeenSentToYourPhoneNumber;
  String? resendOTP;
  String? submit;
  String? badRequest;
  String? unableToProcess;
  String? apiNotRespondedInTime;
  String? unAuthorizedRequest;
  String? error;
  String? oK;
  String? edit;
  String? setAsDefault;
  String? delete;
  String? seeAll;
  String? midWeekDealsToDelightYou;
  String? outForDelivery;
  String? arrivingIn;
  String? days;
  String? amount;
  String? bestSeller;
  String? add;
  String? last3months;
  String? sortBy;
  String? relevance;
  String? newest;
  String? discount;

  LanguageParam(
      {this.s0,
      this.profile,
      this.myOrders,
      this.ahlanRewards,
      this.myOffers,
      this.myCart,
      this.ourLatestDealsHere,
      this.view,
      this.eReceipt,
      this.wishlist,
      this.address,
      this.language,
      this.giftCards,
      this.notifications,
      this.ourStore,
      this.myReturns,
      this.feedback,
      this.help,
      this.aboutUs,
      this.returnPolicy,
      this.signIn,
      this.rawabiShopping,
      this.no,
      this.yes,
      this.signOut,
      this.addNewAddress,
      this.addressName,
      this.pleaseEnterAddressName,
      this.pleaseEnterAddress,
      this.mobileNumber,
      this.zone,
      this.pleaseEnterZone,
      this.buildingNumber,
      this.pleaseEnterBuildingNumber,
      this.apartmentBuildingBlock,
      this.pleaseEnterApartmentBuildingBlock,
      this.floor,
      this.locationType,
      this.work,
      this.home,
      this.myAddresses,
      this.cart,
      this.change,
      this.yourOrders,
      this.items,
      this.contactlessDelivery,
      this.selectPaymentMethod,
      this.addNewCard,
      this.cashOnDelivery,
      this.applyCoupon,
      this.apply,
      this.orderSummary,
      this.cartTotal,
      this.delivery,
      this.bagFee,
      this.grandTotal,
      this.inclusiveOfAllTaxes,
      this.totalAmount,
      this.placeOrder,
      this.deliveryMode,
      this.homeDelivery,
      this.storePickup,
      this.searchLocation,
      this.confirmLocation,
      this.search,
      this.expressDelivery,
      this.scheduledDelivery,
      this.flayer,
      this.filter,
      this.sort,
      this.searchOrders,
      this.orders,
      this.delivered,
      this.cancelled,
      this.returns,
      this.cancelOrder,
      this.trackYourOrder,
      this.trackOrder,
      this.changeTime,
      this.orderPlaced,
      this.itemProcessed,
      this.baggedFromShopAt245Pm,
      this.delivering,
      this.yourDeliveryIsOnTheWay,
      this.itemDelivered,
      this.expectedAt300PmToday,
      this.explore,
      this.offers,
      this.account,
      this.chicken,
      this.oil,
      this.soap,
      this.fish,
      this.sandwitch,
      this.categories,
      this.changePassword,
      this.enterCurrentPassword,
      this.enterNewPassword,
      this.thePasswordMustBeBetween6To20,
      this.charactersAndMustContainAtLeast,
      this.confirmPassword,
      this.reset,
      this.filters,
      this.productType,
      this.category,
      this.brand,
      this.price,
      this.choosePriceRange,
      this.min,
      this.max,
      this.clear,
      this.skip,
      this.enterMobileNumberOrEmail,
      this.pleaseEnterMobileNumberOrEmail,
      this.proceed,
      this.myProfile,
      this.name,
      this.email,
      this.mobile,
      this.saveAndUpdate,
      this.deleteAccount,
      this.searchNotification,
      this.orderPlacedSuccessfully,
      this.continueShopping,
      this.overview,
      this.details,
      this.addToCart,
      this.enterYourName,
      this.pleaseEnterYourName,
      this.enterMobileNumber,
      this.pleaseEnterMobileNumber,
      this.enterMobileOrEmail,
      this.pleaseEnterMobileOrEmail,
      this.pleaseEnterYourMobileNumber,
      this.pleaseEnterYourEmail,
      this.signUp,
      this.getYourGroceriesDeliveredToYourHome,
      this.theBestDeliveryAppInTownForDeliveringYourDailyFreshGroceries,
      this.verificationCode,
      this.an4DigitCodeHasBeenSentToYourPhoneNumber,
      this.resendOTP,
      this.submit,
      this.badRequest,
      this.unableToProcess,
      this.apiNotRespondedInTime,
      this.unAuthorizedRequest,
      this.error,
      this.oK,
      this.edit,
      this.setAsDefault,
      this.delete,
      this.seeAll,
      this.midWeekDealsToDelightYou,
      this.outForDelivery,
      this.arrivingIn,
      this.days,
      this.amount,
      this.bestSeller,
      this.add,
      this.last3months,
      this.sortBy,
      this.relevance,
      this.newest,
      this.discount});

  LanguageParam.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    profile = json['Profile'];
    myOrders = json['My_Orders'];
    ahlanRewards = json['Ahlan_Rewards'];
    myOffers = json['My_Offers'];
    myCart = json['My_Cart'];
    ourLatestDealsHere = json['our_latest_deals_here'];
    view = json['View'];
    eReceipt = json['E-Receipt'];
    wishlist = json['Wishlist'];
    address = json['Address'];
    language = json['Language'];
    giftCards = json['Gift_Cards'];
    notifications = json['Notifications'];
    ourStore = json['Our_Store'];
    myReturns = json['My_Returns'];
    feedback = json['Feedback'];
    help = json['Help'];
    aboutUs = json['About_Us'];
    returnPolicy = json['Return_Policy'];
    signIn = json['Sign_In'];
    rawabiShopping = json['Rawabi_Shopping'];
    no = json['No'];
    yes = json['Yes'];
    signOut = json['Sign_Out'];
    addNewAddress = json['Add_New_Address'];
    addressName = json['Address_Name'];
    pleaseEnterAddressName = json['Please_enter_Address_Name'];
    pleaseEnterAddress = json['Please_enter_Address'];
    mobileNumber = json['Mobile_Number'];
    zone = json['Zone'];
    pleaseEnterZone = json['Please_enter_zone'];
    buildingNumber = json['Building_Number'];
    pleaseEnterBuildingNumber = json['Please_enter_Building_Number'];
    apartmentBuildingBlock = json['Apartment/Building/Block'];
    pleaseEnterApartmentBuildingBlock =
        json['Please_enter_Apartment/Building/Block'];
    floor = json['Floor'];
    locationType = json['Location_Type'];
    work = json['Work'];
    home = json['Home'];
    myAddresses = json['My_Addresses'];
    cart = json['Cart'];
    change = json['Change'];
    yourOrders = json['Your_orders'];
    items = json['items'];
    contactlessDelivery = json['Contactless_Delivery'];
    selectPaymentMethod = json['Select_Payment_Method'];
    addNewCard = json['Add_new_Card'];
    cashOnDelivery = json['Cash_on_Delivery'];
    applyCoupon = json['Apply_Coupon'];
    apply = json['Apply'];
    orderSummary = json['Order_Summary'];
    cartTotal = json['Cart_Total'];
    delivery = json['Delivery'];
    bagFee = json['Bag_Fee'];
    grandTotal = json['Grand_Total'];
    inclusiveOfAllTaxes = json['Inclusive_of_all_taxes'];
    totalAmount = json['Total_amount'];
    placeOrder = json['Place_order'];
    deliveryMode = json['Delivery_Mode'];
    homeDelivery = json['Home_Delivery'];
    storePickup = json['Store_Pickup'];
    searchLocation = json['Search_Location'];
    confirmLocation = json['Confirm_Location'];
    search = json['Search'];
    expressDelivery = json['Express_delivery'];
    scheduledDelivery = json['Scheduled_delivery'];
    flayer = json['Flayer'];
    filter = json['Filter'];
    sort = json['Sort'];
    searchOrders = json['Search_Orders'];
    orders = json['Orders'];
    delivered = json['Delivered'];
    cancelled = json['Cancelled'];
    returns = json['Return'];
    cancelOrder = json['Cancel_Order'];
    trackYourOrder = json['Track_Your_Order'];
    trackOrder = json['Track_Order'];
    changeTime = json['Change_time'];
    totalAmount = json['Total_Amount'];
    orderPlaced = json['Order_placed'];
    itemProcessed = json['Item_Processed'];
    baggedFromShopAt245Pm = json['Bagged_from_Shop_at_2:45_Pm'];
    delivering = json['Delivering'];
    yourDeliveryIsOnTheWay = json['Your_delivery_is_on_the_way'];
    itemDelivered = json['Item_Delivered'];
    expectedAt300PmToday = json['Expected_at_3:00_Pm_Today'];
    explore = json['Explore'];
    offers = json['Offers'];
    account = json['Account'];
    chicken = json['Chicken'];
    oil = json['oil'];
    soap = json['soap'];
    fish = json['Fish'];
    sandwitch = json['sandwitch'];
    categories = json['Categories'];
    changePassword = json['Change_Password'];
    enterCurrentPassword = json['Enter_Current_Password'];
    enterNewPassword = json['Enter_New_Password'];
    thePasswordMustBeBetween6To20 =
        json['The_password_must_be_between_6_to_20'];
    charactersAndMustContainAtLeast =
        json['characters_and_must_contain_at_least'];
    confirmPassword = json['Confirm_Password'];
    reset = json['Reset'];
    filters = json['Filters'];
    productType = json['Product_Type'];
    category = json['Category'];
    brand = json['Brand'];
    price = json['Price'];
    choosePriceRange = json['Choose_price_Range'];
    min = json['Min'];
    max = json['Max'];
    clear = json['Clear'];
    skip = json['Skip'];
    enterMobileNumberOrEmail = json['Enter_Mobile_number_or_Email'];
    pleaseEnterMobileNumberOrEmail =
        json['Please_enter_Mobile_number_or_Email'];
    pleaseEnterMobileNumberOrEmail =
        json['Please_Enter_Mobile_number_or_Email'];
    proceed = json['Proceed'];
    myProfile = json['My_Profile'];
    name = json['Name'];
    email = json['Email'];
    mobile = json['Mobile'];
    saveAndUpdate = json['Save_and_Update'];
    deleteAccount = json['Delete_Account'];
    searchNotification = json['Search_notification'];
    orderPlacedSuccessfully = json['Order_Placed_Successfully'];
    continueShopping = json['Continue_shopping'];
    trackOrder = json['Track_order'];
    overview = json['Overview'];
    details = json['Details'];
    addToCart = json['Add_to_Cart'];
    enterYourName = json['Enter_Your_Name'];
    pleaseEnterYourName = json['Please_Enter_Your_Name'];
    enterMobileNumber = json['Enter_Mobile_number'];
    pleaseEnterMobileNumber = json['Please_enter_Mobile_number'];
    enterMobileOrEmail = json['Enter_Mobile_or_Email'];
    pleaseEnterMobileOrEmail = json['Please_enter_Mobile_or_Email'];
    pleaseEnterYourName = json['Please_enter_your_name'];
    pleaseEnterYourMobileNumber = json['Please_enter_your_mobile_number'];
    pleaseEnterYourEmail = json['Please_enter_your_email'];
    signUp = json['Sign_Up'];
    getYourGroceriesDeliveredToYourHome =
        json['Get_your_groceries_delivered_to_your_home'];
    theBestDeliveryAppInTownForDeliveringYourDailyFreshGroceries = json[
        'The_best_delivery_app_in_town_for_delivering_your_daily_fresh_groceries'];
    verificationCode = json['Verification_Code'];
    an4DigitCodeHasBeenSentToYourPhoneNumber =
        json['An_4_digit_code_has_been_sent_to_your_phone_number'];
    resendOTP = json['Resend_OTP'];
    submit = json['Submit'];
    badRequest = json['Bad_Request'];
    unableToProcess = json['Unable_to_process'];
    apiNotRespondedInTime = json['Api_not_responded_in_time'];
    unAuthorizedRequest = json['UnAuthorized_request'];
    error = json['Error'];
    oK = json['OK'];
    edit = json['Edit'];
    setAsDefault = json['Set_as_default'];
    delete = json['Delete'];
    seeAll = json['See_All'];
    midWeekDealsToDelightYou = json['Mid-week_deals_to_delight_you'];
    outForDelivery = json['Out_for_delivery'];
    arrivingIn = json['Arriving_in'];
    days = json['days'];
    amount = json['Amount:'];
    bestSeller = json['Best_seller'];
    add = json['Add'];
    last3months = json['Last_3months'];
    sortBy = json['Sort_by'];
    relevance = json['Relevance'];
    newest = json['Newest'];
    discount = json['Discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['Profile'] = this.profile;
    data['My_Orders'] = this.myOrders;
    data['Ahlan_Rewards'] = this.ahlanRewards;
    data['My_Offers'] = this.myOffers;
    data['My_Cart'] = this.myCart;
    data['our_latest_deals_here'] = this.ourLatestDealsHere;
    data['View'] = this.view;
    data['E-Receipt'] = this.eReceipt;
    data['Wishlist'] = this.wishlist;
    data['Address'] = this.address;
    data['Language'] = this.language;
    data['Gift_Cards'] = this.giftCards;
    data['Notifications'] = this.notifications;
    data['Our_Store'] = this.ourStore;
    data['My_Returns'] = this.myReturns;
    data['Feedback'] = this.feedback;
    data['Help'] = this.help;
    data['About_Us'] = this.aboutUs;
    data['Return_Policy'] = this.returnPolicy;
    data['Sign_In'] = this.signIn;
    data['Rawabi_Shopping'] = this.rawabiShopping;
    data['No'] = this.no;
    data['Yes'] = this.yes;
    data['Sign_Out'] = this.signOut;
    data['Add_New_Address'] = this.addNewAddress;
    data['Address_Name'] = this.addressName;
    data['Please_enter_Address_Name'] = this.pleaseEnterAddressName;
    data['Please_enter_Address'] = this.pleaseEnterAddress;
    data['Mobile_Number'] = this.mobileNumber;
    data['Zone'] = this.zone;
    data['Please_enter_zone'] = this.pleaseEnterZone;
    data['Building_Number'] = this.buildingNumber;
    data['Please_enter_Building_Number'] = this.pleaseEnterBuildingNumber;
    data['Apartment/Building/Block'] = this.apartmentBuildingBlock;
    data['Please_enter_Apartment/Building/Block'] =
        this.pleaseEnterApartmentBuildingBlock;
    data['Floor'] = this.floor;
    data['Location_Type'] = this.locationType;
    data['Work'] = this.work;
    data['Home'] = this.home;
    data['My_Addresses'] = this.myAddresses;
    data['Cart'] = this.cart;
    data['Change'] = this.change;
    data['Your_orders'] = this.yourOrders;
    data['items'] = this.items;
    data['Contactless_Delivery'] = this.contactlessDelivery;
    data['Select_Payment_Method'] = this.selectPaymentMethod;
    data['Add_new_Card'] = this.addNewCard;
    data['Cash_on_Delivery'] = this.cashOnDelivery;
    data['Apply_Coupon'] = this.applyCoupon;
    data['Apply'] = this.apply;
    data['Order_Summary'] = this.orderSummary;
    data['Cart_Total'] = this.cartTotal;
    data['Delivery'] = this.delivery;
    data['Bag_Fee'] = this.bagFee;
    data['Grand_Total'] = this.grandTotal;
    data['Inclusive_of_all_taxes'] = this.inclusiveOfAllTaxes;
    data['Total_amount'] = this.totalAmount;
    data['Place_order'] = this.placeOrder;
    data['Delivery_Mode'] = this.deliveryMode;
    data['Home_Delivery'] = this.homeDelivery;
    data['Store_Pickup'] = this.storePickup;
    data['Search_Location'] = this.searchLocation;
    data['Confirm_Location'] = this.confirmLocation;
    data['Search'] = this.search;
    data['Express_delivery'] = this.expressDelivery;
    data['Scheduled_delivery'] = this.scheduledDelivery;
    data['Flayer'] = this.flayer;
    data['Filter'] = this.filter;
    data['Sort'] = this.sort;
    data['Search_Orders'] = this.searchOrders;
    data['Orders'] = this.orders;
    data['Delivered'] = this.delivered;
    data['Cancelled'] = this.cancelled;
    data['Return'] = this.returns;
    data['Cancel_Order'] = this.cancelOrder;
    data['Track_Your_Order'] = this.trackYourOrder;
    data['Track_Order'] = this.trackOrder;
    data['Change_time'] = this.changeTime;
    data['Total_Amount'] = this.totalAmount;
    data['Order_placed'] = this.orderPlaced;
    data['Item_Processed'] = this.itemProcessed;
    data['Bagged_from_Shop_at_2:45_Pm'] = this.baggedFromShopAt245Pm;
    data['Delivering'] = this.delivering;
    data['Your_delivery_is_on_the_way'] = this.yourDeliveryIsOnTheWay;
    data['Item_Delivered'] = this.itemDelivered;
    data['Expected_at_3:00_Pm_Today'] = this.expectedAt300PmToday;
    data['Explore'] = this.explore;
    data['Offers'] = this.offers;
    data['Account'] = this.account;
    data['Chicken'] = this.chicken;
    data['oil'] = this.oil;
    data['soap'] = this.soap;
    data['Fish'] = this.fish;
    data['sandwitch'] = this.sandwitch;
    data['Categories'] = this.categories;
    data['Change_Password'] = this.changePassword;
    data['Enter_Current_Password'] = this.enterCurrentPassword;
    data['Enter_New_Password'] = this.enterNewPassword;
    data['The_password_must_be_between_6_to_20'] =
        this.thePasswordMustBeBetween6To20;
    data['characters_and_must_contain_at_least'] =
        this.charactersAndMustContainAtLeast;
    data['Confirm_Password'] = this.confirmPassword;
    data['Reset'] = this.reset;
    data['Filters'] = this.filters;
    data['Product_Type'] = this.productType;
    data['Category'] = this.category;
    data['Brand'] = this.brand;
    data['Price'] = this.price;
    data['Choose_price_Range'] = this.choosePriceRange;
    data['Min'] = this.min;
    data['Max'] = this.max;
    data['Clear'] = this.clear;
    data['Skip'] = this.skip;
    data['Enter_Mobile_number_or_Email'] = this.enterMobileNumberOrEmail;
    data['Please_enter_Mobile_number_or_Email'] =
        this.pleaseEnterMobileNumberOrEmail;
    data['Please_Enter_Mobile_number_or_Email'] =
        this.pleaseEnterMobileNumberOrEmail;
    data['Proceed'] = this.proceed;
    data['My_Profile'] = this.myProfile;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Mobile'] = this.mobile;
    data['Save_and_Update'] = this.saveAndUpdate;
    data['Delete_Account'] = this.deleteAccount;
    data['Search_notification'] = this.searchNotification;
    data['Order_Placed_Successfully'] = this.orderPlacedSuccessfully;
    data['Continue_shopping'] = this.continueShopping;
    data['Track_order'] = this.trackOrder;
    data['Overview'] = this.overview;
    data['Details'] = this.details;
    data['Add_to_Cart'] = this.addToCart;
    data['Enter_Your_Name'] = this.enterYourName;
    data['Please_Enter_Your_Name'] = this.pleaseEnterYourName;
    data['Enter_Mobile_number'] = this.enterMobileNumber;
    data['Please_enter_Mobile_number'] = this.pleaseEnterMobileNumber;
    data['Enter_Mobile_or_Email'] = this.enterMobileOrEmail;
    data['Please_enter_Mobile_or_Email'] = this.pleaseEnterMobileOrEmail;
    data['Please_enter_your_name'] = this.pleaseEnterYourName;
    data['Please_enter_your_mobile_number'] = this.pleaseEnterYourMobileNumber;
    data['Please_enter_your_email'] = this.pleaseEnterYourEmail;
    data['Sign_Up'] = this.signUp;
    data['Get_your_groceries_delivered_to_your_home'] =
        this.getYourGroceriesDeliveredToYourHome;
    data['The_best_delivery_app_in_town_for_delivering_your_daily_fresh_groceries'] =
        this.theBestDeliveryAppInTownForDeliveringYourDailyFreshGroceries;
    data['Verification_Code'] = this.verificationCode;
    data['An_4_digit_code_has_been_sent_to_your_phone_number'] =
        this.an4DigitCodeHasBeenSentToYourPhoneNumber;
    data['Resend_OTP'] = this.resendOTP;
    data['Submit'] = this.submit;
    data['Bad_Request'] = this.badRequest;
    data['Unable_to_process'] = this.unableToProcess;
    data['Api_not_responded_in_time'] = this.apiNotRespondedInTime;
    data['UnAuthorized_request'] = this.unAuthorizedRequest;
    data['Error'] = this.error;
    data['OK'] = this.oK;
    data['Edit'] = this.edit;
    data['Set_as_default'] = this.setAsDefault;
    data['Delete'] = this.delete;
    data['See_All'] = this.seeAll;
    data['Mid-week_deals_to_delight_you'] = this.midWeekDealsToDelightYou;
    data['Out_for_delivery'] = this.outForDelivery;
    data['Arriving_in'] = this.arrivingIn;
    data['days'] = this.days;
    data['Amount:'] = this.amount;
    data['Best_seller'] = this.bestSeller;
    data['Add'] = this.add;
    data['Last_3months'] = this.last3months;
    data['Sort_by'] = this.sortBy;
    data['Relevance'] = this.relevance;
    data['Newest'] = this.newest;
    data['Discount'] = this.discount;
    return data;
  }
}
