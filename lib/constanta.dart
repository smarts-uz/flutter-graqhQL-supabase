const String getNotes = '''
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
          ''';

const String addNote = '''
           mutation InsertIntonotesCollection(\$title: String!, \$description: String!) {
            insertIntonotesCollection(objects: {title: \$title, description: \$description}) {
              affectedCount
                records {
                  nodeId
                  id
                  title
                  description
                }
              }
            }
          ''';

const String updateNote = '''
          mutation UpdatenotesCollection(\$id: ID!, \$title: String!, \$description: String!) {
            updatenotesCollection(
              set: {title: \$title, description: \$description} filter: {id: {eq: \$id}} ) {
               affectedCount
                 records {
                   title
                    description
                  }
                }
             } 

          ''';

const String deleteNote = '''
            mutation DeleteFromnotesCollection(\$id: ID!) {
              deleteFromnotesCollection(atMost: 1, filter: {id: {eq: \$id}}) {
                records {
                  id
                  title
                  description
                }
              }
            }
          ''';

const String baseUrl = 'https://rdmythxwzdcbqhaheafv.supabase.co/graphql/v1';
const String apiKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJkbXl0aHh3emRjYnFoYWhlYWZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODg3MDk0NjgsImV4cCI6MjAwNDI4NTQ2OH0.91F6sZT_9Oz0ajk8JgA8cwV90Rw7cSp_SSDvR62qbM8';














  // mutation InsertIntonotesCollection(\$id: ID!, \$title: String!, \$description: String!){
  //            updatenotesCollection(
  //             set: {title: \$title, description: \$description} filter: {id: {eq: \$id}}) {
  //                records {
  //                 title
  //                 description
  //               }
  //              affectedCount
  //             }
  //           }
