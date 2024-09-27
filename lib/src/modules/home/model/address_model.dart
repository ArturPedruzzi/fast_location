import 'package:hive/hive.dart';

part 'address_model.g.dart'; 

@HiveType(typeId: 0)
class AddressModel {
  @HiveField(0)
  final String cep;

  @HiveField(1)
  final String logradouro;

  @HiveField(2)
  final String complemento;

  @HiveField(3)
  final String bairro;

  @HiveField(4)
  final String cidade;

  @HiveField(5)
  final String uf;

  @HiveField(6)
  final bool erro;

  AddressModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.cidade,
    required this.uf,
    this.erro = false,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      cep: json['cep'] ?? '',
      logradouro: json['logradouro'] ?? '',
      complemento: json['complemento'] ?? '',
      bairro: json['bairro'] ?? '',
      cidade: json['localidade'] ?? '',
      uf: json['uf'] ?? '',
      erro: json['erro'] ?? false,  
    );
  }
}
