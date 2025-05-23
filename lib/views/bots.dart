import 'package:college_ecommerce_app/constants/app_colors.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:college_ecommerce_app/constants/keys.dart';
import 'package:college_ecommerce_app/models/user.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

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
  String? _customApiKey;

  late stt.SpeechToText _speech;
  late FlutterTts _tts;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    OpenAI.baseUrl = 'https://openrouter.ai/api';
    OpenAI.apiKey = OPENAI_API_KEY[0];
    _speech = stt.SpeechToText();
    _tts = FlutterTts();
  }

  @override
  void dispose() {
    _speech.cancel();
    _tts.stop();
    super.dispose();
  }

  void _startListening() async {
    try {
      await _speech.cancel();

      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Speech status: $status');
          setState(() {
            _isListening = status == 'listening';
          });
        },
        onError: (error) {
          print('Speech error: $error');
          setState(() {
            _isListening = false;
          });
          if (error.errorMsg == 'error_no_match') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('No speech recognized. Please try again.'),
              ),
            );
          }
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              String text = result.recognizedWords;
              if (text.isNotEmpty) {
                ChatMessage message = ChatMessage(
                  user: _currentUser,
                  createdAt: DateTime.now(),
                  text: text,
                  customProperties: {'isVoice': true},
                );
                getChatResponse(message);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('No speech recognized. Please try again.'),
                  ),
                );
              }
            }
          },
          listenFor: Duration(seconds: 10),
        );
      } else {
        print('Speech initialization failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Speech recognition unavailable.')),
        );
      }
    } catch (e) {
      print('Exception during speech initialization: $e');
    }
  }

  void _stopListening() {
    _speech.stop();
  }

  // Show dialog to input custom API key
  void _showApiKeyDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Enter Your API Key'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Paste your OpenAI API key here',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final key = controller.text.trim();
                  if (key.isNotEmpty) {
                    setState(() {
                      _customApiKey = key;
                      OpenAI.apiKey = key;
                      _currentKeyIndex = 0;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Custom API key set successfully.'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a valid API key.')),
                    );
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    _currentUser.id = user.id;
    _currentUser.firstName = user.name;

    return Scaffold(
      bottomNavigationBar: mainBottomBar(),
      appBar: AppBar(
        leading: Icon(Icons.settings, color: Colors.transparent),

        automaticallyImplyLeading: true,
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
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.textSecondary),
            onPressed: () {
              _showApiKeyDialog();
            },
          ),
        ],
      ),
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
          leading: [
            IconButton(
              icon: Icon(
                _isListening ? Icons.mic : Icons.mic_none,
                color: AppColors.primary,
              ),
              onPressed: () {
                if (_isListening) {
                  _stopListening();
                } else {
                  _startListening();
                }
              },
            ),
          ],
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
    bool isVoiceInput = m.customProperties?['isVoice'] ?? false;

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
            if (isVoiceInput) {
              _speak(content);
            }
          }
          _typingUsers.remove(_chatUser);
        }
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        // If using custom key, don't cycle through saved keys
        if (_customApiKey != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error with custom API key: $e")),
          );
          _messages.insert(
            0,
            ChatMessage(
              user: _chatUser,
              createdAt: DateTime.now(),
              text:
                  'Sorry, something went wrong with your API key. Please check and try again.',
            ),
          );
        } else if (_currentKeyIndex < OPENAI_API_KEY.length) {
          print(_currentKeyIndex);
          print(OPENAI_API_KEY.length);
          _currentKeyIndex += 1;
          OpenAI.apiKey = OPENAI_API_KEY[_currentKeyIndex - 1];
          _messages.removeLast();
          getChatResponse(m);
        } else {
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

  void _speak(String text) async {
    await _tts.speak(text);
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
