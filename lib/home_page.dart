import 'package:flutter/material.dart';
import 'package:flutter_graphql_testapp/add_note.dart';
import 'package:flutter_graphql_testapp/constanta.dart';
import 'package:flutter_graphql_testapp/delete.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddNoteScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getNotes),
          pollInterval: const Duration(seconds: 2),
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
                      Mutation(
                        options: MutationOptions(document: gql(deleteNote)),
                        builder: (
                          RunMutation runMutation,
                          QueryResult? result,
                        ) {
                          return ElevatedButton(
                            onPressed: () {
                              runMutation({
                                'id': user['node']['id'],
                                'title': 'Updated Title',
                                'description': 'Updated Description',
                              });
                            },
                            child: const Text('Update'),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      DeleteMutation(id: user['node']['id'].toString()),
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
