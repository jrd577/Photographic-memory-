# Recall Ladder

A memory trainer. Recall the list in order, and every perfect recall adds one more word, digit or letter.
Static site: `index.html` + `config.js`. No build step.

## Files
- `index.html` the whole app
- `config.js` Supabase URL and anon key (optional, leave empty to run offline)
- `supabase.sql` table and row-level security for synced progress

## 1. Push to GitHub
```bash
cd recall-ladder-web
git init -b main
git add .
git commit -m "Recall Ladder"
# with the GitHub CLI:
gh repo create recall-ladder --public --source=. --push
# or create an empty repo on github.com, then:
# git remote add origin https://github.com/<you>/recall-ladder.git
# git push -u origin main
```

## 2. Set up Supabase (stores progress, handles sign-in)
Supabase does not host websites. It is the database and login for the app.
1. Create a project at supabase.com.
2. SQL Editor > New query > paste `supabase.sql` > Run.
3. Project Settings > API: copy the **Project URL** and the **anon / publishable key**.
4. Paste them into `config.js`. The anon key is public by design. Never put the `service_role` key anywhere in this repo.
5. Commit and push the change.

## 3. Deploy on Vercel
1. vercel.com > Add New > Project > import the GitHub repo.
2. Framework Preset: **Other**. Leave build command and output directory empty. Deploy.
3. Copy your live URL (for example `https://recall-ladder.vercel.app`).

## 4. Tell Supabase your live URL (needed for email sign-in)
Authentication > URL Configuration:
- Site URL: your Vercel URL
- Redirect URLs: add your Vercel URL too

Sign-in uses an emailed magic link. Supabase's built-in email sender is rate limited, which is fine for testing.

## Notes
- Without `config.js` values the app still works fully, saving to the browser only.
- With them, a "Sign in to sync" link appears at the bottom. Progress then follows the user across devices.
- Each user can only read and write their own rows (row-level security).
