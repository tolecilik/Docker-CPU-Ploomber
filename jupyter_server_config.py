c = get_config()  # noqa

# Listen di semua IP
c.ServerApp.ip = "0.0.0.0"

# Allow access dari mana saja
c.ServerApp.allow_origin = "*"

# Nonaktifkan token/password supaya platform bisa akses
c.ServerApp.token = ""
c.ServerApp.password = ""

# Notebook root directory
c.ServerApp.notebook_dir = "/app"

# Aktifkan collaborative mode jika ingin
c.LabApp.collaborative = True
