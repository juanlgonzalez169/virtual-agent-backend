defmodule ChatbotWeb.DefaultInvestigator do
  use ChatbotWeb, :controller

  alias ChatbotWeb.DefaultResponser
    def iterate([]) do
      0
    end

    def iterate(conn, list, phone) do
      iterate(conn, list, [], phone)
    end

    def iterate(conn, [], result, phone) do
      json(conn, DefaultResponser.responser(phone, result))
    end

    def iterate(conn, [head | tail], result, phone) do
      json(conn, DefaultResponser.responser(phone, head))
      :timer.sleep(1)
      iterate(conn, tail, result, phone)
    end
end
