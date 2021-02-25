<!-- Images Badges -->
[swift-image]: https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat
[xcode-image]: https://img.shields.io/badge/xcode-11.3-orange
[cocoapods-image]: https://img.shields.io/badge/CocoaPods-1.10-orange

<!-- URLs -->
[santander-mobile-coders-url]: https://www.becas-santander.com/pt/program/santander-coders-mobile-2020
[digital-house-url]: https://www.digitalhouse.com/br/
[curso-ios-url]: https://www.digitalhouse.com/br/curso/desenvolvimento-mobile-ios
[tmdb-api-url]: https://www.themoviedb.org/documentation/api


<p align="center">
  <img alt="Jeffrey" src="https://github.com/miziaalmeida/projeto-integrador-iOS/blob/main/Images/jeffrey.jpg" width="200px"/>
<p>


•  [Sobre](#computer-sobre)  •  [Requisitos do Projeto](#wrench-requisitos-do-projeto) •  [Preview do Projeto](#clapper-preview-do-projeto)  •  [Tecnologias utilizadas](#white_check_mark-tecnologias-utilizadas)  •  [Arquitetura](triangular_ruler-padrão-de-projeto)  •  [Metodologia de trabalho](#calendar-metodologia-de-trabalho)  •  [Executar o Projeto](#dvd-execução-do-projeto)  •  [Autores](#open_hands-autores)  •  [Licença](#page_facing_up-licença)  •  

---
## :computer: **Sobre**

O projeto integrador faz parte do ciclo de finalização do curso [iOS mobile developer][curso-ios-url] desenvolvido pela [Digital House Brasil][digital-house-url] em parceria com o Santander Universidades pelo projeto [Becas Santander][santander-mobile-coders-url]. 

O aplicativo desenvolvido se chama **Jeffrey** e tem por finalidade sortear filmes dentro da plataforma utilizando como parâmetro gêneros e streamings setados pelo usuário. O aplicativo ainda apresenta diversos títulos na sua home principal, o usuário tem a opção de guardar listas de favoritos e já vistos para que não seja carregadas como opções no botão de sorteio, e uma tela de de busca de informações onde se pode realizar busca de títulos específicos.

Para este projeto está sendo consumida a API do [The Movie DataBase][tmdb-api-url], conforme uma das exigências de entrega do projeto: consumo de API.

O Santander Coders Mobile é uma experiência de 6 meses de imersão para aprender a desenvolver aplicativos na plataforma iOS, tem como objetivo dar oportunidades reais para pessoas que querem transformar suas vidas por meio da educação de qualidade.

---
## :wrench: **Requisitos do Projeto**

O projeto integrador deve estar em conformida com os seguintes tópicos;

- [x] Deve possuir um design em todas as telas utilizando auto layout;
- [x] Aplicação do POO.
- [x] Deve possuir navegação entre telas (Navigation e Modal);
- [x] Tratativas de erros;
- [x] Deve consumir uma API;
- [x] Deve funcionar em modo offline;
- [x] A arquitetura deve ser MVVM;
- [ ] O código precisa estar comentado;
- [x] Testes Unitários;
- [x] O app deve conter, pelo menos, os seguintes componentes do UIKit: (UITextField, 
UIButton, UILabel, UICollectionView e UITableView).
- [x] O app deve possuir as seguintes features:
    - [x] Tela de carregamento;
    - [x] Tela de login (Facebook e Google são obrigatórios);
    - [x] Tela inicial que deve conter um resumo das funcionalidades do app;
    - [x] Tela de descrição do item;
    - [x] Tela de listagem de características;
    - [ ] Opções para compartilhamento em redes sociais;
- [x] Todo o trabalho deve ser feito utilizando o GitFlow;
- [x] Ao final, o ReadMe deve estar atualizado com screenshots das telas do app e descrição detalhada das funcionalidades.

---
## :clapper: **Preview do Projeto**

<div align="center">

[Demo](https://user-images.githubusercontent.com/42849855/109223712-b4aefa80-7799-11eb-918f-b8cf57482f82.mov)

![LoginFlow](https://media.giphy.com/media/nLbBzBGFxQ4LMBq7Es/giphy.gif)
![HomeFlow](https://media.giphy.com/media/RgGAWcLeXNzzidaeGg/giphy.gif)
![RaffleFlow](https://media.giphy.com/media/OzEqgOZ8jHMzmvwGkH/giphy.gif)
![RedirectFlow](https://media.giphy.com/media/cX9pOFMFEDWdYaY4Fo/giphy.gif)
![ListsFlow](https://media.giphy.com/media/JbakyuHrWnEiYHUpeC/giphy.gif)
![SearchFlow](https://media.giphy.com/media/Of1n85WAR1pYHHMeKD/giphy.gif)

![jeffreyLogado](https://media.giphy.com/media/8okKuavebXEUIQlCdK/giphy.gif)

</div>

---

## :white_check_mark: **Tecnologias utilizadas**

- Miro
- Trello
- Xcode 12.4
- Atom
- Postman
- JSon Export
- Git - GitFlow
- Cocoapods
- Figma
- Canva Pro
- Ninja Mock
- Firebase - Realtime e Storage
- CoreData
- SQLite
- Fastlane
- Bitrise

---
## :triangular_ruler: **Padrão de projeto**

Este projeto foi desenvolvido dentro do padrão de projeto **Model-View-ViewModel (MVVM)**, composto pelos seguintes elementos:
* **Model**: Camada de logística de negócios que impulsiona a aplicação e quaisquer regras de negócios, é responsável pelos dados;
* **View**: Camada de interface de usuário, responsável pela aparência da aplicação
* **ViewModel**: Responsável por ser a ligação principal dentro do MVVM, a ViewModel coordena as operações entre a *view* e as camadas *model*, ela será responsável por expor métodos, comandos e propriedades que mantém o estado da View, bem como manipular a Model com resultados de ações da View.

![MVVM-Pattern](https://github.com/miziaalmeida/projeto-integrador-iOS/blob/main/Images/mvvm.png)

---
## :calendar: **Metodologia de trabalho**

Este projeto utilizou como metodologia principal de trabalho, o padrão ágil implementado com o **Scrum**. Este é uma estrutura voltada para o trabalho em equipe, estimulando as equipes a aprenderem com suas experiências, se organizarem enquanto resolvem um problema e refletirem sobre os êxitos e fracassos para melhorarem continuamente, tudo isso realizado em cerimônias de acompanhamento com o time (Planning, Dailys, Retrospective) que juntas culmimam na entrega do resultado e fechamento da Sprint - período curto de trabalho pré-fixado onde uma equipe se dedica a entrega das tarefas definidas.
Para de controle de versão, abordamos o fluxo de trabalho utilizando branches - **GitFlow**, implementando dois ambientes de código em teste e testado (develop e main), sempre que necessário novas implementações são realizadas nas branches através de features, e quando surgem problemas/bugs são solucionados através de hotfix. Também foi implementado método de integração contínua, utilizando a ferramenta [**Bitrise**](https://www.bitrise.io/), através da lib [**Fastlane**](https://fastlane.tools/), que nos permite ter um controle maior sobre os possíveis problemas ocorridos no código.

![Scrum](https://media.giphy.com/media/r8gRIddoujD7Z9FE8F/giphy.gif)

![Métodos - Git Flow](https://github.com/miziaalmeida/projeto-integrador-iOS/blob/main/Images/metodos.png)

---

## :dvd: **Execução do Projeto**

Este projeto deverá ser executado:
1. No sistema operacional MacOS
2. No simulador do Xcode ou IPhone

💡É preciso efetuar a simulação no ambiente de desenvolvimento Xcode ou integrá-lo com Iphone para funcionar.

### Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:
[Git](https://git-scm.com), [CocoaPods](https://cocoapods.org/)

```bash
# Clone este repositório
$ git clone <https://github.com/miziaalmeida/projeto-integrador-iOS.git>

# Acesse a pasta do projeto no terminal/cmd
$ cd Jeffrey

# Execute o comando *pod install* para iniciar o projeto com as libs necessárias
$ pod install

# Abra o projeto no XCode
$ open Jeffrey.xcworkspace
```

---
## :open_hands: **Autores**

<div align="center">

<a href="https://github.com/michelldossantos">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/60993267?s=400&u=c1f849f90ceb9c25bd7765473b2b933b62c0ef11&v=4" width="100px;" alt="Foto de Perfil Michel Santos"/>
 <br />
  <p>
 <sub><b>Michel Santos</b></sub></a>
<p>

[![Linkedin Badge](https://img.shields.io/badge/-Michel_Santos-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/michellsantoos/)
[![Github Badge](https://img.shields.io/badge/-Michel_Santos-000?style=flat-square&logo=Github&logoColor=white)](https://github.com/michelldossantos)
[![Gmail Badge](https://img.shields.io/badge/-michelsantos15@gmail.com-c14438?style=flat-square&logo=Gmail&logoColor=white&link=mailto:michelsantos15@gmail.com)](mailto:michelsantos15@gmail.com)

<div align="center">

<a href="https://github.com/miziaalmeida">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/42849855?s=400&u=f2dfc70f52e7c272e7865b3582e6cc09fea8f576&v=4" width="100px;" alt="Foto de Mízia Lima"/>
 <br />
  <p>
 <sub><b>Mízia Lima</b></sub></a>
<p>

[![Linkedin Badge](https://img.shields.io/badge/-Mízia_Lima-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/miziasalima/)
[![Github Badge](https://img.shields.io/badge/-Mízia_Lima-000?style=flat-square&logo=Github&logoColor=white)](https://github.com/miziaalmeida)
[![Gmail Badge](https://img.shields.io/badge/-mizia.alima@gmail.com-c14438?style=flat-square&logo=Gmail&logoColor=white&link=mailto:mizia.alima@gmail.com)](mailto:mizia.alima@gmail.com)

<a href="https://github.com/taizecarminatti">
 <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/50411651?s=400&u=9e39961f7f175034f1fdfaab536f180184326c74&v=4" width="100px;" alt="Foto de Taize Carminatti"/>
 <br />
  <p>
 <sub><b>Taize Carminatti</b></sub></a>
<p>

[![Linkedin Badge](https://img.shields.io/badge/-Taize_Carminatti-blue?style=flat-square&logo=Linkedin&logoColor=white)](https://www.linkedin.com/in/taizecarminatti/)
[![Github Badge](https://img.shields.io/badge/-Taize_Carminatti-000?style=flat-square&logo=Github&logoColor=white)](https://github.com/taizecarminatti)
[![Gmail Badge](https://img.shields.io/badge/-taizecarminatti@gmail.com-c14438?style=flat-square&logo=Gmail&logoColor=white&link=mailto:taizecarminatti@gmail.com)](mailto:taizecarminatti@gmail.com)

</div>
</div>

---

### :page_facing_up: **Licença**

Copyright © 2021 [Jeffrey](https://github.com/Jeffrey-iOS/Jeffrey).<br />
Este projeto é licenciado pelo [MIT](https://github.com/miziaalmeida/projeto-integrador-iOS/blob/main/LICENSE).
