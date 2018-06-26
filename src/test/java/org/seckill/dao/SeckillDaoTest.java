package org.seckill.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.Seckill;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

/**
 * 配置spring和junit整合，junit启动时加载容器
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})
public class SeckillDaoTest {

    // 注入Dao实现类依赖
    @Resource
    private SeckillDao seckillDao;

    @Test
    public void reduceNumber() {
        /**
         * org.mybatis.spring.transaction.SpringManagedTransaction - JDBC Connection [com.mchange.v2.c3p0.impl.NewProxyConnection@50d68830 [wrapping: com.mysql.jdbc.JDBC4Connection@1e53135d]] will not be managed by Spring
         * org.seckill.dao.SeckillDao.reduceNumber - ==>  Preparing: update seckill set number = number - 1 where seckill_id = ? and start_time <= ? and end_time >= ? and number > 0;
         * org.seckill.dao.SeckillDao.reduceNumber - ==> Parameters: 1000(Long), 2018-06-26 23:07:17.453(Timestamp), 2018-06-26 23:07:17.453(Timestamp)
         */
        Date killTime = new Date();
        int updateCount = seckillDao.reduceNumber(1000L, killTime);
        System.out.println("updateCount=" + updateCount);
    }

    @Test
    public void queryById() {
        long id = 1000;
        Seckill seckill = seckillDao.queryById(id);
        System.out.println(seckill.getName());
        System.out.println(seckill);
        /**
         * 1000元秒杀iphone7
         * SecKill{seckillId=1000, name='1000元秒杀iphone7', number=100, startTime=Wed Jun 20 00:00:00 CST 2018,
         * endTime=Sat Jun 30 00:00:00 CST 2018, createTime=Sun Jun 24 22:40:54 CST 2018}
         */
    }

    @Test
    public void queryAll() {
        /**
         * Caused by: org.apache.ibatis.binding.BindingException: Parameter 'offset' not found.
         * Available parameters are [arg1, arg0, param1, param2]
         *
         * 原因：java不保存形参名。queryAll(int offset, int limit) -> queryAll(arg0,arg1)
         * 解决方案：为接口添加@Param注解
         */
        List<Seckill> seckills = seckillDao.queryAll(0, 100);
        for (Seckill seckill : seckills) {
            System.out.println(seckill);
        }
    }
}