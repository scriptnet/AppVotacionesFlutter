// MODELO


  class Band {
    
    String id;
    String name;
    int votes;
  // contructor
    Band({
      required this.id,
      required this.name,
      required this.votes
    });

  // FACTORY MODELO
    factory Band.fromMap( Map<String, dynamic> obj) => Band(
      id: obj['id'],
      name: obj['name'],
      votes: obj['votes']
    );

  }
  // FIN MODELO
