alias Chatbot.Repo
alias Chatbot.CMS.{VirtualAssistant, VirtualAssistantAnswer, VirtualAssistantOption, VirtualAssistantQuestion, VirtualAssistantTag}
alias Chatbot.Users.User

Repo.insert!(%User{id: 1, first_name: "First Name", last_name: "Last Name", email: "ExampleEmail@gmail.com", password: "12345678", user_plan: "lite", is_active: true, is_admin: true})
Repo.insert!(%User{id: 2, first_name: "First Name1", last_name: "Last Name1", email: "ExampleEmail1@gmail.com", password: "12345678", user_plan: "basic", is_active: true, is_admin: false})
Repo.insert!(%User{id: 3, first_name: "First Name2", last_name: "Last Name2", email: "ExampleEmail2@gmail.com", password: "12345678", user_plan: "lite", is_active: true, is_admin: false})
Repo.insert!(%User{id: 4, first_name: "First Name3", last_name: "Last Name3", email: "ExampleEmail3@gmail.com", password: "12345678", user_plan: "basic", is_active: true, is_admin: false})
Repo.insert!(%User{id: 5, first_name: "First Name4", last_name: "Last Name4", email: "ExampleEmail4@gmail.com", password: "12345678", user_plan: "basic", is_active: true, is_admin: false})


Repo.insert!(%VirtualAssistant{id: 1, user_id: 1 ,name: "Tio-PullMan", phone: "01234567891011", description: "Asistente de GestSol"})

  Repo.insert!(%VirtualAssistantOption{id: 1, identification: "1", option: "option1", virtual_assistant_id: 1})

    Repo.insert!(%VirtualAssistantQuestion{id: 1, identification: "1", question: "question1", virtual_assistant_option_id: 1})

      Repo.insert!(%VirtualAssistantAnswer{id: 1, identification: "1", answer: "answer1", virtual_assistant_question_id: 1})
      Repo.insert!(%VirtualAssistantTag{id: 1, identification: "1", tag: "tag1", virtual_assistant_question_id: 1})
      Repo.insert!(%VirtualAssistantTag{id: 2, identification: "1", tag: "tag2", virtual_assistant_question_id: 1})

    Repo.insert!(%VirtualAssistantQuestion{id: 2, identification: "2", question: "question2", virtual_assistant_option_id: 1})

      Repo.insert!(%VirtualAssistantAnswer{id: 2, identification: "2", answer: "answer2", virtual_assistant_question_id: 2})
      Repo.insert!(%VirtualAssistantTag{id: 3, identification: "2", tag: "tag1", virtual_assistant_question_id: 2})

    Repo.insert!(%VirtualAssistantQuestion{id: 3, identification: "3", question: "question3", virtual_assistant_option_id: 1})

      Repo.insert!(%VirtualAssistantAnswer{id: 3, identification: "3", answer: "answer3", virtual_assistant_question_id: 3})
      Repo.insert!(%VirtualAssistantTag{id: 4, identification: "3", tag: "tag1", virtual_assistant_question_id: 3})


  Repo.insert!(%VirtualAssistantOption{id: 2, identification: "2", option: "option2", virtual_assistant_id: 1})

    Repo.insert!(%VirtualAssistantQuestion{id: 4, identification: "1", question: "question1", virtual_assistant_option_id: 2})

      Repo.insert!(%VirtualAssistantAnswer{id: 4, identification: "1", answer: "answer1", virtual_assistant_question_id: 4})
      Repo.insert!(%VirtualAssistantTag{id: 5, identification: "1", tag: "tag1", virtual_assistant_question_id: 4})

    Repo.insert!(%VirtualAssistantQuestion{id: 5, identification: "2", question: "question2", virtual_assistant_option_id: 2})

      Repo.insert!(%VirtualAssistantAnswer{id: 5, identification: "2", answer: "answer1", virtual_assistant_question_id: 5})
      Repo.insert!(%VirtualAssistantTag{id: 6, identification: "2", tag: "tag1", virtual_assistant_question_id: 5})

  Repo.insert!(%VirtualAssistantOption{id: 3, identification: "3", option: "option3", virtual_assistant_id: 1})

    Repo.insert!(%VirtualAssistantQuestion{id: 6, identification: "1", question: "question1", virtual_assistant_option_id: 3})

      Repo.insert!(%VirtualAssistantAnswer{id: 6, identification: "1", answer: "answer1", virtual_assistant_question_id: 6})
      Repo.insert!(%VirtualAssistantTag{id: 7, identification: "1", tag: "tag1", virtual_assistant_question_id: 6})

    Repo.insert!(%VirtualAssistantQuestion{id: 7, identification: "2", question: "question2", virtual_assistant_option_id: 3})

      Repo.insert!(%VirtualAssistantAnswer{id: 7, identification: "2", answer: "answer1", virtual_assistant_question_id: 6})
      Repo.insert!(%VirtualAssistantTag{id: 8, identification: "2", tag: "tag1", virtual_assistant_question_id: 6})

    Repo.insert!(%VirtualAssistantQuestion{id: 8, identification: "3", question: "question3", virtual_assistant_option_id: 3})

      Repo.insert!(%VirtualAssistantAnswer{id: 8, identification: "3", answer: "answer1", virtual_assistant_question_id: 6})
      Repo.insert!(%VirtualAssistantTag{id: 9, identification: "3", tag: "tag1", virtual_assistant_question_id: 6})

Repo.insert!(%VirtualAssistant{id: 2, name: "Asistente de Andrea", phone: "04249555585", description: "Asistente de tiendita", user_id: 1})


Repo.insert!(%VirtualAssistant{id: 3, name: "Asistente de Victor", phone: "04249555586", description: "Asistente de tienda", user_id: 1})
