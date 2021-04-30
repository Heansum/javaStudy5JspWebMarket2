package filter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LogFilter implements Filter {
	private PrintWriter writer;
	
	@Override
	public void destroy() {
		System.out.println("LogFilter Down");
		
		writer.close();
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		System.out.println("LogFilter Start Up");
		
		String filename = filterConfig.getInitParameter("filename");
		if(filename == null) throw new ServletException("로그 파일의 이름을 찾을 수 없음");
		
		try {
			writer = new PrintWriter(new FileWriter(filename, true), true);
		} catch(IOException e) {
			throw new ServletException("로그 파일 열 수 없음");
		}
		
		
		
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		long start = System.currentTimeMillis();
		
		String clientIP = request.getRemoteAddr();
		String url = getURLPath(request);
		String startTime = getCurrentTime();
		
		chain.doFilter(request, response);
		
		long end = System.currentTimeMillis();
		
		String endTime = getCurrentTime();
		long duration = end - start;
		
		System.out.println("클라이언트 IP : " + clientIP);
		System.out.println("URL : " + url);
		System.out.println("요청 처리 시작 : " + startTime);
		System.out.println("요청 처리 완료 : " + endTime);
		System.out.println("요청 처리 소요 시간 : " + duration + "ms");
		System.out.println("========== ========== ==========");
		
		writer.println("클라이언트 IP : " + clientIP);
		writer.println("URL : " + url);
		writer.println("요청 처리 시작 : " + startTime);
		writer.println("요청 처리 완료 : " + endTime);
		writer.println("요청 처리 소요 시간 : " + duration + "ms");
		writer.println("========= ========= =========");
		
	}
	
	private String getURLPath(ServletRequest request) {
		HttpServletRequest req;
		
		String currentPath = "";
		String queryString = "";
		
		if(request instanceof HttpServletRequest) {
			req = (HttpServletRequest) request;
			currentPath = req.getRequestURI();
			queryString = req.getQueryString();
			queryString = queryString == null ? "" : "?" + queryString;
		}
		
		return currentPath + queryString;
	}

	private String getCurrentTime() {
		DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		return formatter.format(calendar.getTime());
	}
}
