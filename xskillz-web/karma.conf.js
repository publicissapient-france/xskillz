module.exports = (config) => {
    config.set({
        basePath: 'src',
        singleRun: true,
        frameworks: ['mocha'],
        reporters: ['mocha', 'coverage', 'junit'],
        browsers: ['Chrome', 'PhantomJS', 'PhantomJS_custom'],
        junitReporter: {
            outputFile: '../../reports/test-results.xml'
        },
        coverageReporter: {
            dir: '../reports/coverage/',
            reporters: [
                // reporters not supporting the `file` property
                {type: 'html', subdir: 'report-html'},
                {type: 'clover', subdir: '.', file: 'clover.xml'}
            ]
        },
        files: [
            'test/**/*.spec.js'
        ],
        plugins: ['karma-chrome-launcher', 'karma-phantomjs-launcher', 'karma-mocha', 'karma-sourcemap-loader', 'karma-webpack', 'karma-coverage', 'karma-mocha-reporter', 'karma-junit-reporter'],
        preprocessors: {
            'test/**/*.spec.js': ['webpack'],
            '!(test)**/*.js': ['coverage']
        },
        customLaunchers: {
            'PhantomJS_custom': {
                base: 'PhantomJS',
                options: {
                    windowName: 'my-window',
                    settings: {
                        webSecurityEnabled: false
                    }
                },
                flags: ['--load-images=true'],
                debug: false
            }
        },
        phantomjsLauncher: {
            // Have phantomjs exit if a ResourceError is encountered (useful if karma exits without killing phantom)
            exitOnResourceError: true
        },
        webpack: {
            resolve: {
                extensions: ['', '.js', '.ts', '.scss'],
                modulesDirectories: ['node_modules', 'src'],
            },
            module: {
                loaders: [{
                    test: /\.js$/,
                    loader: 'babel-loader'
                }, {
                    test: /\.scss$/,
                    loader: 'style!css?localIdentName=[path][name]--[local]!postcss-loader!sass'
                }],
                postLoaders: [{ //delays coverage til after tests are run, fixing transpiled source coverage error
                    test: /\.js$/,
                    exclude: /(test|node_modules)\//,
                    loader: 'istanbul-instrumenter'
                }]
            }
        },
        webpackMiddleware: {
            stats: {
                color: true,
                chunkModules: false,
                modules: false
            }
        }
    });
};
