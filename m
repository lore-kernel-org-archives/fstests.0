Return-Path: <SRS0=Q9mn=YL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFAACA9EA1
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 09:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC012064B
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Oct 2019 09:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="VVV1Tguj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633024AbfJRJDm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:03:42 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:12733 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437687AbfJRJDm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Oct 2019 05:03:42 -0400
IronPort-SDR: G0f/FCHdLuTxtiWCfTc+EacVqliBR73mPK7mugBDWir4bs9vBwUI7irbev2IzqdKsRGf+g25Ju
 xs8pqxXKOXyv+X3enHHb9VSAWnNCF28FIlfxKS6MEi7Ck8cY4oOFkwJDIucRyR8rNuxvvGY/tm
 qfZNMZPpIOFyNeTtNxK3q/t6KElP7mfJn+JGZ6lkZTAJEntKwqEbCHjtNuIDPCXmBCzXLE4VfZ
 60QtedYUZbxf3Rgn6JotGvqIESHmpworiy/t5oWuy4LUUHs+BWB812TaDciUgRk5ruzzWaI5rr
 ed4=
X-IronPort-AV: E=McAfee;i="6000,8403,9413"; a="6985137"
X-IronPort-AV: E=Sophos;i="5.67,311,1566831600"; 
   d="scan'208";a="6985137"
Received: from mail-os2jpn01lp2054.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 18 Oct 2019 18:03:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgLrXIl+qe6m9U3ReoSyQJaPEW8vLWK4JtH9cJlrVnJRPD+x4W8mDDCvvKLOlSYUMagd7nkvll9AnFFhzM2PT4Mb9dx5P4gZw2SdnFYwceaDODOK36zUoNOBS5vFF1Ofpv/tU97tqWS7MgQvXeFaul/ZTQb79tjlsf53sCbrCbe4bdlvm8Ui8rpHV3SoXSoUDstxRXU0HzItNYGeUuA19LyNdwVfAz12fVrvSQijAU9Q8eezwfiYOVUa9v2xLANwxCivLfelkIs8sdR0M62Rqyc4D0NFAAGeYg1MU5a9di5GvbUkaQvD01baHsaY8IZk6YJLtKrvZq/Afs79HDzFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27CuyBFBYrfRV28Q8bnt30bg/dOhfWsb4GftE/z4tnQ=;
 b=CG22Oqu3b5YrPXuD7Wur1JA2SwjvpC91m+VojyjypFcsGwU5U2WNqCXG4NuAaH84BWVTq9x+88ZWJ1sBOSIKQq1RoqJ/+q+IEDKBktLNrSVApyHOl/MK6YwopUb/RKHltPSmCsq9Mv0lUORsiReC21S9kKjAoACdTC4FoqKXc90UCkUVu94GXdV0WUMa+Wn39/q+aChB6OJ/T6kspNp/D45KYGzRwZa33enVJfWrTOMZQy2LEjdoZoF7RZECr3ascdqUdpPg/9O9mgoifXVk8geeJLR3q5XlDFYfqjq1cmHeZG+YS3lwa48CVXSBtk7OPR8gw3KZWhmhs0MKz+LyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27CuyBFBYrfRV28Q8bnt30bg/dOhfWsb4GftE/z4tnQ=;
 b=VVV1Tguj6xjvDCW7RyQhYHZ9/jam8Xvb8rSPAoIuKCfensxoMJh1VUxo12jYu1mMnIlikUXczMcQecJ3FQQt7fdY0s8MhOtfCc5VNBSTQUweLTMowbaojidc3qr0+rtcyPdSCybOROFq3CcNmdSf17fpofs6gYg2C5FNMdZEflo=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (20.178.96.203) by
 OSBPR01MB2565.jpnprd01.prod.outlook.com (52.134.252.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 18 Oct 2019 09:03:35 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::4cef:c2a5:21f3:9f3c%5]) with mapi id 15.20.2347.024; Fri, 18 Oct 2019
 09:03:35 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     'Eryu Guan' <guaneryu@gmail.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: RE: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Thread-Topic: [PATCH] generic/469: Skip the test if fallocate keep_size is not
 supported
Thread-Index: AQHVhBCG71vpUjQhc0Csd4LFrwSd2qdgFxqAgAADTZA=
Date:   Fri, 18 Oct 2019 09:02:12 +0000
Deferred-Delivery: Fri, 18 Oct 2019 09:03:11 +0000
Message-ID: <OSBPR01MB3783B9C166C06784BF5C7385E56C0@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20191016105347.16650-1-misono.tomohiro@jp.fujitsu.com>
 <20191018083951.GJ2622@desktop>
