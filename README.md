# Django DRF PostgreSQL Docker Example

## Usage

1. Build and start the containers:

   docker-compose up --build

2. Once running, open a new terminal and run migrations:

   docker-compose exec web python manage.py migrate

3. (Optional) Create a superuser:

   docker-compose exec web python manage.py createsuperuser

4. Access the API at http://localhost:8000/api/items/

---

- The database data is persisted in a Docker volume.
- The Django server reloads on code changes (mounted volume).
