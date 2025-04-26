import 'dart:io';

import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:college_ecommerce_app/constants/keys.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class botsPage extends StatefulWidget {
  const botsPage({super.key});

  @override
  State<botsPage> createState() => _botsPageState();
}

class _botsPageState extends State<botsPage> {
  final _currentUser = ChatUser(id: '1', firstName: "John Doe");
  final _chatUser = ChatUser(id: '2', firstName: "Chat", lastName: "Bot");

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];
  int _currentKeyIndex = 0;

  @override
  void initState() {
    super.initState();
    OpenAI.baseUrl = 'https://openrouter.ai/api';
    OpenAI.apiKey = OPENAI_API_KEY[0];
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    _currentUser.id = user.id;
    _currentUser.firstName = user.name;

    return Scaffold(
      bottomNavigationBar: mainBottomBar(),
      appBar: botsAppBar(),
      body: DashChat(
        currentUser: _currentUser,
        typingUsers: _typingUsers,
        inputOptions: InputOptions(
          cursorStyle: const CursorStyle(color: AppColors.textSecondary),
          sendButtonBuilder:
              (send) => IconButton(
                onPressed: send,
                icon: Icon(Icons.send, color: AppColors.primary),
              ),
        ),
        messageOptions: const MessageOptions(
          currentUserContainerColor: AppColors.primary,
          textColor: AppColors.textPrimary,
          containerColor: AppColors.textSecondary,
          currentUserTextColor: AppColors.textPrimary,
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_chatUser);
    });

    final messageHistory =
        _messages.reversed.map((msg) {
          return OpenAIChatCompletionChoiceMessageModel(
            role:
                msg.user == _currentUser
                    ? OpenAIChatMessageRole.user
                    : OpenAIChatMessageRole.assistant,
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(msg.text),
            ],
          );
        }).toList();

    try {
      final chatCompletion = await OpenAI.instance.chat.create(
        model: 'deepseek/deepseek-chat-v3-0324:free',
        messages: messageHistory,
        maxTokens: 200,
      );

      setState(() {
        for (var choice in chatCompletion.choices) {
          String? content;
          if (choice.message.content is List) {
            content =
                (choice.message.content as List)
                    .where((item) => item.type == 'text')
                    .map((item) => item.text ?? '')
                    .join();
          } else if (choice.message.content is String) {
            content = choice.message.content as String;
          }

          if (content != null && content.isNotEmpty) {
            _messages.insert(
              0,
              ChatMessage(
                user: _chatUser,
                createdAt: DateTime.now(),
                text: content,
              ),
            );
          }
          setState(() {
            _typingUsers.remove(_chatUser);
          });
        }
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        if (_currentKeyIndex < OPENAI_API_KEY.length) {
          _currentKeyIndex += 1;
          OpenAI.apiKey = OPENAI_API_KEY[_currentKeyIndex - 1];
          _messages.removeLast();
          getChatResponse(m);
        }
        if (_currentKeyIndex == OPENAI_API_KEY.length) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: $e")));
          _messages.insert(
            0,
            ChatMessage(
              user: _chatUser,
              createdAt: DateTime.now(),
              text: 'Sorry, something went wrong. Please try again.',
            ),
          );
        }

        _typingUsers.remove(_chatUser);
      });
    }
  }
}

class mainBottomBar extends StatelessWidget {
  const mainBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.edges),
        color: AppColors.background,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home', arguments: user);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Light_Home.svg',
                  color: AppColors.secondary,
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,

                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(
                context,
                '/wishlist',
                arguments: [user, true],
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/Light_Heart.svg',
                  width: 32.0,
                  height: 32.0,
                ),
                Text(
                  'Wishlist',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/sell',
                    arguments: user,
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/Light_Container.svg',
                  color: AppColors.secondary,
                  width: 32.0,
                  height: 32.0,
                ),
              ),
              Text(
                'Sell',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/Light_Bot.svg',
                color: AppColors.primary,
                width: 32.0,
                height: 32.0,
              ),
              Text(
                'Bots',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

AppBar botsAppBar() {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Bots',

          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}
