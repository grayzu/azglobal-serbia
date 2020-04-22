security_group_rules = [
    {
        name                  = "http"
        priority              = 100
        protocol              = "tcp"
        destinationPortRange  = "80"
        direction             = "Inbound"
        access                = "Allow"
    },
    {
        name                  = "https"
        priority              = 150
        protocol              = "tcp"
        destinationPortRange  = "443"
        direction             = "Inbound"
        access                = "Allow"
    },
    {
        name                  = "deny-the-rest"
        priority              = 200
        protocol              = "*"
        destinationPortRange  = "0-65535"
        direction             = "Inbound"
        access                = "Deny"
    },
]
secret_id = "vmadmin"
key_vault = "globalazkv"