# Rent a coder API

Rent a coder API was developed as a final project of Software Engineering III course.
You can found it at https://rent-a-coder-api.herokuapp.com/

## Routes

| Action | Method | Path | Request body (code) | Request header (code) |
| ------ | ------ | -----| ------------------- | ------------------- |
| Sign up | POST | /auth | B02 | H00 |
| Sign in | POST | /auth/sign_in | B01 | H00 |
| Sign out | DELETE | /auth/sign_out | B00 | H01 |
| My profile | GET | /profile | B00 | H01 |
| Create project | POST | /projects | B03 | H01 |
| Update project | PATCH | /projects/:id | B03 | H01 |
| Projects to bid | GET | /projects | B00 | H01 |
| Create offer | POST | /offers | B04 | H01 |
| Project's candidates | GET | /candidates/:project_id | B00 | H01 |
| Candidate's profile | GET | /users/:id | B00 | H01 |
| Select project developer | POST | /projects/:project_id/developer | B05 | H01 |
| Set developer score | POST | /projects/:project_id/developer_score | B06 | H01 |
| Set owner score | POST | /projects/:project_id/owner_score | B06 | H01 |

## Request body

| Code | Properties |
| ---- | ---------- |
| B00 | none |
| B01 | email, password |
| B02 | email, password, password_confirmation, name, city, country, tel, web, nickname|
| B03 | name, description, deadline, technologies_ids |
| B04 | cost, estimated_time, project_id |
| B05 | developer_id |
| B06 | score |

## Request header

| Code | Properties |
| ---- | ---------- |
| H00 | none |
| H01 | access-token, uid, client |
