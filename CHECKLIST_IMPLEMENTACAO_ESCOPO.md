# Checklist de Implementação — ProposalYou

Objetivo: fechar o gap entre `proposalyou_especificacoes_tecnicas.md` e a implementação atual, seguindo ordem de maior impacto no produto.

## Regra de execução
- Implementar de cima para baixo.
- Não pular blocos críticos de fluxo.
- Ao concluir um item, marcar `[x]` e registrar os arquivos alterados.
- Validar rota, estado, UX e integração antes de avançar para o próximo bloco.

---

## Fase 1 — Fluxos críticos de negócio

### 1. Links públicos e assinatura digital
Impacto: Muito alto

- [x] Unificar padrão de links públicos
  - Arquivos alterados: `lib/core/router/app_router.dart`, `lib/core/services/share_service.dart`, `lib/features/contracts/presentation/contract_detail_screen.dart`, `lib/features/proposals/presentation/proposal_detail_screen.dart`, `lib/features/signatures/domain/signature_notifier.dart`, `lib/features/signatures/presentation/signature_public_screen.dart`, `lib/features/proposals/presentation/proposal_public_screen.dart`
  - Definir padrão final para propostas e contratos
  - Corrigir inconsistência entre router, ShareService e telas de detalhe
  - Arquivos-base:
    - `lib/core/router/app_router.dart`
    - `lib/core/services/share_service.dart`
    - `lib/features/contracts/presentation/contract_detail_screen.dart`
    - `lib/features/proposals/presentation/proposal_detail_screen.dart`

- [x] Refatorar rota pública de assinatura para token
  - Arquivos alterados: `lib/core/router/app_router.dart`, `lib/features/signatures/presentation/signature_public_screen.dart`, `lib/features/signatures/domain/signature_notifier.dart`
  - Trocar de `/s/:contractId` para `/sign/:token`
  - Ajustar leitura por token no fluxo público
  - Arquivos-base:
    - `lib/core/router/app_router.dart`
    - `lib/features/signatures/presentation/signature_public_screen.dart`
    - `lib/data/repositories/contract_repository.dart`

- [x] Completar tela pública de assinatura
  - Arquivos alterados: `lib/features/signatures/presentation/signature_public_screen.dart`, `lib/features/signatures/domain/signature_notifier.dart`, `lib/features/signatures/domain/signature_state.dart`, `lib/data/repositories/signature_repository.dart`
  - Exibir contrato
  - Checkbox “Li e concordo”
  - Campo nome completo
  - SignaturePad real
  - Botão limpar assinatura
  - Modal de confirmação
  - Estados: loading, sucesso, já assinado, token inválido/expirado
  - Arquivos-base:
    - `lib/features/signatures/presentation/signature_public_screen.dart`
    - `lib/features/signatures/domain/signature_notifier.dart`
    - `lib/features/signatures/domain/signature_state.dart`
    - `lib/data/repositories/signature_repository.dart`

- [x] Registrar metadados reais da assinatura
  - Arquivos alterados: `lib/features/signatures/domain/signature_notifier.dart`, `lib/features/signatures/presentation/signature_public_screen.dart`, `lib/data/repositories/signature_repository.dart`, `lib/data/repositories/contract_repository.dart`
  - Timestamp
  - IP
  - Geolocalização
  - Hash do documento
  - Arquivos-base:
    - `lib/features/signatures/domain/signature_notifier.dart`
    - `lib/data/repositories/signature_repository.dart`
    - `lib/core/services/pdf_service.dart`

### 2. Contrato completo até certificado
Impacto: Muito alto

- [ ] Criar passo 3 do gerador de contrato
  - Preview PDF
  - Compartilhar
  - Copiar link
  - Salvar PDF
  - Navegação final para lista/detalhe
  - Arquivos-base:
    - `lib/core/router/app_router.dart`
    - `lib/features/contracts/presentation/contract_step3_screen.dart`
    - `lib/features/contracts/domain/contract_notifier.dart`

