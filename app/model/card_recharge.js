'use strict';

module.exports = app => {
    const { STRING, INTEGER, DECIMAL } = app.Sequelize;

    const CardRecharge = app.model.define('CardRecharge', {
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
        price: {
            type: DECIMAL(10, 4),
            allowNull: false,
            defaultValue: 0.0,
        },
        remark: {
            type: STRING(255)
        }
    }, {
            timestamps: true,
            updatedAt: false,
            underscored: true,
            freezeTableName: true,
            tableName: 'card_recharge',
        });


    CardRecharge.associate = function () {
        //app.model.User.hasMany(app.model.Post, { as: 'posts', foreignKey: 'user_id' });
        const { CardRecharge, Card, User } = app.model;
        CardRecharge.belongsTo(Card);
        CardRecharge.belongsTo(User);
    };

    return CardRecharge;
};