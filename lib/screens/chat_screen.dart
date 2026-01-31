import 'package:internshiptaskone/utils/app_imports.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({super.key});

   final TextEditingController _messageController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstants.backgroundColor,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 620,left: 5,right: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message here',
                      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send_outlined,
                    color: AppConstants.textSecondary,
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
