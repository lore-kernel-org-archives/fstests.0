Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AC4C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 17:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF17A60FDA
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Sep 2021 17:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352337AbhIHRFv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:05:51 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30337 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbhIHRFr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Sep 2021 13:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631120679; x=1662656679;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=op71ehEYgF56DJpNnGM9bQPEYiutSC9i36ciATLpMJOuaCGEh051tFjq
   Tvluux2d35Fv9gzr4sX9Ue2r6z1/hg/xUUGNJ8deeqpJlWM/1tAbNIBO3
   FbZB6M6Mvpz4uAJS7Ho+q7WR16EO3rR8JwssrrtKnN1nRRuWVxBVYZGpI
   FeSslt/M6LbPhJGj/tMrEMCpmdH/MnF7uukoLHk74MB70rPFq6/oIzkNE
   /o31SMcpYMu4xWPuaH211twrzNP7vSVJKi1udZL9+wcTDYM9ExpsRa/UD
   clYttFkfAdzxIjEr+QOvF2rDM6ckpR3+lDlSS+qtvi3XIz0APFqhZEXCq
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="283289702"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 01:04:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkAHsJDvdK7llrQPHHuN7dx4BfgTXs4JJkoCsYBX8jYS02o339FTLhBjFUSITHXUtD2NefQncfyxTXmZq7sKt6l1TrldxQqQ/sehhYXf0uWqsg2fr1FBgADVqVQwEDtm47iMcyCg4xsIUj4m6TZBqWXqQNpNHdtc08Vd03EWUgeRhSlQhqiEbef19NTctTkYzuqOkgsS6iAZh+uW48JeBJbmDJMYXeWD1xbtQZ/g2T6U7CiE5OJfaw9/Cpf0o2uHsX4j9G59SlivWwUWOTrJ9pOh9O9zcdKE3U+vRAptx1qMJGiTvyyYDRH1hBwxA0Hj2Z+uqs6ZQTL6PKPBwmSJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DUS9lhrOHfIczfbuGh+sRI3Qyrt/Z8C5MR7rFpADPidwKYP9+uMXxb0ZB7odQvqZvofMM3qBsMmq/IMhSsoLrNmwdQ0e2B2akbNuV9xPTxUHZ9uQ/6OU8R7UjKucMxOxEPWjt03BFLcBkYluYVLc8mxapcnQwMNDE/B+d8xoCMw1eaZBYABbbrwJogvsSKMTy5LTtG5jTFmzJbKWAWcqi0aunJ/GDetsUchb8EbgqWrm5q+6hpszNjaY4KPYKvJ4zBpVgdAOqyJHBxHVUUFat5xQUSNX8M8FLWdz3EtPtywANhfMYHW3VfZDaHtoEtZwu6EKVc5S/VqnZHInGlXssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=R5Kq2SqyGOdLo1Gqk3vBuwvkEw/MahBjJKbwEL0vqwm6FBVC85kipLiBZTf07r+sad37KO4nf6PZDgwBTt0XntVVMTBvJszCYvrbQFlt/wLT3w2psBzKyzo5EsL6C39eny6VTbkbLV+QXUpi3fBU7nUHgjLe8GYpRB4XjPNRid8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7638.namprd04.prod.outlook.com (2603:10b6:510:52::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 17:04:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 17:04:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/3] generic/{628,629}: Fix order of _require_scratch*
 and _require_dm_target
Thread-Topic: [PATCH v2 1/3] generic/{628,629}: Fix order of _require_scratch*
 and _require_dm_target
Thread-Index: AQHXpIy+rqcSycsRv0C7yPG3rrYDug==
Date:   Wed, 8 Sep 2021 17:04:34 +0000
Message-ID: <PH0PR04MB7416AFF89776B79AC2DB121B9BD49@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
 <20210908083715.1831067-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95133790-6d82-4984-042b-08d972eabbef
