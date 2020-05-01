<%@page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="service.ProdutoService"%>
<%@page import="model.Produto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Gerenciador de Produtos</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">

<script type="text/javascript">

	function onCadastrar(){
		showGroups();
		document.querySelector("#myForm").reset();
		const inputAction = document.querySelector("#inputAction");
		const titleModal = document.querySelector("#titleModal");
		const inputCodigo = document.querySelector("#codigo");
		inputAction.value='';
		titleModal.innerHTML = 'Cadastrar Produto';
		inputCodigo.placeholder = 'Digite um número identificador para seu produto';
	}

	function onAlterar(){
		showGroups();
		document.querySelector("#myForm").reset();
		const inputAction = document.querySelector("#inputAction");
		const titleModal = document.querySelector("#titleModal");
		const inputCodigo = document.querySelector("#codigo");
		titleModal.innerHTML = 'Alterar Produto';
		inputAction.value = 'alterar';
		inputCodigo.placeholder = 'Digite o número identificador do seu produto';
	}

	function onDeletar(){
		hiddenGroups();
		document.querySelector("#myForm").reset();
		const inputAction = document.querySelector("#inputAction");
		const titleModal = document.querySelector("#titleModal");
		const inputCodigo = document.querySelector("#codigo");
		titleModal.innerHTML = 'Deletar Produto';
		inputAction.value = 'deletar';
		inputCodigo.placeholder = 'Digite o número identificador do seu produto';
	}


	function hiddenGroups(){
		const group = document.querySelectorAll(".normal");
		group.forEach( i => {
			i.style.display = 'none'
		});
	}

	function showGroups(){
		const group = document.querySelectorAll(".normal");
		group.forEach( i => {
			i.style.display = 'block'
		});
	}
}

</script>
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
			<a class="navbar-brand" href="#">Manager</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav">
					<li class="nav-item active"><a class="nav-link"
						href="index.jsp">Home <span class="sr-only">(current)</span>
					</a></li>

					<li class="nav-item"><a class="nav-link" href="#"
						data-toggle="modal" data-target="#modalForm"
						onclick="onCadastrar()">Cadastrar</a></li>

					<li class="nav-item"><a class="nav-link" href="#"
						data-toggle="modal" data-target="#modalForm" onclick="onAlterar()">Alterar</a>
					</li>

					<li class="nav-item"><a class="nav-link" href="#"
						data-toggle="modal" data-target="#modalForm" onclick="onDeletar()">Deletar</a>
					</li>

				</ul>
			</div>
		</nav>
	</header>
	<div class="container">

		<h2 class='mainTitle'>Bem vindo ao Gerenciador de Produtos</h2>


		<form id="myForm2" method="get" action="ProdutoServlet.do">
			<div class="form-group d-flex">
				<input type="number" required id="codigo" class="form-control" min=1
					name="codigoBusca"
					placeholder="Digite o código do produto que deseja buscar">
				<button type="submit" class="btn btn-primary">
					<i class="fas fa-search"></i>
				</button>
			</div>
		</form>

		<div class="container-produtos">

			<%
				ProdutoService service = new ProdutoService();
				ArrayList<Produto> lista = service.listarProdutos();

				if (!lista.isEmpty()) {
					for (Produto p : lista) {
			%>
			<div class="container-produtos__item mt-3">
				<div class="logo">
					<i class="fas fa-shopping-bag"></i>
				</div>
				<div class="item">
					<div class="item__group">
						Código:
						<div><%=p.getCodigo()%></div>
					</div>
					<div class="item__group">
						Nome:
						<div><%=p.getNome()%></div>
					</div>
					<div class="item__group">
						Descrição:
						<div><%=p.getDescricao()%></div>
					</div>
					<div class="item__group">
						Estoque:
						<div><%=p.getEstoque()%></div>
					</div>
					<div class="item__group">
						Valor:
						<div>
							R$<%=p.getValor()%></div>
					</div>
				</div>
			</div>

			<%
				}
			%>

			<%
				} else {

					out.print("<div>Não possuí nenhum produto cadastrado no momento! </div>");
				}
			%>

		</div>
	</div>


	<!-- Modal de Cadastro Produto -->
	<div class="modal fade" id="modalForm" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="titleModal"></h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="myForm" method="post" action="ProdutoServlet.do">
						<div class="form-group">
							<input hidden id="inputAction" name="action" value=""> <label
								for="codigo" class="col-form-label">Código</label> <input
								type="number" required id="codigo" class="form-control" min=0
								name="codigo" placeholder="">
						</div>

						<div class="form-group normal">
							<label for="nome" class="col-form-label">Nome</label>
							<textarea type="text" class="form-control"
								placeholder="Digite o nome do produto" id="nome" name="nome"></textarea>
						</div>
						<div class="form-group normal">
							<label for="message-text" class="col-form-label">Descrição</label>
							<textarea class="form-control"
								placeholder="Digite uma descrição para o produto" id="descricao"
								name="descricao"></textarea>
						</div>

						<div class="form-group normal">
							<label for="id" class="col-form-label">Quantidade em
								estoque(não precisa de pontuação)</label> <input type="number"
								class="form-control" id="estoque" name="estoque"
								placeholder="Digite o número de produtos em estoque">
						</div>

						<div class="form-group normal">
							<label for="id" class="col-form-label">Valor do
								Produto(não precisa de pontuação)</label> <input type="number"
								class="form-control" id="valor" name="valor"
								placeholder="Digite o valor">
						</div>

						<div class="modal-footer d-flex justify-content-between">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Fechar</button>
							<button type="submit" class="btn btn-primary">Enviar</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script src="https://kit.fontawesome.com/e71e2a1db7.js"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>
</html>