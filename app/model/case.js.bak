'use strict';

module.exports = app => {
    const { STRING, INTEGER, DATE, TEXT } = app.Sequelize;

    const Case = app.model.define('Case', {
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
            //索引长度受限，776bytes
            type: STRING(16),
            allowNull: false,
            //unique: true
        },
        case: {
            type: TEXT
        },
        remark: {
            type: TEXT
        }
    }, {
            timestamps: true,
            underscored: true,
            freezeTableName: true,
            tableName: 'case',
        });


    Case.associate = function () {
        //app.model.User.hasMany(app.model.Post, { as: 'posts', foreignKey: 'user_id' });
        const { Case, Member } = app.model;
        Case.belongsTo(Member);
    };



    return Case;
};