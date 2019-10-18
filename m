Return-Path: <SRS0=Q9mn=YL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC8CA9EA1
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 10:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B8121D7C
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 10:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="dmNB9tre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407701AbfJRKyM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:54:12 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:43068 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392070AbfJRKyL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Oct 2019 06:54:11 -0400
IronPort-SDR: doGXJsSkHlfqqiLO281K/i945M+7AnGPqjfMp+Mp2Ol9OyzIJsnMXRHdPt2ZpplIf6Q/n1Ugnv
 muTXpqwXHS1zvPho20U1b0A71i7POFF51KZCHk8QyMScRNVEKEzm4r+reX8Clfkd1gfLeOmiwi
 DYFyirsRyNaeNzyKyIlzVMD6ovbXUqS060pHoi++yFE2IL4b2f24vJgjsax0ddwqOhu/Qti0e8
 nanWDcwmiyubeRjJDyWteBqHwa8HS7M/zUp68400RpqngSWldROYVGv/2s69v/s0uP4tHZBL1n
 +/A=
X-IronPort-AV: E=McAfee;i="6000,8403,9413"; a="6981184"
X-IronPort-AV: E=Sophos;i="5.67,311,1566831600"; 
   d="scan'208";a="6981184"
Received: from mail-ty1jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 19:54:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrS7vZMi3L/oAVzCgC5qI9uo1jpeWWjA6f8y9pp/4FHy2OuVCFqI4hEBj+5S3XWP8I4pQ7NxZ+vfWTwqDrSpsLJwIFtgAybRAPEziVjVoQwl070HdSNd2BK/GsaS5zfIt53dCLaxtT0bh5wAgYj4UVbYIP/AFejJZ3rqYHhKxvTjH3oQsv1gzvc4wJWaXD+2Zai4lmBRbmFmJ+fbeqdgcmcYpUi0rAzj1cSBMAbLtPyTiCmd1AmZAIn2Q34ocLajAotQqZrE721+mUGhOjwmDQVEgsU/jTaO/p+k5JT/BQcwT6uxVdPhwBoKJaDktHgY66QkIUwGWJs1aOy0UuMPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDXKHncT4+AQ+MvLSB9uck3yc21MLI/c1miE4EDkqr0=;
 b=OWkWw36mpcn+dDAi1vsvUEtKR/ayc2ZrCQ9x3lMpr0y8Y6jazpywM3hCqvGaFf44IKiLHPY1Z/EEqlWPJQndyvF3hQxSSxotTdUvOduF9ylh9beOwM3Y6e5R0Txt+hsv93FikzL8me9h9L0an+1wgpAyPTeQnbbDWw1PKN8gWseDf4/bC5s7IveZrW5CV0dhe+bnMBieAMdU4ZnWDvgu1ArOwGGkR1g+7DuGYVbwfnu0dAE44zerjcSVaNMAIKj4wx30EfEHXGYKMgzp6wVRCCrAsLdZwMMacXkOMRWosquafdsgVgV0s8JZjOP11vUaV0wEPkqvEYIPRwVJMbqwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDXKHncT4+AQ+MvLSB9uck3yc21MLI/c1miE4EDkqr0=;
 b=dmNB9tre8KduV/J2aLIWQdaPNNE5XHSnT+yRXeRUgZZAidI/ywBClmii5tNbqDoEgq927fQcd3eVKWB3jZUhW4hoF9hFS8QvuwOnekb1WEFq0CEea9olXE0A3pl3dJuMZTbjrunTvjrFOUAgOPSjcqexqcmwIAzSfOZmRNn7Yak=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (20.178.96.203) by
 OSBPR01MB2102.jpnprd01.prod.outlook.com (52.134.241.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 18 Oct 2019 10:54:05 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c%5]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 10:54:05 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     'Eryu Guan' <guaneryu@gmail.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: RE: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Thread-Topic: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Thread-Index: AQHVhBCG71vpUjQhc0Csd4LFrwSd2qdgFxqAgAADTZCAABncgIAABp4w
Date:   Fri, 18 Oct 2019 10:52:39 +0000
Deferred-Delivery: Fri, 18 Oct 2019 10:53:38 +0000
Message-ID: <OSBPR01MB378378E4464D44272308DEC2E56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20191016105347.16650-1-misono.tomohiro@jp.fujitsu.com>
 <20191018083951.GJ2622@desktop>
 <OSBPR01MB3783B9C166C06784BF5C7385E56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
 <20191018102417.GN2622@desktop>
