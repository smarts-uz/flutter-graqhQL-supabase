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
            // mutation AddNote(\$title: String!, \$description: String!) {
            //   insert_notesCollection_one(object: {title: \$title, description: \$description}) {
            //     id
            //     title
            //     description
            //   }
            // }
          ''';

const String updateNote = '''
            // mutation UpdateNote(\$id: Int!, \$title: String!, \$description: String!) {
            //   update_notesCollection_by_pk(pk_columns: {id: \$id}, _set: {title: \$title, description: \$description}) {
            //     id
            //     title
            //     description
            //   }
            // }
          ''';

const String deleteNote = '''
            // mutation DeleteNoteMutation(\$id: Int!) {
            //   delete_notesCollection_by_pk(id: \$id) {
            //     id
            //     title
            //     description
            //   }
            // }
          ''';

const String baseUrl = 'https://rdmythxwzdcbqhaheafv.supabase.co/graphql/v1';
const String apiKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJkbXl0aHh3emRjYnFoYWhlYWZ2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODg3MDk0NjgsImV4cCI6MjAwNDI4NTQ2OH0.91F6sZT_9Oz0ajk8JgA8cwV90Rw7cSp_SSDvR62qbM8';
