import 'package:flutter/material.dart';
import 'cadastro_livro_page.dart';

// Lista em memória: cada livro tem titulo, autor e isbn
final List<Map<String, String>> livros = [
    {
        'titulo': 'Dom Casmurro',
        'autor': 'Machado de Assis',
        'isbn': '9788535910663',
    },
];

class BibliotecaPage extends StatefulWidget {
    const BibliotecaPage({super.key});

    @override
    State<BibliotecaPage> createState() {
        return _BibliotecaPageState();
    }
}

class _BibliotecaPageState extends State<BibliotecaPage> {

    // CADASTRO: abre o formulário vazio e adiciona o livro retornado
    Future<void> _adicionar() async {
        final novoLivro = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(
                builder: (context) => const CadastroLivroPage(),
            ),
        );
        if (novoLivro != null && mounted) {
            setState(() {
                livros.add(novoLivro);
            });
        }
    }

    // EDIÇÃO: abre o formulário preenchido e substitui o livro no mesmo índice
    Future<void> _editar(int index) async {
        final livroEditado = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(
                builder: (context) => CadastroLivroPage(livro: livros[index]),
            ),
        );
        if (livroEditado != null && mounted) {
            setState(() {
                livros[index] = livroEditado;
            });
        }
    }

    // EXCLUSÃO: pede confirmação e remove da lista
    void _excluir(int index) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                title: const Text('Excluir Livro'),
                content: Text('Deseja excluir o livro ${livros[index]['titulo']!}?'),
                actions: [
                    TextButton(
                        onPressed: () {
                            Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                    ),
                    TextButton(
                        onPressed: () {
                            setState(() {
                                livros.removeAt(index);
                            });
                            Navigator.pop(context);
                        },
                        child: const Text('Excluir'),
                    ),
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text('Biblioteca'),
            ),
            body: livros.isEmpty
                ? const Center(child: Text('Nenhum livro cadastrado'))
                : ListView.builder(
                    itemCount: livros.length,
                    itemBuilder: (context, index) {
                        return ListTile(
                            onTap: () => _editar(index),
                            leading: const Icon(Icons.book),
                            title: Text(livros[index]['titulo']!),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text('Autor: ${livros[index]['autor']!}'),
                                    Text('ISBN: ${livros[index]['isbn']!}'),
                                ],
                            ),
                            trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _excluir(index),
                            ),
                        );
                    },
                ),
            floatingActionButton: FloatingActionButton(
                onPressed: _adicionar,
                child: const Icon(Icons.add),
            ),
        );
    }
}

void main() {
    runApp(const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BibliotecaPage(),
    ));
}
