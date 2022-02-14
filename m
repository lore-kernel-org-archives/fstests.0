Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095ACC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Feb 2022 07:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbiBNHtI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Feb 2022 02:49:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBNHtH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Feb 2022 02:49:07 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 23:49:00 PST
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA2C5AEE3
        for <fstests@vger.kernel.org>; Sun, 13 Feb 2022 23:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644824940; x=1676360940;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1LJ7xK0RVRV/UH14TCd2UiyPlGWRoS4TjFKj9k7xt5U=;
  b=IwTmb4VjTILTcbVhinehFKLJ6Cq+b2AnqDT8lLMkhrw5BB+spxX1NrLn
   S4TFbW2sf9oiOcLdTbv/u1DEd5XYpoXRKKNmiQgEuAhj4nWFuyxbLpHRy
   J9rh3PylhnR0Q8w5XfoiQbbK8cQgEcmQ3HRnSBByX9Bidk0Y8SgRrE9SW
   JWJAUxmT2DOB1AeG1AeB8YvnNgpTtvTyHVIWVEF79bS/lm9eV6QTnNMI9
   RY9+5uR34QsiXV+o5c5t/EOKBn7/KZQR5y9+0rkRdngCU5sX9d/dufG6l
   pcy5D2mA/2ZikTMObwiityMXai9XrigwuSNgY+dXRpTAVRuCRgAHyEkaw
   w==;
X-IronPort-AV: E=Sophos;i="5.88,367,1635177600"; 
   d="scan'208";a="296947156"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2022 15:47:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNoGYf8eA127ul+9rLcLWXAERgBkfc2a34ZqWFdBUvlh7sLO8iRFv+Fzg53QK+mGoNOnQi16oUYvrGyuUr1ghcuIa6hmx7ZWlNMhgS0Zm1CsTtNAW/afX6VO2I2VtPHzIZzAaTnSAt5Uw+v62kHLrSFDcZQtUkWJkDUiptrBWnyxNrDFLrmspx/S0n8Qt6Kzoxa4UZ/K8uPRTI1vfO5YbYDOnGqooacjCkRL7jI3V5G60sHG7HfbfGmjMx1Xqr5paxN5b9PScep/UPJVoL/O9tGNopNyhV6PKl7+87XapFKQ21BcWQyapugRThEsECpelUo+2HU22ITgucx4OqLtCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6jaCe4hXUsGaUwFaAUbniqQDjDFygCrEpP5wIuZuxU=;
 b=dG/2keMKtrWl6KTMeJm6SqlG/aYdVXVZULFxG7K3F8ks78oCluwLHBhOra5eDzXZOSU92dzBSts/DWfTvCwmChxh2/myvimxV9Y0IsaKtkO8fPxdegfZwitoYcy/fScY9n+BA9B5mIToMh3eBcDiY6p4ZqtnVxqtc1GVzWFnXb33mdopv3UuxnT99XmioSy6B0lcllj88F9OFg/uuqvWZyCGyXkKEJwiW0/IOqEW++dxVOYxmaVabAQKRYZM5JLdnWmAU0/7iNzolbRF9TOtHCV8ooRkkUp19UJ111eS18MnwbfzzMD8t/9uXqSDA/wnOA7mRrBAFV/m3jfaTEPIbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6jaCe4hXUsGaUwFaAUbniqQDjDFygCrEpP5wIuZuxU=;
 b=rHFnNSF/tw5SUKIg2Gnhk8imfw0GetUQ3gsRJK3bRUYMVOElPexoOd8cRxHoeR8YXx4cUIavLY7iPDSmeaaYohjdOn5/f5UFKo+NJ7vcziwE1MkYOF0rn1I8/fd0ysYAeAoP9qtGJIWXh57HtoZgQO3ZXoiW1iQDecVRgJsz5X8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6677.namprd04.prod.outlook.com (2603:10b6:610:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 07:47:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 07:47:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        Karel Zak <kzak@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] btrfs/237: adjust uuid heuristics
