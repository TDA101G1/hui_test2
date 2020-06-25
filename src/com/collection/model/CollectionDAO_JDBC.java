package com.collection.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.inbox.model.InboxVO;
import com.sun.org.apache.bcel.internal.generic.DMUL;
import Common.common;
public class CollectionDAO_JDBC implements CollectionDAO_interface {
	
//	String driver = "oracle.jdbc.driver.OracleDriver";
//	String url = "jdbc:oracle:thin:@localhost:49161:XE";
//	String userid = "TDA101G1";
//	String passwd = "123456";
	
	private static final String INSERT_STMT = "INSERT INTO Collection (collection_ID, member_ID, product_ID) VALUES ('COID'||LPAD(to_char(SEQ_COLLECTION_ID.NEXTVAL),6,'0'), ?, ?)";
	private static final String GET_ALL_STMT = "SELECT collection_ID, member_ID, product_ID FROM collection order by collection_ID";
	private static final String GET_ONE_STMT = "SELECT collection_ID, member_ID, product_ID FROM collection where collection_ID=?";
	private static final String DELETE = "DELETE FROM collection WHERE collection_ID=?";
	private static final String SELECT_BY_MEMEBER = "SELECT collection_ID, member_ID, product_ID FROM collection where member_id=?";

	@Override
	public CollectionVO getOne(String collection_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		CollectionVO collection = new CollectionVO();
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ONE_STMT);
			ps.setString(1, collection_ID);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				collection.setCollection_ID(rs.getString("collection_ID"));
				collection.setMember_ID(rs.getString("member_ID"));
				collection.setProduct_ID(rs.getString("product_ID"));
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		finally{
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return collection;
	}

	@Override
	public List<CollectionVO> getAll() {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		CollectionVO collection = null;
		List<CollectionVO> collections = new ArrayList<CollectionVO>();
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(GET_ALL_STMT);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				collection = new CollectionVO();
				collection.setCollection_ID(rs.getString("collection_ID"));
				collection.setMember_ID(rs.getString("member_ID"));
				collection.setProduct_ID(rs.getString("product_ID"));
				collections.add(collection);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		finally{
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return collections;
	}

	@Override
	public CollectionVO insert(CollectionVO collection) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(INSERT_STMT, new String[] { "COLLECTION_ID" });
			ps.setString(1, collection.getMember_ID());
			ps.setString(2, collection.getProduct_ID());
			
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(rs.next()) {
				collection.setCollection_ID(rs.getString(1));
			}
			con.commit();
			return collection;
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return null;
	}
	

	@Override
	public Integer delete(String collection_Number) {
		Connection con = null;
		PreparedStatement ps = null;
		Integer result = -1;
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			con.setAutoCommit(false);
			ps = con.prepareStatement(DELETE);
			
			ps.setString(1, collection_Number);
			result = ps.executeUpdate();
			
			con.commit();
			return result;
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			try {
				con.rollback();
				throw new RuntimeException("A database error occured. " + e.getMessage());
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return result;
	}

	@Override
	public Set<CollectionVO> getCollectionByMemberID(String member_ID) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Set<CollectionVO>collections = new HashSet<CollectionVO>();
		
		try {
			Class.forName(common.DRIVER);
//			con = DriverManager.getConnection(common.URL, common.USERID, common.PASSWD);
			con = common.dataSource.getConnection();
			ps = con.prepareStatement(SELECT_BY_MEMEBER);
			ps.setString(1, member_ID);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				CollectionVO collection = new CollectionVO();
				collection.setCollection_ID(rs.getString("collection_ID"));
				collection.setMember_ID(rs.getString("member_ID"));
				collection.setProduct_ID(rs.getString("product_ID"));
				collections.add(collection);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. " + e.getMessage());
		}
		
		finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return collections;
	}

}
