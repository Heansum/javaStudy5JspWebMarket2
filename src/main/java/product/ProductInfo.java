package product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DTO.Product;
import util.DBMng;

/**
 * Servlet implementation class ProductInfo
 */
@WebServlet("/product/info")
public class ProductInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String p_id = request.getParameter("p_id");
			
			Connection conn = DBMng.getConnection();
			
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM product WHERE p_id = ?");
			
			pstmt.setString(1, p_id);
			
			ResultSet rs = pstmt.executeQuery();
			boolean isExist = rs.next();
			if(isExist) {
				// 사용자가 요청한 상품의 상세 정보를 찾았다면은 
				String p_name = rs.getString("p_name");
				int p_unitPrice = rs.getInt("p_unitPrice");
				String p_description = rs.getString("p_description");
				String p_category = rs.getString("p_category");
				String p_manufacturer = rs.getString("p_manufacturer");
				int p_unitsInStock = rs.getInt("p_unitsInStock");
				String p_condition = rs.getString("p_condition");
				String p_fileName = rs.getString("p_fileName");
				
				Product product = new Product(p_id, p_name, p_unitPrice, p_description, p_category,
						p_manufacturer, p_unitsInStock, p_condition, p_fileName);
				
				request.setAttribute("product", product);
				
				RequestDispatcher dis = request.getRequestDispatcher("/product/info.jsp");
				dis.forward(request, response);
			} else {
				// 사용자가 요청한 상품의 상세 정보를 찾지못했다면은
				response.setStatus(404);
			}
		} catch(SQLException e) {
			e.printStackTrace();
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
