defmodule ChatbotWeb.DefaultIterator do
use ChatbotWeb, :controller
alias ChatbotWeb.{DefaultResponser}

  def iterate([], _device, _phone) do
    :ok
  end

  def iterate([head | tail], device, phone) do
    if Enum.at(head, 4) == "no-file" and Enum.at(head, 5) == "no-format" do
      DefaultResponser.init(device, phone, Enum.at(head, 3))
      iterate(tail, device, phone)
    else
      DefaultResponser.init(device, phone, Enum.at(head, 3), Enum.at(head, 4), Enum.at(head, 5))
      iterate(tail, device, phone)
    end
  end
end
