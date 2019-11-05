Return-Path: <SRS0=5Vws=Y5=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5B8CA9EC7
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 06:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C402020869
	for <linux-fstests@archiver.kernel.org>; Tue,  5 Nov 2019 06:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="WXmkJdUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKEGAt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 5 Nov 2019 01:00:49 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25334 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726773AbfKEGAt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Nov 2019 01:00:49 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1572933623; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=pigp1ZOd/tPwP9ZykhNJaHV1A+JcdHfrE/Z+6BwwwnnRxLIstfaXFC0AplTZ7qI1ULRLpQ3zxQdAiNI8n3MgaEXAeWLSsfa5PcQquR5DgbqUByKMEFPKU86RA6+3SpYtg+MBRukK6KlgYPjCd4HO8MAPvmtXuiRK4ltaI6GhqXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572933623; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=Fi3c+udnOQ0UY1fTsnFuzZL2OnzLbt9L+XThzcI30UE=; 
        b=Sa0Q3sZHLUaLrPW/ONHK9VsG+ZGigRHo7hUrZsBLva4CoSyj34TgOCXxL8/6I3m/YiAxwznLZ/V6BitczE7i6TtUgLXAnGfBwQ4lqT0gZ91YyXrs9gUkCQVGVbhKWbKTL3XjmJHsWmA02D+qAG7VniKgpg3i/d0xTx1GNRdO7Qs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572933623;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=4413; bh=Fi3c+udnOQ0UY1fTsnFuzZL2OnzLbt9L+XThzcI30UE=;
        b=WXmkJdUXIhkS99CA0nEeBGVSrK8rGoeN9MY0UPZCVl/NjDblWt3dL30/VAJddBCa
        3dVw8CF4dtI6clDRN/aClCc3eMF1Vxp7Jtb+s2cPYS1gmjkKi2kRTWSqgLmZYtjK0ns
        cBqc+sMPVutfyjS9ng7brynbLkUYDbDrpZCSsK88=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1572933621338285.024913380366; Tue, 5 Nov 2019 14:00:21 +0800 (CST)
Date:   Tue, 05 Nov 2019 14:00:21 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "fstests" <fstests@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "Eryu Guan" <guaneryu@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Message-ID: <16e3a265656.134a9f8341853.6895214917865048335@mykernel.net>
In-Reply-To: <CAOQ4uxjqMTFc-Fmpg3oGChy01X2JzQoG_jqxk5iEz+bR4yoQjg@mail.gmail.com>
References: <20191029055713.28191-1-cgxu519@mykernel.net> <CAOQ4uxgzZHXOv7K++BArYmaTEHbYr5oCkgXw8WVUsQgh0uyqhg@mail.gmail.com>
 <16e173c434a.11f8ced8d40796.3954073574203284331@mykernel.net>
 <CAOQ4uxjddbot29=cYqLMLyqT=w=pWmLOPqVzvi-5mcXQ3AB3EQ@mail.gmail.com>
 <CAOQ4uxiZgmA6Z8Lq=ac7O9f1+CMnSmyLoAA7TDu6Hyt=-pUctw@mail.gmail.com> <16e1afc4097.118c98c8b43000.1263688409904269456@mykernel.net> <CAOQ4uxjqMTFc-Fmpg3oGChy01X2JzQoG_jqxk5iEz+bR4yoQjg@mail.gmail.com>
Subject: Re: [PATCH] overlay/066: adjust test file size && add more test
 patterns
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-10-30 13:33:59 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Wed, Oct 30, 2019 at 6:46 AM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-29 20:32:43 Amir =
Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > On Tue, Oct 29, 2019 at 1:58 PM Amir Goldstein <amir73il@gmail.com>=
 wrote:
 > >  > >
 > >  > > On Tue, Oct 29, 2019 at 1:17 PM Chengguang Xu <cgxu519@mykernel.n=
et> wrote:
 > >  > > >
 > >  > > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-29 16:32:3=
2 Amir Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > >  > > >  > On Tue, Oct 29, 2019 at 7:57 AM Chengguang Xu <cgxu519@myker=
nel.net> wrote:
 > >  > > >  > >
 > >  > > >  >
 > >  > > >  > Can you please send the patch as plain/text.
 > >  > > >  > Your mailer has sent it with quoted printable encoding and g=