In-Reply-To: <20191018083951.GJ2622@desktop>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: e08f9ffc869e4be69d55dea9351f85f8
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [114.160.30.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f081a156-6243-4ade-32d3-08d753aa0f06
x-ms-traffictypediagnostic: OSBPR01MB2565:
x-microsoft-antispam-prvs: <OSBPR01MB2565DD10362922EEF9E6BE35E56C0@OSBPR01MB2565.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(1411001)(85182001)(305945005)(25786009)(229853002)(7736002)(6116002)(6246003)(4326008)(3846002)(6916009)(52536014)(86362001)(8936002)(81166006)(81156014)(74316002)(66556008)(14444005)(76116006)(478600001)(64756008)(256004)(14454004)(66476007)(66446008)(66946007)(446003)(476003)(9686003)(11346002)(66066001)(71200400001)(5660300002)(7696005)(55016002)(486006)(33656002)(8676002)(71190400001)(102836004)(186003)(6666004)(6506007)(6436002)(99286004)(26005)(316002)(76176011)(2906002)(41533002)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:OSBPR01MB2565;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTVH5ddx2VYhZWAR4+GyFkhKhr/ckbFYoxO5AM/u8nV7xJ5vFfGhyOJCMPNE+JS+c9YIj4EbxsIglOZXoegW4jFkfqpBq7YG75+ocBBdCKS0DrkXer7ciFb+g9jYebVX9r5VuQOfrJoeJnzJo+syVPZkc7h2Chd7ebXN3y1hKC7nEl1Tg7k3S7A8kjujkortFyBd+EZpMHaHDMzdKwEbtTfWfDBcMcM0WRZCKhMqv4sZ/xgppkyuWPWvjvMTn2oRmW+jBbmvBmh77E3hjvFlk8/hD4z+tolqe/AYp/M/JzHDjYXiiK4VdCETgGbTRLdCvk0zuL1d4DJEr6rb5sSOOpbB0G0+IDbgBaWo0eVIghioZRGQ0PJRPbn8ZYcrENuG2jLFrU1T1esscE/Cy+mFq9/tuj1XzLSz/94fbdLizo8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f081a156-6243-4ade-32d3-08d753aa0f06
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 09:03:35.6955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWmVTU0/EYY7EDMddGI8U5Zk/a30mcgpIlcNOw2NDMMhE5wDy6/eQouvD58nu2JRhtelDM1jPy933OyoKAJc7Q1zHgMk6a8vdGhGFBlDe3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2565
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> On Wed, Oct 16, 2019 at 07:53:47PM +0900, Misono Tomohiro wrote:
> > This test requires fallocate keep_size. So, skip the test if a target
> > FS does not support the function to avoid false negative.
> >
> > Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
>=20
> Would you please paste the false failure you've seen? I can't recall I hi=
t such failures, and I think fsx would just disable unsupported
> operations and don't cause failure, it just prints a message to stderr, a=
nd we already redirect stderr to $seqres.full in run_fsx
> in 469.

Hi, I just got output mismatch error:

$ cat results/generic/469.out.bad
QA output created by 469
fsx --replay-ops fsxops.0
Seed set to 1
main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disab=
ling!
main: filesystem does not support fallocate mode FALLOC_FL_PUNCH_HOLE | FAL=
LOC_FL_KEEP_SIZE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, disa=
bling!
main: filesystem does not support fallocate mode FALLOC_FL_COLLAPSE_RANGE, =
disabling!
main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, di=
sabling!
main: filesystem does not support clone range, disabling!
main: filesystem does not support dedupe range, disabling!
fallocate: 0x0 to 0x1000
do_preallocate: fallocate: Operation not supported
LOG DUMP (1 total operations):
1(  1 mod 256): FALLOC   0x0 thru 0x1000        (0x1000 bytes) PAST_EOF
Log of operations saved to "/test1/469.fsx.fsxops"; replay with --replay-op=
s
Correct content saved for comparison
(maybe hexdump "/test1/469.fsx" vs "/test1/469.fsx.fsxgood")

Thanks.

>=20
> Thanks,
> Eryu
>=20
> > ---
> >  tests/generic/469 | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/generic/469 b/tests/generic/469 index
> > 47fdf0cf..0c6f8ae5 100755
> > --- a/tests/generic/469
> > +++ b/tests/generic/469
> > @@ -40,6 +40,7 @@ rm -f $seqres.full
> >  _supported_fs generic
> >  _supported_os Linux
> >  _require_test
> > +_require_xfs_io_command "falloc" "-k"
> >
> >  run_fsx()
> >  {
> > --
> > 2.21.0
> >
