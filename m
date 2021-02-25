Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2241C433E0
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Feb 2021 02:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5263C64ECB
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Feb 2021 02:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhBYCS2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Feb 2021 21:18:28 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25315 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236862AbhBYCRj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 Feb 2021 21:17:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1614219402; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=MnOSEToFvGk1rXFbzIlsV0pSwWGW7Q8QPW9bGSNnF+fxO+18bKkU0Ej3lUELlVMn14obuFbUElmnZl2mP0nCisJLgNW5dJIPJkvu5EINMH6f1DVzdxFBRY+UpUAKonhpq+DT5ZT+EOD80oDybuX6rq7iLF9YnRS6DUD/cCcJVDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1614219402; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=yKwQstXUqilwGPKhKAXp2ll9MrFGRBeRWYx9RMTeubQ=; 
        b=jIW+7+z5pPSBT+4vLizIHx/icdx4TjsE2jg9GCrtFK9S/6r92tPrOHcrkeNREw+ceQJzeXnVMTZqhBlYw4f7bEoKMstVPjkmDjZC5Vebnm2l9+Bg0s6LecmksppxrKmM45plzvIhbZ9Zji1TyRiDqCZiwQOSKymkCra/oQ7E7uM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1614219402;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=yKwQstXUqilwGPKhKAXp2ll9MrFGRBeRWYx9RMTeubQ=;
        b=R0a6qCLIT06j8in7mQZCb9kv0iUOJb0QETYYFbopPfd0Woir8gij4TLKzToHK2kH
        5SpSBc8LjUrDO9/1kyPCzYCyv7ms4Rqp0UIZ/uEdQechqpO6iRsCtQjpNUs0eF6NNZy
        dT8wj6HIFYZV550/wrnY3kWukZGobD6BVs68eASc=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1614219399730555.7694458889325; Thu, 25 Feb 2021 10:16:39 +0800 (CST)
Date:   Thu, 25 Feb 2021 10:16:39 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "guaneryu" <guaneryu@gmail.com>,
        "fstests" <fstests@vger.kernel.org>
Message-ID: <177d6f95225.10d58c6c517633.3841129799694058715@mykernel.net>
In-Reply-To: <20210224165057.GB7269@magnolia>
References: <20210223134042.2212341-1-cgxu519@mykernel.net> <20210224165057.GB7269@magnolia>
Subject: Re: [PATCH] generic/473: fix expectation properly in out file
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E5=9B=9B, 2021-02-25 00:50:57 Darrick J.=
 Wong <djwong@kernel.org> =E6=92=B0=E5=86=99 ----
 > On Tue, Feb 23, 2021 at 09:40:42PM +0800, Chengguang Xu wrote:
 > > It seems the expected result of testcase of "Hole + Data"
 > > in generic/473 is not correct, so just fix it properly.
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > ---
 > >  tests/generic/473.out | 2 +-
 > >  1 file changed, 1 insertion(+), 1 deletion(-)
 > >=20
 > > diff --git a/tests/generic/473.out b/tests/generic/473.out
 > > index 75816388..f1ee5805 100644
 > > --- a/tests/generic/473.out
 > > +++ b/tests/generic/473.out
 > > @@ -6,7 +6,7 @@ Data + Hole
 > >  1: [256..287]: hole
 > >  Hole + Data
 > >  0: [0..127]: hole
 > > -1: [128..255]: data
 > > +1: [128..135]: data
 >=20
 > This again.  While the FIEMAP documentation allows the call to return
 > file mapping data outside the requested range, it doesn't require it,
 > and neither XFS nor ext4 have ever done so.

I did more tests on ext4 and found in old 4.14 kernel ext4 returned whole e=
xtent range.


 >=20
 > This test *enforces* that the FIEMAP implementation provide data outside
 > the requested range, which means it has never passed on xfs/ext4.  This
 > is no surprise, since it's enforcing one behavior where the spec allows
 > for two behaviors.  The only fs I know of where it passes is btrfs.

plus f2fs.

Thanks,
Chengguang

 >=20
 > Delete this test or move it to tests/btrfs/, because it should not have
 > been added in the first place.
 >=20
 > --D
 >=20
 > >  Hole + Data + Hole
 > >  0: [0..127]: hole
 > >  1: [128..255]: data
 > > --=20
 > > 2.27.0
 > >=20
 > >=20
 >=20
