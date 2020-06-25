package com.redis.test;

import redis.clients.jedis.Jedis;

public class SignUpConfirmCode {
	
	public void writeToRedis(String emailAddress) {
		GenerateRandomNumber gen = new GenerateRandomNumber();
		String randomNumber = gen.genAuthCode();
		
		Jedis jedis = new Jedis("localhost", 6379);
		
		jedis.set(emailAddress, randomNumber);
		jedis.expire(emailAddress, 10);
		
		jedis.close();
	}
	
	public static void main(String[] args) {
		
		SignUpConfirmCode a = new SignUpConfirmCode();
		
		String email = "123@yja";
		a.writeToRedis(email);
	}
}
