output "cluster_name" {
  value = aws_eks_node_group.hotstar_workers.cluster_name
}

output "node_group_name" {
  value = aws_eks_node_group.hotstar_workers.node_group_name
}

output "node_group_status" {
  value = aws_eks_node_group.hotstar_workers.status
}

output "instance_types" {
  value = aws_eks_node_group.hotstar_workers.instance_types
}
