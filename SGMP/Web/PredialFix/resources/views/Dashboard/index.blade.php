<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Painel Administrativo</title>

    <link rel="stylesheet" href="css/dashboard/style.css">

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body>


    <div class="layout">

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <div class="sidebar__top">
                <div class="sidebar__logo">
                    <img src="Imagens/senai.png" alt="Logo do Senai">
                </div>
                <nav class="sidebar__nav">
                    <button class="sidebar__button" onclick="trocarSecao('painel')">
                        <i class="fa-solid fa-house"></i>
                        <span>Home</span>
                    </button>
                    <button class="sidebar__button" onclick="trocarSecao('novo-chamado')">
                        <i class="fa-solid fa-plus"></i>
                        <span>Novo Chamado</span>
                    </button>
                </nav>
            </div>
            <div class="sidebar__bottom">
                <button class="sidebar__button " onclick="trocarSecao('perfil')">
                    <i class="fa-solid fa-circle-user"></i>
                    <span>Perfil</span>
                </button>
            </div>
        </aside>

        <!-- HEADER -->
        <header class="header">
            <h1 class="header__title">
                Painel Administrativo
            </h1>
            <button class="theme-toggle" id="theme-toggle">
                🌙
            </button>
        </header>

        <!-- MAIN -->
        <main class="content">

            <!-- DASHBOARD -->
            <section class="section" id="painel">
                <h2 class="section__title">
                    Meu Painel
                </h2>
                <div class="cards-grid">
                    <article class="card">
                        <h3 class="card__title">
                            Chamados Criados
                        </h3>
                    </article>
                    <article class="card">
                        <h3 class="card__title">
                            Satisfação do Cliente
                        </h3>
                    </article>
                    <article class="card">
                        <h3 class="card__title">
                            Chamados Abertos
                        </h3>
                    </article>
                    <article class="card card--wide">
                        <h3 class="card__title">
                            Relatórios
                        </h3>
                    </article>
                    <article class="card">
                        <h3 class="card__title">
                            Estatísticas
                        </h3>
                    </article>
                </div>
            </section>

            <!-- NOVO CHAMADO -->
            <section class="section hidden" id="novo-chamado">
                <h2 class="section__title">
                    Abrir Chamado
                </h2>
                <div class="form-wrapper">
                    <form class="form">
                        <div class="form-group">

                            <label for="titulo">
                                Título
                            </label>
                            <input
                                type="text"
                                id="titulo"
                                class="input"
                                placeholder="Digite o título">
                        </div>
                        <div class="form-group">
                            <label for="tag">
                                Tag
                            </label>
                            <select id="tag" class="input">
                                <option value="">
                                    Selecione uma tag
                                </option>
                                <option value="hardware">
                                    Hardware
                                </option>
                                <option value="software">
                                    Software
                                </option>
                                <option value="rede">
                                    Rede
                                </option>
                            </select>
                        </div>
                        <div class="form-group">

                            <label for="descricao">
                                Descrição
                            </label>
                            <textarea
                                id="descricao"
                                class="input textarea"
                                placeholder="Digite a descrição"></textarea>

                        </div>
                        <button class="btn-primary" type="submit">
                            Abrir Chamado
                        </button>

                    </form>

                </div>

            </section>

        </main>

    </div>

    <script src="js/Dashboard/dashboard.js"></script>

</body>

</html>