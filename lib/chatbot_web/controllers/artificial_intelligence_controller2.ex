defmodule ChatbotWeb.ArtificialIntelligence2Controller do
  use ChatbotWeb, :controller
  #import Plug.Conn

  def handle(conn, %{"device" => %{"id" => device, "dphone" => dphone},"data" => %{"toNumber" => phone, "body" => message} }) do
      headers = [{:"Authorization", "Token f0a56873fb7d4f11f59275128ece26da868accb14a5065857a9c15e374081704dd41104f7c1eb126"}, {:"Content-Type", "application/json"}]
      {:ok, body} = Jason.encode(%{ phone: "+584249555584", message: message, device: device })
      HTTPoison.post("https://api.wassi.chat/v1/messages", body, headers)
    json(conn, "message has been send")
  end
end
