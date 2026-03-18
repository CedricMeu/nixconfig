{ useremail, ... }:
{
  programs = {
    sapling = {
      enable = true;

      userName = "CedricMeu";
      userEmail = useremail;

      extraConfig = {
        ui.merge = "internal:merge";
      };
    };
  };
}
