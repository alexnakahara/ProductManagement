package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Produto;
import service.ProdutoService;


@WebServlet("/ProdutoServlet.do")
public class ProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ProdutoServlet() {
        // TODO Auto-generated constructor stub
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		StringBuilder builder = new StringBuilder();
		ProdutoService service = new ProdutoService();
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		
		int cod = Integer.parseInt(request.getParameter("codigo"));
		

		switch (request.getParameter("action")) {
			case "deletar":
				 if(!service.deletar(cod)) { 
					 builder.append("<center style='background-color: red; color: white;'>Não foi possível deletar o produto, tente novamente!</center>");
				 } else { 
					 
					 builder.append("<center style='background-color: green; color: white;'>Produto deletado com sucesso!</center>");
				 }
				break;
				
			case "alterar":
				Produto old = service.consultar(cod);
				
				String nome = request.getParameter("nome").isEmpty() ? old.getNome() : request.getParameter("nome") ;
				
				String descricao = request.getParameter("descricao").isEmpty() ? old.getDescricao() : request.getParameter("descricao");
				
				int estoque = request.getParameter("estoque").isEmpty() || request.getParameter("estoque") == null
						? old.getEstoque() : Integer.parseInt(request.getParameter("estoque"));
						
				double valor = request.getParameter("valor").isEmpty() || request.getParameter("valor") == null 
						? old.getValor() : Double.parseDouble(request.getParameter("valor"));
				
				Produto p = new Produto(cod, nome,descricao, valor, estoque);
				
				if (!service.alterar(p)) {
					builder.append("<center style='background-color: red; color: white;'>Não foi possível atualizar a notícia, tente novamente!</center>");
					
				} else {
					
					builder.append("<center style='background-color: green; color: white;'>Produto atualizado com sucesso!</center>");
				}
				
				break;
				
			default:
				String nome1 = request.getParameter("nome");
				String descricao1 = request.getParameter("descricao");
				int estoque1 = Integer.parseInt(request.getParameter("estoque"));
				double valor1 = Double.parseDouble(request.getParameter("valor"));
				Produto prod = new Produto(cod, nome1, descricao1, valor1, estoque1);
				if (!service.cadastrar(prod)) {
					builder.append("<center style='background-color: red; color: white;'>Não foi possível cadastrar a notícia, tente novamente!</center>");
					
				} else {
					
					builder.append("<center style='background-color: green; color: white;'>Produto cadastrado com sucesso!</center>");
				}
				break;
		}
		
		response.setCharacterEncoding("UTF-8");
		out.print(builder.toString());
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.include(request, response);
		
	}

}
