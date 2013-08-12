package com.guoleMIS.service.base;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.lang.reflect.Method;
import java.util.List;

import com.guoleMIS.util.Config;
import com.guoleMIS.service.base.IBaseService;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

public abstract class BaseServiceImpl<V extends Serializable> implements IBaseService<V> {

    static JedisPool jedisPool; // 非切片链接池 
    
    static final String redis_host;//Jedis服务器IP
    
    static final String redis_password;//Jedis服务器密码
	
	static final int redis_port;//Jedis服务器端口
    
    static int maxActive;//Jedis服务器最大激活连接数
    
    static int maxIdle;//Jedis服务器最大闲置连接数
    
    static long maxWait;//Jedis服务器最大等待时长
    
    static int timeOut;//Jedis服务器超时时间
    
    static Config config = Config.getInstance();
    
	static {
		redis_host = config.getString("redis_host");
		redis_port = Integer.parseInt(config.getString("redis_port"));
		redis_password = config.getString("redis_password");
		maxActive =  Integer.parseInt(config.getString("maxActive"));
		maxIdle = Integer.parseInt(config.getString("maxIdle"));
		maxWait = Long.parseLong(config.getString("maxWait"));
		timeOut = Integer.parseInt(config.getString("timeOut"));
		initialPool();
	}
	
	 public Jedis getJedis(){
		 return jedisPool.getResource();
	 }
	 
	 public void closeJedis(Jedis jedis){
		 jedisPool.returnResource(jedis);
	 }
	 
	 public void returnBrokenJedis(Jedis jedis){
		 jedisPool.returnBrokenResource(jedis);
	 }
    
	 public static void initialPool() {
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxActive(maxActive);
        config.setMaxIdle(maxIdle);
        config.setMaxWait(maxWait);
        config.setTestOnBorrow(true);
        jedisPool = new JedisPool(config, redis_host,redis_port,timeOut,redis_password);
	 }
	
	private Jedis jedis;

	@SuppressWarnings("finally")
	public V get(String key) {
		V v = null;
	    try{
			jedis = getJedis();
			v = byte2Object(jedis.get(getKey(key)));
		}catch (Exception e) {
			if(jedis != null)returnBrokenJedis(jedis);
		} finally{
			if(jedis != null)closeJedis(jedis);
			return v;
		}
	}

	
	public void save(String key, String value) {
		try{
			jedis = getJedis();
		    jedis.set(key, value);
		}catch (Exception e) {
			if(jedis != null)returnBrokenJedis(jedis);
		} finally{
			if(jedis != null)closeJedis(jedis);
		}
	}

	@SuppressWarnings("finally")
	public String getStr(String key) {
		String s = null;
		try{
			jedis = getJedis();
			s = jedis.get(key);
		}catch (Exception e) {
			if(jedis != null)returnBrokenJedis(jedis);
		} finally{
			if(jedis != null)closeJedis(jedis);
			return s;
		}
	}

	public void saveStr(String key, String value) {
		try{
			jedis = getJedis();
			jedis.set(key, value);
		}catch (Exception e) {
			if(jedis != null)returnBrokenJedis(jedis);
		} finally{
			if(jedis != null)closeJedis(jedis);
		}
	}

	public void updateStr(String key, String value) {
		saveStr(key, value);
	}

	public List<String> find(int pageNum, int pageSize) {
		return null;
	}

	private byte[] getKey(String key) {
		return key.getBytes();
	}

	@SuppressWarnings("finally")
	public Long incr(String key) {
		Long l = 0l;
		try{
			jedis = getJedis();
			l = jedis.incr(key);
		}catch (Exception e) {
			if(jedis != null)returnBrokenJedis(jedis);
		} finally{
			if(jedis != null)closeJedis(jedis);
			return l;
		}
	}

	public void addHeadList(String key, String oneValue) {
		try{
			jedis = getJedis();
			jedis.lpush(key, oneValue);
		}catch (Exception e) {
			if(jedis != null)returnBrokenJedis(jedis);
		} finally{
			if(jedis != null)closeJedis(jedis);
		}
	}

	@SuppressWarnings("unchecked")
	public V byte2Object(byte[] bytes) {
		if (bytes == null || bytes.length == 0)return null;
		try {
			ObjectInputStream inputStream;
			inputStream = new ObjectInputStream(new ByteArrayInputStream(bytes));
			Object obj = inputStream.readObject();
			return (V) obj;
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	protected byte[] object2Bytes(V value) {
		if (value == null)return null;
		ByteArrayOutputStream arrayOutputStream = new ByteArrayOutputStream();
		ObjectOutputStream outputStream;
		try {
			outputStream = new ObjectOutputStream(arrayOutputStream);
			outputStream.writeObject(value);
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				arrayOutputStream.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return arrayOutputStream.toByteArray();
	}
	
	@SuppressWarnings({ "finally", "unchecked" })
	@Override
	public List<byte[]> mget(String[] keys) {
		List<byte[]> l = null;
		try {
			byte[][] t = new byte[keys.length][];
			int i=0;
			for(String key :keys){
				t[i] = key.getBytes();
				i++;
			}
			jedis = getJedis();
			Method mget = jedis.getClass().getMethod("mget", new Class[]{byte[][].class});
			l = (List<byte[]>) mget.invoke(jedis, t);
		} catch (Exception e) {
			e.printStackTrace();
			if(jedis != null)returnBrokenJedis(jedis);
		} finally{
			if(jedis != null)closeJedis(jedis);
			return l;
		}
	}
}