defmodule Elixvery.Orders.ReportTest do
  use ExUnit.Case

  import Elixvery.Factory

  alias Elixvery.Orders.Agent, as: OrderAgent
  alias Elixvery.Orders.Report

  # DISCLAIMER: OrderAgent.save is a async command and sometimes save in wronsg order
  describe "create/1" do
    setup do
      ensure_there_is_no_file =
        &assert File.exists?(&1) == false,
                """
                --- WARNING ---
                `#{&1}` already exists, test failing to avoid override it!
                """

      {:ok, ensure_there_is_no_file: ensure_there_is_no_file}
    end

    test "creates the report with default name", %{
      ensure_there_is_no_file: ensure_there_is_no_file
    } do
      file_path = "report.csv"

      orders = [
        build(:order),
        build(:order, user_cpf: "00987654321")
      ]

      expected_response1 = """
      00987654321,pizza,1,35.5,japonese_food,2,20.5,76.50
      12345678900,pizza,1,35.5,japonese_food,2,20.5,76.50
      """

      expected_response2 = """
      12345678900,pizza,1,35.5,japonese_food,2,20.5,76.50
      00987654321,pizza,1,35.5,japonese_food,2,20.5,76.50
      """

      ensure_there_is_no_file.(file_path)
      OrderAgent.start_link(nil)
      Enum.each(orders, &OrderAgent.save/1)
      Report.create()

      response = File.read!(file_path)
      File.rm!(file_path)
      assert response == expected_response1 or response == expected_response2
    end

    test "creates the report with custom path", %{
      ensure_there_is_no_file: ensure_there_is_no_file
    } do
      file_path = "test/report_test.csv"

      orders = [
        build(:order),
        build(:order, user_cpf: "00987654321")
      ]

      expected_response1 = """
      00987654321,pizza,1,35.5,japonese_food,2,20.5,76.50
      12345678900,pizza,1,35.5,japonese_food,2,20.5,76.50
      """

      expected_response2 = """
      12345678900,pizza,1,35.5,japonese_food,2,20.5,76.50
      00987654321,pizza,1,35.5,japonese_food,2,20.5,76.50
      """

      ensure_there_is_no_file.(file_path)
      OrderAgent.start_link(nil)
      Enum.each(orders, &OrderAgent.save/1)
      Report.create(file_path)

      response = File.read!(file_path)
      File.rm!(file_path)
      assert response == expected_response1 or response == expected_response2
    end
  end
end
