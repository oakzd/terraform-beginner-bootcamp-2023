## Terrahome AWS

```tf
module "home_pokemon" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.pokemon_public_path
  content_version = var.content_version
}
```

The public directory expects the following:
- index.html
- error.html
- assets

All top level files in assets will be copie, but not any subdirectories