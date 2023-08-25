// ignore_for_file: void_checks

import 'package:flutter/material.dart';
import 'package:flutter_graphql_testapp/constanta.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DeleteMutation extends StatelessWidget {
  const DeleteMutation({super.key, required this.id});

  final String id;
  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(deleteNote),
        update: (GraphQLDataProxy cache, QueryResult? result) {
          return cache;
        },
        onCompleted: (dynamic resultData) {},
      ),
      builder: (RunMutation runMutation, QueryResult? result) {
        return ElevatedButton(
          onPressed: () {
            runMutation({
              'id': id,
            });
          },
          child: const Text('Delete'),
        );
      },
    );
  }
}
