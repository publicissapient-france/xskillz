var exec = require('child_process').exec,
    AWS = require('aws-sdk'),
    fs = require('fs-extra'),
    readdir = require('recursive-readdir'),
    mime = require('mime');

AWS.config.update({
    accessKeyId: 'AKIAIEXG3BZBGPGVSCGQ',
    secretAccessKey: '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',
    region: 'eu-central-1'
});

const s3 = new AWS.S3({params: {Bucket: 'ea-homecare-dev'}});

process.chdir('../ea-homecare-front');

build = (cb) => {
    console.info('Building front app...');
    exec('npm install && npm --production run build', (err, stdout) => {
        if (err) throw err;
        console.info(stdout);
        cb();
    });
};

upload = (file, contentType) => {
    fs.readFile(file, (err, data) => {
        if (err) throw err;
        const params = {
            Key: file,
            Body: data,
            ContentType: contentType
        };
        s3.upload(params, (err) => {
            if (err) {
                console.error(`An error occurred: ${err}`);
            } else {
                console.info(`Successfully uploaded ${file}`);
            }
        });
    });
};

deploy = () => {
    console.info('Deploying to S3...');
    upload('index.html', 'text/html');
    readdir('dist/', (err, files) => {
        files.forEach((f) => {
            upload(f, mime.lookup(f));
        });
    });
};

build(deploy);