- [ ] Completar detalhe do contrato
  - Enviar para assinatura
  - Compartilhar de verdade
  - Exibir progresso de assinaturas
  - Exibir badges por signatário
  - Arquivos-base:
    - `lib/features/contracts/presentation/contract_detail_screen.dart`
    - `lib/core/services/share_service.dart`
    - `lib/data/repositories/signature_repository.dart`

- [ ] Criar tela de certificado do contrato
  - Rota `/contracts/:id/certificate`
  - PDF final
  - Hash
  - Dados dos signatários
  - Download
  - Compartilhar link de verificação
  - Arquivos-base:
    - `lib/core/router/app_router.dart`
    - `lib/features/contracts/presentation/contract_certificate_screen.dart`
    - `lib/core/services/pdf_service.dart`

---

## Fase 2 — Geração e compartilhamento de propostas

### 3. Fechar fluxo completo de proposta
Impacto: Alto

- [ ] Completar Step 1
  - Seleção de cliente com criar novo inline
  - Seleção de empresa
  - Seleção de modelo
  - Data de validade
  - Stepper visual consistente

- [ ] Completar Step 2
  - Busca de itens do catálogo
  - Quantidade/preço editáveis
  - Subtotal em tempo real
  - Desconto percentual e absoluto
  - Total final destacado
  - Observações

- [ ] Completar Step 3
  - Preview PDF embutido
  - Compartilhar via WhatsApp
  - Copiar link
  - Salvar PDF
  - Gerar contrato a partir da proposta
  - Status badge consistente

- [ ] Completar detalhe da proposta
  - Compartilhamento real
  - Mudança de status funcional
  - Geração de contrato real

- [ ] Criar/ajustar rota pública de proposta por token
  - Garantir consistência com ShareService

Arquivos-base:
- `lib/features/proposals/presentation/proposal_step1_screen.dart`
- `lib/features/proposals/presentation/proposal_step2_screen.dart`
- `lib/features/proposals/presentation/proposal_step3_screen.dart`
- `lib/features/proposals/presentation/proposal_detail_screen.dart`
- `lib/features/proposals/domain/proposal_notifier.dart`
- `lib/core/router/app_router.dart`
- `lib/core/services/pdf_service.dart`
- `lib/core/services/share_service.dart`

---

## Fase 3 — Templates de proposta e contrato

### 4. Entregar feature de templates na UI
Impacto: Alto

- [ ] Criar lista de modelos de proposta
  - Agrupamento por empresa
  - Thumbnail/preview
  - Badge de uso
  - FAB novo modelo
  - Duplicar modelo

- [ ] Criar editor de modelo de proposta
  - Editor rich text
  - Variáveis dinâmicas
  - Preview
  - Salvar
  - Pré-visualizar PDF

- [ ] Criar lista de modelos de contrato
  - Estrutura equivalente à de proposta

- [ ] Criar editor de modelo de contrato
  - Variáveis adicionais de assinatura
  - Versionamento simples
  - Preview

Arquivos-base:
- `lib/core/router/app_router.dart`
- `lib/data/repositories/proposal_template_repository.dart`
- `lib/data/repositories/contract_template_repository.dart`
- `lib/features/proposal_templates/presentation/...`
- `lib/features/contract_templates/presentation/...`

Observação:
- As pastas de `presentation/domain` dessas features ainda precisarão ser criadas.

---

## Fase 4 — Clientes e Prestadores

### 5. Completar módulo de clientes
Impacto: Médio-alto

- [ ] Adicionar debounce de busca
- [ ] Implementar filtros PF/PJ
- [ ] Adicionar swipe-to-action editar/arquivar
- [ ] Integrar ViaCEP no formulário
- [ ] Exibir histórico de propostas/contratos vinculados
- [ ] Botão “Criar proposta para este cliente”
- [ ] Validação inline em tempo real

Arquivos-base:
- `lib/features/clients/presentation/client_list_screen.dart`
- `lib/features/clients/presentation/client_detail_screen.dart`
- `lib/features/clients/domain/client_notifier.dart`
- `lib/data/repositories/client_repository.dart`

### 6. Completar módulo de prestadores
Impacto: Médio-alto

