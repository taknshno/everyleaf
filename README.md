## Model

#### User

| Field           | Type      |
|-----------------|-----------|
| id              | Integer   |
| user_name       | String    |
| email           | String    |
| password_digest | String    |
| created_at      | DataTime  |
| updated_at      | DataTime  |


#### Task

| Field       | Type      |
|-------------|-----------|
| id          | Integer   |
| user_id     | Integer   |
| task_name   | String    |
| task_detail | Text      |
| status      | Integer   |
| priority    | Integer   |
| end_date    | Date      |
| created_at  | DateTime  |
| updated_at  | DateTime  |

#### Label

| Field       | Type      |
|-------------|-----------|
| id          | Integer   |
| label_name  | String    |
| created_at  | DataTime  |
| updated_at  | DataTime  |

#### Task_Label

| Field       | Type      |
|-------------|-----------|
| id          | Integer   |
| task_id     | Integer   |
| label_id    | Integer   |
| created_at  | DataTime  |
| updated_at  | DataTime  |