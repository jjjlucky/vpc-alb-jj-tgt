// output the url of the load balancer app
output "load_balancer_dns_name" {
  value = aws_lb.app-lb.dns_name

}
