import 'package:dietapp_a/v_chat/models/message_model.dart';

class FcmModel {
  String fcmBody;
  bool isRecieverOnChat;
  String recieverToken;
  String recieverName;

  String? recieverProfileImgUrl;
  String? chatImg;

  FcmModel({
    this.isRecieverOnChat = false,
    required this.fcmBody,
    required this.recieverToken,
    required this.recieverName,
    required this.recieverProfileImgUrl,
    required this.chatImg,
  });
  Map<String, dynamic> toMap() {
    return {
      fcmos.isRecieverOnChat: isRecieverOnChat,
      fcmos.fcmBody: fcmBody,
      fcmos.recieverToken: recieverToken,
      fcmos.recieverName: recieverName,
      fcmos.recieverProfileImgUrl: recieverProfileImgUrl,
      fcmos.chatImg: chatImg,
    };
  }

  factory FcmModel.fromMap(Map functionMap) {
    return FcmModel(
      isRecieverOnChat: functionMap[fcmos.isRecieverOnChat] ?? false,
      fcmBody: functionMap[fcmos.fcmBody] ?? "New message",
      recieverToken: functionMap[fcmos.recieverToken] ?? "",
      recieverName: functionMap[fcmos.recieverName] ?? "",
      recieverProfileImgUrl: functionMap[fcmos.recieverProfileImgUrl] ?? "",
      chatImg: functionMap[fcmos.chatImg],
    );
  }
}

FcmObjects fcmos = FcmObjects();

class FcmObjects {
  final fcmModel = "fcmModel";
  final isRecieverOnChat = "isRecieverOnChat";
  final recieverToken = "recieverToken";
  final recieverName = "recieverName";
  final recieverProfileImgUrl = "recieverProfileImgUrl";
  final chatImg = "chatImg";
  final fcmBody = "fcmBody";

  String getFcmBody(
      {required String? chatType,
      required String? chatString,
      required String? fileName}) {
    String fcmHeadline = "";

    if (chatType == chatTS.singleYoutube) {
      fcmHeadline = "\u{25b6}  " + (fileName ?? 'Youtube video');
    } else if (chatType == chatTS.singleWebFood) {
      fcmHeadline = "\u{1F310}  " + (fileName ?? 'Web');
    } else if (chatType == chatTS.singleFolder) {
      fcmHeadline = "\u{1F4C1}  " + (fileName ?? 'Foods folder');
    } else if (chatType == chatTS.singleCustomFood) {
      fcmHeadline = "\u{1F4DD}  " + (fileName ?? 'Custom food');
    } else if (chatType == chatTS.multiFoodCollection) {
      fcmHeadline = "\u{1F352}  Food list";
    } else if (chatType == chatTS.dietPlansBeta) {
      fcmHeadline = "\u{1F4CB}  " + (fileName ?? 'Diet plan');
    } else if (chatType == chatTS.multiWeek) {
      fcmHeadline = "\u{1F5D3}  " + (fileName ?? 'Weekly plan');
    } else if (chatType == chatTS.multiDay) {
      fcmHeadline = "\u{1F4C5}  " + (fileName ?? 'Day plan');
    } else if (chatType == chatTS.multiTiming) {
      fcmHeadline = "\u{1F553}  " + (fileName ?? 'Timing plan');
    } else if (chatType == chatTS.viewRequest) {
      fcmHeadline = "\u{1F510}  " + ("Request");
    }

    if (fcmHeadline.isEmpty) {
      return chatString ?? "New message";
    } else if (chatString?.isEmpty ?? true) {
      return fcmHeadline;
    } else {
      return fcmHeadline + "\n" + chatString!;
    }
  }
}
