import 'package:flutter/material.dart';

// --- 1. IL MODELLO DATI ---
class Transazione {
  final String titolo;
  final double importo;
  final String categoria;
  final DateTime data;

  Transazione({
    required this.titolo,
    required this.importo,
    required this.categoria,
    required this.data,
  });
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // --- 2. LA MEMORIA (LO STATO) ---
  double totaleSpese = 0.0;
  List<Transazione> mieTransazioni = [];

  // Controller per leggere i dati dai campi di testo
  final TextEditingController _importoController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _titoloController = TextEditingController();

  // --- 3. FUNZIONE LOGICA PER LE ICONE ---
  Icon _getIconaCategoria(String categoria) {
    String cat = categoria.toLowerCase().trim();
    if (cat == 'spesa' || cat == 'cibo') {
      return const Icon(Icons.shopping_cart, color: Colors.white);
    } else if (cat == 'shopping' || cat == 'abbigliamento') {
      return const Icon(Icons.checkroom, color: Colors.white);
    } else if (cat == 'auto' || cat == 'benzina') {
      return const Icon(Icons.directions_car, color: Colors.white);
    } else {
      return const Icon(Icons.payment, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('MoneyBender'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SCHEDA DEL TOTALE ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A1B9A), Color(0xFF4527A0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Spese di Maggio',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      Icon(
                        Icons.calendar_month,
                        color: Colors.white70,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '€ ${totaleSpese.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'Ultime Transazioni',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // --- 4. LISTA DINAMICA CON SWIPE TO DISMISS ---
            Expanded(
              child: mieTransazioni.isEmpty
                  ? const Center(
                      child: Text(
                        "Nessuna spesa. Aggiungine una!",
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: mieTransazioni.length,
                      itemBuilder: (context, index) {
                        final t = mieTransazioni[index];
                        return Dismissible(
                          // Chiave univoca per identificare la riga da cancellare
                          key: ValueKey(t.titolo + index.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              totaleSpese -= t.importo; // Sottrae dal totale
                              mieTransazioni.removeAt(
                                index,
                              ); // Rimuove dalla lista
                            });
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: _getIconaCategoria(t.categoria),
                            ),
                            title: Text(
                              t.titolo,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Text(
                              '${t.categoria} • ${t.data.day}/${t.data.month} - ${t.data.hour}:${t.data.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(color: Colors.black54),
                            ),
                            trailing: Text(
                              '- € ${t.importo.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // --- 5. BOTTONE AGGIUNGI E POPUP ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Aggiungi Nuova Spesa',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _titoloController,
                      decoration: const InputDecoration(
                        labelText: 'Cosa hai comprato?',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _importoController,
                      decoration: const InputDecoration(
                        labelText: 'Importo (€)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _categoriaController,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        double? valore = double.tryParse(
                          _importoController.text,
                        );
                        String nome = _titoloController.text;
                        String cat = _categoriaController.text;

                        if (valore == null || nome.isEmpty || cat.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Attenzione',
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: const Text(
                                  'compila prima tutti i campi',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'ok',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                        setState(() {
                          totaleSpese += valore;
                          mieTransazioni.insert(
                            0,
                            Transazione(
                              titolo: nome,
                              importo: valore,
                              categoria: cat,
                              data: DateTime.now(),
                            ),
                          );
                        });

                        _importoController.clear();
                        _titoloController.clear();
                        _categoriaController.clear();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('salva spesa'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
