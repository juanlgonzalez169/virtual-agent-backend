defmodule ChatbotWeb.Router do
  use ChatbotWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ChatbotWeb.APIAuthPlug, otp_app: :chatbot
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: ChatbotWeb.APIAuthErrorHandler
  end

  scope "/" do
    pipe_through :api

    post "/handle", ChatbotWeb.ArtificialIntelligenceController, :handle
    post "/handle2", ChatbotWeb.ArtificialIntelligence2Controller, :handle

  end

  scope "/api", ChatbotWeb do
    pipe_through :api

    resources "/virtuals_assistants", VirtualAssistantController, except: [:new, :edit]
    resources "/fully_virtuals_assistants", FullyVirtualAssistantController, only: [:index, :show]
    resources "/virtuals_assistants_options", VirtualAssistantOptionController, except: [:new, :edit]
    resources "/virtuals_assistants_questions", VirtualAssistantQuestionController, except: [:new, :edit]
    resources "/virtuals_assistants_answers", VirtualAssistantAnswerController, except: [:new, :edit]
    resources "/virtuals_assistants_tags", VirtualAssistantTagController, except: [:new, :edit]
    resources "/statistics", StatisticController, except: [:new, :edit]
    resources "/logs", LogController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    post "/users_by_email", UserController, :filter_by_email, param: "email"

  end

  scope "/api/v1", ChatbotWeb.API.V1, as: :api_v1 do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew
  end

  scope "/api/v1", ChatbotWeb.API.V1, as: :api_v1 do
    pipe_through [:api, :api_protected]

    # Your protected API endpoints here
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", ChatbotWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
end
