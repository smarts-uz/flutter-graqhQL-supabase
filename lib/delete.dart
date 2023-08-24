import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> deleteNoteMutation(String noteId, BuildContext context) async {
  final mutation = gql('''
    mutation DeleteFromnotesCollection(\$id: Int!) {
      deleteFromnotesCollection(id: \$id) {
        id
      }
    }
  ''');

  final result = await GraphQLProvider.of(context).value.mutate(
        MutationOptions(
          document: mutation,
          variables: {
            'id': int.parse(noteId),
          },
        ),
      );

  // Handle the result
  // ...
}






























// // Inside MyHomePage class, add methods for update and delete
// Future<void> updateNoteMutation(String noteId, String newTitle, String newDescription) async {
//   final mutation = gql('''
//     mutation UpdateBlogCollection(\$id: Int!, \$title: String!, \$description: String!) {
//       updateBlogCollection(pk_columns: { id: \$id }, _set: { title: \$title, description: \$description }) {
//         id
//         title
//         description
//       }
//     }
//   ''');

//   final result = await GraphQLProvider.of(context).value.mutate(
//     MutationOptions(
//       document: mutation,
//       variables: {
//         'id': int.parse(noteId),
//         'title': newTitle,
//         'description': newDescription,
//       },
//     ),
//   );

//   // Handle the result
//   // ...
// }

// Future<void> deleteNoteMutation(String noteId) async {
//   final mutation = gql('''
//     mutation DeleteNote(\$id: Int!) {
//       delete_notesCollection_by_pk(id: \$id) {
//         id
//       }
//     }
//   ''');

//   final result = await GraphQLProvider.of(context).value.mutate(
//     MutationOptions(
//       document: mutation,
//       variables: {
//         'id': int.parse(noteId),
//       },
//     ),
//   );

//   // Handle the result
//   // ...
// }

// // Inside your ListTile, add buttons for edit, delete, and connect them to methods
// IconButton(
//   onPressed: () {
//     // Navigate to an edit screen or show a dialog for updating
//     // Collect the updated data and call updateNoteMutation
//   },
//   icon: Icon(Icons.edit, color: Colors.yellow),
// ),
// IconButton(
//   onPressed: () {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Confirm Deletion'),
//           content: Text('Are you sure you want to delete this note?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the dialog
//                 deleteNoteMutation(user['node']['id']);
//               },
//               child: Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   },
//   icon: Icon(Icons.delete, color: Colors.yellow),
// ),
