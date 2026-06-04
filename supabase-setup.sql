-- ============================================================
--  Configuração do banco no Supabase
--  Cole tudo isto no "SQL Editor" do Supabase e clique em RUN.
-- ============================================================

-- 1) Tabela que guarda todo o orçamento numa linha só (id = 'casa')
create table if not exists public.orcamento (
  id text primary key,
  payload jsonb not null,
  updated_at timestamptz default now()
);

-- 2) Liga a segurança em nível de linha
alter table public.orcamento enable row level security;

-- 3) Permite que o app (chave anon) leia e escreva nessa tabela.
--    Como é um app privado de uso pessoal (só vocês têm o link e a chave),
--    liberamos leitura/escrita pública nesta única tabela.
drop policy if exists "orcamento_select" on public.orcamento;
drop policy if exists "orcamento_insert" on public.orcamento;
drop policy if exists "orcamento_update" on public.orcamento;

create policy "orcamento_select" on public.orcamento
  for select using (true);

create policy "orcamento_insert" on public.orcamento
  for insert with check (true);

create policy "orcamento_update" on public.orcamento
  for update using (true) with check (true);

-- 4) Habilita o "realtime" para os 2 celulares verem mudanças na hora
alter publication supabase_realtime add table public.orcamento;
