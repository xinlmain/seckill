-- 秒杀执行存储过程
DELIMITER $$   -- 将console换行符由 ; 转换为 $$
-- 定义存储过程
create procedure `seckill`.`execute_seckill`
  (in v_seckill_id bigint, in v_phone bigint,
   in v_kill_time timestamp, out r_result int)
  BEGIN
    DECLARE insert_count int DEFAULT 0;
    start transaction ;
    insert ignore into success_killed
      (seckill_id,user_phone,create_time)
      values (v_seckill_id,v_phone,v_kill_time);
    select row_count () into insert_count;
    if (insert_count = 0) then
      rollback ;
      set r_result = -1;
    elseif(insert_count < 0) then
      rollback ;
      set r_result = -2;
    else
      update seckill
      set number = number - 1
      where seckill_id = v_seckill_id
        and end_time >= v_kill_time
        and start_time <= v_kill_time
        and number > 0;
      select row_count () into insert_count;
      if (insert_count = 0) then
        rollback ;
        set r_result = 0;
      elseif(insert_count < 0) then
        rollback ;
        set r_result = -2;
      else
        commit ;
        set r_result = 1;
      end if;
    end if;
  END;
$$

-- 存储过程定义结束

DELIMITER ; -- 将换行还原为 ;

-- 执行存储过程
set @r_result = -3;

call execute_seckill(1003, 13345678790, now(), @r_result);

-- 获取结果
select @r_result;


-- 存储过程
-- 1： 存储过程优化：事务行级锁持有的时间
-- 2： 不要过度依赖存储过程
-- 3： 简单的逻辑可以使用存储过程
-- 4： QPS：可达到6000/QPS