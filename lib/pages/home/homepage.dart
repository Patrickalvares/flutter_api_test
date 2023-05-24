import 'package:flutter/material.dart';
import 'package:flutter_api_test/data/http/http_client.dart';
import 'package:flutter_api_test/data/repositorios/produto_repository.dart';
import 'package:flutter_api_test/pages/home/stores/produto_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProdutoStore store = ProdutoStore(
      repository: ProdutoRepository(
    client: HttpClient(),
  ));

  @override
  void initState() {
    super.initState();
    store.getProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Teste de Api'),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.erro,
          store.state,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const CircularProgressIndicator();
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(store.erro.value),
            );
          }
        },
      ),
    );
  }
}
