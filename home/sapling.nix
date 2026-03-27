{ useremail, ... }:
{
  programs = {
    sapling = {
      enable = true;

      userName = "cedric.meukens";
      userEmail = useremail;

      extraConfig = {
        ui.merge = "internal:merge";
      };
    };
  };
}
