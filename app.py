import os
import math
from flask import Flask, render_template, request, session, redirect, flash
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from datetime import date
import json
from werkzeug.utils import redirect, secure_filename

with open('config.json', 'r') as c:
    params = json.load(c)["params"]

local_server = True

app = Flask(__name__)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]
db = SQLAlchemy(app)
app.secret_key = 'super-secret-key'
app.config["UPLOAD_FOLDER"] = params['file_location']
app.config.update(dict(
    DEBUG=True,
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT=587,
    MAIL_USE_TLS=True,
    MAIL_USE_SSL=False,
    MAIL_USERNAME=params["gmail_user"],
    MAIL_PASSWORD=params["gmail_password"],
))
mail = Mail(app)


class Contacts(db.Model):
    '''sno, name, email, phone_num, mes, date'''
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    phone_num = db.Column(db.String(15), nullable=False)
    mes = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(120), nullable=False)

    def __repr__(self):
        return '<Name %r>' % self.name


class Posts(db.Model):
    '''sno title slug content date'''
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(120), nullable=False)
    img_url = db.Column(db.String(80), nullable=False)


@app.route('/')
def home():
    # flash("View blog posts here!!","success")
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    # [0:params['no_of_posts']]
    # Pagination Logic
    ''' First Page '''
    # prev = none
    # next = page+1
    '''Middle Page'''
    #prev = page-1
    #next = page+1
    '''Last Page'''
    #prev = page-1
    #next = none

    page = request.args.get('page')
    if not str(page).isnumeric():
        page = 1
    page = int(page)
    posts = posts[(page-1)*int(params['no_of_posts']): (page-1)
                  * int(params['no_of_posts'])+int(params['no_of_posts'])]
    if page == 1:
        prev = "#"
        next = "/?page="+str(page+1)
    elif page == last:
        prev = "/?page="+str(page-1)
        next = "#"
    else:
        prev = "/?page="+str(page-1)
        next = "/?page="+str(page+1)

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)


@app.route('/about')
def about():
    return render_template('about.html', params=params)


@app.route('/contact', methods=['GET', 'POST'])
def contacts():
    if request.method == 'POST':
        """Add entry to the database"""
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')
        entry = Contacts(name=name, email=email, phone_num=phone,
                         mes=message, date=date.today())

        db.session.add(entry)
        db.session.commit()
        mail.send_message('New message from CodeTalks from '+name,
                          sender=email,
                          recipients=[params['gmail_user']],
                          body=message + '\n' + phone

                          )
        flash("Thanks for Submitting your form. We'll reach upto you ASAP.","success")
    return render_template('contact.html', params=params)


@app.route('/posts/<string:post_slug>', methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()

    return render_template('post.html', params=params, post=post)


@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():
    if 'user' in session and session['user'] == params['admin_user']:
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method == 'POST':
        username = request.form.get('uname')
        password = request.form.get('password')
        if username == params['admin_user'] and password == params['admin_password']:
            session['user'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)

    return render_template('login.html', params=params)


@app.route('/logout')
def logout():
    session.pop('user')
    return redirect('/dashboard')


@app.route('/edit/<string:sno>', methods=['GET', 'POST'])
def edit(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':

            box_title = request.form.get('title')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_url = request.form.get('img_url')

            if sno == '0':
                post = Posts(title=box_title, slug=slug,
                             content=content, img_url=img_url, date=date.today())
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.img_url = img_url
                post.date = date.today()
                db.session.commit()
                return redirect('/edit/'+sno)
    post = Posts.query.filter_by(sno=sno).first()

    return render_template('edit.html', params=params, post=post, sno=sno)


@app.route('/delete/<string:sno>', methods=['GET', 'POST'])
def delete(sno):
    if 'user' in session and session['user'] == params['admin_user']:
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route('/uploader', methods=['GET', 'POST'])
def uploader():
    if 'user' in session and session['user'] == params['admin_user']:
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(
                app.config["UPLOAD_FOLDER"], secure_filename(f.filename)))
            return "Uploaded Successfully"


if __name__ == '__main__':
    app.run(debug=True)
