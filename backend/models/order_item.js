const mongoose = require("mongoose");
const Joi = require("joi");
const JoiObjectId = require("joi-objectid")(Joi);
const { milletItemSchema } = require("./millet_item.js");

const milletOrderSchema = new mongoose.Schema({

  listedBy: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },


  farmerId: {
    type: mongoose.Schema.Types.ObjectId,
        ref: "User",
        required: true,
  },

  quantityType: {
    type: String,
    required: true,
    min: 0,
  },
  isDelivered: {
    type: Boolean,
    required: true,
  },
  quantity: {
    type: Number,
    required: true,
    min: 0,
  },
  price: {
    type: Number,
    required: true,
    min: 0,
  },
  phoneFarmer: Joi.string().required(),
  phoneCustomer: Joi.string().required(),
  listedAt: {
    type: Date,
    default: () => {
      return new Date();
    },
  },
  item: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "MilletItem",
      required: true,
    },
});

const MilletOrder = mongoose.model("MilletOrder", milletOrderSchema);

function validateMilletOrder(item) {
  const schema = Joi.object().keys({
    listedBy: JoiObjectId().required(),
    farmerId: JoiObjectId().required(),
    quantityType: Joi.string().required(),
    phoneFarmer: Joi.string().required(),
    phoneCustomer: Joi.string().required(),
    isDelivered:Joi.boolean().required(),
    quantity: Joi.number().required(),
    price: Joi.number().required(),
    item: JoiObjectId().required(),

  });
  return schema.validate(item);
}

exports.MilletOrder = MilletOrder;
exports.validateMilletOrder = validateMilletOrder;
exports.milletOrderSchema = milletOrderSchema;