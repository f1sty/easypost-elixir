defmodule Easypost.Order do
  alias Easypost.Helpers
  alias Easypost.Requester

  defstruct id: "",
            object: "Order",
            reference: "",
            mode: "",
            to_address: nil,
            from_address: nil,
            return_address: nil,
            buyer_address: nil,
            shipments: [],
            rates: [],
            messages: [],
            is_return: false,
            created_at: "",
            updated_at: ""

  @type t :: %__MODULE__{
          object: String.t(),
          reference: String.t(),
          mode: String.t(),
          to_address: Easypost.Address | nil,
          from_address: Easypost.Address | nil,
          return_address: Easypost.Address | nil,
          buyer_address: Easypost.Address | nil,
          shipments: list(Easypost.Shipment),
          rates: list(Easypost.Rate),
          messages: list,
          is_return: boolean,
          created_at: String.t(),
          updated_at: String.t()
        }

  @spec create_order(map, map) :: Easypost.Order.t()
  def create_order(conf, order) do
    body = Helpers.encode(%{"order" => order})
    ctype = 'application/x-www-form-urlencoded'

    case Requester.request(
           :post,
           Helpers.url(conf[:endpoint], "/orders"),
           conf[:key],
           [],
           ctype,
           body
         ) do
      {:ok, order} ->
        {:ok, struct(Easypost.Order, order)}

      {:error, _status, reason} ->
        {:error, struct(Easypost.Error, reason)}
    end
  end

  # @spec refund_usps_label(map, String.t()) :: Easypost.Refund.t()
  # def refund_usps_label(conf, order_id) do
  #   body = []
  #   ctype = 'application/x-www-form-urlencoded'

  #   case Requester.request(
  #          :get,
  #          Helpers.url(conf[:endpoint], "/orders/" <> order_id <> "/refund"),
  #          conf[:key],
  #          [],
  #          ctype,
  #          body
  #        ) do
  #     {:ok, refund} ->
  #       {:ok, struct(Easypost.Refund, refund)}

  #     {:error, _status, reason} ->
  #       {:error, struct(Easypost.Error, reason)}
  #   end
  # end

  # @spec insure_order(map, String.t(), map) :: Easypost.order().t()
  # def insure_order(conf, order_id, insurance) do
  #   body = Helpers.encode(insurance)
  #   ctype = 'application/x-www-form-urlencoded'

  #   case Requester.request(
  #          :post,
  #          Helpers.url(conf[:endpoint], "/orders/" <> order_id <> "/insure"),
  #          conf[:key],
  #          [],
  #          ctype,
  #          body
  #        ) do
  #     {:ok, order} ->
  #       {:ok, struct(Easypost.order(), order)}

  #     {:error, _status, reason} ->
  #       {:error, struct(Easypost.Error, reason)}
  #   end
  # end

  # @spec buy_order(map, String.t(), map) :: Easypost.order().t()
  # def buy_order(conf, order_id, rate) do
  #   body = Helpers.encode(%{"rate" => rate})
  #   ctype = 'application/x-www-form-urlencoded'

  #   case Requester.request(
  #          :post,
  #          Helpers.url(conf[:endpoint], "/orders/" <> order_id <> "/buy"),
  #          conf[:key],
  #          [],
  #          ctype,
  #          body
  #        ) do
  #     {:ok, order} ->
  #       {:ok, struct(Easypost.order(), order)}

  #     {:error, _status, reason} ->
  #       {:error, struct(Easypost.Error, reason)}
  #   end
  # end
end
