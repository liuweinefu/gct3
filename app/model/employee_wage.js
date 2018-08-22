'use strict';

module.exports = app => {
    const { STRING, INTEGER, DECIMAL } = app.Sequelize;

    const EmployeeWage = app.model.define('EmployeeWage', {
        // id: {
        //     type: UUID,
        //     primaryKey: true,
        //     defaultValue: UUIDV1,
        // },
        id: {
            type: INTEGER,
            primaryKey: true,
            autoIncrement: true,
            //defaultValue: UUIDV1,
        },
        wage: {
            type: DECIMAL(16,4),
            allowNull: false,
            defaultValue: 0.0,
        },
        bonus: {
            type: DECIMAL(16,4),
            allowNull: false,
            defaultValue: 0.0,
        },
        remark: {
            type: STRING(255)
        }
    }, {
            timestamps: true,
            underscored: true,
            freezeTableName: true,
            tableName: 'employee_wage',
        });

    EmployeeWage.associate = function () {
        //app.model.User.hasMany(app.model.Post, { as: 'posts', foreignKey: 'user_id' });
        const { EmployeeWage, Consumption, Employee, User } = app.model;

        EmployeeWage.hasMany(Consumption);
        EmployeeWage.belongsTo(Employee);
        EmployeeWage.belongsTo(User);

        // app.model.User.belongsTo(app.model.UserType);
        // app.model.User.hasMany(app.model.CardRecharge);
        // app.model.User.hasMany(app.model.CommodityWarehousing);
        // app.model.User.hasMany(app.model.Consumption);
        // app.model.User.hasMany(app.model.EmployeeWage);
    };

    // User.findByLogin = function* (login) {
    //     return yield this.findOne({
    //         where: {
    //             login: login
    //         }
    //     });
    // }

    // User.prototype.logSignin = function* () {
    //     yield this.update({ last_sign_in_at: new Date() });
    // }

    // User.associate = function (models) {
    //     //this === app.model.User;
    //     app.model.User.belongsTo(app.model.UserType);
    //     app.model.User.hasMany(app.model.CardRecharge);
    //     app.model.User.hasMany(app.model.CommodityWarehousing);
    //     app.model.User.hasMany(app.model.Consumption);
    //     app.model.User.hasMany(app.model.EmployeeWage);

    // };

    return EmployeeWage;
};