import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/chat/controllers/chat_controller.dart';
import 'package:sixam_mart/features/chat/enums/user_type_enum.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/notification/domain/models/notification_body_model.dart';
import 'package:sixam_mart/features/chat/domain/models/conversation_model.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/not_logged_in_screen.dart';
import 'package:sixam_mart/common/widgets/paginated_list_view.dart';
import 'package:sixam_mart/common/widgets/web_search_field.dart';
import 'package:sixam_mart/features/chat/widgets/chatting_shimmer.dart';
import 'package:sixam_mart/features/chat/widgets/message_bubble_widget.dart';
import 'package:sixam_mart/features/chat/widgets/web_conversation_list_view_widget.dart';


class WebChatViewWidget extends StatefulWidget {
  final ScrollController scrollController;
  final ConversationsModel? conversation;
  final ChatController chatController;
  final TextEditingController searchController;
  final Function initCall;

  const WebChatViewWidget({
    super.key, required this.scrollController, required this.conversation, required this.chatController, required this.searchController, required this.initCall,
  });

  @override
  State<WebChatViewWidget> createState() => _WebChatViewWidgetState();
}

class _WebChatViewWidgetState extends State<WebChatViewWidget> with TickerProviderStateMixin{
  final TextEditingController _inputMessageController = TextEditingController();
  final ScrollController _scrollControllerChat = ScrollController();
  final ScrollController _scrollController1 = ScrollController();
  late TabController _tabController;
  User? user;
  bool isHovered = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 64,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.10),
          child: Center(child: Text('live_chat'.tr, style: robotoMedium)),
        ),
        const SizedBox(height: 40),

        Expanded(child: SingleChildScrollView(
          controller: widget.scrollController,
          physics: isHovered ? const NeverScrollableScrollPhysics()  : const BouncingScrollPhysics(),
          child: AuthHelper.isLoggedIn() ? FooterView(child: SizedBox(
            width: Dimensions.webMaxWidth,
            child:  Row(
              children: [

                /// Conversation List
                Container(
                  width: 415,
                  height: 570,
                  //padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
                  decoration: ShapeDecoration(
                    color: Theme.of(context).cardColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: .04)),
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: MouseRegion(
                    onEnter: (event) => onEntered(true),
                    onExit: (event) => onEntered(false),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
                          child: Text('messages'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        ),

                        /// Search
                        (AuthHelper.isLoggedIn() && widget.conversation != null && widget.conversation?.conversations != null
                        && widget.chatController.conversationModel!.conversations!.isNotEmpty) ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
                          child: Center(child: SizedBox(width: Dimensions.webMaxWidth, child: WebSearchField(
                            prefixWidget: widget.chatController.searchConversationModel != null ? null: Padding(
                              padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeSmall),
                              child: Image.asset(Images.searchIcon, height: 18, width: 18,),
                            ),
                            controller: widget.searchController,
                            hint: 'search_'.tr,
                            suffixIcon: widget.chatController.searchConversationModel != null ? Icons.close : null,

                            onSubmit: (String text) {
                              if(widget.searchController.text.trim().isNotEmpty) {
                                widget.chatController.searchConversation(widget.searchController.text.trim());
                              }else {
                                showCustomSnackBar('write_something'.tr);
                              }
                            },
                            iconPressed: () {
                              if(widget.chatController.searchConversationModel != null) {
                                widget.searchController.text = '';
                                widget.chatController.removeSearchMode();
                              }else {
                                if(widget.searchController.text.trim().isNotEmpty) {
                                  widget.chatController.searchConversation(widget.searchController.text.trim());
                                }else {
                                  showCustomSnackBar('write_something'.tr);
                                }
                              }
                            },
                          ))),
                        ) : const SizedBox(),

                      Expanded(
                        child: Column(
                          children: [
                            /// admin conversationList

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                              child: InkWell(
                                onTap: () {
                                  Get.find<ChatController>().getMessages(1, NotificationBodyModel(
                                    type: 'admin',
                                    notificationType: NotificationType.message,
                                    adminId: 0,
                                    restaurantId: null,
                                    deliverymanId: null,
                                  ), user, 0, firstLoad: true);
                                  if(Get.find<ProfileController>().userInfoModel == null || Get.find<ProfileController>().userInfoModel!.userInfo == null) {
                                    Get.find<ProfileController>().getUserInfo();
                                  }
                                  widget.chatController.setNotificationBody(
                                    NotificationBodyModel(
                                      type: 'admin',
                                      notificationType: NotificationType.message,
                                      adminId: 0,
                                      restaurantId: null,
                                      deliverymanId: null,
                                      conversationId: 0,
                                      image: '${Get.find<SplashController>().configModel!.logoFullUrl}',
                                      name: '${Get.find<SplashController>().configModel!.businessName}',
                                      receiverType: 'admin',
                                    ),
                                  );

                                  widget.chatController.setSelectedIndex(-1);
                                },
                                child: Builder(
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                        color: widget.chatController.selectedIndex == -1 ? Theme.of(context).primaryColor.withValues(alpha: 0.10) : Theme.of(context).cardColor,
                                      ),
                                      margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                          child: Row(children: [
                                            ClipOval(child: CustomImage(
                                              height: 50, width: 50,
                                              image: '${Get.find<SplashController>().configModel!.logoFullUrl}',
                                            )),
                                            const SizedBox(width: Dimensions.paddingSizeSmall),

                                            Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [

                                              Text(
                                                '${Get.find<SplashController>().configModel!.businessName}', style: robotoMedium,
                                              ),
                                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                                            ])),
                                          ]),
                                        ),
                                      ]),
                                    );
                                  }
                                ),
                              ),
                            ),
                            Divider(color: Theme.of(context).disabledColor.withValues(alpha: .5)),

                            /// TabBar
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TabBar(
                                  controller: _tabController,
                                  isScrollable: true,
                                  indicatorColor: Theme.of(context).primaryColor,
                                  labelColor: Theme.of(context).primaryColor,
                                  unselectedLabelColor: Theme.of(context).disabledColor,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                                  unselectedLabelStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                                  tabAlignment: TabAlignment.start,
                                  tabs: [
                                    Tab(text: 'store'.tr),
                                    Tab(text: 'delivery_man'.tr),
                                  ],
                                  onTap: (int index){
                                    if(index == 0){
                                      widget.chatController.setType('vendor1');
                                      widget.chatController.setTabSelect();
                                    } else {
                                      widget.chatController.setType('delivery_man');
                                      widget.chatController.setTabSelect();
                                    }
                                  },
                                ),
                              ),
                            ),


                            /// TabBarView
                            Expanded(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: TabBarView(
                                  controller: _tabController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [

                                    /// Store
                                    WebConversationListViewWidget(
                                      chatController: widget.chatController,
                                      conversation: widget.conversation,
                                      scrollController: _scrollController1,
                                      type: 'vendor1',
                                    ),

                                    /// Delivery Man
                                    WebConversationListViewWidget(
                                      chatController: widget.chatController,
                                      conversation: widget.conversation,
                                      scrollController: _scrollController1,
                                      type: 'delivery_man',
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],

                        ),
                      ),

                      ],
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeLarge),

                /// ChatView
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 569,
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    decoration: ShapeDecoration(
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: .04)),
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(children: [

                      /// Header
                     if(widget.chatController.notificationBody != null) Container(
                       padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
                        child: Column(
                          children: [

                            Row(children: [

                              ClipOval(child: CustomImage(
                                height: 50, width: 50,
                                image: widget.chatController.notificationBody!.image!,
                              )),
                              const SizedBox(width: Dimensions.paddingSizeSmall),

                              Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [

                                Row(
                                  children: [

                                    Flexible(
                                      child: Text(
                                        widget.chatController.notificationBody!.name!, style: robotoMedium, maxLines: 1, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    // Text('(${widget.chatController.notificationBody!.receiverType!.tr})', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor)),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                                Text(
                                  widget.chatController.notificationBody!.receiverType!.tr,
                                  style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                                ),
                              ])),
                            ]),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                            Divider(color: Theme.of(context).disabledColor.withValues(alpha: .5)),

                          ],
                        ),
                      ),

                      /// Chat
                      Expanded(child: widget.chatController.notificationBody != null ? widget.chatController.messageModel != null ? widget.chatController.messageModel!.messages!.isNotEmpty ? SingleChildScrollView(
                        controller: _scrollControllerChat,
                        reverse: true,
                        child: PaginatedListView(
                          scrollController: _scrollControllerChat,
                          reverse: true,
                          totalSize: widget.chatController.messageModel?.totalSize,
                          offset: widget.chatController.messageModel?.offset,
                          onPaginate: (int? offset) async => await widget.chatController.getMessages(
                            offset!, NotificationBodyModel(
                            type: widget.chatController.notificationBody!.type,
                            notificationType: NotificationType.message,
                            adminId: widget.chatController.notificationBody!.adminId,
                            restaurantId: widget.chatController.notificationBody!.restaurantId,
                            deliverymanId: widget.chatController.notificationBody!.deliverymanId,
                          ), user, widget.chatController.notificationBody!.conversationId),
                          itemView: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: widget.chatController.messageModel!.messages!.length,
                            itemBuilder: (context, index) {
                              return MessageBubbleWidget(
                                message: widget.chatController.messageModel!.messages![index],
                                user: widget.chatController.messageModel!.conversation!.receiver,
                                userType: widget.chatController.notificationBody!.adminId != null ? UserType.admin.name
                                    : widget.chatController.notificationBody!.deliverymanId != null ? UserType.delivery_man.name : UserType.vendor.name,
                              );
                            },
                          ),
                        ),
                      ) : Center(child: Text('no_message_found'.tr)) : const ChattingShimmer() :  Center(child: Text('no_conversation_selected'.tr))),


                      /// Message Input
                      if(widget.chatController.notificationBody != null) Column(children: [

                        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [

                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
                                border: Border.all(color: Theme.of(context).disabledColor.withValues(alpha: 0.6)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                                child: Column(
                                  children: [

                                    GetBuilder<ChatController>(builder: (chatController) {
                                      return chatController.chatImage.isNotEmpty ? SizedBox(height: 100,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: chatController.chatImage.length,
                                          itemBuilder: (BuildContext context, index){
                                            return  chatController.chatImage.isNotEmpty ? Padding(
                                              padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                                              child: Stack(clipBehavior: Clip.none, children: [

                                                Container(
                                                  width: 80, height: 100,
                                                  decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                                                  child: ClipRRect(
                                                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                                                    child: Image.memory(
                                                      chatController.chatRawImage[index], width: 80, height: 100, fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),

                                                Positioned(
                                                  top: -5, right: -5,
                                                  child: InkWell(
                                                    onTap : () => chatController.removeImage(index, _inputMessageController.text.trim()),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        color: Color(0xff9EADC1),
                                                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.paddingSizeDefault)),
                                                      ),
                                                      child: const Padding(
                                                        padding: EdgeInsets.all(4.0),
                                                        child: Icon(Icons.clear, color: Colors.white, size: 15),
                                                      ),
                                                    ),
                                                  ),
                                                )],
                                              ),
                                            ) : const SizedBox();
                                          }),
                                      ) : const SizedBox();
                                    }),

                                    TextField(
                                      inputFormatters: [LengthLimitingTextInputFormatter(Dimensions.messageInputLength)],
                                      controller: _inputMessageController,
                                      textCapitalization: TextCapitalization.sentences,
                                      style: robotoRegular,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'start_a_new_message'.tr,
                                        hintStyle: robotoRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),
                                      ),
                                      onSubmitted: (String newText) {
                                        if(newText.trim().isNotEmpty && !Get.find<ChatController>().isSendButtonActive) {
                                          Get.find<ChatController>().toggleSendButtonActivity();
                                        }else if(newText.isEmpty && Get.find<ChatController>().isSendButtonActive) {
                                          Get.find<ChatController>().toggleSendButtonActivity();
                                        }
                                      },
                                      onChanged: (String newText) {
                                        if(newText.trim().isNotEmpty && !Get.find<ChatController>().isSendButtonActive) {
                                          Get.find<ChatController>().toggleSendButtonActivity();
                                        }else if(newText.isEmpty && Get.find<ChatController>().isSendButtonActive) {
                                          Get.find<ChatController>().toggleSendButtonActivity();
                                        }
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeDefault),

                          InkWell(
                            onTap: () async {
                              Get.find<ChatController>().pickImage(false);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall + 1),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
                                border: Border.all(color: Theme.of(context).disabledColor.withValues(alpha: 0.6)),
                              ),
                              child: Image.asset(Images.image, width: 25, height: 25, color: widget.chatController.chatImage.isNotEmpty ? Theme.of(context).primaryColor : Theme.of(context).hintColor,),
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeDefault),

                          GetBuilder<ChatController>(builder: (chatController) {
                            return InkWell(
                              onTap: () async {
                                if(chatController.isSendButtonActive) {
                                  await chatController.sendMessage(
                                    message: _inputMessageController.text, notificationBody: chatController.notificationBody,
                                    conversationID: chatController.notificationBody!.conversationId, index: chatController.notificationBody!.index,
                                  );
                                  _inputMessageController.clear();
                                  await Get.find<ChatController>().getConversationList(1, type: chatController.type!);
                                }else {
                                  showCustomSnackBar('write_something'.tr);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall + 1),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)),
                                  border: Border.all(color: Theme.of(context).disabledColor.withValues(alpha: 0.6)),
                                ),
                                child: chatController.isLoading ? const SizedBox(height: 25, width: 25, child: CircularProgressIndicator()) : Image.asset(
                                  Images.sendIconWeb, width: 25, height: 25,
                                  color: chatController.isSendButtonActive ? Theme.of(context).primaryColor : Theme.of(context).hintColor,
                                ),
                              ),
                            );
                          }),

                        ]),
                      ]),


                    ]),
                  ),
                ),

              ],
            ),

          )) :  NotLoggedInScreen(callBack: (value){
            widget.initCall();
            setState(() {});
          }),
        ))
      ],
    );
  }
}
