package com.util;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.converter.ConverterFactory;
public class StringToEnumConverter implements  ConverterFactory<String, Enum>{
	@Override
	public <T extends Enum> Converter<String, T> getConverter(final Class<T> target) {
		return new Converter<String, T>() {
			@Override
			public T convert(String source) {
				int index=(int)source.charAt(0);
				if(index>=48 && index<=57)
					source="_"+source;
				return (T) Enum.valueOf(target, source);
			}
		};
	}
}