import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_provider.dart';
import '../../theme/app_colors.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final _controller = TextEditingController();
  final List<Map<String, String>> _messages = []; // {'role': 'user'|'assistant', 'content': '...'}
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initial greeting
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendInitialGreeting();
    });
  }

  void _sendInitialGreeting() async {
    final user = ref.read(userProvider);
    final mode = user.value?.aiTrainerMode ?? 'friend';
    
    String greeting = "Hey friend! Ready to get moving? 🏃‍♂️";
    if (mode == 'sergeant' || mode == 'wolf') {
      greeting = "ON YOUR FEET! Status report? 📢";
    }

    setState(() {
      _messages.add({'role': 'assistant', 'content': greeting});
    });
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final user = ref.read(userProvider);
    final mode = user.value?.aiTrainerMode ?? 'friend';

    setState(() {
      _messages.add({'role': 'user', 'content': text});
      _isLoading = true;
      _controller.clear();
    });
    _scrollToBottom();

    // Simulate AI thinking
    await Future.delayed(const Duration(seconds: 1));

    String reply = _generateResponse(text, mode);

    if (mounted) {
      setState(() {
        _messages.add({'role': 'assistant', 'content': reply});
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  String _generateResponse(String input, String mode) {
    final lower = input.toLowerCase();
    final isWolf = mode == 'sergeant' || mode == 'wolf';

    if (isWolf) {
      // WOLF PACK / DRILL SERGEANT
      if (lower.contains('tired') || lower.contains('exhausted')) return "TIRED IS A MINDSET. Take 5 minutes, then give me 10 more reps! 😤";
      if (lower.contains('rest') || lower.contains('break')) return "You can rest when you're done! ...Fine. Take today off, but double effort tomorrow.";
      if (lower.contains('pain') || lower.contains('hurt')) return "Assess the damage. If it's injury, STOP. If it's soreness, GROW UP.";
      if (lower.contains('ready') || lower.contains('go')) return "THAT'S WHAT I LIKE TO HEAR! GO CRUSH IT! 🔥";
      if (lower.contains('hello') || lower.contains('hi')) return "Less talking, more lifting. What's the plan today?";
      return "I don't deal in excuses or small talk. Are we working out or what? 💪";
    } else {
      // SOCIAL CLUB / FRIEND
      if (lower.contains('tired') || lower.contains('exhausted')) return "It matches your effort! Listen to your body. Maybe just a light walk today? 🌿";
      if (lower.contains('rest') || lower.contains('break')) return "Rest is crucial for growth! Enjoy your recovery day. 🧘‍♂️";
      if (lower.contains('pain') || lower.contains('hurt')) return "Oh no! Please be careful. Don't push through bad pain. Maybe see a doctor? ❤️";
      if (lower.contains('ready') || lower.contains('go')) return "Woohoo! You got this! I'm cheering for you! 🎉";
      if (lower.contains('hello') || lower.contains('hi')) return "Hi there! Hope you're having a wonderful day! ☀️";
      return "I'm here for you! Let's make today a healthy one. 😊";
    }
  }
  
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final mode = user.value?.aiTrainerMode ?? 'friend';
    final isWolf = mode == 'sergeant' || mode == 'wolf';
    
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('AI Coach'),
            Text(
              _getModeTitle(mode),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser 
                        ? AppColors.primary 
                        : (isWolf ? Colors.red[900] : Colors.blue[800]), // Theme based on personality
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: isUser ? Radius.zero : null,
                        bottomLeft: !isUser ? Radius.zero : null,
                      ),
                    ),
                    child: Text(
                      msg['content']!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(backgroundColor: Colors.transparent),
            ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: isWolf ? 'Speak up, recruit!' : 'How are you feeling?',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  onPressed: _isLoading ? null : _sendMessage,
                  icon: const Icon(Icons.send, color: AppColors.primary),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }

  String _getModeTitle(String mode) {
    switch(mode) {
      case 'sergeant': 
      case 'wolf':
        return 'The Wolf Pack 🐺';
      default: return 'The Social Club ☕';
    }
  }
}
