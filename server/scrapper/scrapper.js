const routes = require('../routes.json');

console.log("routes are: ", routes);

class scrapper {
    constructor() {
        this.routes = routes;
    }

    async login() {
        for (const category in this.routes)
            for (const route in this.routes[category])
                if (route == 'Login')
                    this.treateRoute(this.parseUrl(category, this.routes[category][route]['url']), this.routes[category][route]);
    }

    async pingRoutes() {
        for (const category in this.routes) {
            for (const route in this.routes[category]) {
                const url = this.parseUrl(category, this.routes[category][route]['url']);
                console.log(`pinging ${url}`);
            }
        }
    }

    parseUrl(category, url) {
        return process.env.BASE_URL + "api/" + category + url;
    }

    treateRoute(url, routeData) {
        console.log(`treateRoute ${url}`);
        console.log(`routeData ${JSON.stringify(routeData)}`);
    }
}

myscrapper = new scrapper();
myscrapper.login();
