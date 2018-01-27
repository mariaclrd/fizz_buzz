defmodule FizzBuzz.Numbers.Pagination do
  def entries(collection, current_page \\ 1, page_size \\ 100) do
    first_item = (current_page - 1)*page_size
    collection |> Enum.slice(first_item, page_size)
  end


  def total_entries(collection) when is_map(collection)do
    _..last = collection
    last
  end

  def total_entries(collection) when is_list(collection)do
    length(collection)
  end

  def total_pages(collection, page_size \\ 100) do
    total_entries(collection)
    |> (Kernel./page_size)
    |> Float.ceil
    |> Kernel.trunc
  end
end