module.exports = app => {
    //if (app.config.env === 'local') {
    app.beforeStart(async () => {
        await app.model.sync({ force: true });
        //console.log('abc');
    });
    //}
    app.beforeStart(async () => {
        await app.model.sync({ force: true });
        //console.log('abc');
    });
};
