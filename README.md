# README

```markdown
## Local Setup

### Prerequisites
- Ruby (version 3.2.2)
- Bundler
- MySQL
- Node.js and Yarn (for JavaScript dependencies)
```

### Steps
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```

2. Install Ruby dependencies:
   ```bash
   bundle install
   ```

3. Install JavaScript dependencies:
   ```bash
   yarn install
   ```

4. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```
   
5. Running tests:
   ```bash
   rake test
   ```

5. Start the Rails server:
   ```bash
   rails server
   ```

6. Open the application in your browser:
   ```
   http://localhost:3000
   ```
