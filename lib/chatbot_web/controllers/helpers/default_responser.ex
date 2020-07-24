defmodule ChatbotWeb.DefaultResponser do

  def init(device, to_phone, message) do
    headers = [{:"Authorization", "Token f0a56873fb7d4f11f59275128ece26da868accb14a5065857a9c15e374081704dd41104f7c1eb126"}, {:"Content-Type", "application/json"}]
    {:ok, body} = Jason.encode(responser_(to_phone, message, device))
    HTTPoison.post("https://api.wassi.chat/v1/messages", body, headers)
  end

  def init(device, to_phone, message, file, format) do
    headers = [{:"Authorization", "Token f0a56873fb7d4f11f59275128ece26da868accb14a5065857a9c15e374081704dd41104f7c1eb126"}, {:"Content-Type", "application/json"}]
    {:ok, body} = Jason.encode(responser_(to_phone, message, device, file, format))
    HTTPoison.post("https://api.wassi.chat/v1/messages", body, headers)
  end

  defp responser_(phone, message, device) do
    %{
      message: message,
      device: device,
      priority: "normal",
      phone: phone,
    }
  end

  defp responser_(phone, message, device, file, format) do
    %{
      device: device,
      priority: "normal",
      phone: phone,
      media: %{
        file: file,
        format: format,
        message: message
      }
    }
  end
end
