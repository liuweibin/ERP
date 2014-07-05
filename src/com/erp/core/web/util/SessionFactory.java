package com.erp.core.web.util;

import javax.persistence.Entity;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.cfg.Configuration;

/**
 * Configures and provides access to Hibernate sessions, tied to the
 * current thread of execution.  Follows the Thread Local Session
 * pattern, see {@link http://hibernate.org/42.html}.
 */
@Entity
public class SessionFactory {

    private static String CONFIG_FILE_LOCATION = "/hibernate.cfg.xml";

    private static final ThreadLocal threadLocal = new ThreadLocal();
    private static final Configuration cfg = new AnnotationConfiguration();
    private static  org.hibernate.SessionFactory sessionFactory;

    /**
     * Returns the ThreadLocal Session instance.  Lazy initialize
     * the <code>SessionFactory</code> if needed.
     *
     *  @return Session
     *  @throws HibernateException
     */
    public static Session currentSession() throws HibernateException {
        Session session = (Session) threadLocal.get();

        if (session == null) {
            if (sessionFactory == null) {
                try {
                    cfg.configure(CONFIG_FILE_LOCATION);
                    sessionFactory = cfg.buildSessionFactory();
                }
                catch (Exception e) {
                    System.err.println("%%%% Error Creating SessionFactory %%%%");
                    e.printStackTrace();
                }
            }
            session = sessionFactory.openSession();
            threadLocal.set(session);
        }

        return session;
    }

    /**
     *  Close the single hibernate session instance.
     *
     *  @throws HibernateException
     */
    public static void closeSession() throws HibernateException {
        Session session = (Session) threadLocal.get();
        threadLocal.set(null);

        if (session != null) {
            session.close();
        }
    }

    /**
     * Default constructor.
     */
    private SessionFactory() {
    }

}