Thread-Topic: [PATCH] btrfs/237: adjust uuid heuristics
Thread-Index: AQHYH66UvOP5Ux5XwUqyz/HcT1qHcQ==
Date:   Mon, 14 Feb 2022 07:47:55 +0000
Message-ID: <PH0PR04MB7416BBD1FD978386A64F47259B339@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220212011919.2204685-1-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e75c6db9-e6ff-4c41-3624-08d9ef8e4ff1
x-ms-traffictypediagnostic: CH2PR04MB6677:EE_
x-microsoft-antispam-prvs: <CH2PR04MB6677E9BC380D3A58FF8095029B339@CH2PR04MB6677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HotGExfaAE+68Ji7NeUbtD99+ED1FKNu79rdkq1uySyjpSVeKnfQctaz954ohwQfSrKgeHqUZC0Nssv18Zxwc4ht0X5L92tdtLZiJLIt04m3EOywXlBunidy4DhIkiYWk+5PpoJ7cB5GV0iGeXshcduCdqIFyOmsevO4S2L5dD8MgGI5elgMVJKMM5/ewX5g9DGa+O2RFwa+trjZghVk3DP+IoP59Lie9q/BlNPx+m2sKjXiHv3AFRX5+y3He9CUOxwRrQvdrUHmVtHSgRw5T2kyZ99FfuN9EElwvgrBVEK/djWg8MsEbRWl6PNZcMQm8F/RH4pnGhuDj3f6nZudblsZst3aJxThJ8NMKYDdPo7Pxv7jtNsdD2QLOEyo7GC8szoURWgRub2p436KU3c78gg0GjYzxzxCNb8pV4mb579tLTGCt2Gj+NcntZm+84SOE84uZ4XAzx2DQPF5H6OVLzlslJ/68Ada+E0VH5Vwh4eU/+0Fpsbik8ZUvjqVqVImhXUkgK4wCBpFiwC9iqschLtBw0jWqZFofUTumio+jqFr1AIkJCvO+j0hWRfdSMCw89XwSksDZ4U92GjrVZBMoPa8cxD0ZpIqC5fkdvmhFs6Y71I/EOsqceKZzjErLEDZ2Rk8y2MsiN6FH+pVs7q/qphNcp73tICgB4a1ZUch6OnzrTOpR1twWyBmeTI42IRe3BXeC/Z8uhvQ/ZevflQSLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(186003)(7696005)(6506007)(52536014)(53546011)(2906002)(33656002)(9686003)(83380400001)(71200400001)(5660300002)(4326008)(316002)(54906003)(110136005)(55016003)(38100700002)(8936002)(38070700005)(82960400001)(122000001)(66446008)(64756008)(66476007)(66946007)(66556008)(91956017)(508600001)(76116006)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hKs5Y1t0lqV73oAHKaYuGj8Mlm4J6TQ5EVvDnK9H8FP73rb0Ke/qi3lpDUCt?=
 =?us-ascii?Q?k8mtbxle5PUlWI3kxMsjhYPqr/hIsSVfGrYmdfWpFNVbPft2qGkjt+3HL8EE?=
 =?us-ascii?Q?iZzFybjY/HTdRhinP/wHOp+h4fEMhTwqrA0BbptBwuY91bRuivAon0IrhdXX?=
 =?us-ascii?Q?Qw3VN+izn0J1xhwpfHaH1PewfLQj6EgFKrsR3p1KRY7MY3OOninfQjqPfMhK?=
 =?us-ascii?Q?wVihVCiOpT43ThFXu+dRkfrYwdHlcwMcT5EGfvQHZ5+YnZ3+p0INENQdNrxj?=
 =?us-ascii?Q?PAHnQWy4KZQOWT1ERr+Lxvf+Ld05FOp/Q7TSGJW1FMnu9DtiZCCrpFY2Cet5?=
 =?us-ascii?Q?ImJqrbwYWiWzungu+h4RAsCCWRAM5RyBit/06fbrFBCPrXb5mh/kZ0qfXSsw?=
 =?us-ascii?Q?784/w4eS32OadwxbP+HbG0RPmw3uHOkZkgAGCEdFSRDBJWG43PujDocLPmsw?=
 =?us-ascii?Q?5tgb70XC8OIFKQaKvYc3cyUjGx4biEy3/lANaQfEa7ZhOoH78fG+7h25b9PP?=
 =?us-ascii?Q?l5rEld1m3sKlDLnhHkrzDsuDfYc7fJ5457dv320YQM5pfKIvByJOgyUpQFKx?=
 =?us-ascii?Q?yDLoBP8wTK/1wUToCyoDjF9xR4Q0O7WFgCPD1cn/3FfbCygt9teiLslShpkm?=
 =?us-ascii?Q?vyyXtdb6gJ3Yi2OYKFS4GkPmYwF1Pe7/Xg9z6qyx/+4alPALbxzRYUFkpKtb?=
 =?us-ascii?Q?+pvrbOYA8cgA8qRs2uraP0goGKRj9Y7zINC7caxn1zFA+hes/KyKgu0gj6UF?=
 =?us-ascii?Q?ZaVU3nsbX2GA9kSWsg4kBznipIQfvqGGZjwYF5fBPKQHfRcGCIrquo4wLfnU?=
 =?us-ascii?Q?qN3XhpQu6nq3yT3Lyf4s/RM9N1ajWQJlnmkVwe8T4f4FlOOTlfTI5b/yLrsA?=
 =?us-ascii?Q?OLT07f+xF3VW909q3ouqD+vmmlTdqGl9MiN1lNgmLlCKwwY7fjReZ0ya6sYK?=
 =?us-ascii?Q?8OSFVyf7Yf9zOU/ilYa/+HGz7CUYXGOh4BynTcjybyGj+5WoyeGTVOC3tK4F?=
 =?us-ascii?Q?xk9yu3hJj17elvT4M644O1b9JBoNnXtLgX1g45bRzyEL8JLTqLXQrqmBXisl?=
 =?us-ascii?Q?KvYu2UVsK5bS2cjVJhQUDAjcDJocXFrO66dSegX9f0Fg0pU9GbOxtwjyZWnF?=
 =?us-ascii?Q?wotoaCwhpU6rQMQ2jbI5K6z6CIwXku5hjtBxkxMphGGbbNcxbTUnPYpkzznX?=
 =?us-ascii?Q?353hTdlyV55V1Tcd3QbgBbPhZJj3UpvUWHGPLcpIeZgL7i4z0QMgUV0bD8/j?=
 =?us-ascii?Q?Y69ElhfV2jUZd2sbt/WSrri5L+vIpmfwtAUNsjnMnrwK2DmDRB98mXRDCRsr?=
 =?us-ascii?Q?4N4QLe3wT9aCM+PJJ0EvT3Y7n4FzUmDUB/J7XpXmhGo3ps5vFWgPo/nrK79Z?=
 =?us-ascii?Q?VFGjPLLZJpKu9vZoiuWb5LxvBUirSF7eK5PUONHoO17aMByHwMV5NWfOoNgl?=
 =?us-ascii?Q?ygb0VeCH5lsdkcjlkXjfaeZRWcjoPqTcYkGIMIfJooviqHZ8UFTPcqAMG0IK?=
 =?us-ascii?Q?qzDutMBCOdHLRYvVlGKk2qmIckbE861Rg9LES//okzCXf+JFsgciig2iwJxm?=
 =?us-ascii?Q?m2p06PE8dIj37i9fLA0HtHmmNMrYYtcMABbrlVlKTTN2/GJV2ypW9iOoaQ5n?=
 =?us-ascii?Q?8Q5mFphi4TmbFgDgiaMc5Y0Fmr3ZHdiIVbGcevNwNYeP2gINKiTjPTk47u0E?=
 =?us-ascii?Q?Pw6sQpMfLh0Ex2brFweOd6BkgIfWMWcW3dFbFVKBOrzC5DrZwQh2qz1W1/qE?=
 =?us-ascii?Q?4ckb1H/QDbDJ37AwcRhvzzBCGdEalBQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75c6db9-e6ff-4c41-3624-08d9ef8e4ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 07:47:55.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKJ5TFf3YMwEhf6I+3kzmHySherLLynYVfBt/zV6YRqJbiLIECgcv0+3NSA3L+oItRF4eb80YxYWRsfwYIumy50b6xmmeXJOmAOLss6lsss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6677
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On 12/02/2022 02:19, Luis Chamberlain wrote:=0A=
> Using $(findmnt -n -o UUID mount-directory) only works on=0A=
> util-linux v2.38, not on 2.37. Even debian-testing has util-linux=0A=
> v2.37, so use a mechanism which has worked for longer to fetch the=0A=
> UUID.=0A=
> =0A=
> Without this the test fails on permission failure on accessing=0A=
> the file /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold as $uuid is=0A=
> empty. So while at it, add a check to ensure the UUID is never=0A=
> empty.=0A=
> =0A=
> Cc: Karel Zak <kzak@redhat.com>=0A=
> Cc: Pankaj Raghav <p.raghav@samsung.com>=0A=
> Reported-by: Pankaj Raghav <p.raghav@samsung.com>=0A=
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>=0A=
=0A=
Thanks!=0A=
Minior nit below, otherwise=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
=0A=
> ---=0A=
>  tests/btrfs/237 | 9 ++++++++-=0A=
>  1 file changed, 8 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/tests/btrfs/237 b/tests/btrfs/237=0A=
> index 5168777e..07c07e8e 100755=0A=
> --- a/tests/btrfs/237=0A=
> +++ b/tests/btrfs/237=0A=
> @@ -41,7 +41,14 @@ zonesize=3D$((zonesize << 9))=0A=
>  _scratch_mkfs >/dev/null 2>&1=0A=
>  _scratch_mount -o commit=3D1 # 1s commit time to speed up test=0A=
>  =0A=
> -uuid=3D$(findmnt -n -o UUID "$SCRATCH_MNT")=0A=
> +uuid=3D$($BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV |grep uuid: |\=0A=
> +        awk '{print $NF}')=0A=
=0A=
Think that should be $AWK_PROG=0A=
=0A=
