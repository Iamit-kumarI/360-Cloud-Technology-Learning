public class DeacriptionHavingCharacterA {
    public void fetchProduct(String s){
        List<Product2> product=[SELECT Name FROM Product2 WHERE Description LIKE:('%'+ s +'%')];
    	System.debug(product.size()+' Product descriptions have String '+s);  
    }  
}