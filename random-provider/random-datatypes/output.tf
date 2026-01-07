output "random_string" {
  value = random_string.example.result
}

output "shuffled_envs" {
  value = random_shuffle.envs.result
}

output "tuple_integer" {
  value = random_integer.tuple_based.result
}

output "random_id" {
  value = random_id.map_example.hex
}

output "password" {
  value     = random_password.object_example.result
  sensitive = true
}
