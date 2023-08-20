const {User} = require("../models/user");
const Joi = require("joi");
const express = require("express");
const {getSuccessResponse, getErrorResponse} = require("../utils/response");
const router = express.Router();
const _ = require("lodash");
const {default: mongoose} = require("mongoose");
const {MilletItem} = require("../models/millet_item");
const nodemailer = require("nodemailer");
/**
 * Login as a user using {email} {password}
 * body: {email:"email",password:"password"}
 */

router.post("/login", async (req, res) => {
    console.log("Request Body: ", req.body);
    const {error} = validateLogin(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    let user = await User.findOne({email: req.body.email});
    // let user = false;
    if (!user)
        return res.send(getErrorResponse("No User Exists with this email"));

    const validPassword = req.body.password === user.password;
    if (!validPassword) return res.send(getErrorResponse("Invalid Password"));

    return res.send(
        getSuccessResponse(
            "Login Success",
            _.omit(user.toObject(), ["password", "__v"])
        )
    );
});

/**
 * SignUp a new user
 * BODY: { name, email, password, userType, phone}
 */

router.post("/signup", async (req, res) => {
    console.log("Request Body---: ", req.body);
    const {error} = validateSignUp(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    let user = await User.findOne({email: req.body.email});
    // let user = false;
    if (user)
        return res.send(getErrorResponse("User with this email already exists"));
    let user_phone_test = await User.findOne({phone: req.body.phone});
    if (user_phone_test)
        return res.send(getErrorResponse("User with this phone already exists"));

    let user_name_test = await User.findOne({name: req.body.name});
    if (user_name_test)
        return res.send(getErrorResponse("User with this name already exists"));

    let userType = req.body.userType;
    if (!userType || userType === "admin") userType = "wholesaler";

    /// NOTE: asterjoules@gmail.com is an admin email
    if (req.body.email === "asterjoules@gmail.com") userType = "admin";

    user = new User({
        email: req.body.email,
        name: req.body.name,
        password: req.body.password,
        userType: userType,
        phone: req.body.phone,
        latitude: req.body.latitude,
        longitude: req.body.longitude,
    });
    console.log("Before saving: ", user);


    await user.save();
    return res.send(
        getSuccessResponse(
            "Signup Successful",
            _.omit(user.toObject(), ["password", "__v"])
        )
    );
});


/**
 * Get All Users (For Admin Panel)
 * {adminId: Objectid}
 */

router.post("/getAll", async (req, res) => {
    console.log("Request Body: ", req.body);

    // Validate if Id is valid
    if (!mongoose.Types.ObjectId.isValid(req.body.adminId)) {
        return res.status(404).send(getErrorResponse("Invalid Admin ID"));
    }

    let user = await User.findOne({_id: req.body.adminId});
    // let user = false;
    // Check if user exists
    if (!user)
        return res.send(getErrorResponse("No User Exists with this email"));

    // Check if user is admin
    if (user.userType !== "admin") {
        return res.status(404).send(getErrorResponse("You are not an Admin!"));
    }

    // User is admin, fetch all users and return

    var users = await User.find({}).select("-__v -password");

    return res.send(
        getSuccessResponse(
            "Success",
            users
            // _.omit(user.toObject(), ["password", "__v"])
        )
    );
});
router.get("/farmer-coordinates/getAll", async (req, res) => {
    const items = await User.find({});

    return res.send(getSuccessResponse("Success!", items));
});
router.post("/exists", async (req, res) => {
    var email = req.body.email;
    if (!email) return res.send(getErrorResponse("Enter a valid email"));

    const user = await User.findOne({email: email});
    // let user = false;
    if (!user)
        return res.send(getErrorResponse("No User Exists with this email address"));
    return res.send(
        getSuccessResponse(
            "User Found",
            _.omit(user.toObject(), ["password", "__v"])
        )
    );
});
router.post("/getUser", async (req, res) => {
    var id = req.body.id;
    if (!id) return res.send(getErrorResponse("Not a valid id"));

    const user = await User.findOne({_id: id});
    // let user = false;
    if (!user)
        return res.send(getErrorResponse("No User Exists with this id"));
    return res.send(
        getSuccessResponse(
            "User Found",
            _.omit(user.toObject(), ["password", "__v"])
        )
    );
});
router.post("/phoneExists", async (req, res) => {
    var phone = req.body.phone;
    if (!phone) return res.send(getErrorResponse("Enter a valid phone"));

    const user = await User.findOne({phone: phone});
    // let user = false;
    if (user)
        return res.send(getErrorResponse("User Already Exists with this Phone"));
    return res.send(
        getSuccessResponse(
            "This is unique",
            // _.omit(user.toObject(), ["password", "__v"])
        )
    );
});


router.post("/forgot-password", async (req, res) => {
    console.log(req.body);
    const {error} = validateForgotPassword(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    const user = await User.findOne({email: req.body.email});
    if (!user) return res.send(getErrorResponse("No User Exists with this email"));

    //  // Check if the old password matches the user's current password
    // if (!user.isValidPassword(req.body.oldPassword)) {
    //     return res.send(getErrorResponse("Old password is incorrect"));
    // }

    // Generate a random token and set it in the user's document
    const token = generateRandomToken(); // You need to implement this function
    user.newPassword = req.body.newPassword;
    user.resetPasswordToken = token;
    user.resetPasswordExpires = Date.now() + 3600000; // Token valid for 1 hour
    await user.save();

    // Send a password reset email to the user
    const transporter = nodemailer.createTransport({
        service: 'Gmail',
        auth: {
            user: 'tardefarm@gmail.com',  // Replace with your Gmail address
            pass: 'okzkjbjchdrjmbjm'   // Replace with your Gmail password or an app-specific password
        }
    });


    const mailOptions = {
        from: "tardefarm@gmail.com",
        to: user.email,
        subject: "Password Reset",
        text: `You are receiving this because you (or someone else) have requested the reset of the password for your account.\n\n`
            + `Please click on the following link, or paste this into your browser to complete the process:\n\n`
            + `http://${req.headers.host}/api/auth/reset-password/${token}\n\n`
            + `If you did not request this, please ignore this email and your password will remain unchanged.\n`
    };

    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            console.log(error);
            return res.send(getErrorResponse("Failed to send reset email"));
        } else {
            console.log("Email sent: " + info.response);
            return res.send(getSuccessResponse("Password reset email sent"));
        }
    });
});

