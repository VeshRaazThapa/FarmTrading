const mongoose = require("mongoose");
const Joi = require("joi");

const billingAddressSchema = new mongoose.Schema({
    fullName: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
    }, phone: {
        type: String,
        required: true,
    },
    city: {
        type: String,
        required: true,
    }, province: {
        type: String,
        required: true,
    },
    postalCode: {
        type: String,
        required: true,
    },
    areaName: {
        type: String,
        required: true,
    },


});

const userSchema = new mongoose.Schema({
    email: {
        type: String,
        required: true,
        unique: true,
        // match: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
    },
    phone: {
        type: String,
        required: true,
        unique: true,
        // match: /^\+(?:[0-9] ?){6,14}[0-9]$/,
    },
    name: {
        type: String,
        required: true,
        // match: /^[A-Za-z0-9]{5,50}$/,
    },
    password: {
        type: String,
        required: true,
        min: 5,
        max: 1024,
        // match: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{5,1024}$/,
    },
    newPassword: {
        type: String,
        required: false,
        min: 5,
        max: 1024,
        // match: /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{5,1024}$/,
    },
    userType: {
        type: String,
        enum: ["admin", "wholesaler", "farmer"],
        default: "wholesaler",
    },
    createdAt: {
        type: Date,
        default: () => {
            return new Date();
        },
    },
    latitude: {
        type: Number,
        required: true,
        min: 0,
    },
    longitude: {
        type: Number,
        required: true,
        min: 0,
    },
    resetPasswordToken: String,
    billingAddresses: [billingAddressSchema],
    resetPasswordExpires: Date,
});

userSchema.methods.isValidPassword = function (password) {
    return password === this.password;
};

const User = mongoose.model("User", userSchema);

function validateUser(user) {
    const schema = Joi.object().keys({
        name: Joi.string().required(),
        email: Joi.string().required().email(),
        password: Joi.string().required(),
        phone: Joi.string().required(),
        latitude: Joi.number().required(),
        longitude: Joi.number().required(),
        billingAddresses: Joi.array().items(Joi.object({
            city: Joi.string().required(),
            houseNumber: Joi.string().required(),
            areaName: Joi.string().required(),
            postalCode: Joi.string().required(),
            fullName: Joi.string().required(),
            email: Joi.string().required(),
            phone: Joi.string().required(),
            province: Joi.string().required(),
        })),
    });
    return schema.validate(user);
}

exports.User = User;
exports.validate = validateUser;