it am
 > >  > > >  > fails to apply the patch:
 > >  > > >  > https://lore.kernel.org/fstests/20191029055713.28191-1-cgxu5=
19@mykernel.net/raw
 > >  > > >  >
 > >  > > >
 > >  > > > Sorry for that,  I'm not clear for the reason, so I send you th=
e patch in attachment first.
 > >  > > >
 > >  > >
 > >  >
 > >  > OK, I can verify that test runs quick (5s) on my VM.
 > >  >
 > >  > But there is one more issue that I think needs to be addressed, eit=
her
 > >  > in this fix patch or in a follow up patch.
 > >  >
 > >  > If the test ever fails on some run with a specific random holes seq=
uence,
 > >  > it is going to be quite hard for reporter to report this sequence o=
r for
 > >  > developers to reproduce the same random sequence.
 > >
 > > IMO, it's not so hard as you thought,  I prefer to use filefrag to che=
ck it.
 > >
 > > I think below tidy info is very clear and easy to understand what had =
happened.
 > >
 > > [root@hades ovl-lower]# filefrag -k -e copyup_sparse_test_random_small=
_holefile
 > > Filesystem type is: 58465342
 > > File size of copyup_sparse_test_random_small_holefile is 10485760 (102=
40 blocks of 1024 bytes)
 > >  ext:     logical_offset:        physical_offset: length:   expected: =
flags:
 > >    0:        4..     411:    2625148..   2625555:    408:          4:
 > >    1:      816..    1259:    2626172..   2626615:    444:    2625960:
 > >    2:     1696..    1783:    2627196..   2627283:     88:    2627052:
 > >    3:     1872..    2207:    2627372..   2627707:    336:
 > >    4:     2544..    3019:    2629244..   2629719:    476:    2628044:
 > >    5:     3496..    3599:    2629720..   2629823:    104:
 > >    6:     3704..    3819:    2629928..   2630043:    116:
 > >    7:     3936..    3959:    2630044..   2630067:     24:
 > >    8:     3980..    4487:    2631292..   2631799:    508:    2630088:
 > >    9:     4992..    5235:    2631800..   2632043:    244:
 > >   10:     5472..    5715:    2632044..   2632287:    244:
 > >   11:     5956..    6355:    2633340..   2633739:    400:    2632528:
 > >   12:     6752..    6787:    2633740..   2633775:     36:
 > >   13:     6820..    6907:    2633808..   2633895:     88:
 > >   14:     6996..    7447:    2633896..   2634347:    452:
 > >   15:     7900..    8211:    2637436..   2637747:    312:    2634800:
 > >   16:     8516..    8867:    2638052..   2638403:    352:
 > >   17:     9216..    9703:    2638752..   2639239:    488:             =
last
 > > copyup_sparse_test_random_small_holefile: 7 extents found
 > >
 >=20
 > There is a difference between understanding what happened and
 > reproducing, but there is no reason to choose one method over
 > the other.
 >=20
 > As a developer, when I get a bug report I would rather have both
 > an easy reproducer and all the postmortem  information available.
 > Therefore, please echo xfs_io commands, at least for creation of
 > random files to full log AND filefrag info, at least for the random
 > files to full log.
 >=20
=20
Actually, xfs_io itself will leave detail information for write operation (=
pos+write size)
See below, IMO, it is almost no difference compare to echo xfs_io command.
So I just added title for those write scenarios in v2.

---
iosize=3D2048K hole test write scenarios --- (This is what I added in v2)

wrote 2097152/2097152 bytes at offset 2097152
2 MiB, 512 ops; 0.0007 sec (2.732 GiB/sec and 716083.9161 ops/sec)
wrote 2097152/2097152 bytes at offset 6291456
2 MiB, 512 ops; 0.0006 sec (2.889 GiB/sec and 757396.4497 ops/sec)
wrote 2097152/2097152 bytes at offset 10485760
2 MiB, 512 ops; 0.0007 sec (2.728 GiB/sec and 715083.7989 ops/sec)
wrote 2097152/2097152 bytes at offset 14680064
2 MiB, 512 ops; 0.0007 sec (2.778 GiB/sec and 728307.2546 ops/sec)

Thanks,
Chengguang



