import bet.chicken.Role
import bet.chicken.User
import bet.chicken.UserRole

class BootStrap {

    def init = { servletContext ->
		if (User.count()<2){
			User.deleteAll(User.list())
			def u = new User(username: 'root', password: '1058papero').save(failOnError:true)
			def u2 = new User(username: 'fede0089', password: 'jefe2013').save(failOnError:true)
			def r = new Role(authority:'ROLE_ADMIN').save(failOnError:true)
			new UserRole(role:r,user:u).save(failOnError:true)
			new UserRole(role:r,user:u2).save(failOnError:true)
		}
    }
    def destroy = {
    }
}
