resource "aws_internet_gateway" "gw" {
  count = length(local.vpc_ids)
  vpc_id = element(local.vpc_ids, count.index)

  tags = {
    Name = "${var.env}-gw"

  }
}

resource "aws_eip" "ngw" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngw.id
  subnet_id     = lookup(lookup(module.public_subnets, "public", null), "subnets", null)[0].id
  tags = {
    Name = "NAT GW"
  }
}