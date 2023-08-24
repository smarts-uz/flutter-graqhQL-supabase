// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_graphql_testapp/add_note.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
          primarySwatch: Colors.yellow,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const AddNoteScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Query(
        options: QueryOptions(
          document: gql('''
            query NotesCollection {
              notesCollection {
                edges{
                  node{
                    id
                    title
                    description
                  }
                }
              }
            }
          '''),
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Center(
              child: Text('Error: ${result.exception.toString()}'),
            );
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = result.data!['notesCollection']['edges'];
          print(result.data!);
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.yellow.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.yellow),
                ),
                child: ListTile(
                  title: Text(user['node']['title']),
                  subtitle: Text(
                    user['node']['description'],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit, color: Colors.yellow),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Confirm Deletion'),
                                content: const Text(
                                    'Are you sure you want to delete this note?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: const Text(
                                      'Delete',
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete, color: Colors.yellow),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
