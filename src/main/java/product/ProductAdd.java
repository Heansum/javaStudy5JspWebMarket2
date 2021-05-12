package product;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import DTO.Product;
import exception.DuplicateProductException;
import util.DBMng;

/**
 * Servlet implementation class ProductAdd
 */
@WebServlet("/product/add")
public class ProductAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String filename = "";
		// 프로젝트의 절대 경로
		String realFolder = "C:\\Users\\ITPS\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WebMarket\\images";
		// 업로드될 파일의 최대 크기 5MB
		int maxSize = 15 * 1024 * 1024;
		// 인코딩 유형
		String encType = "UTF-8";
		
		MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		
		String productId = multi.getParameter("productId");
		String name = multi.getParameter("name");
		String unitPrice = multi.getParameter("unitPrice");
		String description = multi.getParameter("description");
		String manufacturer = multi.getParameter("manufacturer");
		String category = multi.getParameter("category");
		String unitsInStock = multi.getParameter("unitsInStock");
		String conditon = multi.getParameter("condition");
		
		Enumeration files = multi.getFileNames();
		String fileName = (String) files.nextElement();
		fileName = multi.getFilesystemName(fileName);
		
		// 상품 정보 저장
		// ProductRepository 객체의 생성을 제한 (싱글턴 패턴)
		try {
			Connection conn = DBMng.getConnection();
			
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO product(p_id, p_name, p_unitPrice, P_description, p_category, p_manufacturer, p_unitsInStock, p_condition, p_fileName) VALUES(?,?,?,?,?,?,?,?,?)");
			
			pstmt.setString(1, productId);
			pstmt.setString(2, name);
			pstmt.setInt(3, Integer.parseInt(unitPrice));
			pstmt.setString(4, description);
			pstmt.setString(5, category);
			pstmt.setString(6, manufacturer);
			pstmt.setInt(7, Integer.parseInt(unitsInStock));
			pstmt.setString(8, conditon);
			
			if(fileName == null) {
				// 업로드한 파일 이미지가 없다면
				pstmt.setNull(9, java.sql.Types.VARCHAR);
			} else {
				// 업로드한 파일 이미지가 있다면
				pstmt.setString(9, fileName);
			}
			
			
			
			int row = pstmt.executeUpdate();
			if(row == 1) {
				// 상품 코드가 중복되지 않아서 성공적으로 상품 정보를 저장했다면
				response.sendRedirect("/WebMarket/product/list?active=products");
			}
		} catch(SQLException e) {
			// 상품 코드가 중복됬다면
			response.getOutputStream().print("duplicate p_id");
			response.setStatus(400);
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
