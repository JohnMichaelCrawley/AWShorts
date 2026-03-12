# Instance Count
variable "instance_count" {
    default = 4
}
# Instance Type 
variable "instance_type" {
    default = "t2.nano"
}

# Region 
variable "region" {
    default = "eu-west-1"
}
# Instance names
variable "instance_names" {
    type = list(string)
    default = [
        "Server1", 
        "Server2",
        "Server3",
        "Server4"   
    ]
}

