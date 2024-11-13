# Creating New Migrations for up and down
createNewMigration:
	migrate create -ext sql -dir db/migration -seq init-schema

# Apply migrations
migrateup:
	migrate -path ./db/migration -database "postgres://bankingGo2:bankingGo2@localhost:5433/bankingGo2?sslmode=disable" -verbose up

# Apply Force migrations
migrateupForce:
	migrate -path ./db/migration -database "postgres://bankingGo2:bankingGo2@localhost:5433/bankingGo2?sslmode=disable" force 1

# Configrm migrations have been applied
confirmMigrateup:
	docker exec -it banking-application-db-1 psql -U bankingGo2 -d bankingGo2 -c '\dt'

# Remove Last migration applied
migratedown:
	migrate -path ./db/migration -database "postgres://bankingGo2:bankingGo2@localhost:5433/bankingGo2?sslmode=disable" -verbose down

# Force database version if dirty
forcedatabaseVersion:
	migrate -path ./db/migration -database "postgres://bankingGo2:bankingGo2@localhost:5433/bankingGo2?sslmode=disable" force 1

# Generate Go files with sql queries
sqlc: 
	sqlc generate	

.PHONY: confirmMigrateup migrateup migratedown createNewMigration migrateupForce forcedatabaseVersion sqlc