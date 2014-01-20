import bet.chicken.Role
import bet.chicken.User
import bet.chicken.UserRole

class BootStrap {

    def init = { servletContext ->
		def u = new User(username: 'admin', password: '123456').save(failOnError:true)
		def r = new Role(authority:'ROLE_ADMIN').save(failOnError:true)
		def ur = new UserRole(role:r,user:u).save(failOnError:true)
    }
    def destroy = {
    }
}
