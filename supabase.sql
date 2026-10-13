-- Run once in Supabase: SQL Editor > New query > paste > Run.
create table if not exists public.user_docs (
  user_id    uuid        not null references auth.users (id) on delete cascade,
  doc_id     text        not null,
  data       jsonb       not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, doc_id)
);

alter table public.user_docs enable row level security;

create policy "read own rows"   on public.user_docs for select
  using ((select auth.uid()) = user_id);
create policy "insert own rows" on public.user_docs for insert
  with check ((select auth.uid()) = user_id);
create policy "update own rows" on public.user_docs for update
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "delete own rows" on public.user_docs for delete
  using ((select auth.uid()) = user_id);