function generateRandomToken(length = 32) {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  let token = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    token += characters.charAt(randomIndex);
  }

  return token;
}

function validateForgotPassword(req) {
    const schema = Joi.object().keys({
        email: Joi.string().required().email(),
        newPassword: Joi.string().required(),
    });
    return schema.validate(req);
}

router.get("/reset-password/:token", async (req, res) => {
    // const {error} = validateResetPassword(req.body);
    // if (error) return res.status(400).send(error.details[0].message);

    const user = await User.findOne({
        resetPasswordToken: req.params.token,
        resetPasswordExpires: {$gt: Date.now()}
    });

    if (!user) return res.send(getErrorResponse("Password reset token is invalid or has expired"));

    user.password = user.newPassword;
    user.resetPasswordToken = undefined;
    user.resetPasswordExpires = undefined;
    await user.save();

    return res.send(getSuccessResponse("Password reset successful"));
});

function validateResetPassword(req) {
    const schema = Joi.object().keys({
        password: Joi.string().required(),
    });
    return schema.validate(req);
}


function validateLogin(req) {
    const schema = Joi.object().keys({
        email: Joi.string().required().email(),
        password: Joi.string().required(),
    });
    return schema.validate(req);
}

function validateSignUp(req) {
    const schema = Joi.object().keys({
        name: Joi.string().required(),
        email: Joi.string().required().email(),
        password: Joi.string().required(),
        phone: Joi.string().required().pattern(/^\+(?:[0-9] ?){6,14}[0-9]$/),
        latitude: Joi.number().required(),
        longitude: Joi.number().required(),
        userType: Joi.string().default("wholesaler"),
    });
    return schema.validate(req);
}

module.exports = router;