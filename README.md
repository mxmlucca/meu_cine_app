# Meu CineApp 🎬

> Um aplicativo de catálogo de filmes desenvolvido em Flutter para demonstrar habilidades em arquitetura de software limpa, consumo de APIs REST e persistência de dados locais com SharedPreferences.

Este projeto foi construído como parte de um processo de aprendizado, focando nas melhores práticas de mercado para desenvolvimento de aplicativos móveis robustos e escaláveis.

## ✨ Features

- [✅] **Lista de Filmes Populares:** Exibe uma grade com os filmes mais populares do momento consumindo a API do TMDb.
- [✅] **Tela de Detalhes:** Apresenta informações detalhadas de cada filme, como sinopse, avaliação e gêneros.
- [✅] **Sistema de Favoritos:** Permite ao usuário salvar e remover filmes de uma lista de favoritos, com os dados persistindo localmente no dispositivo.
- [✅] **Interface Reativa:** A UI responde aos estados da aplicação (carregando, erro, sucesso).
- [✅] **Design Simples e Moderno:** Foco em uma experiência de usuário limpa e agradável, com um tema escuro.

## 🏛️ Arquitetura e Tecnologias Utilizadas

Este projeto foi estruturado utilizando **Clean Architecture**, dividindo as responsabilidades em três camadas principais: `Domain`, `Data` e `Presentation`.

- **Linguagem:** `Dart`
- **Framework:** `Flutter`
- **Arquitetura:** `Clean Architecture`
- **Gerenciamento de Estado:** `Provider`
- **Comunicação com API:** `Dio` (para consumo de API REST)
- **Persistência Local:** `SharedPreferences`
- **Igualdade de Objetos:** `Equatable`
- **Testes:** _(A ser implementado)_

## 🚀 Como Rodar o Projeto

Para rodar este projeto localmente, siga os passos abaixo:

**1. Clone o Repositório**

```bash
git clone [https://github.com/SEU_USUARIO/meu_cine_app.git](https://github.com/SEU_USUARIO/meu_cine_app.git)
cd meu_cine_app
```

**2. Instale as Dependências**

```bash
flutter pub get
```

**3. Configure a Chave da API**

- Abra o arquivo `lib/features/movies/data/datasources/movie_remote_datasource.dart`.
- Encontre a constante `apiKey` e substitua `'SUA_CHAVE_API_VEM_AQUI'` pela sua chave pessoal da API do The Movie Database (TMDb).

**4. Rode o Aplicativo**

```bash
flutter run
```

---
