import "package:flutter/material.dart";
import "../components/my_button.dart";
import "../components/my_drawer.dart";
import "../models/product.dart";
import "package:provider/provider.dart";
import "../models/shop.dart";

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  //Função para remover item do carrinho
  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: const Text("Deseja remover esse item do carrinho?"),
                actions: [
                  //botão cancelar
                  MaterialButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar")),

                  //botão confirmar
                  MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);

                        context.read<Shop>().removeFromCart(product);
                      },
                      child: const Text("Confirmar"))
                ]));
  }

  //Função do botão adicionar
  void addItemToCart(BuildContext context, Product product) {
    context.read<Shop>().addToCart(product);
  }

  //Função do botão diminuir
  void decreaseItemToCart(BuildContext context, Product product) {
    context.read<Shop>().decreamentFromCart(product);
  }

  //Função pressionar o botão de pagamento
  void payButtonPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
            content:
                Text("Logo conectaremos esse app a uma solução de pagamento")));
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;

    double totalBill = cart.fold<double>(
        0, (previousValue, element) => previousValue + (element.totalPrice));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Carrinho"),
        ),
        drawer: MyDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            //Lista Carrinho
            Expanded(
                child: cart.isEmpty
                    ? const Center(child: Text("Seu carrinho está vazio"))
                    : ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final item = cart[index];

                          return ListTile(
                              leading: Image.network(item.imagePath),
                              title: Text(item.name),
                              subtitle: Text(item.price.toStringAsFixed(2)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () =>
                                        removeItemFromCart(context, item),
                                  ),
                                  IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: item.quantity >= 2
                                          ? () =>
                                              decreaseItemToCart(context, item)
                                          : () => removeItemFromCart(
                                              context, item)),
                                  Text(item.quantity.toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () =>
                                        addItemToCart(context, item),
                                  )
                                ],
                              ));
                        })),
            //Botão de Pagamento
            Visibility(
              visible: cart.isNotEmpty,
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total R\$ ${totalBill.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )),
                          MyButton(
                              onTap: () => payButtonPressed(context),
                              child: const Text("Pagamento")),
                        ],
                      ))),
            )
          ],
        ));
  }
}
