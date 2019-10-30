Return-Path: <SRS0=KRl+=YX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030DFCA9EAF
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Oct 2019 04:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F205F2087F
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Oct 2019 04:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="Rt0SywHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3Eqh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Oct 2019 00:46:37 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25871 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbfJ3Eqh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Oct 2019 00:46:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572410771; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=LqL9Eswftg1GQ9BVfBHszsM6wsQLoVtT+kRViZJhWm+x16hhJs9B9D1dOo9xViX1BX/DsVmHSwgss7+rZNcmOV4LVyC7wLQ/dAoRgng09qJoZLsbz1Ro3QEuR2yQh3BuuK5DHnrf4TH0ZvSOq2dQVX9RiSg0H3RHHXkDg683C1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1572410771; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=AN8lDqOiB+kNOu3crr9CIze0LZY1E0cqX86zUVwF1h0=; 
        b=BoXE372lBldbxOrmozaW9+208DdS9OO8RVXn6ykh/stYjtsD3sY8leythIe2zWOk7m4q6r4gIfGA2ZSjcI9zNRbUJrnYhnaNAJs8hDf5j2vKCCFsC1QoXHWmiYb7Bi1BRvrAUoav0PEg4VRLBZy6sJZx6mRbspHjiKMIHwpY5TU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1572410771;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=3143; bh=AN8lDqOiB+kNOu3crr9CIze0LZY1E0cqX86zUVwF1h0=;
        b=Rt0SywHGcqIbtmiikR+ZDiOtW0SjSbQQs3NZBxPaIOWlRGXRi27lMbcsrkIkOE38
        uKk/MBoZm7fELOJB0NoW1LzUA+K0m+QkjxH52ErB43BBP4NK8avrIp35FUOVKGW/Tn7
        1jSTuNjomGF4ciTf3larJev40sOYI8l9VHcZy/Ms=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1572410769563783.251668097101; Wed, 30 Oct 2019 12:46:09 +0800 (CST)
Date:   Wed, 30 Oct 2019 12:46:09 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "fstests" <fstests@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "Eryu Guan" <guaneryu@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Message-ID: <16e1afc4097.118c98c8b43000.1263688409904269456@mykernel.net>
In-Reply-To: <CAOQ4uxiZgmA6Z8Lq=ac7O9f1+CMnSmyLoAA7TDu6Hyt=-pUctw@mail.gmail.com>
References: <20191029055713.28191-1-cgxu519@mykernel.net> <CAOQ4uxgzZHXOv7K++BArYmaTEHbYr5oCkgXw8WVUsQgh0uyqhg@mail.gmail.com>
 <16e173c434a.11f8ced8d40796.3954073574203284331@mykernel.net> <CAOQ4uxjddbot29=cYqLMLyqT=w=pWmLOPqVzvi-5mcXQ3AB3EQ@mail.gmail.com> <CAOQ4uxiZgmA6Z8Lq=ac7O9f1+CMnSmyLoAA7TDu6Hyt=-pUctw@mail.gmail.com>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-29 20:32:43 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Tue, Oct 29, 2019 at 1:58 PM Amir Goldstein <amir73il@gmail.com> wrot=
e:
 > >
 > > On Tue, Oct 29, 2019 at 1:17 PM Chengguang Xu <cgxu519@mykernel.net> w=
rote:
 > > >
 > > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-29 16:32:32 Ami=
r Goldstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > > >  > On Tue, Oct 29, 2019 at 7:57 AM Chengguang Xu <cgxu519@mykernel.n=
et> wrote:
 > > >  > >
 > > >  >
 > > >  > Can you please send the patch as plain/text.
 > > >  > Your mailer has sent it with quoted printable encoding and git am
 > > >  > fails to apply the patch:
 > > >  > https://lore.kernel.org/fstests/20191029055713.28191-1-cgxu519@my=
kernel.net/raw
 > > >  >
 > > >
 > > > Sorry for that,  I'm not clear for the reason, so I send you the pat=
ch in attachment first.
 > > >
 > >
 >=20
 > OK, I can verify that test runs quick (5s) on my VM.
 >=20
 > But there is one more issue that I think needs to be addressed, either
 > in this fix patch or in a follow up patch.
 >=20
 > If the test ever fails on some run with a specific random holes sequence=
,
 > it is going to be quite hard for reporter to report this sequence or for
 > developers to reproduce the same random sequence.

IMO, it's not so hard as you thought,  I prefer to use filefrag to check it=
.

I think below tidy info is very clear and easy to understand what had happe=
ned.

[root@hades ovl-lower]# filefrag -k -e copyup_sparse_test_random_small_hole=
file
Filesystem type is: 58465342
File size of copyup_sparse_test_random_small_holefile is 10485760 (10240 bl=
ocks of 1024 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags=
:
   0:        4..     411:    2625148..   2625555:    408:          4:
   1:      816..    1259:    2626172..   2626615:    444:    2625960:
   2:     1696..    1783:    2627196..   2627283:     88:    2627052:
   3:     1872..    2207:    2627372..   2627707:    336:           =20
   4:     2544..    3019:    2629244..   2629719:    476:    2628044:
   5:     3496..    3599:    2629720..   2629823:    104:           =20
   6:     3704..    3819:    2629928..   2630043:    116:           =20
   7:     3936..    3959:    2630044..   2630067:     24:           =20
   8:     3980..    4487:    2631292..   2631799:    508:    2630088:
   9:     4992..    5235:    2631800..   2632043:    244:           =20
  10:     5472..    5715:    2632044..   2632287:    244:           =20
  11:     5956..    6355:    2633340..   2633739:    400:    2632528:
  12:     6752..    6787:    2633740..   2633775:     36:           =20
  13:     6820..    6907:    2633808..   2633895:     88:           =20
  14:     6996..    7447:    2633896..   2634347:    452:           =20
  15:     7900..    8211:    2637436..   2637747:    312:    2634800:
  16:     8516..    8867:    2638052..   2638403:    352:           =20
  17:     9216..    9703:    2638752..   2639239:    488:             last
copyup_sparse_test_random_small_holefile: 7 extents found

Thanks,
Chengguang


 >=20
 > One way to fix this is to output the sequence of commands that
 > generated the random files to full output, so it can be used as a recipe
 > for reproducer in case of a failure.
 >=20
 > If you do that, please make sure that the recipe for creating
 > small random file is clearly separated from recipe for creating
 > big random file.
 >=20
 > Thanks,
 > Amir.
 >

