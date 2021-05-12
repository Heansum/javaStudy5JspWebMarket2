package product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DTO.Product;
import util.DBMng;

/**
 * Servlet implementation class ProductList
 */
@WebServlet("/product/list")
public class ProductList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductList() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * 상품 목록 페이지에 필요한 상품의 목록을 DB에서 가져와
	 * request에 담아서 포워딩한다.
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Connection conn = DBMng.getConnection();
			
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM product");
			
			ResultSet rs = pstmt.executeQuery();
			
			// View로 전달할 상품의 목록
			List<Product> productList = new ArrayList<>();
			
			while(rs.next()) {
				// n번째 상품을 목록에 저장
				
				// n번째 상품의 p_id 칼럼의 값을 꺼냄
				String p_id = rs.getString("p_id");
				
				// n번째 상품의 p_name 칼럼의 값을 꺼냄
				String p_name = rs.getString("p_name");
				
				// n번째 상품의 p_unitPrice 칼럼의 값을 꺼냄
				int p_unitPrice = rs.getInt("p_unitPrice");
				
				// n번째 상품의 p_description 칼럼의 값을 꺼냄
				String p_description = rs.getString("p_description");
				
				// n번째 상품의 p_manufacturer 칼럼의 값을 꺼냄
				String p_manufacturer = rs.getString("p_manufacturer");
				
				// n번째 상품의 p_category 칼럼의 값을 꺼냄
				String p_category = rs.getString("p_category");
				
				// n번째 상품의 p_unitsInStock 칼럼의 값을 꺼냄
				int p_unitsInStock = rs.getInt("p_unitsInStock");
				
				// n번째 상품의 p_condition 칼럼의 값을 꺼냄
				String p_condition = rs.getString("p_condition");
				
				// n번째 상품의 p_fileName 칼럼의 값을 꺼냄
				String p_fileName = rs.getString("p_fileName");
				
				
				
				// n번째 상품의 데이터를 저장할 객체 생성
				Product product = new Product(p_id, p_name, p_unitPrice, p_description, p_manufacturer, p_category,
						 p_unitsInStock, p_condition, p_fileName);
				
				productList.add(product);
			} // end while
			
			request.setAttribute("productList", productList);
			
			RequestDispatcher dis = request.getRequestDispatcher("/product/list.jsp");
			dis.forward(request, response);
			
		} catch(SQLException e) {
			RequestDispatcher dis = request.getRequestDispatcher("/error/500.jsp");
			dis.forward(request, response);
		} finally {
			DBMng.closeConnection();
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
