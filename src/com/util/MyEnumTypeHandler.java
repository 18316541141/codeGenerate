package com.util;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.ibatis.type.EnumTypeHandler;
import org.apache.ibatis.type.JdbcType;
public class MyEnumTypeHandler<E extends Enum<E>> extends EnumTypeHandler<E>{
	private final Class<E> type;
	public MyEnumTypeHandler(Class<E> type) {
		super(type);
		this.type=type;
	}
	  @Override
	  public void setNonNullParameter(PreparedStatement ps, int i, E parameter, JdbcType jdbcType) throws SQLException {
		  if (jdbcType == null) {
	      ps.setString(i, parameter.name().startsWith("_")?parameter.name().substring(1):parameter.name());
	    } else {
	      ps.setObject(i, parameter.name().startsWith("_")?parameter.name().substring(1):parameter.name(), jdbcType.TYPE_CODE); // see r3589
	    }
	  }
	  @Override
	  public E getNullableResult(ResultSet rs, String columnName) throws SQLException {
	    String s = rs.getString(columnName);
	    int index=s.charAt(0);
	    return s == null ? null : Enum.valueOf(type, (index>=48 && index<=57)?("_"+s):s);
	  }

	  @Override
	  public E getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
	    String s = rs.getString(columnIndex);
	    int index=s.charAt(0);
	    return s == null ? null : Enum.valueOf(type, (index>=48 && index<=57)?("_"+s):s);
	  }
	  @Override
	  public E getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
	    String s = cs.getString(columnIndex);
	    int index=s.charAt(0);
	    return s == null ? null : Enum.valueOf(type, (index>=48 && index<=57)?("_"+s):s);
	  }
}