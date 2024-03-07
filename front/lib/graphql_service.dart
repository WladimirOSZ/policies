// ignore_for_file: avoid_print

import 'package:front/graphql_config.dart';
import 'package:front/policy_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery;

  Future<Policy> getPolicy(int id) async {
    final result = await client.query(
      QueryOptions(
        document: gql('''
          query GetPolicies {
            getPolicies(policyId: 81) {
              policyId
              issueDate
              insuredName
              vehicleYear
              vehicleBrand
            }
          }
        '''),
      ),
    );

    print('------------------here--------------');
    print(result.data);
    print('------------------here--------------');

    if (result.hasException) {
      print(result);
      throw Exception('Failed to get policies');
    }

    return Policy.fromJson(result.data?['getPolicies']);
  }
}
