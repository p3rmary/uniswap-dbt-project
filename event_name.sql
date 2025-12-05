{% macro event_name(topic_0) %}

case {{ topic_0 }}
    when '0x1b3d7edb2e9c0b0e7c525b20aaaef0f5940d2ed71663c7d39266ecafac728859'
        then 'Transfer'
    
    when '0x40e9cecb9f5f1f1c5b9c97dec2917b7ee92e57ba5563708daca94dd84ad7112f'
        then 'Swap'
    
    when '0x8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e0'
        then 'Ownership Transferred'
    
    when '0xb3fd5071835887567a0671151121894ddccc2842f1d10bedad13e0d17cace9a7'
        then 'Approval'
    
    when '0xceb576d9f15e4e200fdb5096d64d5dfd667e16def20c1eefd14256d8e3faa267'
        then 'Operator set'
    
    when '0xdd466e674ea557f56295e2d0218a125ea4b4f0f6f3307b95f85e6110838d6438'
        then 'Initialize'
    
    when '0xf208f4912782fd25c7f114ca3723a2d5dd6f3bcc3ac8db5af63baa85f711d5ec'
        then 'Modify liquidity'
    
    else 'unknown'
end 

{% endmacro %}