In-Reply-To: <20191018102417.GN2622@desktop>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 7d1879bf005c414a8b6ef38115e84fc7
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [114.160.30.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81313c91-f960-4392-3d32-08d753b97ed6
x-ms-traffictypediagnostic: OSBPR01MB2102:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <OSBPR01MB2102F96EA3AF34BD9C9DF190E56C0@OSBPR01MB2102.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(8936002)(66946007)(64756008)(66446008)(66476007)(6306002)(9686003)(6436002)(25786009)(76116006)(55016002)(66066001)(66556008)(305945005)(85182001)(6916009)(7736002)(256004)(478600001)(14444005)(3846002)(6116002)(11346002)(86362001)(446003)(476003)(33656002)(316002)(486006)(966005)(4326008)(6666004)(5660300002)(8676002)(71190400001)(229853002)(14454004)(71200400001)(6246003)(102836004)(1411001)(6506007)(26005)(186003)(52536014)(99286004)(74316002)(76176011)(7696005)(2906002)(81166006)(81156014)(41533002)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB2102;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qCfls0yTfWjDZ+htvrycwNBGvJyxYWV90MlZk67RDiIwArKC9jBtmJXa/ijI2T186G85DQX4r6Bhr75BkTvqiCRkCeeuM+6ec6bjLKo9QmwAgJHeNRtGCvDxRVXYVbJWEHSm6h19MuAcM4sZV/I3A0u3r2g1gmuCQSPFJGenbu0gZXzGwXtY8AfyClWshIX3Dl/TFxD1EROPz0h/HKQwbCLql4sPrw9rgWZ/PP+F8lkUSNgPdjAsjTyqz9vahf6/5fj1t+rJ3HJKWzmMAELx+lGldzds8YikUFAzMY+GI0bkBWwQhfcF9L+oqAc/OeBcB7ota6q9Shq1LfAmxdZoNLGa6L5N1ZUbbvcmV6rOpf9+pwQ01p6yN4ipu+rV6iNi8Qa+44B6aGVR1cXUN3quf5aAS1yoKCZ8bpAl8hK0gx6ztsm+5mwSz6gYLfr6PvlhaE87d2lvMrBcCEfTYglROA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81313c91-f960-4392-3d32-08d753b97ed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 10:54:05.7559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4owZdGjBLVJiYSNf3AOw/mxtJaNc1Vzrgcvbzcg7w1P8t7qy0Cof0VqTgula19yL4QBsML6QoB7GMMajQrMBv7pbS1c7X76dXttXKM/+EJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2102
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> On Fri, Oct 18, 2019 at 09:02:12AM +0000, misono.tomohiro@fujitsu.com wro=
te:
> > > On Wed, Oct 16, 2019 at 07:53:47PM +0900, Misono Tomohiro wrote:
> > > > This test requires fallocate keep_size. So, skip the test if a
> > > > target FS does not support the function to avoid false negative.
> > > >
> > > > Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
> > >
> > > Would you please paste the false failure you've seen? I can't recall
> > > I hit such failures, and I think fsx would just disable unsupported
> > > operations and don't cause failure, it just prints a message to stder=
r, and we already redirect stderr to $seqres.full in
> run_fsx in 469.
> >
> > Hi, I just got output mismatch error:
> >
> > $ cat results/generic/469.out.bad
> > QA output created by 469
> > fsx --replay-ops fsxops.0
> > Seed set to 1
> > main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, d=
isabling!
> > main: filesystem does not support fallocate mode FALLOC_FL_PUNCH_HOLE |=
 FALLOC_FL_KEEP_SIZE, disabling!
> > main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, =
disabling!
> > main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RAN=
GE, disabling!
> > main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE=
, disabling!
> > main: filesystem does not support clone range, disabling!
> > main: filesystem does not support dedupe range, disabling!
> > fallocate: 0x0 to 0x1000
> > do_preallocate: fallocate: Operation not supported LOG DUMP (1 total
> > operations):
> > 1(  1 mod 256): FALLOC   0x0 thru 0x1000        (0x1000 bytes) PAST_EOF
> > Log of operations saved to "/test1/469.fsx.fsxops"; replay with
> > --replay-ops Correct content saved for comparison (maybe hexdump
> > "/test1/469.fsx" vs "/test1/469.fsx.fsxgood")
>=20
> Ah, I recalled that I actually tried to fix this issue before, but Amir d=
idn't like my patch back then :)
>=20
> https://spinics.net/lists/fstests/msg07953.html
>=20
> Because my patch silently ignored 'keep_size' flag when replaying operati=
ons, and look at it again, I don't like it either.
>=20
> I think we could just skip the keep_size operations instead of ignoring i=
t.
>=20
> Would you please try this patch?
>=20
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 06d08e4e93f3..ae89bf665db4 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -2044,6 +2044,9 @@ have_op:
>                 if (!fallocate_calls) {
>                         log4(OP_FALLOCATE, offset, size, FL_SKIPPED);
>                         goto out;
> +               } else if (keep_size && !keep_size_calls) {
> +                       log4(OP_FALLOCATE, offset, size, FL_SKIPPED | FL_=
KEEP_SIZE);
> +                       goto out;
>                 }
>                 break;
>         case OP_PUNCH_HOLE:
> @@ -2056,6 +2059,9 @@ have_op:
>                 if (!zero_range_calls) {
>                         log4(OP_ZERO_RANGE, offset, size, FL_SKIPPED);
>                         goto out;
> +               } else if (keep_size && !keep_size_calls) {
> +                       log4(OP_ZERO_RANGE, offset, size, FL_SKIPPED | FL=
_KEEP_SIZE);
> +                       goto out;
>                 }
>                 break;
>         case OP_COLLAPSE_RANGE:
>=20

With this patch, 469 just succeeds on my environment (virtiofs).
I'm fine with this approach:
  Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Thanks!

> Thanks!
>=20
> Eryu
> >
> > Thanks.
> >
> > >
> > > Thanks,
> > > Eryu
> > >
> > > > ---
> > > >  tests/generic/469 | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/tests/generic/469 b/tests/generic/469 index
> > > > 47fdf0cf..0c6f8ae5 100755
> > > > --- a/tests/generic/469
> > > > +++ b/tests/generic/469
> > > > @@ -40,6 +40,7 @@ rm -f $seqres.full  _supported_fs generic
> > > > _supported_os Linux  _require_test
> > > > +_require_xfs_io_command "falloc" "-k"
> > > >
> > > >  run_fsx()
> > > >  {
> > > > --
> > > > 2.21.0
> > > >
