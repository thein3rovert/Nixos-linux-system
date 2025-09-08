{
  age = {
    secrets = {

      secret2 = {
        file = ../../secrets/secret2.age;
        owner = "introvert";
      };

      linkding = {
        file = ../../secrets/linkding-env.age;
        owner = "introvert";
        path = "/home/introvert/.secrets/linkding";
        # group = "thein3rovert";
        # mode = "0440";
      };

    };
  };
}
