import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/entity/product_entity.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final priceFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final imageUrlFocus = FocusNode();
  final imageUrlController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formData = <String, Object>{};

  @override
  void initState() {
    imageUrlFocus.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    priceFocus.dispose();
    descriptionFocus.dispose();
    imageUrlFocus.removeListener(updateImageUrl);
    super.dispose();
  }

  void updateImageUrl() {
    setState(() {});
  }

  bool isValidUrl(String url) {
    bool isValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool isImage = url.endsWith('.png') || url.endsWith('.jpg');

    return isValid && isImage;
  }

  void submitForm() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    formKey.currentState?.save();

    final newProduct = Product(
      id: Random().nextDouble().toString(),
      title: formData['title'] as String,
      description: formData['description'] as String,
      price: formData['price'] as double,
      imageUrl: formData['imageUrl'] as String,
    );

    inspect(newProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Produto"),
        actions: [
          IconButton(
            onPressed: submitForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                  decoration: const InputDecoration(labelText: "Título"),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) => {
                        FocusScope.of(context).requestFocus(priceFocus),
                      },
                  onSaved: (title) => formData["title"] = title ?? "",
                  validator: (value) {
                    final name = value ?? '';

                    if (name.trim().isEmpty == true) {
                      return "Informe um título válido";
                    }

                    if (name.trim().length < 3) {
                      return "Informe um título com no mínimo 3 letras";
                    }
                  }),
              TextFormField(
                decoration: const InputDecoration(labelText: "Preço"),
                textInputAction: TextInputAction.next,
                focusNode: priceFocus,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(descriptionFocus),
                onSaved: (price) =>
                    formData["price"] = double.parse(price ?? '0'),
                validator: (value) {
                  final price = double.tryParse(value ?? '') ?? -1;

                  if (price <= 0) {
                    return "Informe um preço maior que zero";
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                focusNode: descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (description) =>
                    formData["description"] = description ?? "",
                validator: (value) {
                  final description = value ?? '';

                  if (description.trim().isEmpty == true) {
                    return "Informe um título válido";
                  }

                  if (description.trim().length < 10) {
                    return "Informe um título com no mínimo 10 letras";
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: "Image URL"),
                      keyboardType: TextInputType.url,
                      focusNode: imageUrlFocus,
                      controller: imageUrlController,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => submitForm(),
                      onSaved: (imageUrl) =>
                          formData["imageUrl"] = imageUrl ?? "",
                      validator: (url) {
                        if (!isValidUrl(url ?? "")) {
                          return "Informe uma URL válida";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: imageUrlController.text.isEmpty
                        ? const Text('Informe a Url')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(imageUrlController.text),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
