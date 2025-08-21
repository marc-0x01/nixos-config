# codex: Lightweight coding agent that runs in your terminal

{ pkgs, lib, config, nixpkgs, nixpkgs-unstable, home-manager, ... }: {

  programs.codex = {
    enable = true;
    # Settings
    settings = {
        model = "gpt-5";
        model_provider = "openai"
        model_providers = {
          openai = {
            # Name of the provider that will be displayed in the Codex UI.
            name = "OpenAI using Chat Completions";
            base_url = "https://api.openai.com/v1";
            env_key = "OPENAI_API_KEY";
            wire_api = "chat";
            query_params = {};
          };
        };
    };
    # Custom guidance for the agent(s)
    custom-instructions = ''
    '';

  };

}