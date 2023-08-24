import 'package:flutter/material.dart';
import 'package:flutter_graphql_testapp/home_page.dart';
import 'package:flutter_graphql_testapp/constanta.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink =
        HttpLink(baseUrl, defaultHeaders: {'apikey': apiKey});
    final AuthLink authLink = AuthLink(
      getToken: () async => apiKey,
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
