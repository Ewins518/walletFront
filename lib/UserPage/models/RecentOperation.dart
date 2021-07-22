class RecentOpr {
  final String? noCompte,  date, nature;
  final int ? montant;

 RecentOpr({this.noCompte, this.montant, this.date, this.nature});
}

List demoRecentOpr = [
  RecentOpr(
    noCompte: "tra78854",
    montant: 15000,
    date: "01-03-2021",
    nature: "Reçu",
  ),
  RecentOpr(
    noCompte: "tra78754",
    montant: 1500,
    date: "01-03-2021",
    nature: "Reçu",
  ),
 
];
