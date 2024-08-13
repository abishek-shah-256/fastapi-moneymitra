# README 
## MoneyMitra
Service handler for Money Mitra application

> _<b>Swagger UI</b>_ </br> 
> Available at:  <br>
> endpoint: [/mm/apidoc/swagger-ui.html](http://localhost:8080/mm/apidoc/swagger-ui.html) <br>


Code: [Abishek Shah](mailto:developabishek@gmail.com) <br>

&copy; **2023 Ideapreneur Nepal Pvt. Ltd.** All Rights Reserved. </br>
<img src="https://ideapreneurnepal.com/static/landing/img/logo.jpg" width="135" height="40"> <br>
<a href="https://ideapreneurnepal.com/">Site</a> &nbsp; |


## How to Run the Application

### 1. Create the `.env` File

Create a file named `.env` in the root directory of your project with the following content:

<pre>
DATABASE1_URL=postgresql://postgres:postgres123@moneymitra-postgres:5432/moneymitra1
DB1_DRIVER_NAME=postgresql
DB1_HOST=moneymitra-postgres
DB1_PORT=5432
DB1_USER=postgres
DB1_PASSWORD=postgres123
DB1_NAME=moneymitra1
</pre>

### 2. Create the 'tmp' directory in the root folder

Create the tmp folder to store the log files of the application

### 3. Run Docker Compose

Make sure you have Docker and Docker Compose installed on your system. Navigate to the directory containing your `docker-compose.yml` file and run:
```bash
docker-compose up

