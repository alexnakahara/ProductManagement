package service;

import java.util.ArrayList;
import dao.ProdutoDAO;
import model.Produto;


public class ProdutoService {

	public ArrayList<Produto> listarProdutos(){
		ProdutoDAO dao = new ProdutoDAO();
		return dao.listarProdutos();
	}
	
	public boolean cadastrar(Produto p) {
		ProdutoDAO dao = new ProdutoDAO();
		
		if(p.getCodigo() >= 1 && p.getNome() != null &&
			p.getNome().length() <= 256 && p.getDescricao() !=null) {
			return dao.cadastrar(p);
		} else {
			return false;
		}
	}
	
	public boolean alterar(Produto p) {
		if(p.getCodigo() <= 0)
			return false;
		
		ProdutoDAO dao = new ProdutoDAO();
		return dao.alterar(p);
			
		
	}
	
	public boolean deletar(int cod) {
		ProdutoDAO dao = new ProdutoDAO();
		if(cod >= 1) {
			return dao.excluir(cod);
		} else {
			return false;
		}
	}
	
	public Produto consultar(int cod) {
		ProdutoDAO dao = new ProdutoDAO();
		if(cod >= 1) {
			return dao.consultar(cod);
		} else {
			return null;
		}
	}
	
}
