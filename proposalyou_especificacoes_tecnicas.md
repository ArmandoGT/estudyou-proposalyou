# ProposalYou — Especificações Técnicas

**App Flutter · Gerador de propostas e contratos com assinatura digital**

---

## Sumário

1. [Sumário de Telas](#sumário-de-telas)
2. [Módulos do Sistema](#módulos-do-sistema)
3. [Arquitetura Técnica](#arquitetura-técnica)
4. [Fluxo de Dados](#fluxo-de-dados)

---

## Sumário de Telas

### 01 · Splash / Onboarding
**Rota:** `/splash`  
**Categoria:** Navegação

**Widgets e componentes:**
- SplashScreen com logo da empresa selecionada
- Onboarding 3 slides (swipeable PageView)
- Botão "Começar" → Login

**Estados de tela:** Primeiro acesso: onboarding completo · Acesso recorrente: direto ao login

**Navegação:** Nenhuma (tela raiz)

---

### 02 · Login / Autenticação
**Rota:** `/login`  
**Categoria:** Autenticação

**Widgets e componentes:**
- Seletor de empresa (Estudyou / Protseg / Protuni)
- Campo email + senha
- Botão login com loading state
- Link "Esqueci minha senha" → bottom sheet
- Login biométrico (local_auth) após primeiro acesso

**Estados de tela:** Idle · Loading · Erro (credenciais inválidas) · Sucesso → redirect por role

**Navegação:** → Home (sucesso) | → Recuperar senha (link)

---

### 03 · Home / Dashboard
**Rota:** `/home`  
**Categoria:** Principal

**Widgets e componentes:**
- AppBar com logo da empresa ativa + avatar usuário
- Cards de métricas: Propostas pendentes, Contratos ativos, Aguardando assinatura
- Ações rápidas: Nova Proposta, Novo Contrato, Novo Cliente
- Lista "Recentes" (propostas + contratos misturados)
- BottomNavigationBar: Home | Clientes | Propostas | Contratos | Menu

**Estados de tela:** Loading skeleton · Dados carregados · Empty state (nenhuma atividade ainda)

**Navegação:** BottomNav para todos os módulos

---

### 04 · Clientes — Lista
**Rota:** `/clients`  
**Categoria:** Clientes

**Widgets e componentes:**
- SearchBar com debounce 300ms
- Filtros chip: Todos | PF | PJ
- ListView com cards: nome, CPF/CNPJ, último contato
- FAB: + Novo cliente
- Swipe-to-action: Editar | Arquivar

**Estados de tela:** Loading · Lista populada · Sem resultados (pesquisa vazia) · Empty state geral

**Navegação:** → Detalhe do cliente (tap) | → Novo cliente (FAB)

---

### 05 · Clientes — Detalhe / Edição
**Rota:** `/clients/:id`  
**Categoria:** Clientes

**Widgets e componentes:**
- Form unificado PF/PJ com toggle
- Campos: nome, CPF/CNPJ (com máscara), email, telefone, endereço (CEP auto-preenchimento via ViaCEP)
- Histórico de propostas e contratos vinculados (ScrollableList)
- Botão "Criar proposta para este cliente"
- Validação inline em tempo real

**Estados de tela:** Modo visualização · Modo edição · Salvando (loading) · Erro de validação

**Navegação:** ← Voltar | → Proposta relacionada (tap)

---

### 06 · Prestadores — Lista e Seleção
**Rota:** `/providers`  
**Categoria:** Prestadores

**Widgets e componentes:**
- 3 cards fixos: Estudyou | Protseg | Protuni
- Indicador "empresa ativa" (border colorido)
- Dados resumidos: CNPJ, logo, cor da marca
- Botão "Editar dados" por empresa

**Estados de tela:** Normal · Empresa ativa destacada

**Navegação:** → Editar prestador (tap)

---

### 07 · Prestadores — Edição
**Rota:** `/providers/:id/edit`  
**Categoria:** Prestadores

**Widgets e componentes:**
- Upload de logo (image_picker + compressão)
- Campos: razão social, CNPJ, endereço, responsável, email, assinatura padrão
- Preview do rodapé do documento em tempo real
- Cor da marca (ColorPicker simples)

**Estados de tela:** Carregando dados · Editando · Salvando

**Navegação:** ← Voltar para lista

---

### 08 · Produtos/Serviços — Lista
**Rota:** `/products`  
**Categoria:** Catálogo

**Widgets e componentes:**
- Filtros: Todos | Produtos | Serviços | Por empresa
- Cards com nome, preço, tipo, empresa vinculada
- FAB: + Novo item
- Busca por nome

**Estados de tela:** Loading · Lista · Vazio

**Navegação:** → Detalhe (tap) | → Novo (FAB)

---

### 09 · Produtos/Serviços — Detalhe/Edição
**Rota:** `/products/:id`  
**Categoria:** Catálogo

**Widgets e componentes:**
- Campos: nome, descrição, preço (com formatação BRL), tipo, unidade, empresa vinculada
- Toggle ativo/inativo
- Preview do item no formato de linha de proposta

**Estados de tela:** Visualização · Edição · Novo item

**Navegação:** ← Voltar

---

### 10 · Modelos de Proposta — Lista
**Rota:** `/proposal-templates`  
**Categoria:** Propostas

**Widgets e componentes:**
- Lista por empresa com grouping visual
- Preview thumbnail de cada modelo
- Badge com número de propostas geradas
- FAB: + Novo modelo
- Botão duplicar modelo

**Estados de tela:** Loading · Lista agrupada · Vazio

**Navegação:** → Editor de modelo (tap) | → Novo modelo (FAB)

---

### 11 · Modelos de Proposta — Editor
**Rota:** `/proposal-templates/:id/edit`  
**Categoria:** Propostas

**Widgets e componentes:**
- Editor rich text (flutter_quill) para corpo do modelo
- Variáveis dinâmicas inseríveis: `{{cliente_nome}}`, `{{data}}`, `{{validade}}`, `{{itens}}`, `{{total}}`
- Preview em tempo real (WebView renderizando HTML)
- Configurações: empresa vinculada, tema de cores, layout (header/footer)
- Botão "Salvar" + "Pré-visualizar como PDF"

**Estados de tela:** Editando · Preview · Salvando

**Navegação:** ← Voltar | → Preview PDF

---

### 12 · Gerador de Proposta — Passo 1: Dados
**Rota:** `/proposals/new/step1`  
**Categoria:** Propostas

**Widgets e componentes:**
- Stepper indicador de progresso (3 etapas)
- Seleção de cliente (SearchableDropdown com criar novo inline)
- Seleção de prestador (empresa)
- Seleção de modelo de proposta
- Data de validade (DatePicker)

**Estados de tela:** Formulário vazio · Preenchendo · Validação

**Navegação:** → Passo 2 | ← Cancelar

---

### 13 · Gerador de Proposta — Passo 2: Itens
**Rota:** `/proposals/new/step2`  
**Categoria:** Propostas

**Widgets e componentes:**
- Buscador de produtos/serviços do catálogo
- Lista de itens adicionados com quantidade e preço editáveis
- Subtotal em tempo real
- Campo de desconto (% ou R$)
- Total final destacado
- Campo de observações livres

**Estados de tela:** Lista vazia · Itens adicionados · Calculando total

**Navegação:** → Passo 3 | ← Passo 1

---

### 14 · Gerador de Proposta — Passo 3: Preview e Envio
**Rota:** `/proposals/new/step3`  
**Categoria:** Propostas

**Widgets e componentes:**
- Preview PDF embutido (flutter_pdfview)
- Botão "Compartilhar via WhatsApp" (share_plus com link)
- Botão "Copiar link" (link de visualização web)
- Botão "Salvar como PDF" (download local)
- Botão "Gerar Contrato a partir desta proposta"
- Status badge: Rascunho | Enviada | Aprovada | Recusada

**Estados de tela:** Gerando PDF (loading) · PDF pronto · Compartilhando

**Navegação:** → Gerador de contrato | → Lista de propostas

---

### 15 · Propostas — Lista e Histórico
**Rota:** `/proposals`  
**Categoria:** Propostas

**Widgets e componentes:**
- Filtros por status: Todas | Rascunho | Enviada | Aprovada | Recusada | Expirada
- Filtro por empresa (chip multi-select)
- Cards com cliente, valor total, data de validade, status colorido
- Busca por cliente ou número
- Pull-to-refresh

**Estados de tela:** Loading · Lista · Filtrada · Vazia

**Navegação:** → Detalhe da proposta (tap) | → Nova proposta (FAB)

---

### 16 · Modelos de Contrato — Lista e Editor
**Rota:** `/contract-templates`  
**Categoria:** Contratos

**Widgets e componentes:**
- Idêntico à estrutura de modelos de proposta
- Variáveis adicionais: `{{assinatura_cliente}}`, `{{assinatura_prestador}}`, `{{data_assinatura}}`
- Campo de cláusulas com numeração automática
- Versioning simples (v1, v2, v3)

**Estados de tela:** Lista · Editando · Preview

**Navegação:** → Editor (tap) | → Novo (FAB)

---

### 17 · Gerador de Contrato — Passos 1 a 3
**Rota:** `/contracts/new`  
**Categoria:** Contratos

**Widgets e componentes:**
- Passo 1: Dados (cliente, empresa, modelo, vigência início/fim)
- Passo 2: Revisão e edição do texto final (campos substituídos, editáveis)
- Passo 3: Preview PDF + compartilhamento (igual ao da proposta)
- Vincular à proposta existente (opcional)

**Estados de tela:** 3 passos com validação progressiva

**Navegação:** → Assinatura | → Lista de contratos

---

### 18 · Contratos — Lista e Detalhe
**Rota:** `/contracts`  
**Categoria:** Contratos

**Widgets e componentes:**
- Filtros: Todos | Aguardando assinatura | Assinado | Vencido | Cancelado
- Cards com cliente, empresa, datas de vigência, status de assinatura (badges por signatário)
- Barra de progresso de assinaturas (ex: 1/2 assinados)

**Estados de tela:** Loading · Lista · Filtrada

**Navegação:** → Detalhe / assinatura (tap)

---

### 19 · Assinatura Digital — Tela do Signatário
**Rota:** `/sign/:token`  
**Categoria:** Assinaturas

**Widgets e componentes:**
- Tela acessível por link (sem login obrigatório)
- Exibição do contrato completo para leitura
- Checkbox "Li e concordo com o contrato"
- Campo nome completo do signatário
- Pad de assinatura canvas (touch e mouse)
- Botão limpar assinatura
- Botão "Assinar" com confirmação modal
- Timestamp, IP e geolocalização registrados

**Estados de tela:** Carregando contrato · Lendo · Assinando · Sucesso · Já assinado (bloqueado) · Token inválido/expirado

**Navegação:** Tela standalone (acessada via link externo)

---

### 20 · Documento Assinado — Certificado
**Rota:** `/contracts/:id/certificate`  
**Categoria:** Assinaturas

**Widgets e componentes:**
- PDF final com todas as assinaturas inseridas visualmente
- Hash de verificação do documento
- Dados dos signatários (nome, data, IP, geolocalização)
- Botão baixar PDF final
- Botão compartilhar link de verificação

**Estados de tela:** Gerando PDF com assinaturas · Pronto

**Navegação:** ← Voltar ao contrato

---

### 21 · Configurações e Perfil
**Rota:** `/settings`  
**Categoria:** Configurações

**Widgets e componentes:**
- Dados do usuário logado + troca de senha
- Empresa padrão ativa (toggle entre as 3)
- Notificações push: propostas expiradas, contratos aguardando assinatura
- Tema: claro / escuro / sistema
- Sobre o app + versão
- Logout

**Estados de tela:** Normal · Editando

**Navegação:** ← Voltar ao home

---

## Módulos do Sistema

### Auth & Multi-empresa
**Categoria:** Autenticação

Supabase Auth com JWT. Cada usuário tem um `provider_id` vinculado. RLS (Row Level Security) garante que cada empresa só veja seus dados. Troca de empresa ativa sem relogin.

**Packages e dependências:**
- `supabase_flutter`
- `flutter_secure_storage` (JWT)
- `local_auth` (biometria)
- Row Level Security por `provider_id`

---

### Cadastro de Clientes
**Categoria:** Clientes

Cadastro unificado PF/PJ. Integração com ViaCEP para autopreenchimento de endereço. Busca com FTS (Full Text Search) do PostgreSQL.

**Packages e dependências:**
- Máscara CPF/CNPJ (`mask_text_input_formatter`)
- ViaCEP via `http` package
- Supabase Realtime sync
- Soft delete (arquivar)

---

### Geração de PDF
**Categoria:** Documentos

PDFs gerados no dispositivo via package `pdf` (dart). Modelos definidos em JSON/HTML, variáveis substituídas em runtime. Armazenamento no Supabase Storage.

**Packages e dependências:**
- `pdf` + `printing` packages
- WebView para preview HTML
- `flutter_pdfview` para visualização
- Supabase Storage para arquivos

---

### Assinatura Digital
**Categoria:** Assinaturas

Signatários acessam via link público (token único). Assinatura desenhada em canvas, salva como PNG base64. Registro de IP, timestamp e geolocalização. Hash SHA-256 do documento final.

**Packages e dependências:**
- `syncfusion_flutter_signaturepad`
- `geolocator` package
- `crypto` package (SHA-256)
- Link público sem login via `share_token`

---

### Share & Links
**Categoria:** Compartilhamento

Propostas e contratos compartilhados via `share_plus`. Link de visualização web aponta para uma tela Flutter Web ou página Next.js que renderiza o documento.

**Packages e dependências:**
- `share_plus` (WhatsApp, email, copiar link)
- `url_launcher`
- Dynamic Links (deep linking)
- QR Code opcional (`qr_flutter`)

---

### Offline First
**Categoria:** Offline

Drift (SQLite) mantém cache local de clientes, produtos e rascunhos. Sync automático ao reconectar via Supabase Realtime. Conflitos resolvidos por timestamp `updated_at`.

**Packages e dependências:**
- `drift` (SQLite ORM)
- `connectivity_plus`
- Supabase Realtime subscriptions
- Optimistic updates na UI

---

## Arquitetura Técnica

### Stack Tecnológico

| Camada | Tecnologia | Detalhes |
|---|---|---|
| Framework | Flutter 3.x | Dart 3.x · null safety |
| State management | Riverpod 2.x | AsyncNotifier + Provider |
| Backend | Supabase | PostgreSQL + Auth + Storage |
| Roteamento | GoRouter | Deep links + guards |
| PDF | pdf (dart) | Geração + printing |
| Assinatura | syncfusion_flutter_signaturepad | Canvas nativo |
| Compartilhamento | share_plus | WhatsApp / link / email |
| Armazenamento local | drift (SQLite) | Offline-first |

---

### Estrutura de Pastas

```
lib/
├── features/
│   ├── auth/
│   ├── clients/
│   ├── providers/
│   ├── products/
│   ├── proposals/
│   ├── contracts/
│   └── signatures/
├── shared/
│   ├── widgets/
│   ├── theme/
│   ├── constants/
│   └── extensions/
├── core/
│   ├── router/
│   ├── services/
│   │   ├── pdf_service.dart
│   │   ├── share_service.dart
│   │   └── auth_service.dart
│   └── error/
└── data/
    ├── repositories/
    ├── dtos/
    ├── supabase/
    └── drift/

assets/
└── templates/       ← Modelos HTML/JSON de propostas e contratos
```

---

### Modelo de Dados Principal

| Tabela | Campos chave | Relações |
|---|---|---|
| `clients` | id, nome, cpf_cnpj, email, telefone, endereco | N:N com propostas e contratos |
| `providers` | id, empresa (enum), razao_social, cnpj, logo_url | 1:N com propostas e contratos |
| `products` | id, nome, descricao, preco, tipo (produto/serviço), provider_id | N:N com itens de proposta |
| `proposal_templates` | id, nome, corpo_json, provider_id, ativo | 1:N com propostas |
| `proposals` | id, template_id, client_id, provider_id, status, validade, itens_json, total, share_token | 1:1 com contrato (opcional) |
| `contract_templates` | id, nome, corpo_json, provider_id, versao | 1:N com contratos |
| `contracts` | id, proposal_id, template_id, client_id, provider_id, status, texto_final, share_token | 1:N com signatures |
| `signatures` | id, contract_id, signatario_nome, signatario_email, imagem_base64, ip, signed_at | N:1 com contracts |

---

## Fluxo de Dados

### Fluxo Principal: Proposta → Contrato → Assinatura

**Passo 1 — Cadastrar cliente e prestador**
Dados ficam no Supabase com RLS por `provider_id`. Offline: drift cache local.

**Passo 2 — Criar / selecionar modelo de proposta**
JSON do modelo armazenado no Supabase. Variáveis: `{{cliente_nome}}`, `{{itens}}`, `{{total}}`, etc.

**Passo 3 — Gerar proposta (stepper 3 etapas)**
Itens adicionados do catálogo. Cálculo local em tempo real. Salvo como `proposals` row.

**Passo 4 — Gerar PDF e compartilhar**
`pdf` package gera arquivo localmente. `share_plus` envia por WhatsApp. `share_token` permite link público.

**Passo 5 — Converter proposta em contrato**
`proposal_id` linkado ao novo `contracts` row. Modelo de contrato pré-selecionado por empresa.

**Passo 6 — Enviar link de assinatura**
Token único gerado (UUID v4). Link `/sign/:token` acessível sem login. Enviado por WhatsApp ou email.

**Passo 7 — Signatário assina no dispositivo**
Canvas touch/mouse. Nome, IP, geo e timestamp gravados. Imagem PNG base64 salva em `signatures` table.

**Passo 8 — PDF final com certificado**
Assinaturas inseridas visualmente no PDF. Hash SHA-256 gerado. Documento armazenado no Supabase Storage.

---

## Empresas Suportadas (Multi-tenant)

| Empresa | Slug | Observação |
|---|---|---|
| Estudyou | `estudyou` | Empresa principal da plataforma |
| Protseg | `protseg` | Segurança do trabalho |
| Protuni | `protuni` | Proteção / uniformes |

Cada empresa possui seus próprios modelos de proposta/contrato, logo, cor de marca e assinatura padrão. O isolamento de dados é garantido via Row Level Security (RLS) no Supabase, filtrando por `provider_id` em todas as tabelas.

---

*Documento gerado para o projeto ProposalYou — estud.you · versão 1.0*
