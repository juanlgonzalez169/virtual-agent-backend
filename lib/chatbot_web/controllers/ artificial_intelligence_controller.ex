defmodule ChatbotWeb.ArtificialIntelligenceController do
  use ChatbotWeb, :controller
  alias Chatbot.Repo
  import Ecto.Query, only: [from: 2]
  alias ChatbotWeb.{DefaultResponser, DefaultOthersUpdater, DefaultInvestigator, DefaultIterator}
  alias Chatbot.Others.{Statistic, Log}
  alias Chatbot.CMS.{VirtualAssistant, VirtualAssistantAnswer, VirtualAssistantOption, VirtualAssistantQuestion, VirtualAssistantTag}


  def handle(conn, %{"device" => %{"id" => device},"data" => %{"toNumber" => dphone, "fromNumber" => phone, "body" => message} }) do

    va_id = Repo.one(from v in VirtualAssistant, where: v.phone == ^dphone, select: v.id)

    if va_id != nil do


      if Repo.one(from s in "statistics", where: s.virtual_assistant_id == ^va_id, select: s.virtual_assistant_id) == nil and Repo.one(from l in "logs", where: l.virtual_assistant_id == ^va_id, select: l.virtual_assistant_id) == nil do

        Repo.insert(%Statistic{virtual_assistant_id: va_id})

        Repo.insert(%Log{virtual_assistant_id: va_id})

        DefaultResponser.init(device, phone, "Usted ha iniciado una nueva conversacion con el asistente, por favor, intente de nuevo.")

        json(conn, "Usted ha iniciado una nueva conversacion con el asistente, por favor, intente de nuevo.")

      else
        statistic_id = Repo.one(from s in "statistics", where: s.virtual_assistant_id == ^va_id, select: s.id)

        log_id = Repo.one(from l in "logs", where: l.virtual_assistant_id == ^va_id, select: l.id)

        tier = Repo.one(from t in "logs", where: t.virtual_assistant_id == ^va_id, select: t.tier)

        va_options = Repo.all(from o in "virtuals_assistants_options", where: o.virtual_assistant_id == ^va_id, select: [o.id, o.identification, o.option])

        if va_options != nil do

          saludos = ["hola", "buenos dias", "buenas tardes", "buenas noches", "hey", "hi", "hello"]

          correct_choices = ["opciones", "servicios", "alternativas", "elecciones", "preferencias", "selecciones"]

          info_choices = ["info", "informacion"]

          tier_location_choices = ["nivel", "tier"]

          terminators = ["adios", "chao", "hasta luego", "nos vemos", "fue un placer", "conversamos luego"]

          cond do

            tier == 0 ->

              case String.match?(message, ~r/^[a-zA-Z]+$/) do

                true ->

                  options_counter = Enum.count(va_options)

                  if Enum.member?(saludos, String.downcase(message)) do

                    response = List.to_string([String.capitalize(message)]++[", recuerde que puede ingresar: 'comandos' para ver la lista de comandos."])

                    DefaultResponser.init(device, phone, response)

                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, response)

                  end

                  if String.downcase(message) == "comandos" do

                    choices = Enum.map(correct_choices, fn correct_choices -> " [#{correct_choices}] " end)
                    information = Enum.map(info_choices, fn info_choices -> " [#{info_choices}] " end)
                    tier = Enum.map(tier_location_choices, fn tier_location_choices -> " [#{tier_location_choices}] " end)
                    leaves = Enum.map(terminators, fn terminators -> " [#{terminators}] "  end)
                    full_commands = "Avanzar en su conversacion: '#{choices}', Ver en que nivel se encuentra actualmente: '#{tier}', Informacion sobre este asistente: '#{information}', Terminar conversacion: '#{leaves}' "

                    DefaultResponser.init(
                      device,
                      phone,
                      full_commands
                      )


                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, full_commands)

                  end

                  if Enum.member?(info_choices, String.downcase(message)) do

                    va = Repo.one(from v in "virtuals_assistants", where: v.id == ^va_id, select: [v.phone, v.name, v.description])
                    response = "Nombre: #{Enum.at(va, 1)}, telefono asociado: #{Enum.at(va, 0)}, descripcion: #{Enum.at(va, 2)}."

                    DefaultResponser.init(device, phone, response)

                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, response)

                  end

                  if Enum.member?(tier_location_choices, String.downcase(message)) do

                    choices = Enum.map(correct_choices, fn correct_choices -> " [#{correct_choices}] " end)
                    response = "Usted se encuentra en el nivel #{tier+1}, por favor, ingrese alguna de estas opciones para continuar con la conversacion: #{choices}"

                    DefaultResponser.init(device, phone, response)

                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, response)

                  end

                  if Enum.member?(terminators, String.downcase(message)) do

                    response = "#{String.capitalize(message)}, espero vuelva pronto."

                    DefaultResponser.init(device, phone, response)

                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, response)

                  end

                  if Enum.member?(correct_choices, String.downcase(message)) do

                    options_getter = va_options |> Enum.map( fn [_id, identification, option] -> " [[#{identification}] - #{option}] " end )

                    formated_options = options_getter ++ [" [[#{options_counter+1}] - Atras] "]

                    response = "Ingresos disponibles: #{formated_options}"

                    DefaultResponser.init(device, phone, response)

                    DefaultOthersUpdater.append_to_log_tier(log_id, tier)

                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, response)

                  end

                  if Enum.member?((query = Repo.one(from o in VirtualAssistantOption, where: o.virtual_assistant_id == ^va_id, join: q in VirtualAssistantQuestion, on: q.virtual_assistant_option_id == o.id, join: a in VirtualAssistantAnswer, on: a.virtual_assistant_question_id == q.id, join: t in VirtualAssistantTag, on: t.virtual_assistant_question_id == q.id and t.tag in ^String.split(String.downcase(message)), select: [t.id, t.tag, a.id, a.answer, a.file, a.format])), message) do

                    if Enum.at(query, 4) != "no-file" and Enum.at(query, 5) != "no-format" do
                      DefaultResponser.init(device, phone, Enum.at(query, 3), Enum.at(query, 4), Enum.at(query, 5))
                      json(conn, "El mensaje #{Enum.at(query, 3)} ha sido enviado a: #{phone}")
                    else
                      DefaultResponser.init(device, phone, Enum.at(query, 3))
                      json(conn, "El mensaje #{Enum.at(query, 3)} ha sido enviado a: #{phone}")
                    end
                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                  else

                    choices = Enum.map(correct_choices, fn correct_choices -> " [#{correct_choices}] " end)

                    response = "Esta ingresando un parametro incorrecto, por favor, ingrese alguna de estas opciones para continuar con la conversacion: #{choices}"

                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                    json(conn, response)

                  end

                false ->

                  case String.match?(message, ~r/^[0-9]+$/) do

                    true ->

                      DefaultResponser.init(device, phone, "Ingreso incorrecto para este nivel.")

                      json(conn, "Ingreso incorrecto para este nivel.")

                    false ->

                      splitted = String.replace(message, ~r"[,.~!@#$%^&*()-+=`;:_'-?/<>]", "") |> String.split()

                      case splitted != nil do
                        true ->
                          query = Repo.all(from o in VirtualAssistantOption, where: o.virtual_assistant_id == ^va_id,
                            join: q in VirtualAssistantQuestion, on: q.virtual_assistant_option_id == o.id,
                            join: a in VirtualAssistantAnswer, on: a.virtual_assistant_question_id == q.id,
                            join: t in VirtualAssistantTag, on: t.virtual_assistant_question_id == q.id and t.tag in ^splitted, select: [t.id, t.tag, a.id, a.answer, a.file, a.format])
                          case query != nil do
                            true ->
                              #Enum.map(query, fn x -> if Enum.at(x, 4) == "no-file" and Enum.at(x, 5) == "no-format", do: DefaultResponser.init(device, phone, Enum.at(x, 3)), else: DefaultResponser.init(device, phone, Enum.at(x, 3), Enum.at(x, 4), Enum.at(x, 5))end)
                              #json(conn, "Los mensajes han sido enviados.")
                              DefaultIterator.iterate(query, device, phone)
                              json(conn, "Los mensajes han sido enviados.")
                            false ->
                              DefaultResponser.init(device, phone, "No existe respuesta disponible para su ingreso.")
                              json(conn, "No existe respuesta disponible para su ingreso.")
                          end
                      end

                  end

              end

            tier == 1 ->

              options_counter = Enum.count(va_options)

              case String.match?(message, ~r/^[a-zA-Z]+$/)  do

                true ->

                  if Enum.member?(saludos, String.downcase(message)) do

                    response = List.to_string([String.capitalize(message)]++[", recuerde que puede ingresar: 'comandos' para ver la lista de comandos."])

                    DefaultResponser.init(device, phone, response)
                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, response)

                  end

                  if String.downcase(message) == "comandos" do

                    choices = Enum.map(va_options, fn [_id, identification, option] -> " [[#{identification}] #{option}] " end)
                    go_back = " [[#{Enum.count(choices)+1}] [Atras]] "
                    information = Enum.map(info_choices, fn info_choices -> " [#{info_choices}] " end)
                    tier = Enum.map(tier_location_choices, fn tier_location_choices -> " [#{tier_location_choices}] " end)
                    leaves = Enum.map(terminators, fn terminators -> " [#{terminators}] "  end)
                    full_commands = "Avanzar en su conversacion: '#{choices}', Ir atras: '#{go_back}', Ver en que nivel se encuentra actualmente: '#{tier}', Informacion sobre este asistente: '#{information}', Terminar conversacion: '#{leaves}' "

                      DefaultResponser.init(
                        device,
                        phone,
                        full_commands
                      )

                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, full_commands)

                  end

                  if Enum.member?(info_choices, String.downcase(message)) do

                    va = Repo.one(from v in "virtuals_assistants", where: v.id == ^va_id, select: [v.phone, v.name, v.description])
                    response = "Nombre: #{Enum.at(va, 1)}, telefono asociado: #{Enum.at(va, 0)}, descripcion: #{Enum.at(va, 2)}."

                    DefaultResponser.init(device, phone, response)
                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, response)

                  end

                  if Enum.member?(tier_location_choices, String.downcase(message)) do

                    response = "Usted se encuentra en el nivel #{tier+1}, por favor, seleccione una pregunta numerica (pre-configurada) para continuar con la conversacion."
                    DefaultResponser.init(device, phone, response)
                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, response)

                  end

                  if Enum.member?(terminators, String.downcase(message)) do

                    response = "#{String.capitalize(message)}, espero vuelva pronto."
                    DefaultResponser.init(device, phone, response)

                    DefaultOthersUpdater.reset_log_tier(log_id)
                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    json(conn, response)

                  end

                  if String.downcase(message) == "atras" or message == "#{options_counter+1}" do

                    DefaultOthersUpdater.prepend_to_log_tier(log_id, tier)
                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                    DefaultResponser.init(device, phone, "Usted ha ido hacia atras 1 nivel, recuerde que puede ingresar 'comandos' para conocer los comandos que tiene disponibles por nivel.")

                    json(conn, "Usted ha ido hacia atras 1 nivel, recuerde que puede ingresar 'comandos' para conocer los comandos que tiene disponibles por nivel.")

                  end

                  if Enum.member?((query = Repo.one(from o in VirtualAssistantOption, where: o.virtual_assistant_id == ^va_id, join: q in VirtualAssistantQuestion, on: q.virtual_assistant_option_id == o.id, join: a in VirtualAssistantAnswer, on: a.virtual_assistant_question_id == q.id, join: t in VirtualAssistantTag, on: t.virtual_assistant_question_id == q.id and t.tag in ^String.split(String.downcase(message)), select: [t.id, t.tag, a.id, a.answer, a.file, a.format])), message) do

                    if Enum.at(query, 4) != "no-file" and Enum.at(query, 5) != "no-format" do
                      DefaultResponser.init(device, phone, Enum.at(query, 3), Enum.at(query, 4), Enum.at(query, 5))
                      json(conn, Enum.at(query, 3))
                    else
                      DefaultResponser.init(device, phone, Enum.at(query, 3))
                      json(conn, Enum.at(query, 3))
                    end
                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                  else

                    response = "Esta ingresando un parametro incorrecto, por favor, ingrese 'comandos' para saber como interactuar con el asistente."


                    DefaultResponser.init(device, phone, response)
                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                    json(conn, response)

                  end

                false ->

                  case String.match?(message, ~r/^[0-9]+$/) do

                    true ->

                      case Integer.parse(message) do

                        {value, _} ->

                          if value > options_counter do

                            DefaultResponser.init(device, phone, "Disculpe, se encuentra ingresando un parametro superior a las opciones configuradas para este nivel.")
                            DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                            DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                            json(conn, "Disculpe, se encuentra ingresando un parametro superior a las opciones configuradas para este nivel.")

                          end

                          if value == 0 do

                            DefaultResponser.init(device, phone, "Disculpe, se encuentra ingresando un parametro no admitido, el ingreso debe ser mayor que 1 y estar configurado en sus opciones para este nivel.")
                            DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                            DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                            json(conn, "Disculpe, se encuentra ingresando un parametro no admitido, el ingreso debe ser mayor que 1 y estar configurado en sus opciones para este nivel.")

                          end

                          if value > 0 and value <= options_counter do

                            id = Enum.map(va_options, fn [id, identification, option] -> if [id, identification, option] == [id, message, option ], do: id end) |> Enum.filter( fn id -> if id != nil, do: id end ) |> Enum.at(0)

                            va_questions = Repo.all(from q in "virtuals_assistants_questions", where: q.virtual_assistant_option_id == ^id, select: [q.identification, q.question])

                            if va_questions != [] and va_questions != nil do

                              questions = Enum.map(va_questions, fn [identification, question] -> " [[#{identification}] #{question}] "  end )

                              response = questions ++ [" [[#{Enum.count(questions)+1}] - Atras] "]

                              DefaultResponser.init(device, phone, List.to_string(response))

                              DefaultOthersUpdater.append_to_log_tier(log_id, tier)

                              DefaultOthersUpdater.append_to_log_selected_option(log_id, message)
                              DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                              DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                              json(conn, List.to_string(response))

                            else

                              DefaultResponser.init(device, phone, "Por favor, configure correctamente sus preguntas e intente nuevamente.")
                              DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                              DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                              json(conn, "Por favor, configure correctamente sus preguntas e intente nuevamente.")

                            end
                          else
                            DefaultResponser.init(device, phone, "Parametro no reconocido, por favor, intente de nuevo.")
                            DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                            DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                            json(conn, "Parametro no reconocido, por favor, intente de nuevo.")

                          end

                        :error ->
                          DefaultResponser.init(device, phone, "Parametro invalido.")
                          DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                          DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                          json(conn, "Parametro invalido.")

                      end

                    false ->

                      splitted = String.replace(message, ~r"[,.~!@#$%^&*()-+=`;:_'-?/<>]", "") |> String.split()

                      case splitted != nil do
                        true ->
                          query = Repo.all(from o in VirtualAssistantOption, where: o.virtual_assistant_id == ^va_id,
                            join: q in VirtualAssistantQuestion, on: q.virtual_assistant_option_id == o.id,
                            join: a in VirtualAssistantAnswer, on: a.virtual_assistant_question_id == q.id,
                            join: t in VirtualAssistantTag, on: t.virtual_assistant_question_id == q.id and t.tag in ^splitted, select: [t.id, t.tag, a.id, a.answer, a.file, a.format])
                          case query != nil do
                            true ->
                              #Enum.map(query, fn x -> if Enum.at(x, 4) == "no-file" and Enum.at(x, 5) == "no-format", do: DefaultResponser.init(device, phone, Enum.at(x, 3)), else: DefaultResponser.init(device, phone, Enum.at(x, 3), Enum.at(x, 4), Enum.at(x, 5))end)
                              DefaultIterator.iterate(query, device, phone)
                              json(conn, "Los mensajes han sido enviados.")
                            false ->
                              DefaultResponser.init(device, phone, "No existe respuesta disponible para su ingreso.")
                              json(conn, "No existe respuesta disponible para su ingreso.")
                          end
                      end

                  end

              end

            tier == 2 ->

            selected_option = Repo.one(from l in "logs", where: l.virtual_assistant_id == ^va_id, select: l.selected_option )

            va_option_id = Enum.map(va_options, fn [id, identification, option] -> if [id, identification, option] == [id, Integer.to_string(selected_option), option], do: id end) |> Enum.filter( fn id -> id != nil end ) |> Enum.at(0)
            va_questions = Repo.all(from q in "virtuals_assistants_questions", where: q.virtual_assistant_option_id == ^va_option_id, select: [q.id, q.identification, q.question])
            #va_questions_ids = Enum.map(va_questions, fn [id, _identification, _question] -> "#{id}" end)

            if va_questions == nil or va_questions == [] do

            else

            questions_counter = Enum.count(va_questions)

            case String.match?(message, ~r/^[a-zA-Z]+$/) do
              true ->

              if Enum.member?(saludos, String.downcase(message)) do

                response = List.to_string([String.capitalize(message)]++[", recuerde que puede ingresar: 'comandos' para ver la lista de comandos."])

                DefaultResponser.init(device, phone, response)
                DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                json(conn, response)

              end

              if String.downcase(message) == "comandos" do

                choices = Enum.map(va_questions, fn [_id, identification, question] -> " [[#{identification}] #{question}] " end)
                go_back = " [[#{Enum.count(va_questions)+1}] [Atras]] "
                information = Enum.map(info_choices, fn info_choices -> " [#{info_choices}] " end)
                tier = Enum.map(tier_location_choices, fn tier_location_choices -> " [#{tier_location_choices}] " end)
                leaves = Enum.map(terminators, fn terminators -> " [#{terminators}] "  end)
                full_commands = "Responder a las preguntas: '#{choices}', Ir atras: '#{go_back}', Ver en que nivel se encuentra actualmente: '#{tier}', Informacion sobre este asistente: '#{information}', Terminar conversacion: '#{leaves}' "

                DefaultResponser.init(
                  device,
                  phone,
                  full_commands
                )

                DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                json(conn, full_commands)

              end

              if Enum.member?(info_choices, String.downcase(message)) do

                va = Repo.one(from v in "virtuals_assistants", where: v.id == ^va_id, select: [v.phone, v.name, v.description])
                response = "Nombre: #{Enum.at(va, 1)}, telefono asociado: #{Enum.at(va, 0)}, descripcion: #{Enum.at(va, 2)}."

                DefaultResponser.init(device, phone, response)
                DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                json(conn, response)

              end

              if Enum.member?(tier_location_choices, String.downcase(message)) do

                response = "Usted se encuentra en el nivel #{tier+1}, por favor, seleccione una pregunta en numerico (pre-configurada) para ser respondida."
                DefaultResponser.init(device, phone, response)
                DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                json(conn, response)

              end

              if Enum.member?(terminators, String.downcase(message)) do

                response = "#{String.capitalize(message)}, espero vuelva pronto."
                DefaultResponser.init(device, phone, response)

                DefaultOthersUpdater.reset_log_tier(log_id)
                DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                json(conn, response)

              end

              if String.downcase(message) == "atras" or message == "#{questions_counter+1}" do

                DefaultOthersUpdater.prepend_to_log_tier(log_id, tier)
                DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                DefaultResponser.init(device, phone, "Usted ha ido hacia atras 1 nivel, recuerde que puede ingresar 'comandos' para conocer los comandos que tiene disponibles por nivel.")

              end

              if Enum.member?((query = Repo.one(from o in VirtualAssistantOption, where: o.virtual_assistant_id == ^va_id, join: q in VirtualAssistantQuestion, on: q.virtual_assistant_option_id == o.id, join: a in VirtualAssistantAnswer, on: a.virtual_assistant_question_id == q.id, join: t in VirtualAssistantTag, on: t.virtual_assistant_question_id == q.id and t.tag in ^String.split(String.downcase(message)), select: [t.id, t.tag, a.id, a.answer, a.file, a.format])), message) do

                if Enum.at(query, 4) != "no-file" and Enum.at(query, 5) != "no-format" do
                  DefaultResponser.init(device, phone, Enum.at(query, 3), Enum.at(query, 4), Enum.at(query, 5))
                  json(conn, Enum.at(query, 3))
                else
                  DefaultResponser.init(device, phone, Enum.at(query, 3))
                  json(conn, Enum.at(query, 3))
                end
                DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

              else

                response = "Esta ingresando un parametro incorrecto, por favor, ingrese 'comandos' para saber como interactuar con el asistente."


                DefaultResponser.init(device, phone, response)
                DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                json(conn, response)

              end

              false ->

                case String.match?(message, ~r/^[0-9]+$/) do

                  true ->

                  case Integer.parse(message) do

                    {value, _} ->

                    if value > questions_counter do

                      DefaultResponser.init(device, phone, "Disculpe, se encuentra ingresando un parametro superior a las opciones configuradas para este nivel.")
                      DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                      DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                      json(conn, "Disculpe, se encuentra ingresando un parametro superior a las opciones configuradas para este nivel.")

                    end

                    if value == 0 do

                      DefaultResponser.init(device, phone, "Disculpe, se encuentra ingresando un parametro no admitido, el ingreso debe ser mayor que 1 y debe estar configurado en las opciones para este nivel.")
                      DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                      DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                      json(conn, "Disculpe, se encuentra ingresando un parametro no admitido, el ingreso debe ser mayor que 1 y debe estar configurado en las opciones para este nivel.")

                    end

                    if value > 0 and value <= questions_counter do

                      question_id = va_questions |> Enum.map(fn [id, identification, question] -> if [id, identification, question] == [id, message, question], do: id end) |> Enum.filter(fn id -> if id != nil, do: id end) |> Enum.at(0)
                      answer = Repo.one(from a in "virtuals_assistants_answers", where: a.virtual_assistant_question_id == ^question_id, select: [a.id, a.identification, a.answer, a.file, a.format])

                      if answer != nil do

                        if Enum.at(answer, 3) != "no-file" and Enum.at(answer, 4) != "no-format" do

                          DefaultResponser.init(device, phone, Enum.at(answer, 2), Enum.at(answer, 3), Enum.at(answer, 4))
                          DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                          DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                          json(conn, "La pregunta ha sido respondida.")

                        else

                          DefaultResponser.init(device, phone, Enum.at(answer, 2))
                          DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                          DefaultOthersUpdater.append_to_statistic_valid_messages(statistic_id)

                          json(conn, "La pregunta ha sido respondida.")

                        end

                      else

                        DefaultResponser.init(device, phone, "Por favor, configure correctamente sus respuestas e intente nuevamente.")
                        DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                        DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                        json(conn, "Por favor, configure correctamente sus respuestas e intente nuevamente.")

                      end

                    end

                    :error ->
                    DefaultResponser.init(device, phone, "Ingreso no invalido, por favor, intente nuevamente ingresando un parametro valido.")
                    DefaultOthersUpdater.append_to_statistic_accepted_messages(statistic_id)
                    DefaultOthersUpdater.append_to_statistic_invalid_messages(statistic_id)

                    json(conn, "Ingreso no invalido, por favor, intente nuevamente ingresando un parametro valido.")

                  end

                  false ->

                  splitted = String.replace(message, ~r"[,.~!@#$%^&*()-+=`;:_'-?/<>]", "") |> String.split()

                  case splitted != nil do
                    true ->
                      query = Repo.all(from o in VirtualAssistantOption, where: o.virtual_assistant_id == ^va_id,
                        join: q in VirtualAssistantQuestion, on: q.virtual_assistant_option_id == o.id,
                        join: a in VirtualAssistantAnswer, on: a.virtual_assistant_question_id == q.id,
                        join: t in VirtualAssistantTag, on: t.virtual_assistant_question_id == q.id and t.tag in ^splitted, select: [t.id, t.tag, a.id, a.answer, a.file, a.format])
                      case query != nil do
                        true ->
                          DefaultIterator.iterate(query, device, phone)
                          json(conn, "Los mensajes han sido enviados.")
                        false ->
                          DefaultResponser.init(device, phone, "No existe respuesta disponible para su ingreso.")
                          json(conn, "No existe respuesta disponible para su ingreso.")
                      end
                  end
                end
              end
            end
          end
        end
      end
    else
      DefaultResponser.init(device, phone, "Usted no ha creado y configurado correctamente un asistente, por favor, configure adecuadamente su asistente e intente nuevamente.")
      json(conn, "Usted no ha creado y configurado correctamente un asistente, por favor, configure adecuadamente su asistente e intente nuevamente.")
    end
  end
end
