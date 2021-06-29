import joi from 'joi';

const SignUpSchema = joi.object({
    name: joi.string().min(2).required(),
    email: joi.string().email().required(),
    password: joi.string().min(1).required(),
    confirmPassword: joi.ref('password')
});

export {
    SignUpSchema
}