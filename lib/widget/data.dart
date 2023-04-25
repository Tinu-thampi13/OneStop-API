class PlanetInfo {
  final String? name;
  final String? description;
  final String? url;

  PlanetInfo({
    this.name,
    this.description,
    required this.url,
  });
}

List<PlanetInfo> planets = [
  PlanetInfo(
    name: 'Tinu Thampi',
    description: "Flutter Frontend Developer",
    url: 'https://www.linkedin.com/in/tinu-thampi/',
  ),
  PlanetInfo(
      name: 'Linkedin',
      description: "@tinu-thampi",
      url: 'https://www.linkedin.com/in/tinu-thampi/'),
  PlanetInfo(
    name: 'Github',
    description: "@Tinu-thampi13",
    url: 'https://github.com/Tinu-thampi13',
  ),
  PlanetInfo(
    name: 'GeeksforGeeks',
    description: "@tinuthampi13",
    url: 'https://auth.geeksforgeeks.org/user/tinuthampi13/practice',
  ),
  PlanetInfo(
    name: 'CodeChef',
    description: "@Tinu thampi",
    url: 'https://www.codechef.com/users/tinu_thampi',
  ),
];
