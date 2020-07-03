defmodule ChatbotWeb.DefaultResponser do

  @spec responser(any, any) :: %{
          broadcast: <<_::72>>,
          contacts: [%{name: <<_::48>>, phone: <<_::48>>}, ...],
          deliverAt: <<_::8, _::_*8>>,
          device: <<_::192>>,
          enqueue: <<_::40>>,
          expiration: %{date: <<_::8, _::_*8>>, duration: <<_::40>>, seconds: 5},
          group: <<_::48>>,
          location: %{address: <<_::48>>, coordinates: [-90, ...]},
          media: %{file: <<_::192>>, format: <<_::24>>, message: <<_::48>>},
          message: any,
          phone: any,
          previewUrl: true,
          priority: <<_::48>>,
          reference: <<_::48>>,
          retentionPolicy: <<_::104>>,
          retries: 0,
          retryWait: 0,
          schedule: %{date: <<_::8, _::_*8>>, delay: 1, delayTo: <<_::40>>},
          sendReadAck: true
        }
  def responser(phone, message) do
    %{
      message: message,
      reference: "string",
      device: "stringstringstringstring",
      priority: "normal",
      phone: phone,
      group: "string",
      broadcast: "stringstr",
      contacts: [
        %{
          phone: "string",
          name: "string"
        }
      ],
      retentionPolicy: "plan_defaults",
      enqueue: "never",
      retries: 0,
      retryWait: 0,
      previewUrl: true,
      media: %{
        file: "stringstringstringstring",
        format: "gif",
        message: "string"
      },
      location: %{
        address: "string",
        coordinates: [
          -90,
          -90
        ]
      },
      sendReadAck: true,
      deliverAt: DateTime.utc_now() |> DateTime.to_iso8601(),
      expiration: %{
        seconds: 5,
        duration: "strin",
        date: DateTime.utc_now() |> DateTime.to_iso8601()
      },
      schedule: %{
        delay: 1,
        delayTo: "strin",
        date: DateTime.utc_now() |> DateTime.to_iso8601()
      }
    }
  end

  def responser(phone, file, format, message) do
    %{
      message: "string",
      reference: "string",
      device: "stringstringstringstring",
      priority: "normal",
      phone: phone,
      group: "string",
      broadcast: "stringstr",
      contacts: [
        %{
          phone: "string",
          name: "string"
        }
      ],
      retentionPolicy: "plan_defaults",
      enqueue: "never",
      retries: 0,
      retryWait: 0,
      previewUrl: true,
      media: %{
        file: file,
        format: format,
        message: message
      },
      location: %{
        address: "string",
        coordinates: [
          -90,
          -90
        ]
      },
      sendReadAck: true,
      deliverAt: DateTime.utc_now() |> DateTime.to_iso8601(),
      expiration: %{
        seconds: 5,
        duration: "strin",
        date: DateTime.utc_now() |> DateTime.to_iso8601()
      },
      schedule: %{
        delay: 1,
        delayTo: "strin",
        date: DateTime.utc_now() |> DateTime.to_iso8601()
      }
    }
  end

end
