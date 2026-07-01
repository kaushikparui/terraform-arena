output "frontend_ip"{value=module.frontend.ipv4}
output "backend_ip"{value=module.backend.ipv4}
output "db_host"{value=module.postgres.host}
output "space_name"{value=module.space.name}
