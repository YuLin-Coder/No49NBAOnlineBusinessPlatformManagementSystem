package org.healthbeauty.service;

import java.util.List;

import org.healthbeauty.pojo.Address;
import org.healthbeauty.pojo.AddressExample;

public interface AddressService {
    public List<Address> getAllAddressByExample(AddressExample addressExample);

    public void updateByPrimaryKeySelective(Address address);

    public void deleteByPrimaryKey(Integer addressid);

    public void insert(Address address);

    public void  insertSelective(Address address);

    public Address selectByPrimaryKey(Integer addressid);
}
