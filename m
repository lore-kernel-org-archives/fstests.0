Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9CAC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Feb 2022 15:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiBOPwb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:52:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiBOPwa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Feb 2022 10:52:30 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA429D4E3
        for <fstests@vger.kernel.org>; Tue, 15 Feb 2022 07:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644940340; x=1676476340;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=CMXWddxrdCVDPM2TJYUuMS+3EPsmrxHdTGVWlmfs/HS533WWC+VSA1tO
   2T+h0VfGAfqrgrrb6twTsTLJMe9pi1IjS4mUA0yl66cOrdFSVYq0B8zp3
   w+/HPpfv35HefqzbMcP9d1tGfZzvfxTa+ESufbS7o4FL7+JhWaviIIn/q
   NQW3BbGPkrA4O/bgmSSRbqWTedMLIN8FTGOjEGW6nFQ0OGKPOeHOTNDJK
   AL6wfAUUNbVUzmGv5k83fqmjuEArXqpcWQidJQdWBnP6Pyk2XxAm2AWLj
   pviaphNNsB+T3T1djc7jjOJKLbd4DF2mq7eJi0IMtACEBwo9+gM69enX7
   A==;
X-IronPort-AV: E=Sophos;i="5.88,371,1635177600"; 
   d="scan'208";a="297122676"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2022 23:52:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHQlbqtYkeiWvQ3H/zbcuauf4W0kFjV1taU4MEFo5iJTSPhVGVXDjShmofpnpuEcH6F/E33op468NUJkbMe9wa7kXjGPqFnA9vOPmE+TK4M/vJC1lGHfZl2QWFYN/m4efqt82FqYT7yY1ciOKdLaIny0XYR/0MeLP0rsVsbou3eP5NrQ0aYczpebAsXqrbsCS4FECAK/lkf97fvb5p1N0sJvUP/O1cd08Qm8hEduT9Jw6pJl9pQ4GB4HQK5PntMMsnVS6YP6U+RpvdIEMjUXyA52VxEjfTkzUCYHtEAcD4ZX7kJDlLcrmXq5sRoKjjcgvCJSPrFdBOKB6nuBzWb8Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=K1cxTLtgbT+zabbKmTj+d2heC8hpiJfph3hENjk4q9bQEL/kjP9pUDwKPCu28o82f9OSALm4aDiu9lWtHc/RD+NbdQA9GyITQ4zyWhoz7IV/gkB7YSGC+t5KwGmRGV8SDPiPf0tAXluMx/U35j6RKBMUN53b4gLyzd6cRtolxycVL8EYOkuw5TFwyxLDUdy0YGZSayONXeavzFWSwl+48T4UIPyy0i2EvGcTBT4BIJcEF1SOijrOcEJL7t9H0322r8IhGt8s31BfGlc0NtHQtbf9fwuv+LDa2JlTArQJznNGk+vjjmu7b8qEPPBbw4rpelrL46H8EcnmX4snu62gqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Wh/USuHWLmnxP/N5dqNxgfr9agjjVQQpQGstb+WT4VhUy46KkfQTqabNbwzjquU6AgAgXuzw8W1AHpSgLW3xfpRo4owqQHjhkYNIEsvGwau0RUriNbvJIvVOUl/oVV0DTVfzYHYGkzsSU8ND0m6I0Y885uVJvTubgsbNS9DGVQE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB1254.namprd04.prod.outlook.com (2603:10b6:910:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 15:52:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 15:52:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>
Subject: Re: [PATCH v2 2/3] common/btrfs: use $AWK_PROG
Thread-Topic: [PATCH v2 2/3] common/btrfs: use $AWK_PROG
Thread-Index: AQHYIg4vT1K617++MEe79RB1t5qBXA==
Date:   Tue, 15 Feb 2022 15:52:14 +0000
Message-ID: <PH0PR04MB74160F23B9DF41FCA8538C239B349@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220215014845.4164719-1-mcgrof@kernel.org>
 <20220215014845.4164719-3-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43ce60be-c5b9-4201-cf3e-08d9f09b22d9
x-ms-traffictypediagnostic: CY4PR04MB1254:EE_
x-microsoft-antispam-prvs: <CY4PR04MB1254AF266DB41ACACE596E9B9B349@CY4PR04MB1254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IjQG1AMlW5BPdvBfb7cHu8U2UJmhSrcvdd724eCpXYBzK2F+gWRnOMTZak8A9+rcM5z44zngGiaLPuzaVg6kJSn14zs/+gLH+jpBh2zu3otyQT7MZKJvf5bnYxx21UeDsdtciqHks/SQBqtYh4CE3yyU05xyLV2B1smMyp6dPZgq7axYuk2rEeQsMj98LpWDfEMRM9APgvCxOA94TZ/3ky++iXzyO8VAMhvAO1WgyUrfGS1H5gaSKMCG1WScgrUIMZox0UWobUMrefxaR+J8GGrEmGkBcwPiu1lNYUOwm4LK3ephRAzuUZ3wmivof3a1tbBoO4OYDs0kdbaK7TiXakOwnwMJpSaa9Ut/40nyEwH/C+hcwtcdgC+ivSE/117l5Hir2A435hkwfhHg1Lr0Fyn73DK5/cEY1P2OyN+bgvlcAVfOgljrwfE7BDipkzdkcDhncLYjYQyWNpY9QDqmOrv23zVAuYEHG+omeYGjpJrPQ1EoLHniG7SwrGSQ89NDPi9C0CjxKVXL7pWQHebk7gY4y7yJnlHf7c3dvO223q0DAM3Wuu76I5nNcoHUKHLYrDQgsKeOl3hMgTafde0F27Pc5VoE+6XjdS6y+N26zXkSjq5DiEfka+RqE9ZW/+3J5osEJ7ONdWxDrOVRrykTnkgL/xbqeuzofk/KKr6Pad2Cv/2NxNI20d2qivz4JhzFLSiuc2mXXdrvwF0FTUDAcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(66556008)(55016003)(4326008)(8676002)(91956017)(66476007)(38100700002)(66946007)(86362001)(76116006)(122000001)(38070700005)(110136005)(54906003)(316002)(66446008)(82960400001)(508600001)(6506007)(19618925003)(33656002)(4270600006)(71200400001)(9686003)(186003)(52536014)(7696005)(5660300002)(2906002)(558084003)(26005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u3ccgD8JgeltoynnTWzyvTRxcTiwWuPbUtYP0sQYMLdo4WemFLtmq8P+J2nS?=
 =?us-ascii?Q?a0kZkEwxnvgrqrE5RN1TsiNBhjtrldZCKkPJ7/D4zlveZwXVk9VFCFDkyFjW?=
 =?us-ascii?Q?uLhdx80vdQB6IsHt52JmJxKjoA19S2MyNhTpzSlaqmSrLfUQMeDbmFMaGEEX?=
 =?us-ascii?Q?PUikhgUkoh4griU835EDdNubrxhuawXfcLRyDtNB5JtAFHYM5+DtahKONYxi?=
 =?us-ascii?Q?+D1pQLoiQPOLcUzthUJugKGx1mHFaNwWDQ8b6KP9xAMhlqzOn4NYQLOUfVoZ?=
 =?us-ascii?Q?3pL8hc2Pq8OfCCAIfPsry8+xFEqzKxcrKnc3D8rzhAv4IhEi9HYcMiC/3I9h?=
 =?us-ascii?Q?qumz6IsS8HKCyhSudn8fCyWg37PIxyycUtYTSjSkLROTuCa5budXgjjii917?=
 =?us-ascii?Q?J6pIjOwcJz8lCMssIOi5KISXtoS1VxOYBjlcW+Hck9C/qpmgIOIO5YEqmTWS?=
 =?us-ascii?Q?4WanKbzfZiTs+QDQuocE0gtvgutT2U/5Wc0+yAfrm7+QCKdCtqcZJIDqmAu0?=
 =?us-ascii?Q?0VjXxeYKhZmMNgtq/Cf8wwxP4WZMnesjmkNSxTG+aXBni6j/i4uPJl7Uxrw4?=
 =?us-ascii?Q?2aA2H1+wapmUMyNYtVZSoSZwoqSYyFE9qDKaEQ7ax4vtmqy3h4iASKEIZ2jB?=
 =?us-ascii?Q?9kjrdaLwXt/S/15RdAOlDOE4FWtgB/w/kG5Rb1t5R33DJH0cSvBOhyirPG+T?=
 =?us-ascii?Q?i1jJk/mnloBvWKsc1vnJ30225o8sPOiCHDWaFMbcHwZNcRmYrsNlEVWatsPh?=
 =?us-ascii?Q?nOb1PlK9iraxpvRZoKb/q5s00XU0UEoR7fbdQf9sF9j+FePgORmm0VwWtfxE?=
 =?us-ascii?Q?D2tU2SVaCq+zyoD4SHFBDKK+1ug72WmKs9DOpfRiz82jPpdFQ3HdJ8wVm8ka?=
 =?us-ascii?Q?C4hM/DrcgwHAa9KLJCApIW85vlyWn9Z3wRip/+Ug8xBcq+BF8Bh3NduUushO?=
 =?us-ascii?Q?lPexc1xMqqru1YMMgCa2h10JbwS2OavKvX+4IkJsS6vEGAOAPlXo8ssskDvo?=
 =?us-ascii?Q?qLRdQ3bfW+EYoUjdDaGpE9ZG9M6t++M9BMvYblJg3xlcqmNQkJvVjIua0C/M?=
 =?us-ascii?Q?zTwcRYtYG8Dze+d1ezmyeTUQjLroXgZzSajSdF2J0iFCwHbeCTawO/I7sJOQ?=
 =?us-ascii?Q?bxmnWH+tDxkymCohudL9FIBpyEE+Zpe3ntWaABkvAco9b7R6T2YRA39TA0A5?=
 =?us-ascii?Q?EfLiXSnJXG8aH1R4sdE6V/loqk9rxbnFOdHMDvt+5s9Ybg9apRKG0n3mupej?=
 =?us-ascii?Q?eLcwdDxDrao03lFe0uV8UAaogBaYZc5c/FbeR9TYiSboiHSfwlZI/x7nIykd?=
 =?us-ascii?Q?wB+7ZO2dGvBOsSBXJKbu/pEcQ7qoeWFwTMyJl0yeFB8wM1nGqfmwV3XmXIbY?=
 =?us-ascii?Q?D3sZcrx7bCMrZSmwiMERgaV25HmFTfhmBQrCv4/pEk4zZ/0QD8JSi1VoX3Y3?=
 =?us-ascii?Q?GfSzu3ayl0eBrtSbIZWs9nVibpu4uB6tCjCFEfj5yUMI96MKEfpYLykjU03Q?=
 =?us-ascii?Q?JN0M/S7MyQPYvwKLGok6X41Krz7zpxR1QzX1vMC5kZ+9YrnlLZWnMgi8GRMl?=
 =?us-ascii?Q?ZlIzUKR/ILvcf5l0SW8eWlVP/h3b1Mv4tl/zjlNyN1SdpkOaoSXrrxVYOT5X?=
 =?us-ascii?Q?E/brgK8zD63gcGY2HjJ8YQ6/tNDNzPt6l3y+btinmX/SHPKBC+AJSHShhkQC?=
 =?us-ascii?Q?75erX3PQAJZraxrK89jtrI/SxRE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ce60be-c5b9-4201-cf3e-08d9f09b22d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 15:52:14.3682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lM0vBvk3YsQ9dfM4pbc1VEPOLMda1YVNIgLOj1Y1SOw4wPAzxV7EXwQOSTvx670oTJOefVGRM/tECFglyBdFk7zbjGiY+lyYVcd0L2I/xRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1254
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
