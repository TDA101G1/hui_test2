package jdbc.util.CompositeQuery;

import java.util.Arrays;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

public class jdbcUtilQuery_For_Index {

	private static String get_aCondition_For_Oracle(String columnName, String value) {
		String aCondition = null;
		if (columnName.equals("product_class") || columnName.equals("product_county"))
			return aCondition = columnName + " LIKE '%" + value + "%'";
		else if (columnName.equals("cust_schedule_id"))
			return aCondition = columnName + " = '" + value + "'";
		return aCondition + " ";
	}

	public static String getFinalSql(Map<String, String[]> map) {
		int count = 0;
		StringBuffer finalSql = new StringBuffer();
		Set<String> keys = map.keySet();
		for (String key : keys) {
			for (int i = 0; i < map.get(key).length; i++) {
				String value = map.get(key)[i];
				if (value != null && value.trim().length() != 0 && !value.equals("全部")) {                
					count++;
					String aCondition = get_aCondition_For_Oracle(key, value.trim());
					if (count == 1)
						finalSql.append(" WHERE " + aCondition);
					else
						finalSql.append(" OR " + aCondition);
				}  
			}
		}
		return finalSql.toString();
	}
	
	public static String getFinalSql_For_productJoinProductCmt(Map<String, String[]> map) {
		int count = 0;
		StringBuffer finalSql = new StringBuffer();
		Set<String> keys = map.keySet();
		for (String key : keys) {
			for (int i = 0; i < map.get(key).length; i++) {
				String value = map.get(key)[i];
				if (value != null && value.trim().length() != 0 && !value.equals("全部")) {                
					count++;
					String aCondition = get_aCondition_For_Oracle(key, value.trim());
					if (count == 1)
						finalSql.append(" HAVING " + aCondition);
					else
						finalSql.append(" OR " + aCondition);
				}  
			}
		}
		return finalSql.toString();
	}
	
	public static String getFinalSql_For_detailjoinProduct(Map<String, String[]> map) {
		int count = 0;
		StringBuffer finalSql = new StringBuffer();
		Set<String> keys = map.keySet();
		for (String key : keys) {
			for (int i = 0; i < map.get(key).length; i++) {
				String value = map.get(key)[i];
				if (value != null && value.trim().length() != 0) {                
					count++;
					String aCondition = get_aCondition_For_Oracle(key, value.trim());
					if(key.equals("cust_schedule_id")) 
						finalSql.append(" WHERE " + aCondition + " AND (");
					
					if(key.equals("product_county")) {
						if(i == (map.get(key).length - 1))
							finalSql.append(aCondition + " ) ");
						else
							finalSql.append(aCondition + " OR ");
					}
				}  
			}
		}
		return finalSql.toString();
	}

	public static void main(String[] args) {
		String[] str = { "keelung", "taipei" };
		Map<String, String[]> map1 = new TreeMap<>();
		map1.put("123", str);
		System.out.println(map1.get("123").length);

	}
}
