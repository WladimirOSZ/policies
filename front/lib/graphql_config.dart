import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    'http://192.168.0.23:3001/graphql',
  );

  GraphQLClient clientToQuery = GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(),
  );
}
