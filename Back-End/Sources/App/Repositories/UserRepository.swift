//
//  UserRepository.swift
//
//
//  Created by Nanashi Li on 2022/10/09.
//

import Vapor
import Fluent

protocol UserRepository: Repository {
    func create(_ user: User) async -> Void
    func all() -> EventLoopFuture<[User]>
    func find(id: UUID) async throws -> User?
    func find(email: String) async throws -> User?
    func checkIfUserIdExists(id: UUID) async throws -> Bool
    func checkIfEmailExists(email: String) async throws -> Bool
    func checkIfUsernameExists(username: String) async throws -> Bool
    func find(role: UserRoles) async throws -> [User]
    func set<Field>(_ field: KeyPath<User, Field>, to value: Field.Value, for userID: UUID) -> EventLoopFuture<Void> where Field: QueryableProperty, Field.Model == User
    func set<Field>(_ field: KeyPath<User, Field>, to value: Field.Value, for userID: UUID) async throws -> Void where Field: QueryableProperty, Field.Model == User
    func count() -> EventLoopFuture<Int>
    func logout(id: UUID) -> EventLoopFuture<Void>
    func getAccountEmail(id: UUID) async throws -> String?

    // MARK: - Update Account
    func updateEmail(update: UserEmailUpdateRequest, id: UUID) async throws -> Void
    func updateUsername(update: UserUsernameUpdateRequest, id: UUID) async throws -> Void
    func updateFullname(update: UserFullnameUpdateRequest, id: UUID) async throws -> Void
    func updatePassword(update: UserPasswordUpdateRequest, id: UUID, req: Request) async throws -> Void

    // MARK: - MFA
    func updateMFA(isActive: Bool, id: UUID, req: Request) async throws -> Void
    func addMFAMethod(method: MFAEmailMethod, id: UUID, req: Request) async throws -> Void

    // MARK: - Dangerous Actions
    func delete(id: UUID, user: User, req: Request) async throws -> Void
}

struct DatabaseUserRepository: UserRepository, DatabaseRepository {
    let database: Database
    
    func create(_ user: User) async -> Void {
        do {
            return try await user.create(on: database)
        } catch {
            print(error)
            return
        }
    }
    
    func all() -> EventLoopFuture<[User]> {
        return User.query(on: database).all()
    }

    func find(id: UUID) async throws -> User? {
        do {
            return try await User.query(on: database)
                .filter(\.$id == id)
                .first()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func find(email: String) async throws -> User? {
        do {
            return try await User.query(on: database)
                .filter(\.$email == email)
                .first()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func checkIfUserIdExists(id: UUID) async throws -> Bool {
        do {
            guard (try await User.query(on: database)
                .filter(\.$id == id)
                .first()) != nil else {
                return false
            }
            return true
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func checkIfEmailExists(email: String) async throws -> Bool {
        do {
            guard (try await User.query(on: database)
                .filter(\.$email == email)
                .first()) != nil else {
                return false
            }
            return true
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func checkIfUsernameExists(username: String) async throws -> Bool {
        do {
            guard (try await User.query(on: database)
                .filter(\.$username == username)
                .first()) != nil else {
                return false
            }
            return true
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func find(role: UserRoles) async throws -> [User] {
        do {
            return try await User.query(on: database)
                .filter(\.$role == role)
                .all()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func set<Field>(_ field: KeyPath<User, Field>, to value: Field.Value, for userID: UUID) async throws -> Void
        where Field: QueryableProperty, Field.Model == User
    {
        do {
            return try await User.query(on: database)
                .filter(\.$id == userID)
                .set(field, to: value)
                .update()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func set<Field>(_ field: KeyPath<User, Field>, to value: Field.Value, for userID: UUID) -> EventLoopFuture<Void>
        where Field: QueryableProperty, Field.Model == User
    {
        return User.query(on: database)
            .filter(\.$id == userID)
            .set(field, to: value)
            .update()
    }
    
    func count() -> EventLoopFuture<Int> {
        return User.query(on: database).count()
    }

    func logout(id: UUID) -> EventLoopFuture<Void> {
        return AccessToken.query(on: database)
            .filter("user_id.id", .equal, id)
            .delete(force: true)
    }

    func getAccountEmail(id: UUID) async throws -> String? {
        do {
            let user = try await User.query(on: database)
                .filter(\.$id == id)
                .first()

            return user?.email
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    // MARK: - Update Account
    func updateEmail(update: UserEmailUpdateRequest, id: UUID) async throws -> Void {
        do {
            return try await User.query(on: database)
                .filter(\.$id == id)
                .set(\.$email, to: update.email)
                .update()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func updateUsername(update: UserUsernameUpdateRequest, id: UUID) async throws -> Void {
        do {
            return try await User.query(on: database)
                .filter(\.$id == id)
                .set(\.$username, to: update.username)
                .update()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func updateFullname(update: UserFullnameUpdateRequest, id: UUID) async throws -> Void {
        do {
            return try await User.query(on: database)
                .filter(\.$id == id)
                .set(\.$firstName, to: update.firstName)
                .set(\.$lastName, to: update.lastName)
                .update()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func updatePassword(update: UserPasswordUpdateRequest, id: UUID, req: Request) async throws -> Void {
        do {
            return try await User.query(on: database)
                .filter(\.$id == id)
                .set(\.$passwordHash, to: req.password.hash(update.password))
                .update()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    // MARK: - MFA
    func updateMFA(isActive: Bool, id: UUID, req: Request) async throws -> Void {
        do {
            return try await User.query(on: database)
                .filter(\.$id == id)
                .set(\.$twoFactorEnabled, to: isActive)
                .update()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }

    func addMFAMethod(method: MFAEmailMethod, id: UUID, req: Request) async throws -> Void {
        do {
            return try await User.query(on: database)
                .filter(\.$id == id)
                .set(\.$twoFactor, to: method)
                .update()
        } catch {
            throw AuthenticationError.userNotFound
        }
    }


    // MARK: - Dangerous Actions
    func delete(id: UUID, user: User, req: Request) async throws -> Void {
        do {
            try await User.query(on: database)
                .filter(\.$id == id)
                .delete(force: true)

            try await Extensions.query(on: database)
                .filter("extension_creator.creator_id", .equal, id)
                .delete(force: true)

            let _ = try await deleteImage(req, imageUrl: user.profileImage)

        } catch {
            throw AuthenticationError.userNotFound
        }
    }
}

extension Application.Repositories {
    var users: UserRepository {
        guard let storage = storage.makeUserRepository else {
            fatalError("UserRepository not configured, use: app.userRepository.use()")
        }
        
        return storage(app)
    }
    
    func use(_ make: @escaping (Application) -> (UserRepository)) {
        storage.makeUserRepository = make
    }
}
