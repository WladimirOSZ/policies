// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:front/graphql_service.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:front/models/policy.dart';
import 'package:front/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'src/sign_in_button.dart';

const List<String> scopes = <String>[
  'email',
];

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: scopes,
);

void main() {
  runApp(
    MaterialApp(
      title: 'Google Sign In',
      home: const PoliciesList(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3684A7),
          primary: const Color(0xFF3684A7),
          secondary: const Color.fromRGBO(54, 132, 167, 0.25),
        ),
      ),
    ),
  );
}

class SignInDemo extends StatefulWidget {
  const SignInDemo({super.key});

  @override
  State createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;

  @override
  void initState() {
    GraphQLService graphQLService = GraphQLService();
    graphQLService.getPolicies();
    super.initState();

    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      setState(() {
        print('google sign in changed!!!!!!!!!!!!!!');

        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      if (_currentUser != null) {
        User user = User(
          name: _currentUser!.displayName!,
          email: _currentUser!.email,
          picture: _currentUser!.photoUrl!,
        );

        print('user!!!!!!!!!!!!!!');
        print(user);
      }

      if (isAuthorized) {}
    });

    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized = await _googleSignIn.requestScopes(scopes);
    setState(() {
      _isAuthorized = isAuthorized;
    });
    if (isAuthorized) {}
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    print(user);
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          if (_isAuthorized) ...<Widget>[
            ElevatedButton(
              child: const Text('REFRESH'),
              onPressed: () => {},
            ),
          ],
          if (!_isAuthorized) ...<Widget>[
            // The user has NOT Authorized all required scopes.
            // (Mobile users may never see this button!)
            const Text('Additional permissions needed to read your contacts.'),
            ElevatedButton(
              onPressed: _handleAuthorizeScopes,
              child: const Text('REQUEST PERMISSIONS'),
            ),
          ],
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          buildSignInButton(
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sign In'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      ),
    );
  }
}

class PoliciesList extends StatefulWidget {
  const PoliciesList({super.key});

  @override
  State<PoliciesList> createState() => _PoliciesListState();
}

class _PoliciesListState extends State<PoliciesList> {
  late Future<List<Policy>> policies;
  @override
  void initState() {
    super.initState();

    GraphQLService graphQLService = GraphQLService();

    policies = graphQLService.getPolicies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Policy>>(
          future: policies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            } else {
              List<Policy> exams = snapshot.data!;
              return Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: exams.length,
                  itemBuilder: (context, index) {
                    final exam = exams[index];

                    return PolicyCard(policy: exam);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class PolicyCard extends StatelessWidget {
  const PolicyCard({
    super.key,
    required this.policy,
  });

  final Policy policy;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        Column(
          children: [
            Text(policy.insuredName),
            Text(policy.vehicleBrand),
            Text(policy.vehicleYear),
          ],
        ),
      ],
    ));
  }
}
