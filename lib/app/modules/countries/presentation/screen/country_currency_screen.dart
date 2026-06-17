import 'package:clean_architecture_example_app/app/core/services/network_service/routes/api_routes.dart';
import 'package:clean_architecture_example_app/app/modules/countries/presentation/provider/counties_provider.dart';
import 'package:clean_architecture_example_app/app/modules/countries/presentation/widgets/country_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountryCurrencyScreen extends ConsumerStatefulWidget {
  const CountryCurrencyScreen({super.key});

  @override
  ConsumerState<CountryCurrencyScreen> createState() =>
      _CountryCurrencyScreenState();
}

class _CountryCurrencyScreenState extends ConsumerState<CountryCurrencyScreen> {

  @override
  void initState() {
    Future.microtask((){
      ref.read(countriesProvider.notifier).getCountryCurrency();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ctrl = ref.watch(countriesProvider);
    return Scaffold(
      appBar: AppBar(title: Text("List of Countries")),

      body: ctrl.hasLoader(ApiRoutes.getCountryCurrency)
          ? Center(child: CircularProgressIndicator())
          : ((ctrl.getCountiesCurrencyDto?.data?.countries ?? []).isEmpty)
          ? Center(child: Text("No Data Found"))
          : ListView.builder(
              itemCount:
                  ctrl.getCountiesCurrencyDto?.data?.countries?.length ?? 0,
              itemBuilder: (context, index) {
                final country =
                    ctrl.getCountiesCurrencyDto?.data?.countries?[index];
                return CountryCard(
                  code: country?.code ?? "AD",
                  emoji: country?.emoji ?? "🇦🇩",
                  capital: country?.capital ?? "Andorra la Vella",
                  currency: country?.currency ?? "EUR",
                  name: country?.name ?? "Andorra",
                );
              },
            ),
    );
  }
}
