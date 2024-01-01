# github: Let's build from here 

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.gh = {
    enable = true;
    extensions = with pkgs; [ 
      # Quite limited option for now by default
      # look for OSPO tools gh-net, gh-sbom
      gh-eco
    ];
    settings = {
    };
  };

  # Enable the popular dashboard (gh-dash)
  # NOTE: It has is own configuration, see https://github.com/dlvhdr/gh-dash
  programs.gh-dash = {
    enable = true;
    settings = { 
      # Specificy PR/filters
      prSections = [
        {
          title = "PR Created";
          filters = "is:open author:@me";
        }
        {
          title = "PR to Reviews";
          filters = "is:open review-requested:@me";
        }
        {
          title = "PR Involved";
          filters = "is:open involves:@me -author:@me";
        }
      ];
      # Specificy Issues/filters
      issuesSections = [
        {
          title = "Created";
          filters = "is:open author:@me";
        }
        {
          title = "Assigned";
          filters = "is:open assignee:@me";
        }
        {
          title =  "Involved";
          filters = "is:open involves:@me -author:@me"; 
        }
      ];
    };
  };

}