x-ms-traffictypediagnostic: PH0PR04MB7638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7638B351D644809F1FD438F19BD49@PH0PR04MB7638.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cQUGSUndvqE9bbqcBItZp5uMzovKSUb0pAtV+R0kBxtNsdoX5LYzTGaAMJxjExI9VozcpPOGEaxoTgcy3yGKxA9G76n9Ij6tQlShcebzA8oh+BuCLu5Gwv7Iwqxja9sp7V2WDCUKrM+IjyHkvsQp4v9ZnMb3UR4LpdBDhB21gRLZ8y7wGX2wf+KkabmMbMth5d+q2O17u2Du/B13HNRapUyLXInb9RABhvX9wqyOBJAkcbFCsB8YNTz6Fv08o1KKX1S7EmggE1KDyb6QiKdUR3Y5jvc3zbAjPZ/THTPOLRCgTJy4Bulb3XdMH6xj5bXdhBbx9tmHD9FcLQM45bWTDB0HxLow/yVvKVML38aJUc4VkDRNy3NIboUuFJBMQcrit4lBY6/lrxYGnIxGoRxQVBvQK4OS9ZEXtYk8kN3xnlvymXEuJUqvYPkCItnXdnKECtrwFCdnChjHoW+ziIBVjCXu+IWQC9UppFAoBnaj2er1JKdcaZT4cfwPc+13PG/0oA/KhsQcMNJwMrhhxfv2F87TYvR7KAnuWoWtu1WC405zxVZ9LmFDQy4HGTtFNwNldl7JxUj2xfPLYCqtzIuZNRM8I/4m2egjX071yYhGcGjSmjGjDntitmqa3VEnGVYyf1FPTj9bBse16iKBus8tCjiRLYssuLbXn8tb6d0/B3hJKhZdXcBIjw0AzShvxGhJUOQHHAobEI/1GfaGS0o7Smo7atbJLVlT5PqEoPALdGs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(8936002)(186003)(8676002)(19618925003)(478600001)(26005)(38070700005)(7696005)(71200400001)(5660300002)(33656002)(9686003)(86362001)(55016002)(558084003)(6506007)(52536014)(4270600006)(76116006)(91956017)(2906002)(64756008)(4326008)(66946007)(122000001)(38100700002)(54906003)(66556008)(66476007)(66446008)(110136005)(316002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O5vYfPoWgcUbuX0mgsjfwrBVx9Vk8XrmfFhTA6Vg/YASx1IoSQWXuEcwYw9y?=
 =?us-ascii?Q?rYpATa6GDurbKgwpRw5bSHuE+YPHgz3LkE9JWntzY90BIa2UXZaMyZ5jxzGZ?=
 =?us-ascii?Q?eRBRM+aYceJXY2sKHcY98Toqj00N0NmV0wRKtM+PWBH5lifMuEOoaTAJdvrz?=
 =?us-ascii?Q?ajei+CWfCA7r4phVT8fVyrxo2YgUstRBWhO10cfgNMPXa+Fw37IyInpx76BD?=
 =?us-ascii?Q?eENHFR0q7pbGedbcwHzFXvLmTKw6HRuRXZVJGM8/28lNAmvSjDraJkivtjyB?=
 =?us-ascii?Q?S7cKPtqLWXcQRLr6pt/hT0b82F/tFfagjo25zcfxRU2g6Bypkiy3R9D8p8/i?=
 =?us-ascii?Q?BJjM/83aQiHyv1jdSktc2NrEpkW88Qw9EgdZ+88OVz8HWPxpHdzOef5MrD8N?=
 =?us-ascii?Q?Sw8YpkjpsYYKbgQy0dGm+mlJ5j2J7IbRPQWH9xQPjKvvcBGhx5sXgjFcnYDK?=
 =?us-ascii?Q?mkCsCfMcL6NJhNtNCIFpSZMzAAAUoHydKk/JTiQp2LJnscpffKMDY5NQlm2W?=
 =?us-ascii?Q?VTYqtrne+k/TUE+rUdXIYGVs+ZhkLPVLoduszwgRyxYAPoljG/UtuKocI/zp?=
 =?us-ascii?Q?FqwU/AiEyzKm4klh2hY19sNU/nPS6HpFBfN6kKbFwzGG2Kd/zMNV38lMDYLP?=
 =?us-ascii?Q?GBJmpH0Ph5uJEku62USmWXYbPd8v9hLMwBhymoW3w4e8//d7kk5ypUJD+J/F?=
 =?us-ascii?Q?Lrsmj0gLhZ0MJgSYaCuY7RMZCY7ZlZkQ+toaKvgfK1dLvIqPVRv+4CvnFYHk?=
 =?us-ascii?Q?KFxarFyK5ZwB1btwprftKOYu+zSl/1XtFsYhkqI71PeyfGCbZToUgHV+yLND?=
 =?us-ascii?Q?pcmSUFpef+LORTBod+T6jB3o/gZLYsqUOt74T3gljO3yMottEbG+wia1hWMy?=
 =?us-ascii?Q?oZaKvzFqJ2H9tI15kn9rmjs1gEBgQzNAt9VU79OpfEqoB96nejFa+TcHdYaR?=
 =?us-ascii?Q?4UoTP7mVRQ44UtuLdTqj0Anh1aVkC07qWj16QMzBzI80KJbuVyYRmskP8xbk?=
 =?us-ascii?Q?As0hM9+39tkP+0AfT9bnhF45JK+ggJJpAY4bEyKpVdfxo0Ir0Ldp3+bs+0Pd?=
 =?us-ascii?Q?7z+hECe530jpYHAbiouI08OOSSNO3dgQbXZrx2ozxnezV4URX7M5mjcNHww1?=
 =?us-ascii?Q?KAO11el/qnUqJUtECQ7LNJ3pf4ma9tYfwv9UGtnFFKdaZegc8ulNAM0aXmb4?=
 =?us-ascii?Q?36lxwxMCkbI/N8W1Jk/TABnjlsQ5s6gKHg8X+SaKu5kmTgnNWtjxQSGDvver?=
 =?us-ascii?Q?v5s5QX7qDTUeB1sFqgGWT/sl/3GzBNGdwrGEgz+kw/nrFnzNetQZxn62dSGa?=
 =?us-ascii?Q?4b2ZYo0Cjpb+pqVh+ccM6QGO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95133790-6d82-4984-042b-08d972eabbef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 17:04:34.9368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BPil5xWS8bHIkQSM23pKP5IHfxpi9UpWhujIx2HzerZZCcswx79lKrN3lxcZVt3+ceCH/qsv+3ZJ7EGxp/2mqTbXV2DCXpQ8Hy4jWElfgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7638
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
