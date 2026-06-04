# Nosso Orçamento — instalação só com GitHub + Supabase

Sem Vercel, sem terminal, sem build. Você sobe os arquivos pelo navegador,
o GitHub Pages publica, e o Supabase guarda os dados sincronizados entre os
2 celulares.

São só 2 serviços, ambos gratuitos:
- **Supabase** — o banco de dados (a sincronização)
- **GitHub** — guarda o código E publica o app (via GitHub Pages)

Tempo estimado: 25 a 35 minutos.

> Importante: a sincronização entre os celulares **só funciona depois** que você
> preencher as credenciais do Supabase (Parte 1 e Parte 2). Antes disso, o app
> abre numa tela avisando que falta configurar.

---

## Parte 1 — Supabase (o banco de dados)

1. Acesse https://supabase.com e crie uma conta (pode entrar com o GitHub).
2. Clique em **New project**. Dê um nome (ex.: `orcamento`), crie uma senha forte
   para o banco (guarde-a) e escolha a região mais próxima (ex.: São Paulo).
3. Espere ~2 minutos até ficar pronto.
4. Menu lateral → **SQL Editor** → **New query**.
5. Abra o arquivo `supabase-setup.sql` deste projeto, copie todo o conteúdo,
   cole no editor e clique em **Run**. Deve aparecer "Success".
6. Pegue as credenciais: menu lateral → **Project Settings** (engrenagem) →
   **API**. Copie dois valores e deixe à mão:
   - **Project URL** (ex.: `https://xxxx.supabase.co`)
   - **anon public** key (uma chave longa)

---

## Parte 2 — Colar as credenciais no arquivo

Antes de subir pro GitHub, você precisa editar **uma única vez** o arquivo
`index.html` para colocar suas credenciais.

1. Abra o `index.html` num editor de texto simples (Bloco de Notas, TextEdit, ou
   até direto no GitHub depois de subir — explico abaixo).
2. Logo no comecinho do script, procure este trecho:

   ```js
   const CONFIG = {
     SUPABASE_URL: "COLE_AQUI_A_PROJECT_URL",
     SUPABASE_ANON_KEY: "COLE_AQUI_A_CHAVE_ANON",
   };
   ```
3. Troque os dois textos pelos valores que você copiou no passo 6 da Parte 1.
   Mantenha as aspas. Exemplo:

   ```js
   const CONFIG = {
     SUPABASE_URL: "https://abcdefg.supabase.co",
     SUPABASE_ANON_KEY: "eyJhbGciOi......sua-chave-longa",
   };
   ```
4. Salve o arquivo.

> A chave "anon public" é feita para ficar visível no app — isso é normal e seguro.
> Quem protege seus dados são as regras (policies) que o SQL já criou no banco.

---

## Parte 3 — GitHub (subir e publicar)

1. Acesse https://github.com e crie uma conta, se ainda não tiver.
2. Clique em **New** para criar um repositório. Nome: `nosso-orcamento`.
   Pode deixar **Public** (necessário para o GitHub Pages gratuito) — não tem
   problema, pois ninguém terá motivo para procurar seu app, e os dados ficam no
   Supabase protegidos pelas policies. Clique em **Create repository**.
3. Na página do repositório vazio, clique em **uploading an existing file**.
4. Arraste para a área de upload TODOS estes arquivos:
   - `index.html`
   - `manifest.webmanifest`
   - `icon-192.png`
   - `icon-512.png`
   (o `supabase-setup.sql` você já usou; pode subir junto, não atrapalha)
5. Clique em **Commit changes**.

> Se preferiu não editar o `index.html` antes de subir: depois do upload, clique
> no arquivo `index.html` no GitHub, no ícone de lápis (Edit), faça a troca das
> credenciais da Parte 2 ali mesmo e clique em **Commit changes**.

### Ativar o GitHub Pages
6. No repositório, vá em **Settings** (aba no topo) → **Pages** (menu à esquerda).
7. Em **Source**, escolha **Deploy from a branch**.
8. Em **Branch**, selecione **main** e a pasta **/ (root)**. Clique em **Save**.
9. Espere 1 a 2 minutos. A própria página vai mostrar o link, algo como:
   `https://SEU-USUARIO.github.io/nosso-orcamento/`
10. Abra esse link no computador. O painel deve carregar com os dados de 2026.

> Se aparecer a tela "Quase lá", as credenciais não foram coladas (ou ficaram com
> o texto "COLE_AQUI"). Volte na Parte 2, corrija no `index.html` e dê commit.

---

## Parte 4 — Instalar nos 2 celulares (tela inicial, sem barra do navegador)

O app é um PWA. Abra o link do GitHub Pages no celular e:

**iPhone (Safari):**
1. Toque no botão compartilhar (quadrado com seta pra cima).
2. **Adicionar à Tela de Início**.

**Android (Chrome):**
1. Toque no menu (três pontinhos).
2. **Adicionar à tela inicial** / **Instalar aplicativo**.

Faça nos dois aparelhos. Ao abrir pelo ícone, ele abre em tela cheia, sem a barra
do navegador. Quando um lança uma despesa, o outro vê na hora (ou ao reabrir).

---

## Como usar no dia a dia

- **Painel**: saldo do mês, entradas, saídas, orçado vs. real por categoria.
- **Lançamentos**: toque no valor de qualquer item para editar; tem busca e filtros.
- **Botão laranja (+)**: novo lançamento por toques; a descrição pode ser escolhida
  entre as existentes ou digitada nova; toggle "repetir nos próximos meses".
- **Ajustes**: orçamentos por categoria, saldo inicial, restaurar dados de 2026.

---

## Dúvidas comuns

**Por que o repositório precisa ser público?**
O GitHub Pages gratuito publica a partir de repositórios públicos. O código fica
visível, mas isso não expõe seus dados — eles moram no Supabase, e a chave que
aparece no código é a "anon" (pública por design). Se quiser repositório privado
com Pages, o GitHub permite em planos pagos.

**Quero blindar de verdade.**
O próximo nível é adicionar login (Supabase Auth) e restringir as policies ao
usuário logado, para que só vocês dois consigam ler/gravar mesmo que alguém
descubra o link. Posso te ajudar com isso quando quiser.

**Mudei as credenciais e não atualizou.**
Depois de dar commit no GitHub, o Pages republica em ~1 minuto. No celular,
às vezes é preciso fechar e reabrir o app, ou limpar o cache do navegador.
