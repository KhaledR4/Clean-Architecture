import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/core/controllers/home_controller.dart';
import 'package:fitness/core/controllers/user_controller.dart';
import 'package:fitness/core/data/datasources/firebase_chat_request.dart';
import 'package:fitness/core/data/repositories/firebase_chat_repository.dart';
import 'package:fitness/core/domain/repositories/firebase_chat_repo.dart';
import 'package:fitness/core/domain/repositories/firebase_user_repo.dart';
import 'package:fitness/features/chatSection/domain/usecases/chat_stream_usecase.dart';
import 'package:fitness/features/chatSection/domain/usecases/create_chat_usercase.dart';
import 'package:fitness/features/chatSection/domain/usecases/get_chat_usecase.dart';
import 'package:fitness/features/chatSection/domain/usecases/new_chat_stream_usecase.dart';
import 'package:fitness/features/chatSection/domain/usecases/search_users_usecase.dart';
import 'package:fitness/features/chatSection/presentation/controllers/chat_page_controller.dart';
import 'package:fitness/features/loading/data/datasources/local_data.dart';
import 'package:fitness/features/loading/data/datasources/user_request.dart';
import 'package:fitness/features/loading/data/repositories/user_repository.dart';
import 'package:fitness/features/loading/domain/repositories/user_repository.dart';
import 'package:fitness/features/loading/domain/usecases/signin_local_token.dart';
import 'package:fitness/features/loading/presentation/controllers/loading_controller.dart';
import 'package:fitness/features/login/data/datasources/login_request.dart';
import 'package:fitness/features/login/data/repositories/user_repository.dart';
import 'package:fitness/features/login/domain/repositories/user_repository.dart';
import 'package:fitness/features/login/domain/usecases/login_usecase.dart';
import 'package:fitness/features/login/presentation/controllers/login_controller.dart';
import 'package:fitness/core/data/datasources/firebase_user_request.dart';
import 'package:fitness/features/messagesSection/data/datasources/firebase_message.dart';
import 'package:fitness/features/messagesSection/data/datasources/local_message.dart';
import 'package:fitness/features/messagesSection/data/repositories/message_repository.dart';
import 'package:fitness/features/messagesSection/domain/repositories/message_repsoitory.dart';
import 'package:fitness/features/messagesSection/domain/usecases/make_messages_read_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/message_info_stream_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/message_stream_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/read_messages_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/read_unread_messages_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/save_messages_locally_usecase.dart';
import 'package:fitness/features/messagesSection/domain/usecases/send_message_usecase.dart';
import 'package:fitness/features/messagesSection/presentation/controllers/messages_controller.dart';
import 'package:fitness/features/signup/data/datasources/local_save_user.dart';
import 'package:fitness/features/signup/data/datasources/signup_request.dart';
import 'package:fitness/core/data/repositories/firebase_user_repository.dart';
import 'package:fitness/features/signup/data/repositories/local_signup.dart';
import 'package:fitness/features/signup/data/repositories/signup.dart';
import 'package:fitness/features/signup/domain/repositories/singup.dart';
import 'package:fitness/features/signup/domain/usecases/signup_usecase.dart';
import 'package:fitness/features/signup/presentation/controllers/page_controller.dart';
import 'package:fitness/features/signup/presentation/controllers/signup_controller.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async{
  // Controller
  sl.registerLazySingleton(()=> HomePageController());
  sl.registerLazySingleton(() => SignupController(signupCase: sl()));
  sl.registerLazySingleton(()=> LoadingController(signinCase: sl()));
  sl.registerLazySingleton(() => LoginController(loginCase: sl()));
  sl.registerLazySingleton(() => UserController());
  sl.registerLazySingleton(() => SignupPageController());
  sl.registerLazySingleton(() => ChatPageController(chatUseCase: sl(), searchUserCase: sl(), newChatStream: sl(), getNewChatCase: sl(), createNewChatCase: sl()));
  sl.registerLazySingleton(() => MessagesController(
    sendMessageCase: sl(), 
    readMessageCase: sl(), 
    streamMessages: sl(), 
    streamMessageInfo: sl(),
    unReadMessageCase: sl(),
    makeReadMessageCase: sl(),
    saveMessageLocallyCase: sl(),
    ));

  // useCase 
  sl.registerLazySingleton(() => SignupCase(repository: sl(), firebaseAuthService: sl(), firebaseRepository: sl(), localSaveUserRepository: sl()));
  sl.registerLazySingleton(() => SigninCase(signinUserRepository: sl()));
  sl.registerLazySingleton(() => LoginCase(loginUserRepository: sl(), firebaseAuthService: sl(), firebaseUserRepositoy: sl(), chatRepository: sl()));
  sl.registerLazySingleton<ChatStreamCase>(() => ChatStreamCaseImp(chatRepository: sl()));
  sl.registerLazySingleton<SendMessageCase>(() => SendMessageCaseImp(messageRepository: sl()));
  sl.registerLazySingleton<ReadMessageCase>(() => ReadMessageCaseImp(messageRepository: sl()));
  sl.registerLazySingleton<StreamMessageCase>(() => StreamMessageCaseImp(messageRepository: sl()));
  sl.registerLazySingleton<StreamMessageInfoCase>(() => StreamMessageInfoCaseImp(messageRepository: sl()));
  sl.registerLazySingleton<UnReadMessageCase>(() => UnReadMessageCaseImp(messageRepository: sl()));
  sl.registerLazySingleton<MakeReadMessageCase>(() => MakeReadMessageCaseImp(messageRepository: sl()));
  sl.registerLazySingleton<SaveMessageLocallyCase>(() => SaveMessageLocallyCaseImp(messageRepository: sl()));
  sl.registerLazySingleton<SearchUserCase>(() => SearchUserCaseImp(userRepository: sl()));
  sl.registerLazySingleton<StreamNewChatCase>(() => StreamNewChatCaseImp(chatRepository: sl()));
  sl.registerLazySingleton<GetNewChatCase>(() => GetNewChatCaseImp(chatRepository: sl()));
  sl.registerLazySingleton<CreateNewChatCase>(() => CreateNewChatCaseImp(chatRepository: sl()));

  // repository
   sl.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImp(signupDataSource: sl()));
   sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
   sl.registerLazySingleton<FirebaseUserRepository>(()=> FirebaseUserRepositoryImp(firebaseDataSource: sl()));
   sl.registerLazySingleton<LocalSaveUserRepository>(() => LocalSaveUserRepositoryImp(signupDataSource: sl()));
   sl.registerLazySingleton<SigninUserRepository>(() => SigninUserRepositoryImp(checkUserToken: sl(), localUser: sl()));
   sl.registerLazySingleton<LoginRepository>(()=> LoginRepositoryImp(loginDataSource: sl()));
   sl.registerLazySingleton<FirebaseChatRepository>(() => FirebaseChatRepositoryImp(chatRequest: sl(), userRequest: sl()));
   sl.registerLazySingleton<MessageRepository>(() => MessageRepositoryImp(messagesRequest: sl(), localMessageSource: sl()));

   // data sources
    sl.registerLazySingleton<SignUpRequestImp>(() => SignUpRequestImp());
    sl.registerLazySingleton<FirebaseSaveUserRequest>(() => FirebaseSaveUserRequestImp());
    sl.registerLazySingleton<FirebaseChatRequest>(() => FirebaseChatRequestImp(userRequest: sl()));
    sl.registerLazySingleton<LocalUser>(() => LocalUserImp());
    sl.registerLazySingleton<UserLocalSource>(() => UserLocalSourceImp());
    sl.registerLazySingleton<CheckUserToken>(() => CheckUserTokenImp());
    sl.registerLazySingleton<LoginRequest>(() => LoginRequestImp());
    sl.registerLazySingleton<FirebaseMessagesRequest>(() => FirebaseMessagesRequestImp());
    sl.registerLazySingleton<LocalMessageSource>(() => LocalMessageSourceImp());
}