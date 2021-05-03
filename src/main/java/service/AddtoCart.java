package service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DTO.Product;

/**
 * Servlet implementation class AddtoCart
 */
@WebServlet("/cart/add")
public class AddtoCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddtoCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 사용자가 장바구니에 추가할 상품 번호를 전달하면
		// 해당 번호를 저장한다. 
		
		// 사용자의 장바구니 정보를 갖고 있는 세션을 가져온다.
		HttpSession session = request.getSession();
		
//		// 세션이 생성된 시간을 반환
//		System.out.println(session.getCreationTime());
//		// 세션의 ID를 반환
//		System.out.println(session.getId());
//		// 세션의 생성 여부(처음 생성된 세션이면 true, 이전에 생성된 세션이면 false를 반환)
//		System.out.println(session.isNew());
		
		// 세션에서 장바구니(goodsList)를 꺼낸다.
		ArrayList<String> goodsList = (ArrayList<String>) session.getAttribute("goodsList");
		if(goodsList == null) {
			goodsList = new ArrayList<String>();
		}
		
		String productId = request.getParameter("productId");
		System.out.println(productId);
		goodsList.add(productId);
		
		session.setAttribute("goodsList", goodsList);
		
		response.setStatus(204);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
