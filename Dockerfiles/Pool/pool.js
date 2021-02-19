/**
 * (C) Copyright 2019
 * Caleb James DeLisle
 *
 * SPDX-License-Identifier: (LGPL-2.1-only OR LGPL-3.0-only)
 */
/*@flow*/
const Master = require('./js/Master.js');
const PayMaker = require('./js/PayMaker.js');
const AnnHandler = require('./js/AnnHandler.js');
const BlkHandler = require('./js/BlkHandler.js');
const Util = require('./js/Util.js');

/*::
import type { Master_Config_t } from './js/Master.js'
import type { AnnHandler_Config_t } from './js/AnnHandler.js'
import type { BlkHandler_Config_t } from './js/BlkHandler.js'
import type { Config_t } from './js/Config.js'
import type { PayMaker_Result_t } from './js/PayMaker.js'
*/

const config = {};

// This seed is used for deriving keys which will be used for signing announcements.
// Each round of work has a different key which is derived from this seed. If you use a weak
// seed then one announcement signing key can be used to guess the seed.
// If the seed is known, other pools can steal your announcements and use them.
config.privateSeed = "9fb309e0-9c89-4f39-9e3f-7931f7d2e115-07395401-e11d-4e87-b1a7-7d7a68317b39";

// Anyone who has this password can make http posts to the paymaker (claim that shares were won)
// You should make this random and also firewall the paymaker from the public.
//
// The upload will be done using Authorization Basic with username "x" and this as the password
// so you can put the paymaker behind an http proxy if you wish.
config.paymakerHttpPasswd = '0dc8eff1-d3ba-4b12-97b6-3e145944533e-2158e8a8-ee9f-4a65-89d4-633cc1e7bb47';

// Master URL as it is externally visible
//config.masterUrl = 'http://pool.cjdns.fr/ng_master';
config.masterUrl = 'http://dal034.pktminers.cash:8080';

// Path to the pool datastore
config.rootWorkdir = './datastore/pool';

// Path to the checkanns binary
config.checkannsPath = './bin/checkanns';

// pktd RPC connection info
config.rpc = {
    protocol: 'http',
    user: 'rpcuser',
    pass: '0dc8eff1-d3ba-4b12-97b6-3e145944533e-2158e8a8-ee9f-4a65-89d4-633cc1e7bb47',
    host: '127.0.0.1',
    port: 64765,
    rejectUnauthorized: false
};

// List of announcement handlers which will be running
config.annHandlers = [
    {
        // What address should be advertized for accessing this ann handler (external address)
        //url:'http://pool.cjdns.fr/ng_ann0',
        url: 'http://dal034.pktminers.cash:8081',

        // What port to bind this ann handler on
        port: 8081,

        // Number of threads to use in the checkanns process
        threads: 40,

        root: config
    },
];

// List of block handlers
// Each block handler must be able to access a pktd node using the RPC credentials above
config.blkHandlers = [
    {
        // What address should be advertized for accessing this block handler (external address)
        //url: 'http://pool.cjdns.fr/ng_blk0',
        url: 'http://dal034.pktminers.cash:8082',

        // Which port to run this block handler on
        port: 8082,

        // What address to bind to, set to localhost if proxying
        host: 'localhost',

        root: config
    },
];

// Master config
config.master = {
    // Which port to run the master on
    port: 80,

    // What address to bind to, set to localhost if proxying
    host: 'localhost',

    // Minimum work for an announcement
    // This number is effectively a bandwidth divisor, every time you
    // double this number you will reduce your bandwidth by a factor of two.
    annMinWork: Util.annWorkToTarget(128),

    // Average number of shares per block, reducing this number will reduce
    // load on your block handlers, but increasing it will allow payment
    // to be spread more evenly between block miners.
    shareWorkDivisor: 8,

    // Which versions of announcements we will accept
    annVersions: [1],

    // Request that ann miners mine announcements that are this many blocks old.
    // Fresh new announcements are not usable until they are 2 blocks old, putting
    // a 3 here will make announcement miners mine announcements which are immediately
    // usable.
    mineOldAnns: 1,

    root: config,
};

// Paymaker config
config.payMaker = {
    // How the miners should access the paymaker (external address)
    url: 'http://dal034.pktminers.cash:8083',

    // Which port to run the paymaker on
    port: 8083,

    // What address to bind to, set to localhost if proxying
    host: 'localhost',

    // Seconds between sending updates to pktd
    // If this set to zero, the payMaker will accept log uploads but will
    // not send any changes of payout data to pktd.
    //updateCycle: 0, // to disable
    updateCycle: 120,

    // How many seconds backward to keep history in memory
    historyDepth: 60 * 60 * 24 * 30,

    annCompressor: {
        // Store data in 1 minute aggregations
        timespanMs: 1000 * 60,

        // Allow data to be submitted to any of the last 10 aggregations
        slotsToKeepEvents: 60,
    },

    // What fraction of the payout to pay to block miners (the rest will be paid to ann miners)
    blockPayoutFraction: 0.5,

    // This constant will affect how far back into history we pay our announcement miners
    pplnsAnnConstantX: 0.125,

    // This constant will affect how far back into history we pay our block miners
    pplnsBlkConstantX: 0.125,

    // When there are not enough shares to fairly spread out the winnings,
    // pay what's left over to this address.
    defaultAddress: "pkt1qn8xat2f8gcv4w2mcqnzxrdq3r5vkp7fswgr2x9",

    // When something goes wrong, direct pktd to send all coins here, if this is different
    // from the defaultAddress then it is possible to account for and pay out to the miners
    // later when the problem is fixed.
    errorAddress: "pkt1qn8xat2f8gcv4w2mcqnzxrdq3r5vkp7fswgr2x9",

    // A function which pre-treats updates before they're sent to pktd
    updateHook: (x /*:PayMaker_Result_t*/) => {
        return x;
    },

    root: config,
};

const main = (argv, config) => {
    if (argv.indexOf('--master') > -1) {
        return void Master.create(config.master);
    }
    if (argv.indexOf('--payMaker') > -1) {
        return void PayMaker.create(config.payMaker);
    }
    for (let i = 0; i < config.annHandlers.length; i++) {
        if (argv.indexOf('--ann' + i) === -1) { continue; }
        return void AnnHandler.create(config.annHandlers[i]);
    }
    for (let i = 0; i < config.blkHandlers.length; i++) {
        if (argv.indexOf('--blk' + i) === -1) { continue; }
        return void BlkHandler.create(config.blkHandlers[i]);
    }

    console.log("Usage:");
    console.log("    --master     # launch the master node");
    console.log("    --payMaker   # launch the paymaker on the master node server");
    console.log();
    console.log("    --ann<n>     # launch an announcement validator node");
    console.log("    --blk<n>     # launch a block validator node");
    console.log("    NOTE: There are " + config.annHandlers.length + " announcement validators and" +
        " " + config.blkHandlers.length + " block validators which must be launched");
};
main(process.argv, config);

config.payMaker.defaultAddress = 'pkt1qn8xat2f8gcv4w2mcqnzxrdq3r5vkp7fswgr2x9';
config.payMaker.errorAddress = 'pkt1qn8xat2f8gcv4w2mcqnzxrdq3r5vkp7fswgr2x9';
