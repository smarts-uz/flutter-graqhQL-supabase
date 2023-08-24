// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart' as dotenv;

void main() async {
  await initHiveForFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        'https://rdmythxwzdcbqhaheafv.supabase.co/graphql/v1',
        defaultHeaders: {
          'apikey':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJkbXl0aHh3emRjYnFoYWhlYWZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODg3MDk0NjgsImV4cCI6MjAwNDI4NTQ2OH0.91F6sZT_9Oz0ajk8JgA8cwV90Rw7cSp_SSDvR62qbM8'
        });
    final AuthLink authLink = AuthLink(
      getToken: () async =>
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJkbXl0aHh3emRjYnFoYWhlYWZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODg3MDk0NjgsImV4cCI6MjAwNDI4NTQ2OH0.91F6sZT_9Oz0ajk8JgA8cwV90Rw7cSp_SSDvR62qbM8',
    );
    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'GraphQL Flutter Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Query(
        options: QueryOptions(
          document: gql('''
            query UserCollection {
              usersCollection {
                edges{
                  node{
                    id
                    name
                    email
                  }
                }
              }
            }
          '''),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            // print(result.exception.toString());
            return Center(
              child: Text('Error: ${result.exception.toString()}'),
            );
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = result.data!['usersCollection']['edges'];
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user['node']['name']),
                subtitle: Text(user['node']['email']),
              );
            },
          );
        },
      ),
    );
  }
}
