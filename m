Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB81C07E96
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 12:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD226146E
	for <linux-fstests@archiver.kernel.org>; Thu,  8 Jul 2021 12:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhGHMEp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 8 Jul 2021 08:04:45 -0400
Received: from mx-relay94-hz2.antispameurope.com ([94.100.136.194]:50069 "EHLO
        mx-relay94-hz2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231347AbhGHMEp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Jul 2021 08:04:45 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 08:04:44 EDT
Received: from smtp-out.all-for-one.com ([91.229.168.76]) by mx-relay94-hz2.antispameurope.com;
 Thu, 08 Jul 2021 13:56:33 +0200
Received: from bruexc105.brumgt.local (10.251.3.41) by bruexc106.brumgt.local
 (10.251.3.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2176.14; Thu, 8 Jul
 2021 13:55:50 +0200
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (10.251.3.124) by
 bruexc105.brumgt.local (10.251.3.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2176.14 via Frontend Transport; Thu, 8 Jul 2021 13:55:50 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUSMXgMuMT9Oq7eEOprpcd55Tg5e2djtLi6wNUVPhteZCGVzXsBJd3wopl06UmehxTKqmkrNXCUCUjVlDp4iLuCxeG3U3DooHi1/Zc1FIbNtkQ+pi9TECiV/sjcnq9ABBQ8S++5I9PcmBf4U8XEiR1wXQELIo/S4dJHJ0R1hsSFaXlVmpNHV5HKmUympo8HH4doKuq3/qO7wuODaV1GYZ82bGBDf+KFImCXE/5mSXCzoWVRXY8IgWX/9IRFuhZ1lw3NjI40IvKgIRoxAB3qvK9xPcLKX4mM7SNAmHLn7S4774lF9AUnomN/ZcFWdld0dPozM6q58Yb5s9FMw/gv2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWIaZ+eeJE+2+pFsnekrlIMSlx4EKdU6WpG7NSf3mcA=;
 b=mb9c5O+PKM9cH2jhPSGoj2T+E0Xy7luxp4AEpEACaF1XGuRXXcpa6y52uB3vQ6uGrVnIrbNup1j9R8gyS9OVz0J0hrGVvwEHeie0S8s4bgAAFWtdHdXZfBiKwtrneX5WITiwuT3mwhSkwYWAo6iVXsb/YI9/oUQFt7HUOud6Km1hEJZ1AKDtsOWlmleS0w00s6m1tn6EWM8DkZs4t1PvHz/AMUSZ078cvU9xGIv/UX7/LOTx50nh4z3qA++XRPF7QganylqBR90gBB1dJdoJA8ToxsbgejVUHm5op9mbGT/au7JRdLgfGCHD+Dj9ltOZODo6fLtOmXYExyZ+INXBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bruker.com; dmarc=pass action=none header.from=bruker.com;
 dkim=pass header.d=bruker.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Bruker.onmicrosoft.com; s=selector2-Bruker-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWIaZ+eeJE+2+pFsnekrlIMSlx4EKdU6WpG7NSf3mcA=;
 b=YQL1RHxIjKBQAuHdmS2juN4vXkrNtkwXBrU/pkGvibORyJzD534GrS+weJp5AbqvX1r4cWHVyHDzU+KYQVhWvQ5LbxncdOsA4aEZ9yGnEvy8u+BCpQK04JtYyi5amXLonMLsqiA1W9HMyEKLAS7kwDtg4Ut8iP+ElmkUM9AImGw=
Received: from AM8PR10MB4161.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::11)
 by AM8PR10MB4051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Thu, 8 Jul
 2021 11:55:50 +0000
Received: from AM8PR10MB4161.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40cc:6209:75b9:3264]) by AM8PR10MB4161.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::40cc:6209:75b9:3264%7]) with mapi id 15.20.4308.021; Thu, 8 Jul 2021
 11:55:50 +0000
