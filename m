Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42782C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 11:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbiEQL32 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiEQL31 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 07:29:27 -0400
Received: from apac01-obe.outbound.protection.outlook.com (mail-eastasiaazon11020020.outbound.protection.outlook.com [52.101.128.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F6137A1C
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 04:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFoXf04RQtKJAwN+Erz9V3ZKCQGjlR55pLhauvFrx6wyIYj4YTwDE6VM6afer9t+mUnA4jT1b7zP1Fho7unKOr/YmVF5mSmMDoe63x30wZDm4slIdL1pyTkNfRiQ2Epv8iyuf6G9K6Mx37RZSk1gLB418KXiHG64KVTzToPFFMNzX6GBw+vB5iWJ2D1/H2b3XTj6GKEpu/NPMMeEFgbYjVNz775OjRgUodlwdBvntK/74dzQs0njAGJY2StaYzCJABz5SOTNcM9YItVr6Azn0DBE9mYXtYzXdO70NHYa8qXCby4rQhd/BjXD1ULrwGdPqPG+IWiXsuDFp/qjl8vwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM+RcT84amL3+7Tlr5xJ1edO7lzQ7/LvuOxW0T9ikZI=;
 b=XdF1MmmZB2FZjqkSWDw3UzOVVBeF4ateujjpSs6WXb0YS8+vXBOP6ifI8XZdN3VZ39SLtztvaZJ7rDOvyWoaUsq6d5rdOwqCdYNOA2XoUnetF0+D6tChT493vTD0RqZRyXuz6+unfQ2RSJ1EDOeh1aAlMLVhrLEj5MHZBJW1Aau/Dl4UGqDnC5J8BL/+qRZAcnl80dJNSNRmxQjlEa+LcGDap/7GGe1el9mXnQ22Z1RGi4PuyJZD1Gg4El4DJy9mbtf2NhsQv2XyFm7zFN3t/lsH52Xgf2o0UZFDoXcKE/XE/RnJRZ+zcPOvMhfy1Inb+FJEXCZf8h7sWrEkEtkokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM+RcT84amL3+7Tlr5xJ1edO7lzQ7/LvuOxW0T9ikZI=;
 b=chNqHPqYEhPgHzN3vzqph1Kn0q/N3+yFWHXYQk/OzmNMN7vX4Vp08nxootsvLujI/xE7WwNWY117vbH40Jc7d8ILECSQxGhd4R5I9SKcRR0LfuJpExAxnOcQD2ii+k1db9QqmeOjqxWyFXlK9/XC3eppNAxo0XdkTiO8mrGWUK8=
Received: from SI2P153MB0476.APCP153.PROD.OUTLOOK.COM (2603:1096:4:12f::11) by
 TY2P153MB0382.APCP153.PROD.OUTLOOK.COM (2603:1096:404:8012::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.2; Tue, 17 May
 2022 11:29:20 +0000
Received: from SI2P153MB0476.APCP153.PROD.OUTLOOK.COM
 ([fe80::757b:60e3:e45c:afaf]) by SI2P153MB0476.APCP153.PROD.OUTLOOK.COM
 ([fe80::757b:60e3:e45c:afaf%6]) with mapi id 15.20.5293.004; Tue, 17 May 2022
 11:29:18 +0000
From:   Lili Deng <Lili.Deng@microsoft.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     fstests <fstests@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Build error for file chprojid_fail.c on ubuntu
 16.04
Thread-Topic: [EXTERNAL] Re: Build error for file chprojid_fail.c on ubuntu
 16.04
Thread-Index: Adcb6wf10xYMhiiXRdeQS3lg6Or+awAJ5UMAAAAOmwBQIJOOkAM4lIwAABp1Y9A=
Date:   Tue, 17 May 2022 11:29:18 +0000
Message-ID: <SI2P153MB04768A69624FBFEA691D0000E7CE9@SI2P153MB0476.APCP153.PROD.OUTLOOK.COM>
References: <SI2P153MB0476DF844D7018D0BA4C7E1CE7699@SI2P153MB0476.APCP153.PROD.OUTLOOK.COM>
 <20210318162030.GH22097@magnolia> <20210318162208.GI22097@magnolia>
 <SI2P153MB0476DF2BCAC21C87458F5369E7FF9@SI2P153MB0476.APCP153.PROD.OUTLOOK.COM>
 <YoLVbHQX+PvpJHFM@magnolia>
In-Reply-To: <YoLVbHQX+PvpJHFM@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f8f6dcd5-beb0-4312-a381-760d85e108d0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-17T11:28:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22811d1b-74e8-4b14-fd60-08da37f87b0c
x-ms-traffictypediagnostic: TY2P153MB0382:EE_
x-microsoft-antispam-prvs: <TY2P153MB0382684D9048C308994E1857E7CE9@TY2P153MB0382.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: if6Sb9R9iRDmeZvPoxIisjHpMQgrTve4kYRD9xvIOyIqL0uAQGBcnY9Oi8nEmr4J7Hy2Pdq8WWrQcfyfL/+Z3m9xVELolZZRll4JBHsL+h/A+E+SCMa0J0s5gkv/VUtIjigfOQgH8Di5Y2qB8jNfoeSeVeBdFuvkZMtcmMOq6BvWEoPHlbCQOWyVH7aaLISflQh2Ir6iycEqf+eJV53P1wN+egm2Z6uwXyjW9gde4cxDSCz1sb5pTUS6Y+dY7boFwy6h4iVlFBNjt64cD5/4RzkxnGFHPUpUqYdZXQ5j+rauxypucT0YUV4THx/bMSwhzgxuRHm4HO2HON458+5QepKohsWrzUJD8lm8XpPk7wxBeTbYR/6zrtuHBs9sSiCIwP7SWtI/aE8y41mcmn5GOtDE0khytoXjtSqKw5vYenHIpylG1ZFC0HxklshzqsZMhjuNt7Hv6svpUg/4nCKsVFwrmenxj7mHYLBf3U7lhjQntCxG3jBZFI8svEYYe8a8bC8EgANhodM4YOvgl1SsgY4JeUgeQ6Y2zl4gYIAWPA8WAZtBnymqkVr/3+9COTSpTP4j2xrerJSZSHPYM61eD2XYHfny8LMDf2cNJ8zJqNyUaVL+XtVKdV2zXxgb0WTBYb/NylVZ+IM2fWsUogxvK6m0YvlIkItiHWdOoaSLuj9jKBP02wKUj57T4k2c5/t2z/jmLiJEWW3JtDgmWK3Mrw4UTKU0bYObl0eyjF7/9A8x/qEG1zIJ+bW91cYVSNPvZvN+SGB2JNZo3TqagC9GguKnHP4rQduWJR8CTs3tYPZi9VhI1Q2M9inY/5Avhn4+rBbyasXT2WZlPu7RJM+9/R5N6RPYTP7Fvn6JU1yXTeEo+RIbyx31qjNLpFTKVp1wkY2QGPS4XdRMKUSVgKDTmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2P153MB0476.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(53546011)(71200400001)(82960400001)(2906002)(6506007)(33656002)(83380400001)(55016003)(5660300002)(7696005)(966005)(52536014)(8936002)(508600001)(122000001)(82950400001)(9686003)(6916009)(10290500003)(38100700002)(316002)(38070700005)(86362001)(8990500004)(66946007)(66476007)(186003)(66556008)(4326008)(76116006)(66446008)(8676002)(64756008)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uvzb5EIOcKcsNa2W8Bc+Pg6YdbcZIxOk8ix7U3hnyXhARzr4+pdEB7fGiZmi?=
 =?us-ascii?Q?EF1lbRhyZcp4bkO69nsIU7H3o5Y3tO5Ab9l+W9RcXBe6LDM9iK+glMJIDi0+?=
 =?us-ascii?Q?BTARgWtyy86IcjIXnhxtmVbSonS41DTmJuVfvd+e7tfiuuwrd4j4qCWFvooe?=
 =?us-ascii?Q?3JFVmuWjS4k4Mv37wbrBER7OLYUMvJmJn1OCLoZ2w7t1bGUCvrn8QsHzpCPM?=
 =?us-ascii?Q?uKWZgJnQxnqEY0+w5ITo5+jJVcbJEtXKtkRKtcdpxyNoIOJuUxNARgfcIB23?=
 =?us-ascii?Q?gQFwQx/lXDxdVEJtk+moS6Vj1W6LK2+LVLvVpXE9HltC2I6LRzPlNDzT29Jr?=
 =?us-ascii?Q?Jq/h14stkcNLRoxuddDukmlFk0avAWTiGyY5hpI2ISWzAGwwg4HCP1gRhl1I?=
 =?us-ascii?Q?Ko9Dq3+Zme4PjyQ5IpKcfRJM0IBxRoB7DZwA+d44v+NOI+wJN1Q8QXbvOo8f?=
 =?us-ascii?Q?vtDzEpMK+RmWPfySShZOb7uHEQB7o+ftEaOF7zFzIgKESiCKvJi3Xl6vWy62?=
 =?us-ascii?Q?aIne7Mwn8d9kLGI7czv09IV1imWNxb7paYB6OuanJlOxMiz2s85HQ6vOpHFg?=
 =?us-ascii?Q?cIIs4yY1AWMCLwoN/s9oiXmsOU4LPJISbeI/oqeEhjpwXwprXhwtzBsujKPj?=
 =?us-ascii?Q?X1g36I9K4dnPlT7lAvzLZ7mdKeEOnxuijCuDPw/s5y6q+UKwYeqdZSmwhqQG?=
 =?us-ascii?Q?wyFkDX6G4ZkeGVSFoKBV2MI55EJsD6Enec374QjgXDnbQ1SJvnE06VHSlzyZ?=
 =?us-ascii?Q?rzKXBeNvQP4INT8iHlNaf97Kssh5e0ArHg2JOZT4cPZ/z/FEsOjfyHEzlRh0?=
 =?us-ascii?Q?gfWRvxx36ghQKaVq6CN5j+0WEflx6phUAAZcRyfAC9cMkILakS6GzRDVciKJ?=
 =?us-ascii?Q?f6fTvQO09hLFMyWCxV8aRZtGNc2fw65P9No2po7NYZzD2eHe+k06jBwBdcz9?=
 =?us-ascii?Q?J4ebgrDLQNolI9589uifwkR7WEBJOwN1Hcv6+QbZOyoQAM5YRgBqr+KpZcJt?=
 =?us-ascii?Q?a0pREv3yRYTQOZgb+QS01EbjydVANGUz7ZIagcMQeMCBUOUR/4GaQ5ZN5Vic?=
 =?us-ascii?Q?GD5EVqRLKUud9ivHW6I25fxtH2B2Cuvol2Vw0lZcjGfREAKJbEskBIrtbAnZ?=
 =?us-ascii?Q?Swl6dUCaHRiTskHPjtHM8rPziz0jZTIyYbhztbpJYGLsqHyI7Yjqn0+D1iAj?=
 =?us-ascii?Q?uAFymU1LkUctmpzG3ROyKVgK3NOS9rFpCS2kiB1wqaAkmTT/nJQ0eq8QbFs+?=
 =?us-ascii?Q?cH92jOLrYAlTpmIyhbCpSIx3yK0GqD/qEzFV5HCVaDfDZQLZv9Qb0dfWHCA8?=
 =?us-ascii?Q?+mOgI7DprDarr2P16N7pk/q6JSa1mcReEk1C8ubYpH3y7Eh6XR4TNt7yhY9f?=
 =?us-ascii?Q?reSwle3+ZMlZGMMesM4IIccrgdhUyDN3DExpn5Z/W6HcWQceZvuSVySDjblo?=
 =?us-ascii?Q?VwVRDzr7EjD2oC6AZFP8m3fzAZZglBrmrO3JoWgFo0VVETYrGowg+d6OBAev?=
 =?us-ascii?Q?J1CWEm3yLQXcjWP+jPVbZK/BW0dV9DQzYnQ1CcjC/irLZPGCpxJFR+451UJj?=
 =?us-ascii?Q?M8/ZNq9IXoSLg1eauBve0b/gokIaZP5X3SxC2FayVNmbecz2+PKfV5awXuXG?=
 =?us-ascii?Q?QVkMRvGmraMWS0+n1L6NyIYgGko62+4aZHyXRPxwCvjRhSdYLpXJBcylDVSa?=
 =?us-ascii?Q?U23ZA7IQppXYwAZ/RA1j0f/Ut2a2njUP3Ujwx5aryIFuGFAQJ2nUTeIYeT6A?=
 =?us-ascii?Q?j6cxTbT4r7px3zEDFtGeIdGuT91AactJOPTz+cfhE84eqt0TYVSqSpZ4epF0?=
x-ms-exchange-antispam-messagedata-1: cKX+pPOZBmv5Sg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2P153MB0476.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 22811d1b-74e8-4b14-fd60-08da37f87b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 11:29:18.1587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QraskcE9zI3GXTLTWUXbJ78vnHuy8Y9E0H22HwrLX8UbnMomjn+Jp4o4jOO899e5SINo5v5jPdd7iHnxtitIjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2P153MB0382
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thanks for your reply.

> -----Original Message-----
> From: Darrick J. Wong <djwong@kernel.org>
> Sent: Tuesday, May 17, 2022 6:51 AM
> To: Lili Deng <Lili.Deng@microsoft.com>
> Cc: fstests <fstests@vger.kernel.org>
> Subject: Re: [EXTERNAL] Re: Build error for file chprojid_fail.c on ubunt=
u 16.04
>=20
> On Sat, Apr 30, 2022 at 01:23:05PM +0000, Lili Deng wrote:
> > Hi,
> >
> > Could you please submit a patch for this issue? Add below lines before =
using
> them. Thanks!
> >
> >         unsigned int        FS_IOC_FSSETXATTR;
> >         unsigned int        FS_XFLAG_EXTSIZE;
> >         unsigned int        FS_IOC_FSGETXATTR;
>=20
> That will break the build on systems where the kernel headers actually /d=
o/
> define those symbols.
>=20
> Also, this is free software -- as a community member, *you* can propose
> patches to fix things.
>=20
> --D
>=20
> > Thanks,
> > Lili
> > > -----Original Message-----
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > Sent: Friday, March 19, 2021 12:22 AM
> > > To: Lili Deng <Lili.Deng@microsoft.com>
> > > Subject: [EXTERNAL] Re: Build error for file chprojid_fail.c on
> > > ubuntu 16.04
> > >
> > > On Thu, Mar 18, 2021 at 09:20:30AM -0700, Darrick J. Wong wrote:
> > > > On Thu, Mar 18, 2021 at 11:37:11AM +0000, Lili Deng wrote:
> > > > >
> > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
> > > > > t.kernel.org%2Fpub%2Fscm%2Ffs%2Fxfs%2Fxfstests-
> > > dev.git%2Fcommit%2Fsr
> > > > >
> > >
> c%2Fchprojid_fail.c%3Fid%3Df6ddaf130d5b0817278afe441fdde52f464f321
> > > b&
> > > > >
> > >
> amp;data=3D04%7C01%7CLili.Deng%40microsoft.com%7C68254dbe593f41a2
> > > 50b00
> > > > >
> > >
> 8d8ea29fb1e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637
> > > 51681332
> > > > >
> > >
> 7967886%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > > V2luMzIi
> > > > >
> > >
> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DAfkOw5bow95qd
> > > p7HoTl%
> > > > > 2F4lMJzE11arE0zst0jrQVMf0%3D&amp;reserved=3D0
> > > > >
> > > > > Hi Darrick,
> > > > >
> > > > > I hit below build error on Ubuntu 16.04. Do you know how to work
> > > > > around it? Thanks.  Gcc version is gcc version 5.4.0 20160609
> > > > > (Ubuntu 5.4.0-6ubuntu1~16.04.12), make version is GNU Make 4.1
> > > >
> > > > Sorry about that. :/
> > > >
> > > > Does it work if you #include "global.h" in src/chprojid_fail.c?
> > >
> > > Or, does applying this patch fix it?
> > >
> > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> > > kernel.org%2Ffstests%2F1615975873-19206-1-git-send-email-
> > >
> xuyang2018.jy%40cn.fujitsu.com%2FT%2F%23u&amp;data=3D04%7C01%7CLil
> > >
> i.Deng%40microsoft.com%7C68254dbe593f41a250b008d8ea29fb1e%7C72
> > >
> f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637516813327967886
> > > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
> MzIi
> > >
> LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D7TSc%2FlROJm5
> > > QN5X5se25Qow3Ws8MQCw%2BH5%2F3KaZkYko%3D&amp;reserved=3D0
> > >
> > > --D
> > >
> > > > --D
> > > >
> > > > >
> > > > > Building include
> > > > > Building lib
> > > > > Building ltp
> > > > > Building src
> > > > >     [CC]    chprojid_fail
> > > > > chprojid_fail.c: In function 'main':
> > > > > chprojid_fail.c:26:17: error: storage size of 'fa' isn't known
> > > > >   struct fsxattr fa;
> > > > >                  ^
> > > > > chprojid_fail.c:42:18: error: 'FS_IOC_FSGETXATTR' undeclared
> > > > > (first use in
> > > this function)
> > > > >   ret =3D ioctl(fd, FS_IOC_FSGETXATTR, &fa);
> > > > >                   ^
> > > > > chprojid_fail.c:42:18: note: each undeclared identifier is
> > > > > reported only once for each function it appears in
> > > > > chprojid_fail.c:51:19: error: 'FS_IOC_FSSETXATTR' undeclared
> > > > > (first use in
> > > this function)
> > > > >    ret =3D ioctl(fd, FS_IOC_FSSETXATTR, &fa);
> > > > >                    ^
> > > > > chprojid_fail.c:82:19: error: 'FS_XFLAG_EXTSIZE' undeclared
> > > > > (first use in
> > > this function)
> > > > >   fa.fsx_xflags |=3D FS_XFLAG_EXTSIZE;
> > > > >                    ^
> > > > > chprojid_fail.c:26:17: warning: unused variable 'fa' [-Wunused-va=
riable]
> > > > >   struct fsxattr fa;
> > > > >                  ^
> > > > > Makefile:88: recipe for target 'chprojid_fail' failed
> > > > > make[2]: *** [chprojid_fail] Error 1
> > > > > include/buildrules:30: recipe for target 'src' failed
> > > > > make[1]: *** [src] Error 2
> > > > > Makefile:50: recipe for target 'default' failed
> > > > > make: *** [default] Error 2
> > > > >
> > > > > Thanks,
> > > > > Lili
