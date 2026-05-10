# Checklist de Testes Manuais — ProposalYou

Objetivo: validar manualmente os fluxos principais já implementados nas Fases 1 a 6.12.

## Instruções gerais
- Marque `[x]` ao validar com sucesso.
- Se houver falha, anote tela, passo, mensagem e comportamento observado.
- Sempre testar com pelo menos 2 empresas ativas diferentes quando o fluxo depender de tenant.
- Quando possível, repetir o teste em:
  - app logado
  - link público
  - com e sem dados previamente gerados

---

## 1. Autenticação e sessão

- [X] Login com email/senha funciona
- [X] Logout funciona e volta para `/login`
- [ ] Troca de senha em Configurações funciona
- [ ] Dados do usuário logado aparecem em Configurações
- [ ] Empresa ativa pode ser trocada sem relogin
- [X] Tema claro/escuro/sistema persiste após reinício do app

---

## 2. Multi-empresa real

### 2.1 Troca de empresa ativa
- [ ] Trocar empresa ativa atualiza Home
- [ ] Trocar empresa ativa atualiza Produtos
- [ ] Trocar empresa ativa atualiza Clientes
- [ ] Trocar empresa ativa atualiza Propostas
- [ ] Trocar empresa ativa atualiza Contratos
- [ ] Trocar empresa ativa atualiza Templates

### 2.2 Branding por tenant
- [ ] Home mostra logo da empresa ativa
- [ ] Step 3 da proposta mostra branding correto da empresa ativa
- [ ] Detalhe da proposta mostra branding correto
- [ ] Step 3 do contrato mostra branding correto
- [ ] Detalhe do contrato mostra branding correto
- [ ] PDF de proposta usa branding correto
- [ ] PDF de contrato usa branding correto

---

## 3. Produtos

### 3.1 Catálogo
- [ ] Lista mostra apenas itens da empresa ativa
- [ ] Filtro por tipo funciona
- [ ] Busca funciona
- [ ] Item inativo aparece visualmente como inativo
- [ ] Criar novo item funciona
- [ ] Editar item funciona
- [ ] Ativar/desativar item funciona

### 3.2 Uso em proposta
- [ ] Apenas itens ativos aparecem na seleção de proposta
- [ ] Linha do item mostra tipo/unidade/descrição quando aplicável
- [ ] Quantidade e preço atualizam subtotal corretamente

### 3.3 Offline-first
- [ ] Abrir lista online popula o cache
- [ ] Fechar e reabrir offline mostra lista de produtos em cache
- [ ] Busca offline funciona sobre o cache
- [ ] Editar online reflete depois no cache local

---

## 4. Clientes

### 4.1 CRUD e filtros
- [ ] Lista mostra apenas clientes da empresa ativa
- [ ] Busca por nome funciona
- [ ] Busca por CPF/CNPJ funciona
- [ ] Filtro PF funciona
- [ ] Filtro PJ funciona
- [ ] Criar cliente funciona
- [ ] Editar cliente funciona
- [ ] Arquivar cliente remove da listagem principal
- [ ] ViaCEP continua funcionando quando online

### 4.2 Offline-first
- [ ] Abrir lista online popula o cache
- [ ] Fechar e reabrir offline mostra clientes em cache
- [ ] Busca offline funciona sobre o cache
- [ ] Arquivar online reflete no cache local

---

## 5. Propostas

### 5.1 Wizard
- [ ] Step 1 salva cliente, empresa, modelo e validade corretamente
- [ ] Step 2 salva itens, desconto e total corretamente
- [ ] Step 3 mostra resumo correto

### 5.2 Detalhe e fluxo
- [ ] Proposta pode ser marcada como enviada
- [ ] Proposta pode ser aprovada
- [ ] Proposta aprovada pode gerar contrato
- [ ] Link público da proposta funciona

