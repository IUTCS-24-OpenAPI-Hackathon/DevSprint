package config

type PermissionType string
type PermissionFor string

const (
	SystemPermissionType PermissionFor = "system"
	UserPermissionType   PermissionFor = "user"
)

const (
	// roles
	RolePermissionFor PermissionType = "role"
	UserPermissionFor PermissionType = "user"
)

// PermissionAction represents an action that can be performed on a permission type
type PermissionAction string

// Define constants for permission actions
const (
	ReadPermission   PermissionAction = "read"
	CreatePermission PermissionAction = "create"
	UpdatePermission PermissionAction = "update"
	DeletePermission PermissionAction = "delete"
	AssignPermission PermissionAction = "assign"
	RevokePermission PermissionAction = "revoke"
)

// Permission represents a specific permission with its name and description
type Permission struct {
	Name string
	Desc string
}

// PermissionSet represents a set of permissions for a specific type
type PermissionSet struct {
	Read   Permission
	Create Permission
	Update Permission
	Delete Permission
	Assign Permission
	Revoke Permission
}

// SystemPermissionSet contains system-related permissions
var PsSystemPermission = PermissionSet{
	Read:   Permission{"system:permission:read", "Read system permissions"},
	Create: Permission{"system:permission:create", "Create system permissions"},
	Update: Permission{"system:permission:update", "Update system permissions"},
	Delete: Permission{"system:permission:delete", "Delete system permissions"},
}

var PsSystemRole = PermissionSet{
	Read:   Permission{"system:role:read", "Read system roles"},
	Create: Permission{"system:role:create", "Create system roles"},
	Update: Permission{"system:role:update", "Update system roles"},
	Delete: Permission{"system:role:delete", "Delete system roles"},
}

var PsUserRole = PermissionSet{
	Assign: Permission{"user:role:assign", "Assign roles to users"},
	Revoke: Permission{"user:role:revoke", "Revoke roles from users"},
	Read:   Permission{"user:role:read", "Read system roles"},
}

var PsUser = PermissionSet{
	Read:   Permission{"user:read", "Read system users"},
	Create: Permission{"user:create", "Create system users"},
	Update: Permission{"user:update", "Update system users"},
	Delete: Permission{"user:delete", "Delete system users"},
}

var PsPharmacyOwner = PermissionSet{
	Create: Permission{"pharmacy:owner:create", "Create pharmacy owners"},
}

var PsSubscriptionPlan = PermissionSet{
	Create: Permission{"sub:plan:create", "Create subscription plans"},
	Update: Permission{"sub:plan:update", "Update subscription plans"},
}

var PsSubscriptionRequest = PermissionSet{
	Read:   Permission{"sub:request:read", "Read subscription requests"},
	Update: Permission{"sub:request:update", "Update subscription requests"},
	Delete: Permission{"sub:request:delete", "Delete subscription requests"},
}
