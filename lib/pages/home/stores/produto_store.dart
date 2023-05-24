import 'package:flutter/material.dart';
import 'package:flutter_api_test/data/http/exceptions.dart';
import 'package:flutter_api_test/data/models/produto_model.dart';
import 'package:flutter_api_test/data/repositorios/produto_repository.dart';

class ProdutoStore {
  final IProdutoRepository repository;

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  Future getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProdutos();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.massage;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
