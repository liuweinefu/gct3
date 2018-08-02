'use strict';

module.exports = app => {
    const { STRING, INTEGER, DECIMAL, BOOLEAN } = app.Sequelize;

    const CommodityWarehousing = app.model.define('CommodityWarehousing', {
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
        quantity: {
            type: INTEGER,
            allowNull: false,
            defaultValue: 1,
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
            tableName: 'commodity_warehousing',
        });

    CommodityWarehousing.associate = function () {
        //app.model.User.hasMany(app.model.Post, { as: 'posts', foreignKey: 'user_id' });
        const { CommodityWarehousing, Commodity, User } = app.model;
        CommodityWarehousing.belongsTo(Commodity);
        CommodityWarehousing.belongsTo(User);
    };



    return CommodityWarehousing;
};