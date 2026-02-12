import 'package:internshiptaskone/screens/pending_request_screen.dart';
import '../utils/app_imports.dart';
import 'connections_screen.dart';

class RequestsMainScreen extends StatelessWidget {
  const RequestsMainScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppConstants.backgroundColor,

        appBar: AppBar(
          title: const Text("Requests"),
          automaticallyImplyLeading: false,
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Connections"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            PendingRequestScreen(),
            ConnectionsScreen(),
          ],
        ),
      ),
    );
  }
}