From:   "Yurkov, Vyacheslav" <Vyacheslav.Yurkov@bruker.com>
To:     Eryu Guan <guaneryu@gmail.com>,
        Vyacheslav Yurkov <uvv.mail@gmail.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: RE: [PATCH] Revert "build: Use the original install-sh file from SGI"
Thread-Topic: [PATCH] Revert "build: Use the original install-sh file from
 SGI"
Thread-Index: AQHXbLkWiMyVdRWQJEi7JRaePXto5qsymLgAgAS+AVA=
Date:   Thu, 8 Jul 2021 11:55:49 +0000
Message-ID: <AM8PR10MB41617ACC5BE653FD62869B7086199@AM8PR10MB4161.EURPRD10.PROD.OUTLOOK.COM>
References: <20210629073247.230001-1-uvv.mail@gmail.com>
 <YOGC0h/iHUrzh01B@desktop>
In-Reply-To: <YOGC0h/iHUrzh01B@desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_Enabled=true;
 MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_SetDate=2021-07-08T11:55:48Z;
 MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_Method=Standard;
 MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_Name=Confidential;
 MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_SiteId=375ce1b8-8db1-479b-a12c-06fa9d2a2eaf;
 MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_ActionId=ba38e674-0cb3-497e-872c-a732f4dc3b02;
 MSIP_Label_e340eb20-1c5f-4409-b1a4-85adc943d5d7_ContentBits=2
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bruker.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 166d87d4-bbae-419b-d231-08d942075487
x-ms-traffictypediagnostic: AM8PR10MB4051:
x-microsoft-antispam-prvs: <AM8PR10MB4051E84100BE22ABF54CFB4C86199@AM8PR10MB4051.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4FL8jcE4f8Qr6BZmZEedg1m3KkWK6ZtjZHgnxU2/5yni1WaokVcvXUKDmTzXJEkws/p7erqPjBJEwI8oXzrva5XNf826de6mOyhrjc0nUPcWkFV2CqxJ0Qgt0kQ0rHnAJ+IaF0MGY3NSWyxFfXqMHfAs/KRc9ZI9Aa/cOEFNa2sbWoCPHfKL84C40Vsj22iV3yQURzQ9LpVLk3vn5QUwEfSCr44e+eL3d2oBAPGhdqdPi5KsE3zyxgsgxrIBl6CbGMmnTM29JS4cx1ZbMQoR8rXKHRCacsNxhqZbw42w8ZQOit0HrVygeifRXukeFuiodoDoYNqHesBNE8/d2Tn7DaFLe6I+dY7MeX1vO0dBVuektD1JUL9x5tPY8JjWV9Q3dII9D0oiSoj9mX99byVPO33eFkn1HfZ+tTcubF+5JXiGyfvGABo+aY5GC4Ln7GGYbuA7ZBy7LvXSCT8nYlrfkK4GbFhs6Q+Tz/9KasdulD7jZ0M7j9imqmM+QTEPZUDYwGjiiZuRIwduPLGsteIZOTeqcD9rH5CJqc/AQ+E98iRh1SAQZoIoBTyXYflr2ZYd2rHc6dmq1zfrgy8c086zKToJJ/bj7a9zk0QiCJH9AsDsb05I+tqjuIV8LQo8HQJa/yxodCXz1o7blDHM92oACQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR10MB4161.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39840400004)(396003)(71200400001)(64756008)(66476007)(66556008)(52536014)(66946007)(76116006)(6506007)(38100700002)(26005)(186003)(7696005)(4326008)(33656002)(66446008)(8676002)(83380400001)(8936002)(122000001)(2906002)(316002)(53546011)(9686003)(110136005)(30864003)(86362001)(5660300002)(478600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E/CZ29N/JgA2pK/6fsGh3JtOk2Z8n840cJckHfibjk7uREgINcnrze+/4Zxo?=
 =?us-ascii?Q?9k32bbtMo3i327JXgiOMqYXUodex0H1mJ/Jrba6uakI82NUn7Opy6UQ0oxO5?=
 =?us-ascii?Q?hZ/2pJeIjvHv9DiPQ2fBPpWhtY6PdxjKbB8Aw6xpL8sLx+XBQO0QRW0eDfVR?=
 =?us-ascii?Q?imf9X/hoYa6AOhkCji08dSEIE7jVDCZ4zEJtrDd7ZXxOK0zAunPbQOf4/xyL?=
 =?us-ascii?Q?URLssMlARKDanot0M+gYc5uXcM4wQ1IcPZUx3QdL4HJioDIMcDFiDw0oDZuy?=
 =?us-ascii?Q?GuY1SlKNsWBkdQrr0WB8xQeJBqT5Q2wwq2wv3ZjHSaDS5KlT3p+tFtFHvsV3?=
 =?us-ascii?Q?t24gwhzjbU/efAoJ1V2rgM23rfHTnyn4+HaryY4ae2Rl7HbuBHICTlwY+RIo?=
 =?us-ascii?Q?NPy9ILA2epGyPJOuAsfzq1F9nOWFQCFvn36KG5h0dy8FvK74xk0KvmSDV/QU?=
 =?us-ascii?Q?SBG7+k+XXkHIjP34hOXIUc8H3Eb6uQoiTtyMes4ppVYMrYpkqxQbab5F7KaK?=
 =?us-ascii?Q?KtFVL3euroAIXVcaqzfjr5IxlJXlUaeyTpN+ckKQT1I0Ulohsiy666pn7CYw?=
 =?us-ascii?Q?CEXgClt2gy+yNnDOlefg30cI4ez7u1J7xru4A456F4+8T48it54Ezl9ewc63?=
 =?us-ascii?Q?9sALV3u9uXaaJGbiO7o+QhKJLZVnYqLQsGkxO4UiqWjR36O+yifL5dfUscSs?=
 =?us-ascii?Q?Q2jqP1H5pvO6vqcCV0MNgyjckBBszK0lwdsvmzqXFwHRJhAvh27QcoFW6b4H?=
 =?us-ascii?Q?tHpxDyGQQ6/oLKdySxKVfsdm2qdRGWneSv2oWfwMMg7o5a6jiAEzhAYXNbSn?=
 =?us-ascii?Q?vOojWZazyvqqumpRF7BkyNJwWCjKxKmj/E/u5WfIwM6+y/Gwi+uU3hbEdMey?=
 =?us-ascii?Q?TVIUCprx7CMAtUw+gofsczZTMesBL0nJfWIfZdI71J6N+iPDMI5sSJpV1wAg?=
 =?us-ascii?Q?fNTgegUAR+l3BMCClqnHvs1BqFZo3knbWyn83ThUhiasLLyxzRhJ1g2S1/sl?=
 =?us-ascii?Q?yyMy03EDEx3eHQmOk4eDHgZHwcVDCEAGiVaM6tvZg53rdkyME3UVfvDoJBos?=
 =?us-ascii?Q?i1wCknt5KvXVlabafOF+lmkrQumReOCHQWaVY6yZx/fHlyc7FISBUAyd3GSc?=
 =?us-ascii?Q?MpScCIxiRMDLql40udWD7HGdjaU+gXHspLdJa3risb0NsHi4jWZAoc7g24We?=
 =?us-ascii?Q?1o6b5GdG1w50HCohxRsDKXlqaiJruvdiESgqnw5LTlfam49HScT0+uPhJRu4?=
 =?us-ascii?Q?z3ThaMe0ZIBFmQG6nqcoHsiGlawNOu7Dgk4KZ4ZODGDYATwRqZl+DD8KHNr5?=
 =?us-ascii?Q?mCB0I6lz+Q5UNeQgVedRLkM4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR10MB4161.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 166d87d4-bbae-419b-d231-08d942075487
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2021 11:55:49.9310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 375ce1b8-8db1-479b-a12c-06fa9d2a2eaf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9A8I05V1vyfCMAtPjz04YNQQfYAqdEG75yCWZk/nF8C2RBJlQt77bj3TAH7aj4mxjqUHXOL7VXbkm4vtxQHVkBHmW4E/GvYjZpT+aPq6Bw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4051
X-OriginatorOrg: bruker.com
X-cloud-security-sender: vyacheslav.yurkov@bruker.com
X-cloud-security-recipient: fstests@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay94-hz2.antispameurope.com with 2B45F1785AA9
X-cloud-security-connect: smtp-out.all-for-one.com[91.229.168.76], TLS=1, IP=91.229.168.76
X-cloud-security-Digest: 9a726048bc766641bde05797082f0cdc
X-cloud-security: scantime:3.731
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There are several errors I was getting actually. The first one is something=
 like this:

> | configure: error: cannot run /bin/bash ./../config.sub

The problem is that yocto/oe build system has distinct stages like fetch/co=
nfigure/compile/install/etc, and this error occurs during the configure sta=
ge when it tries to run automake/autoconf.

When I prepend configure stage with copying of include/install-sh, it passe=
s further, but fails at install stage with the errors like:

Usage: build/tmp/work/corei7-64-oe-linux/xfstests/git-r0/git/x86_64-oe-linu=
x-libtool [OPTION]... [MODE-ARG]...
Try 'x86_64-oe-linux-libtool --help' for more information.
x86_64-oe-linux-libtool:   error: 'build/tmp/work/corei7-64-oe-linux/xfstes=
ts/git-r0/image/usr/xfstests/src' is not a directory
make[1]: *** [Makefile:102: install] Error 1

So I honestly didn't look into what's failing there. Using up-to-date scrip=
ts just fixed the issue for me. I could keep the patch in my yocto BSP then=
 if you don't like it.

Thanks,
Vyacheslav


- confidential -

> -----Original Message-----
> From: Eryu Guan <guaneryu@gmail.com>
> Sent: Sunday, July 4, 2021 11:44
> To: Vyacheslav Yurkov <uvv.mail@gmail.com>
> Cc: fstests@vger.kernel.org; Yurkov, Vyacheslav
> <Vyacheslav.Yurkov@bruker.com>
> Subject: Re: [PATCH] Revert "build: Use the original install-sh file from=
 SGI"
>=20
> **EXTERNAL EMAIL**
>=20
> On Tue, Jun 29, 2021 at 09:32:47AM +0200, Vyacheslav Yurkov wrote:
> > From: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
> >
> > This reverts commit da7916f72206750cce0d0d306d3ba9094a375880.
> >
> > Old install-sh fails in cross-compilation environments like yocto.
>=20
> This install-sh has been used for performance reason, I'd like keep it
> if possible. Would you please describe the failures you hit in
> cross-compilation env? It'd be great if we could fix the env issue.
>=20
> Thanks,
> Eryu
>=20
> >
> > Signed-off-by: Vyacheslav Yurkov <Vyacheslav.Yurkov@bruker.com>
> > ---
> >  Makefile           |   1 -
> >  include/install-sh | 352 ---------------------------------------------
> >  2 files changed, 353 deletions(-)
> >  delete mode 100755 include/install-sh
> >
> > diff --git a/Makefile b/Makefile
> > index 86a2d399..c52daeb8 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -61,7 +61,6 @@ endif
> >
> >  configure: configure.ac
> >       libtoolize -cfi
> > -     cp include/install-sh .
> >       aclocal -I m4
> >       autoheader
> >       autoconf
> > diff --git a/include/install-sh b/include/install-sh
> > deleted file mode 100755
> > index a19cbe31..00000000
> > --- a/include/install-sh
> > +++ /dev/null
> > @@ -1,352 +0,0 @@
> > -#! /bin/bash
> > -#
> > -# SPDX-License-Identifier: GPL-2.0
> > -# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
> > -#
> > -# This script emulates bsd install and also recognises
> > -# two environment variables, with the following semantics :-
> > -#
> > -# $DIST_MANIFEST - if set, the name of the file to append manifest
> > -#                  information in the following format:
> > -#                  File     :  f mode owner group src target
> > -#                  Directory:  d mode owner group target
> > -#                  Symlink  :  l linkval target
> > -#
> > -# $DIST_ROOT     - if set, prepend to target
> > -#
> > -# The sematics of all combinations of these two variables
> > -# are as follows:
> > -#
> > -# $DIST_MANIFEST?  $DIST_ROOT? |   Copy?  Append Manifest?
> > -# -----------------------------+--------------------------
> > -#       not set       not set  |    yes        no
> > -#       not set       set      |    yes        no
> > -#       set           not set  |    no         yes
> > -#       set           set      |    yes        yes
> > -#
> > -_usage() {
> > -    echo "Usage: $prog [-o owner] [-g group] [-m mode] -d directory"
> > -    echo "or     $prog [-D] [-o owner] [-g group] [-m mode] file direc=
tory/file"
> > -    echo "or     $prog [-o owner] [-g group] [-m mode] file [file ...]=
 directory"
> > -    echo "or     $prog -S file target  (creates \"target\" symlink)"
> > -    echo "or     $prog -T lt_arg [-o owner] [-g group] [-m mode] libto=
ol.lai
> directory"
> > -    echo ""
> > -    echo "The \$DIST_MANIFEST and \$DIST_ROOT environment variables
> affect the"
> > -    echo "behaviour of this command - see comments in the script."
> > -    echo "The -D flag is only available for the second usage, and caus=
es"
> > -    echo "the target directory to be created before installing the fil=
e."
> > -    echo ""
> > -    exit 1
> > -}
> > -
> > -_chown ()
> > -{
> > -    _st=3D255
> > -    if [ $# -eq 3 ] ; then
> > -     chown $1:$2 $3
> > -     _st=3D$?
> > -     if [ $_st -ne 0 ] ; then
> > -         if [ $REAL_UID !=3D '0' ] ; then
> > -             if [ ! -f $DIST_ROOT/.chown.quiet ] ; then
> > -                 echo
> '=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
> > -                 echo Ownership of files under ${DIST_ROOT:-/}
> > -                 echo cannot be changed
> > -                 echo
> '=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D'
> > -                 if [ -n "$DIST_ROOT" ] ; then
> > -                     touch $DIST_ROOT/.chown.quiet
> > -                 fi
> > -             fi
> > -            _st=3D0
> > -         fi
> > -     fi
> > -    fi
> > -
> > -    return $_st
> > -}
> > -
> > -
> > -_manifest ()
> > -{
> > -    echo $* | sed -e 's/\/\//\//g' >>${DIST_MANIFEST:-/dev/null}
> > -}
> > -
> > -prog=3D`basename $0`
> > -HERE=3D`pwd`
> > -dflag=3Dfalse
> > -Dflag=3Dfalse
> > -Sflag=3Dfalse
> > -Tflag=3Dfalse
> > -DIRMODE=3D755
> > -FILEMODE=3D644
> > -OWNER=3D`id -u`
> > -GROUP=3D`id -g`
> > -REAL_UID=3D$OWNER
> > -
> > -# default is to install and don't append manifest
> > -INSTALL=3Dtrue
> > -MANIFEST=3D:
> > -
> > -: ${DIST_ROOT:=3D${DESTDIR}}
> > -
> > -[ -n "$DIST_MANIFEST" -a -z "$DIST_ROOT" ] && INSTALL=3Dfalse
> > -[ -n "$DIST_MANIFEST" ] && MANIFEST=3D"_manifest"
> > -
> > -[ $# -eq 0 ] && _usage
> > -
> > -if $INSTALL
> > -then
> > -    CP=3Dcp; LN=3Dln; MKDIR=3Dmkdir; CHMOD=3Dchmod; CHOWN=3D_chown
> > -else
> > -    CP=3Dtrue; LN=3Dtrue; MKDIR=3Dtrue; CHMOD=3Dtrue; CHOWN=3Dtrue
> > -fi
> > -
> > -[ -n "$DIST_ROOT" -a $REAL_UID -ne 0 ] && CHOWN=3Dtrue
> > -
> > -while getopts "Dcm:d:S:o:g:T:" c $*
> > -do
> > -   case $c in
> > -   c)
> > -     ;;
> > -   g)
> > -     GROUP=3D$OPTARG
> > -     ;;
> > -   o)
> > -     OWNER=3D$OPTARG
> > -     ;;
> > -   m)
> > -     DIRMODE=3D`expr $OPTARG`
> > -     FILEMODE=3D$DIRMODE
> > -     ;;
> > -   D)
> > -     Dflag=3Dtrue
> > -     ;;
> > -   S)
> > -     symlink=3D$OPTARG
> > -     Sflag=3Dtrue
> > -     ;;
> > -   d)
> > -     dir=3D$DIST_ROOT/$OPTARG
> > -     dflag=3Dtrue
> > -     ;;
> > -   T)
> > -     lt_install=3D$OPTARG
> > -     Tflag=3Dtrue
> > -     ;;
> > -   *)
> > -     _usage
> > -     ;;
> > -   esac
> > -done
> > -
> > -shift `expr $OPTIND - 1`
> > -
> > -status=3D0
> > -if $dflag
> > -then
> > -    #
> > -    # first usage
> > -    #
> > -    $MKDIR -p $dir
> > -    status=3D$?
> > -    if [ $status -eq 0 ]
> > -    then
> > -     $CHMOD $DIRMODE $dir
> > -     status=3D$?
> > -    fi
> > -    if [ $status -eq 0 ]
> > -    then
> > -     $CHOWN $OWNER $GROUP $dir
> > -     status=3D$?
> > -    fi
> > -    $MANIFEST d $DIRMODE $OWNER $GROUP ${dir#$DIST_ROOT}
> > -elif $Sflag
> > -then
> > -    #
> > -    # fourth usage (symlink)
> > -    #
> > -    if [ $# -ne 1 ]
> > -    then
> > -     _usage
> > -    else
> > -     target=3D$DIST_ROOT/$1
> > -    fi
> > -    $LN -s -f $symlink $target
> > -    status=3D$?
> > -    $MANIFEST l $symlink ${target#$DIST_ROOT}
> > -elif $Tflag
> > -then
> > -    #
> > -    # -T (install libs built by libtool)
> > -    #
> > -    if [ $# -ne 2 ]
> > -    then
> > -     _usage
> > -    else
> > -     libtool_lai=3D$1
> > -     # source the libtool variables
> > -     if [ ! -f $libtool_lai ]
> > -     then
> > -             echo "$prog: Unable to find libtool library file $libtool=
_lai"
> > -             exit 2
> > -     fi
> > -     . ./$libtool_lai
> > -     target=3D$DIST_ROOT/$2
> > -    fi
> > -    case $lt_install in
> > -    so_dot_version)
> > -     # Loop until we find libfoo.so.x.y.z, then break out.
> > -     for solib in $library_names
> > -     do
> > -             # does it have enough parts?  libfoo.so.x.y.z =3D=3D 5
> > -             cnt=3D`echo "$solib" | sed -e 's/\./ /g' | wc -w`
> > -             if [ $cnt -eq 5 ]
> > -             then
> > -                     install_name=3D$target/$solib
> > -                     $CP $solib $install_name
> > -                     status=3D$?
> > -                     $MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$solib
> ${install_name#$DIST_ROOT}
> > -                     break
> > -             fi
> > -     done
> > -     ;;
> > -
> > -    so_*)
> > -     case $lt_install in
> > -     so_dot_current)
> > -             # ln -s libfoo.so.x.y.z to libfoo.so.x
> > -             from_parts=3D5  # libfoo.so.x.y.z
> > -             to_parts=3D3    # libfoo.so.x
> > -             ;;
> > -     so_base)
> > -             # ln -s libfoo.so.x to libfoo.so
> > -             from_parts=3D3  # libfoo.so.x
> > -             to_parts=3D2    # libfoo.so
> > -             ;;
> > -     *)
> > -             echo "$prog: -T $lt_install invalid"
> > -             exit 2
> > -             ;;
> > -     esac
> > -
> > -     # Loop until we find the names, then break out.
> > -     for solib in $library_names
> > -     do
> > -             # does it have enough parts?
> > -             cnt=3D`echo "$solib" | sed -e 's/\./ /g' | wc -w`
> > -             if [ $cnt -eq $from_parts ]
> > -             then
> > -                     from_name=3D$solib
> > -             elif [ $cnt -eq $to_parts ]
> > -             then
> > -                     to_name=3D$solib
> > -             fi
> > -
> > -             if [ -n "$from_name" ] && [ -n "$to_name" ]
> > -             then
> > -                     install_name=3D$target/$to_name
> > -                     $LN -s -f $from_name $install_name
> > -                     status=3D$?
> > -                     $MANIFEST l $from_name ${install_name#$DIST_ROOT}
> > -                     break
> > -             fi
> > -     done
> > -     ;;
> > -    old_lib)
> > -     install_name=3D$target/$old_library
> > -     $CP $old_library $install_name
> > -     status=3D$?
> > -     $MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$old_library
> ${install_name#$DIST_ROOT}
> > -     ;;
> > -    *)
> > -     echo "$prog: -T $lt_install invalid"
> > -     exit 2
> > -     ;;
> > -    esac
> > -
> > -    case $lt_install in
> > -    old_lib|so_dot_version)
> > -     if [ $status -eq 0 ]
> > -     then
> > -             $CHMOD $FILEMODE $install_name
> > -             $CHOWN $OWNER $GROUP $install_name
> > -     fi
> > -     ;;
> > -    esac
> > -
> > -else
> > -    list=3D""
> > -    dir=3D""
> > -    if [ $# -eq 2 ]
> > -    then
> > -     #
> > -     # second usage
> > -     #
> > -     f=3D$1
> > -     dir=3D$DIST_ROOT/$2
> > -     if $Dflag
> > -     then
> > -         mkdir -p `dirname $dir`
> > -     fi
> > -     $CP $f $dir
> > -     status=3D$?
> > -     if [ $status -eq 0 ]
> > -     then
> > -         if [ -f $dir/$f ]
> > -         then
> > -             $CHMOD $FILEMODE $dir/$f
> > -             status=3D$?
> > -             if [ $status -eq 0 ]
> > -             then
> > -                 $CHOWN $OWNER $GROUP $dir/$f
> > -                 status=3D$?
> > -             fi
> > -             $MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$f
> ${dir#$DIST_ROOT}/$f
> > -         else
> > -             $CHMOD $FILEMODE $dir
> > -             status=3D$?
> > -             if [ $status -eq 0 ]
> > -             then
> > -                 $CHOWN $OWNER $GROUP $dir
> > -                 status=3D$?
> > -             fi
> > -             $MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$dir
> ${dir#$DIST_ROOT}
> > -         fi
> > -     fi
> > -    else
> > -     #
> > -     # third usage
> > -     #
> > -     n=3D1
> > -     while [ $# -gt 0 ]
> > -     do
> > -         if [ $# -gt 1 ]
> > -         then
> > -             list=3D"$list $1"
> > -         else
> > -             dir=3D$DIST_ROOT/$1
> > -         fi
> > -         shift
> > -     done
> > -
> > -     # echo DIR=3D$dir list=3D\"$list\"
> > -     for f in $list
> > -     do
> > -         $CP $f $dir
> > -         status=3D$?
> > -         if [ $status -eq 0 ]
> > -         then
> > -             $CHMOD $FILEMODE $dir/$f
> > -             status=3D$?
> > -             if [ $status -eq 0 ]
> > -             then
> > -                 $CHOWN $OWNER $GROUP $dir/$f
> > -                 status=3D$?
> > -             fi
> > -             $MANIFEST f $FILEMODE $OWNER $GROUP $HERE/$f
> ${dir#$DIST_ROOT}/$f
> > -         fi
> > -         [ $status -ne 0 ] && break
> > -     done
> > -    fi
> > -fi
> > -
> > -exit $status
> > --
> > 2.25.1=
