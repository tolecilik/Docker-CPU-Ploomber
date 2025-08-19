c = get_config()  # noqa

# Listen di semua IP
c.ServerApp.ip = "0.0.0.0"
c.ServerApp.allow_origin = "*"  # akses dari mana saja
c.ServerApp.token = ""          # disable token
c.ServerApp.password = ""       # disable password

# Enable collaborative mode
c.LabApp.collaborative = True

# Set default notebook dir
c.ServerApp.notebook_dir = "/app"