- [ ] Garantir 3 cards fixos: Estudyou, Protseg, Protuni
- [ ] Destacar empresa ativa
- [ ] Upload de logo
- [ ] Color picker simples
- [ ] Preview do rodapé do documento
- [ ] Editar assinatura padrão

Arquivos-base:
- `lib/features/providers/presentation/provider_list_screen.dart`
- `lib/features/providers/presentation/provider_edit_screen.dart`
- `lib/features/providers/domain/provider_notifier.dart`
- `lib/data/repositories/provider_repository.dart`

Dependências a avaliar:
- `image_picker`
- pacote de color picker

---

## Fase 5 — Home, catálogo e configurações

### 7. Fechar Home/Dashboard
Impacto: Médio

- [ ] Exibir logo da empresa ativa na AppBar
- [ ] Validar métricas contra o escopo
- [ ] Refinar lista de recentes
- [ ] Implementar loading skeleton

Arquivos-base:
- `lib/features/home/presentation/home_screen.dart`
- `lib/features/home/domain/home_notifier.dart`

### 8. Completar catálogo de produtos/serviços
Impacto: Médio

- [ ] Filtros por tipo e empresa
- [ ] FAB novo item
- [ ] Busca refinada
- [ ] Preview do item em linha de proposta
- [ ] Toggle ativo/inativo com UX final

Arquivos-base:
- `lib/features/products/presentation/product_list_screen.dart`
- `lib/features/products/presentation/product_detail_screen.dart`
- `lib/features/products/domain/product_notifier.dart`

### 9. Completar configurações
Impacto: Médio

- [ ] Dados do usuário logado
- [ ] Troca de senha
- [ ] Empresa padrão ativa
- [ ] Tema claro/escuro/sistema editável
- [ ] Notificações push
- [ ] Sobre + versão
- [ ] Logout final

Arquivos-base:
- `lib/features/settings/presentation/settings_screen.dart`
- `lib/core/services/auth_service.dart`
- `lib/main.dart`

---

## Fase 6 — Base técnica e consistência

### 10. Multi-empresa real
Impacto: Médio

- [ ] Troca de empresa ativa sem relogin
- [ ] Aplicar branding por tenant
- [ ] Logo/cor/assinatura por empresa
- [ ] Garantir propagação correta por provider ativo

Arquivos-base:
- `lib/core/services/auth_service.dart`
- `lib/shared/theme/app_theme.dart`
- `lib/features/providers/...`
- `lib/features/home/...`

### 11. Offline-first completo
Impacto: Médio

- [ ] Sync ao reconectar
- [ ] Realtime subscriptions
- [ ] Conflitos por `updated_at`
- [ ] Optimistic updates na UI

Arquivos-base:
- `lib/data/drift/app_database.dart`
- `lib/data/repositories/*.dart`
- `lib/features/*/domain/*_notifier.dart`

### 12. PDF e documento final
Impacto: Médio

- [ ] Inserção visual real de assinaturas no PDF
- [ ] Melhorar layout dos PDFs
- [ ] Armazenamento e recuperação final no Supabase Storage
- [ ] Garantir hash SHA-256 no fluxo final

Arquivos-base:
- `lib/core/services/pdf_service.dart`
- `lib/data/repositories/signature_repository.dart`
- `lib/data/repositories/contract_repository.dart`

---

## Dependências/infra a revisar antes de executar fases específicas

- [ ] WebView para preview HTML de modelos
- [ ] `image_picker` para logo de prestador
- [ ] pacote ColorPicker
- [ ] estratégia de notifications push
- [ ] estratégia final de deep links/domínio web público

---

## Ordem recomendada de execução
1. Links públicos + assinatura digital
2. Contrato step 3 + certificado
3. Fluxo completo de proposta
4. Templates de proposta/contrato
5. Clientes
6. Prestadores
7. Home
8. Produtos
9. Configurações
10. Multi-empresa real
11. Offline-first completo
12. PDF final refinado

---

## Critério de pronto por bloco
Um bloco só deve ser considerado concluído quando:
- rota funciona
- estado loading/erro/sucesso existe
- ação principal funciona sem mock
- UX principal foi validada visualmente
- integração com serviço/repositório está real
