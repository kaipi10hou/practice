package testBoard;

import java.util.List;



public class BoardService {
	BoardDAO  boardDAO;
	
	public BoardService() {
		boardDAO = new BoardDAO();
	}
	
	public List<ArticleVO> listArticles(){
		List<ArticleVO> articlesList = boardDAO.selectAllArticles();
		return articlesList;
		
	}
	public int addArticle(ArticleVO article) {
		return boardDAO.insertNewArticle(article);
	}
	
	public ArticleVO viewArticle(int bno) {
		ArticleVO article = null;
		article = boardDAO.selectArticle(bno);
		return article;
	}
	
	public void modArticle(ArticleVO article) {
		boardDAO.updateArticle(article);
	}
	
	public void removeArticle(int  bno) {
		boardDAO.deleteArticle(bno);
	}
	
}
