{ useremail, ... }:
{
  programs = {
    delta.enableJujutsuIntegration = true;

    jujutsu = {
      enable = true;

      settings = {
        user = {
          email = useremail;
          name = "cedric.meukens";
        };
      };
    };
  };
}
