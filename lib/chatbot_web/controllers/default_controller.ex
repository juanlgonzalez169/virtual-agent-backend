defmodule ChatbotWeb.DefaultController do
  use ChatbotWeb, :controller

  def index(conn, _params) do
    text conn, "Wealcome to WhatsPro!"
  end
end