### 5.3 PDF final
- [ ] Ao salvar proposta, PDF final é gerado e enviado ao Storage
- [ ] `pdf_url` da proposta fica disponível após o save
- [ ] Botão “Salvar prévia local” salva arquivo localmente
- [ ] Detalhe da proposta permite copiar link do PDF final remoto

### 5.4 Offline-first
- [ ] Abrir lista online popula cache
- [ ] Fechar e reabrir offline mostra propostas em cache
- [ ] Busca offline funciona sobre o cache

---

## 6. Contratos

### 6.1 Wizard
- [ ] Step 1 permite criar contrato a partir de proposta aprovada
- [ ] Step 2 salva cláusulas corretamente
- [ ] Step 3 mostra resumo correto
- [ ] Step 3 comunica corretamente que o PDF final depende das assinaturas

### 6.2 Detalhe
- [ ] Contrato em minuta pode ser enviado para assinatura
- [ ] Link de assinatura pode ser copiado
- [ ] Certificado pode ser acessado quando contrato estiver assinado
- [ ] PDF final pode ser copiado quando existir

### 6.3 Assinatura pública
- [ ] Link público de assinatura abre sem login
- [ ] Nome do signatário é obrigatório
- [ ] Assinatura no canvas funciona
- [ ] Registro de assinatura funciona
- [ ] Não permite assinatura duplicada do mesmo nome

### 6.4 Fechamento final do contrato
Testar com contrato de 2 signatários:
- [ ] Primeira assinatura é registrada
- [ ] Após a primeira assinatura, contrato continua `aguardando_assinatura`
- [ ] Segunda assinatura é registrada
- [ ] Após a última assinatura, contrato vira `assinado`
- [ ] Após a última assinatura, PDF final é gerado
- [ ] Após a última assinatura, PDF final é enviado ao Storage
- [ ] `pdf_url` do contrato aponta para PDF real
- [ ] `hash_documento` é preenchido

### 6.5 Certificado
- [ ] Certificado mostra hash
- [ ] Certificado mostra signatários
- [ ] Certificado mostra link de verificação
- [ ] Certificado mostra PDF final separadamente da verificação
- [ ] Copiar link do PDF final funciona

### 6.6 Offline-first
- [ ] Abrir lista online popula cache
- [ ] Fechar e reabrir offline mostra contratos em cache
- [ ] Busca offline funciona sobre o cache

---

## 7. Templates

### 7.1 Templates de proposta
- [ ] Lista mostra apenas templates da empresa ativa
- [ ] Criar template funciona
- [ ] Editar template funciona
- [ ] Duplicar template funciona
- [ ] Templates ficam disponíveis no Step 1 da proposta
- [ ] Cache local funciona após carga online

### 7.2 Templates de contrato
- [ ] Lista mostra apenas templates da empresa ativa
- [ ] Criar template funciona
- [ ] Editar template funciona
- [ ] Criar nova versão funciona
- [ ] Cache local funciona após carga online

---

## 8. Home / Dashboard

- [ ] Logo da empresa ativa aparece corretamente
- [ ] Métricas fazem sentido para a empresa ativa
- [ ] Lista de recentes mostra dados da empresa ativa
- [ ] Loading skeleton aparece corretamente

---

## 9. PDF e Storage

### 9.1 Propostas
- [ ] PDF de proposta abre corretamente quando baixado localmente
- [ ] PDF de proposta mantém branding correto
- [ ] PDF de proposta remoto fica acessível via `pdf_url`

### 9.2 Contratos
- [ ] PDF de contrato inclui branding correto
- [ ] PDF de contrato inclui assinaturas visuais
- [ ] PDF de contrato inclui hash final
- [ ] PDF final remoto fica acessível via `pdf_url`

---

## 10. Regressão geral

- [ ] `flutter analyze` continua limpo
- [ ] Navegação principal continua íntegra
- [ ] Nenhuma rota pública principal quebrou
- [ ] Nenhum fluxo de CRUD principal quebrou

---

## 11. Anotações de teste

### Falhas encontradas
- 
- 
- 

### Observações gerais
- 
- 
- 
