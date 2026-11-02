# Manish Sahu — Flutter Web Portfolio

A responsive, dark-themed Flutter Web portfolio starter with About, Skills, Experience, Projects and Contact sections. Hosting can be free with GitHub Pages.

## Step 1 — Install prerequisites

Install the Flutter SDK and Git, then verify:

```bash
flutter doctor
```

## Step 2 — Open this project

Extract this ZIP, open the `manish_flutter_portfolio` folder in VS Code, and run:

```bash
flutter pub get
flutter run -d chrome
```

## Step 3 — Personalize before publishing

Edit `lib/main.dart`:
- Replace `REPLACE_WITH_USERNAME` with your GitHub username.
- Replace `YOUR_EMAIL@example.com` with your professional email.
- Add a resume PDF and a link/button to it.
- Verify role titles, experience durations and project descriptions.
- Add only screenshots and details you are authorized to share.

The LinkedIn link is prefilled from the profile previously supplied.

## Step 4 — Test a production build

```bash
flutter build web --release
```

## Step 5 — Publish free on GitHub Pages

1. Create a **public** GitHub repository named `manish_flutter_portfolio` (or another name).
2. Push the contents of this folder to the repository's `main` branch.
3. The included `.github/workflows/deploy.yml` builds and deploys the site automatically.
4. In the repository, open **Settings → Pages** and set the source to **GitHub Actions**.
5. After the workflow succeeds, your website URL will be `https://YOUR_USERNAME.github.io/REPOSITORY_NAME/`.

No paid domain or hosting is required. GitHub Pages is suitable for a public portfolio repository.
