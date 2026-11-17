from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)




app.config["SQLALCHEMY_DATABASE_URI"] = ("mysql+pymysql://root:1234@localhost/airlineDB")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

#Database Models
class   Aircraft(db.Model):
    __tablename__ = "aircraft"

    aircraftID = db.Column(db.Integer, primary_key=True)
    model = db.Column(db.String(50))
    manufacturer = db.Column(db.String(50))
    seating_capacity = db.Column(db.Integer)
    registration_no = db.Column(db.String(50))
    
@app.route("/")
def home():
    return render_template("home.html")

@app.route("/about")
def about():
    return "Airline Administration System - Admin Portal"

# /dashboard
@app.route("/dashboard")
def dashboard():
    name = "Arjun"
    role = "Admin"
    return render_template("dashboard.html", name=name, role=role)

# /aircraft
@app.route("/aircraft")
def aircraft():
    aircraft_list = Aircraft.query.all()
    
    return render_template("aircraft.html", aircraft_list=aircraft_list)


# /aircraft/add
@app.route("/aircraft/add", methods = ["GET", "POST"])
def add_aircraft():
    if request.method == "POST":

        registration_no = request.form.get("registration_no", "").strip()
        model = request.form.get("model", "").strip()
        manufacturer = request.form.get("manufacturer", "").strip()
        seating_capacity = request.form.get("seating_capacity", "").strip()

        if not registration_no:
            return "Registration field is required"
        if not model:
            return "Model field is required"
        if not manufacturer:
            return "Manufacturer field is required"
        if not seating_capacity:
            return "Capacity field is required"

        try:
            seating_capacity = int(seating_capacity)
            if seating_capacity <= 0:
                return "Capacity must be greater than 0"
        except ValueError:
            return "Capacity must be a number"
        

        last_aircraft = Aircraft.query.order_by(Aircraft.aircraftID.desc()).first()

        if last_aircraft:
            new_ID = last_aircraft.aircraftID + 1
        else:
            new_ID = 301

        aircraft = Aircraft(
            aircraftID=new_ID,
            model=model,
            manufacturer=manufacturer,
            seating_capacity=seating_capacity,
            registration_no=registration_no
        )

        db.session.add(aircraft)
        db.session.commit()


        return redirect(url_for("aircraft"))

    return render_template("aircraft_add.html")
        

@app.route("/aircraft/edit/<int:aircraft_id>", methods=["GET", "POST"])
def edit_aircraft(aircraft_id):

    aircraft = db.session.get(Aircraft, aircraft_id)

    if aircraft is None:
        return "Aircraft not found"

    if request.method == "POST":

        model = request.form.get("model", "").strip()
        manufacturer = request.form.get("manufacturer", "").strip()
        seating_capacity = request.form.get("seating_capacity", "").strip()

        # Validation
        if not model:
            return "Model field is required"

        if not manufacturer:
            return "Manufacturer field is required"

        if not seating_capacity:
            return "Capacity field is required"

        try:
            seating_capacity = int(seating_capacity)

            if seating_capacity <= 0:
                return "Capacity must be greater than 0"

        except ValueError:
            return "Capacity must be a number"

        # Update object
        aircraft.model = model
        aircraft.manufacturer = manufacturer
        aircraft.seating_capacity = seating_capacity

        # Save changes
        db.session.commit()

        return redirect(url_for("aircraft"))

    return render_template(
        "aircraft_edit.html",
        aircraft=aircraft
    )

@app.route("/aircraft/delete/<int:aircraft_id>", methods=["POST"])
def delete_aircraft(aircraft_id):
    aircraft = db.session.get(Aircraft, aircraft_id)

    if aircraft is None:
        return "Aircraft not found"

    db.session.delete(aircraft)
    db.session.commit()

    return redirect(url_for("aircraft"))

        



# /flights
@app.route("/flights")
def flights():
    return "flights"

@app.route("/test-db")
def test_db():

    try:
        db.session.execute(db.text("SELECT 1"))
        return "Database connection successful!"

    except Exception as e:
        return f"Database connection failed: {e}"





if __name__ == "__main__":
    app.run(debug=True)
