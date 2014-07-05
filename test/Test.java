import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.security.authentication.encoding.Md5PasswordEncoder;
import org.springframework.security.authentication.encoding.PasswordEncoder;


public class Test {
	private static Md5PasswordEncoder md5PasswordEncoder;
	private static Logger logger = Logger.getLogger(Test.class);
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 ApplicationContext context  = new ClassPathXmlApplicationContext(new String[] { "applicationContext*.xml" });

		/* AgentsUserTblDao agentsUserTblDao = (AgentsUserTblDao) context.getBean("agentsUserTblDao");
		 AgentsUserTbl agentsUserTbl = agentsUserTblDao.find("13751867590");
			System.out.println(agentsUserTbl.getLastLoginIp());
			System.out.println(Charset.defaultCharset());  
	 
			System.out.println("OK==========================");*/
		 
		 md5PasswordEncoder = (Md5PasswordEncoder) context.getBean("md5PasswordEncoder");
		 System.out.println(md5PasswordEncoder.encodePassword("123456", "13751867590"));//WCYZ71X6hNUAT42tr/tXtA==
		 System.out.println(md5PasswordEncoder.encodePassword("123456", null));//4QrcOUm6Wau+VuBX8g+IPg==
		// test();
	}
	public static void test(){
		System.out.println("begin");
		Boolean bo = md5PasswordEncoder.isPasswordValid("WCYZ71X6hNUAT42tr/tXtA==", "123456", "13751867590");
		System.out.println(bo);// 4QrcOUm6Wau+VuBX8g+IPg==
		  if(!bo)
	        {
			  logger.info("Authentication failed: password does not match stored value");
	        }
			System.out.println("end");
	}
}
