# FizzBuzz

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`
  * Run the tests with`mix test`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

* In that page you can navigate through the numbers collection with their FizzBuzz values clicking on the "Next Page" and "Previous Page" links. 
* The pages size can be changed sumitting it on the input box at the bottom of the page. 
* You can also mark you favourite numbers using the "Mark as favourite" buttons. They will appear highlighted on your screen.

#Api

The following endoints are available in the JSON API:

* GET /api/numbers
    - This endpoint returns the collection of numbers from 1 to 100_000_000_000 paginated.
    - By defualt returns the collection paginated in pages of 100 elements
    - You can specify the page size and the current page passing them as parameters:
     ```json
        { 
          current_page: :current_page,
          page_size: page_size
        }
     ```
     - In the body of the response you will receive the number, the fizzbuzz value associated to it and if it is marked as favourite in the collection.
     Here you have an example:
      
      ```json
              { 
                entries: [
                { 
                    number: 3,
                    fizz_buzz_value: "Fizz",
                    favourite: false
                },...
              ],
              pagination: {
                    total_pages: 500_000_000,
                    current_page: 1,
                    total_entries:  100_000_000_000
              }
       ```
    - Returns 200 when success
    
 * POST /api/favourites
     - This endpoint allows you to store a number as you favourite in the collection.
     - It accepts only the number parameter on the body
     ```json
             { 
               number: :mumber
             }
     ```
     - Returns 200 when success
     - Returns 422 when number doesn't have a valid format
     
 * GET /api/favourites/:id
      - Allows you to retrieve the favourite number that you stored by id
      - The body that it returns is as follows
      ```json
              { 
                id: :id,
                number: :mumber
              }
      ```
      - Returns 200 when success
      - Returns 404 when id is not found