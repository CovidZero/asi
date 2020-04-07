output "cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.main.name
}

output "cluster_id" {
  description = "ECS Cluster Id"
  value       = aws_ecs_cluster.main.id
}
