import 'package:flutter_aula_1/models/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
      icone: 'images/bitcoin.png', 
      nome: 'Segurança da Informação', 
      sigla: 'BTC', 
      preco: 164603.00,
    ),
    Moeda(
      icone: 'images/ethereum.png', 
      nome: 'Programação para Dispositivos Móveis', 
      sigla: 'ETH', 
      preco: 9716.00,
    ),
    Moeda(
      icone: 'images/xrp.png', 
      nome: 'Programação Linear', 
      sigla: 'XRP', 
      preco: 3.34,
    ),
    Moeda(
      icone: 'images/cardano.png', 
      nome: 'Engenharia de Software III', 
      sigla: 'ADA', 
      preco: 6.32,
    ),
    Moeda(
      icone: 'images/usdcoin.png', 
      nome: 'Inglês V', 
      sigla: 'USDC', 
      preco: 5.02,
    ),
    Moeda(
      icone: 'images/litecoin.png', 
      nome: 'Laboratório de Banco de Dados', 
      sigla: 'LTC', 
      preco: 669.93,
    ),
  ];
}