class UserOperations {
  final String getNotes = '''
            query NotesCollection {
              notesCollection {
                edges{
                  node{
                    id
                    created_at
                    title
                    description
                  }
                }
              }
            }
          ''';

  final String deleteNotes = '''
            mutation DeleteFromnotesCollection(\$id: ID!) {
              deleteFromnotesCollection(id: \$id) {
                id
              }
            }
  ''';
}

const addNotes = '''
  mutation InsertIntonotesCollection(\$name: String!, \$email: String!) {
    InsertIntonotesCollection(name: \$name, email: \$email) {
      id
      name
      email 
    }
  }  
''';


 // static final String createUser = '''
  //   mutation CreateUser($name: String!, $email: String!) {
  //     createUser(name: $name, email: $email) {
  //       id
  //       name
  //       email
  //     }
  //   }
  // ''';


 // static final String updateUser = '''
  //   mutation UpdateUser($id: ID!, $name: String!, $email: String!) {
  //     updateUser(id: $id, name: $name, email: $email) {
  //       id
  //       name
  //       email
  //     }
  //   }
  // ''';