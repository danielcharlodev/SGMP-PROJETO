<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/dashboard/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <title>Exemplo</title>
</head>

<body>
    <div class="container">

        <div class="sidebar">

            <div class="icon-sidebar">
                <img src="Imagens/senai.png" alt="Logo do Senai">
            </div>

            <div class="sidebar-links">

                <button class="sidebar-btn" onclick="trocarSecao('painel')">
                    <i class="fa-solid fa-house"></i>
                    <p>Home</p>
                </button>

                <br>

                <button class="sidebar-btn" onclick="trocarSecao('novo-chamado')">
                    <i class="fa-solid fa-plus"></i>
                    <p>Novo Chamado</p>
                </button>

            </div>

        </div>

        <div class="header">

            <h1>Painel Administrativo</h1>

            <button id="theme-toggle">
                🌙
            </button>

        </div>

        <div class="main secao" id="painel">

            <h1 class="subtitle">Meu Painel</h1>

            <div class="grafic1">
                <h2>Chamados<br>Criados</h2>
            </div>

            <div class="grafic2">
                <h2>Satisfação do<br>cliente</h2>
            </div>

            <div class="grafic3">
                <h2>Chamados<br>Abertos</h2>
            </div>

            <div class="grafic4">
                <h2>Chamados<br>Criados</h2>
            </div>

            <div class="grafic5">
                <h2>Chamados<br>Criados</h2>
            </div>

        </div>

        <div
            class="abrir-novo-chamado secao hidden"
            id="novo-chamado">

            <h1 class="subtitle">Abrir Chamado</h1>

            <div class="novo-chamado">

                <form action="">

                    <label>Título:</label>

                    <input
                        type="text"
                        name="titulo"
                        class="input-chamado mulish"
                        id="titulo-chamado"
                        placeholder="Digite o título do chamado">

                    <label>Tag:</label>

                    <input
                        type="text"
                        name="tag"
                        class="input-chamado mulish"
                        id="tag-chamado"
                        placeholder="Digite a tag do chamado">

                    <label>Descrição:</label>

                    <input
                        type="text"
                        name="descricao"
                        class="input-chamado mulish"
                        id="descricao-chamado"
                        placeholder="Digite a descrição do chamado">

                    <button>
                        Abrir Chamado
                    </button>

                </form>

            </div>

        </div>
    </div>
    </div>

    <script src="js/Dashboard/dashboard.js"></script>
</body>

</html>