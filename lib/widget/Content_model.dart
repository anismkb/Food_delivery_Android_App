
class UnboardingContent{
  String image;
  String title;
  String description;

  UnboardingContent({required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents = [
  UnboardingContent(description: "pick your food from our menu !\n      more then 35 items", image: "images/screen1.png", title: "Select from our \n     Best menu"),
  UnboardingContent(description: "you can pay cash or with a card", image: "images/screen2.png", title: "Easy and Online paymente"),
  UnboardingContent(description: "Deliver your food to your adresse", image: "images/screen3.png", title: "Quick delivery at your door"),
];