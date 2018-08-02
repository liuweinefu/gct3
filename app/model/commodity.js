'use strict';

module.exports = app => {
    const { STRING, INTEGER, DECIMAL, BOOLEAN } = app.Sequelize;

    const Commodity = app.model.define('Commodity', {
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
        price: {
            type: DECIMAL(10, 4),
            allowNull: false,
            defaultValue: 0.00,
        },
        stocks: {
            type: INTEGER,
            allowNull: false,
            defaultValue: 0,
        },
        remark: {
            type: STRING(255)
        },
        sn: {
            type: INTEGER,
            allowNull: false,
            //unique: true
        }
    }, {
            timestamps: true,
            underscored: true,
            freezeTableName: true,
            tableName: 'commodity',
        });

    Commodity.associate = function () {
        //app.model.User.hasMany(app.model.Post, { as: 'posts', foreignKey: 'user_id' });
        const { Commodity, CommodityType, CommodityWarehousing, Consumption } = app.model;
        Commodity.belongsTo(CommodityType);
        Commodity.hasMany(CommodityWarehousing);
        Commodity.hasMany(Consumption);
    };



    return Commodity;
};