import 'package:flutter/material.dart';

class CadastroLivroPage extends StatefulWidget {
    // Se vier um livro, é edição; se for null, é cadastro novo
    final Map<String, String>? livro;
    const CadastroLivroPage({super.key, this.livro});

    @override
    State<CadastroLivroPage> createState() {
        return _CadastroLivroPageState();
    }
}

class _CadastroLivroPageState extends State<CadastroLivroPage> {

    final tituloController = TextEditingController();
    final autorController = TextEditingController();
    final isbnController = TextEditingController();

    @override
    void initState() {
        super.initState();
        if (widget.livro != null) {
            tituloController.text = widget.livro!['titulo'] ?? '';
            autorController.text = widget.livro!['autor'] ?? '';
            isbnController.text = widget.livro!['isbn'] ?? '';
        }
    }

    @override
    void dispose() {
        tituloController.dispose();
        autorController.dispose();
        isbnController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text(widget.livro == null ? 'Cadastro de Livro' : 'Editar Livro'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    children: [

                        TextField(
                            controller: tituloController,
                            decoration: const InputDecoration(
                                labelText: 'Título',
                                border: OutlineInputBorder(),
                            ),
                        ),

                        const SizedBox(height: 16.0),
                        TextField(
                            controller: autorController,
                            decoration: const InputDecoration(
                                labelText: 'Autor',
                                border: OutlineInputBorder(),
                            ),
                        ),

                        const SizedBox(height: 16.0),
                        TextField(
                            controller: isbnController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'ISBN',
                                border: OutlineInputBorder(),
                            ),
                        ),

                        const SizedBox(height: 16.0),
                        ElevatedButton(
                            onPressed: () {
                                String titulo = tituloController.text.trim();
                                String autor = autorController.text.trim();
                                String isbn = isbnController.text.trim();

                                // VALIDAÇÃO: campos vazios ou só com espaços
                                if (titulo.isEmpty || autor.isEmpty || isbn.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Atenção! Todos os campos são obrigatórios!'),
                                        ),
                                    );
                                    return;
                                }

                                Navigator.pop(context, {
                                    'titulo': titulo,
                                    'autor': autor,
                                    'isbn': isbn,
                                });
                            },
                            child: const Text('Salvar'),
                        ),

                    ],
                ),
            ),
        );
    }
}
