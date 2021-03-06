'use strict';

module.exports = app => {
    const { STRING, INTEGER, DECIMAL } = app.Sequelize;

    const CardType = app.model.define('CardType', {
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
        name: {
            type: STRING(16),
            allowNull: false,
            unique: true
        },
        discount: {
            type: DECIMAL(16,4),
            allowNull: false,
            defaultValue: 1,
        },
        sn: {
            type: INTEGER,
            allowNull: false,
            //unique: true
        },
        remark: {
            type: STRING(255)
        }
    }, {
            timestamps: true,
            underscored: true,
            freezeTableName: true,
            tableName: 'card_type',
        });


    CardType.associate = function () {
        //app.model.User.hasMany(app.model.Post, { as: 'posts', foreignKey: 'user_id' });
        const { CardType, Card } = app.model;
        CardType.hasMany(Card);
    };

    return CardType;
};