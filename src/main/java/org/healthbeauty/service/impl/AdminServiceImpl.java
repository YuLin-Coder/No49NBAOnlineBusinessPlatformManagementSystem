package org.healthbeauty.service.impl;

import org.healthbeauty.dao.AdminMapper;
import org.healthbeauty.pojo.Admin;
import org.healthbeauty.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

    @Autowired(required = false)
    private AdminMapper adminMapper;

    @Override
    public Admin selectByName(Admin admin) {
        return adminMapper.selectByName(admin);
    }
}
