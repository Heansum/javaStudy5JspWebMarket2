package DAO;

import java.util.ArrayList;
import java.util.List;

import DTO.Product;
import exception.DuplicateProductException;

public class ProductRepository {
	private List<Product> listOfProducts;
	{
		listOfProducts = new ArrayList<Product>();
	}
	
	// �겢�옒�뒪�쓽 硫ㅻ쾭 蹂��닔濡� �옄湲� �옄�떊�쓣 媛뽮퀬 �엳�쓬
	private static ProductRepository productRepository;
	static {
		productRepository = new ProductRepository();
	}
	
	// �겢�옒�뒪 硫ㅻ쾭 蹂��닔濡� �꽑�뼵�릺�뼱�엳�뒗 �옄湲� �옄�떊(�씠 �겢�옒�뒪�쓽 �씤�뒪�꽩�뒪)�쓣
	// 諛섑솚�븯�뒗 硫붿꽌�뱶
	public static ProductRepository getInstance() {
		return productRepository;
	}
	
	// �젒洹쇱젣�뼱�옄媛� private �씤 �깮�꽦�옄�쓽 �쓽誘�?
	// �겢�옒�뒪�쓽 �쇅遺��뿉�꽌 �씤�뒪�꽩�뒪瑜� 留뚮뱾 �닔 �뾾�쓬
	private ProductRepository() {
		Product phone = new Product("P1234", "iPhone 6s", 800000);
		phone.setDescription("4.7-inch, 1334X750 Retina HD display, 8-megapixel iSight Camera");
		phone.setCategory("Smart Phone");
		phone.setManufacturer("Apple");
		phone.setUnitsInStock(1000);
		phone.setCondition("New");
		phone.setImagePath("P1234.jpg");
		
		Product notebook = new Product("P1235", "LG PC Gram", 1500000);
		notebook.setDescription("13.3-inch, IPS LED display, 5rd Generation Intel Core processor");
		notebook.setCategory("Notebook");
		notebook.setManufacturer("LG");
		notebook.setUnitsInStock(1000);
		notebook.setCondition("Refurbished");
		notebook.setImagePath("P1235.jpg");
		
		Product tablet = new Product("P1236", "Galaxy Tab 5", 900000);
		tablet.setDescription("212.8*125.6*6.6mm, Super AMOLED display, Octa-Core processor");
		tablet.setCategory("Tablet");
		tablet.setManufacturer("Samsung");
		tablet.setUnitsInStock(10000);
		tablet.setCondition("Old");
		tablet.setImagePath("P1236.jpg");
		
		listOfProducts.add(phone);
		listOfProducts.add(notebook);
		listOfProducts.add(tablet);
	}
	
	public ArrayList<Product> getAllProducts() {
		return (ArrayList<Product>) listOfProducts;
	}
	
	public Product getProduct(String productId) {
		Product product = null;

		// �궗�슜�옄媛� �썝�븯�뒗 �긽�뭹�쓽 �긽�꽭 �젙蹂대�� 媛��졇���꽌
		// product 媛앹껜�뿉 ���옣�븯�뒗 肄붾뱶
		for(Product nthProduct : listOfProducts) {
			String nthProductId = nthProduct.getProductId();
			
			if(nthProductId.equals(productId)) {
				product = nthProduct;
				break;
			}
		}
		
		return product;
	}
	
	// �긽�뭹 異붽�
	public void addProduct(Product product) throws DuplicateProductException {
		for(Product nthProduct : listOfProducts) {
			String nthProductId = nthProduct.getProductId();
			
			if(nthProductId.equals(product.getProductId())) {
				throw new DuplicateProductException(product.getProductId() + "媛� 以묐났�릺�뿀�쓬");
			}
		}
		
		listOfProducts.add(product);
	}
}






