Return-Path: <SRS0=nbej=YQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAFCCA9EA0
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 02:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F6E2053B
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Oct 2019 02:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="UniVkE+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfJWCgI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Oct 2019 22:36:08 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25725 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388969AbfJWCgI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Oct 2019 22:36:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571798146; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=SRDUfn1F5ISOg9WQ090kCGSc7qjRonw7/18d9kQcrtKrjJuA3+P9wH26T4JtTHe7rP3f2zKVA8IlSAHUDgXwtaIa0ZrWHTrVrkBX+I4umc2jinEZ0WHe3r+tnyMZW22SV8lzT8fDwK8ugAD+A+eKAO+nqAzMmQVo41FA+vA93pc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571798146; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=i9Gm5YNnthNWQFsTAvgpartk6iJmywHmbyaQYAzVrWM=; 
        b=g+8FvJ1qK3e5g8P8dmdybMpF1Xwiq6s9kr4eNSUZEiDSVrvCEz681etU9eALTCH5y4NTb2zVw4ME0JazbIn3JzOeGjIIGkT4yYLG10oBy+cpYk2v4d2eCqcusDFdA4uyJi3Df5gNS4QNqudaqaDEsnaZTzyTU8SS2W2TjctWVvI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571798146;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=6815; bh=i9Gm5YNnthNWQFsTAvgpartk6iJmywHmbyaQYAzVrWM=;
        b=UniVkE+WteLeLQa2oPVf07zkkSB258VWsYe9AGiQJUfeTaUi+MvHoPenWL+64maU
        fVL/lUtVjP8Arg2l9feJrcb4eFskPqVrw1zrguE6hBNyFy6ymZsuxTBYx4qNZir9qIk
        TqcUwjZYNTy4JxaGyBPLcIjYZdEpc7YXVbdGTU18=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1571798143907963.5163989350823; Wed, 23 Oct 2019 10:35:43 +0800 (CST)
Date:   Wed, 23 Oct 2019 10:35:43 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Amir Goldstein" <amir73il@gmail.com>
Cc:     "fstests" <fstests@vger.kernel.org>,
        "overlayfs" <linux-unionfs@vger.kernel.org>,
        "Eryu Guan" <guaneryu@gmail.com>,
        "Miklos Szeredi" <miklos@szeredi.hu>
Message-ID: <16df67853a0.cbb0025c28387.6494870826455764764@mykernel.net>
In-Reply-To: <CAOQ4uxiXwJp4dh_yENsxskbSvuGew2ZqRFyKccdFUMLGWUaz3Q@mail.gmail.com>
References: <20191022122621.27374-1-cgxu519@mykernel.net> <CAOQ4uxiXwJp4dh_yENsxskbSvuGew2ZqRFyKccdFUMLGWUaz3Q@mail.gmail.com>
Subject: Re: [PATCH] overlay/066: copy-up test for variant sparse files
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-22 21:31:32 Amir Golds=
tein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
 > On Tue, Oct 22, 2019 at 3:26 PM Chengguang Xu <cgxu519@mykernel.net> wro=
te:
 > >
 > > This is intensive copy-up test for sparse files,
 > > these cases are mainly used for regression test
 > > of copy-up improvement for sparse files.
 > >
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > > ---
 > >  tests/overlay/066     | 108 +++++++++++++++++++++++++++++++++++++++++=
+
 > >  tests/overlay/066.out |   2 +
 > >  tests/overlay/group   |   1 +
 > >  3 files changed, 111 insertions(+)
 > >  create mode 100755 tests/overlay/066
 > >  create mode 100644 tests/overlay/066.out
 > >
 > > diff --git a/tests/overlay/066 b/tests/overlay/066
 > > new file mode 100755
 > > index 00000000..0394b14e
 > > --- /dev/null
 > > +++ b/tests/overlay/066
 > > @@ -0,0 +1,108 @@
 > > +#! /bin/bash
 > > +# SPDX-License-Identifier: GPL-2.0
 > > +# Copyright (c) 2019 Chengguang Xu <cgxu519@mykernel.net>. All Rights=
 Reserved.
 > > +#
 > > +# FS QA Test 066
 > > +#
 > > +# Test overlayfs copy-up function for variant sparse files.
 > > +#
 > > +seq=3D`basename $0`
 > > +seqres=3D$RESULT_DIR/$seq
 > > +echo "QA output created by $seq"
 > > +
 > > +here=3D`pwd`
 > > +tmp=3D/tmp/$
 > > +status=3D1       # failure is the default!
 > > +trap "_cleanup; exit \$status" 0 1 2 3 15
 > > +
 > > +_cleanup()
 > > +{
 > > +       cd /
 > > +       rm -f $tmp.*
 > > +}
 > > +
 > > +# get standard environment, filters and checks
 > > +. ./common/rc
 > > +. ./common/filter
 > > +
 > > +# remove previous $seqres.full before test
 > > +rm -f $seqres.full
 > > +
 > > +# real QA test starts here
 > > +
 > > +# Modify as appropriate.
 > > +_supported_fs generic
 > > +_supported_os Linux
 > > +_require_test
 > > +_require_scratch
 > > +
 > > +# Remove all files from previous tests
 > > +_scratch_mkfs
 > > +_require_fs_space $OVL_BASE_SCRATCH_MNT $((10*1024*13 + 100*1024))
 >=20
 > Please add a comment about how the above is calculated.
 > Should it depend on fs reported iosize or blocksize?

The calculation based on file size * file num, in other word,
we have 13 10M files and one 100M file. I'll add explanation
for it.

 >=20
 > > +
 > > +lowerdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
 > > +upperdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
 > > +testfile=3D"copyup_sparse_test"
 > > +mkdir -p $lowerdir
 > > +
 > > +# Create a completely empty hole file.
 > > +$XFS_IO_PROG -fc "truncate 10M" "${lowerdir}/${testfile}_empty_holefi=
le" >>$seqres.full
 > > +
 > > +iosize=3D`stat -c %o "${lowerdir}/${testfile}_empty_holefile"`
 >=20
 > I am not sure why fs reported iosize is interesting for this test case.
 > If anything you need _get_file_block_size

If hole size is smaller than fs block size, then the block will still be al=
located,
let me check _get_file_block_size.


 >=20
 > > +if [ $iosize -le 1024 ]; then
 > > +       ioszie=3D1
 >=20
 > typo: ioszie

I'll fix in v2.

 >=20
 > > +else
 > > +       iosize=3D`expr $iosize / 1024`
 > > +fi
 > > +
 > > +# Create test files with different hole size patterns.
 > > +while [ $iosize -le 2048 ]; do
 > > +       pos=3D$iosize
 > > +       $XFS_IO_PROG -fc "truncate 10M" "${lowerdir}/${testfile}_iosiz=
e${iosize}K_holefile" >>$seqres.full
 > > +       while [ $pos -lt 8192 ]; do
 > > +               $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" "${lowerd=
ir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
 > > +               pos=3D`expr $pos + $iosize + $iosize`
 > > +       done
 > > +       iosize=3D`expr $iosize + $iosize`
 > > +done
 > > +
 > > +# Create test file with many random holes(1M~2M).
 > > +$XFS_IO_PROG -fc "truncate 100M" "${lowerdir}/${testfile}_random_hole=
file" >>$seqres.full
 > > +pos=3D2048
 > > +while [ $pos -le 81920 ]; do
 > > +       iosize=3D`expr $RANDOM % 2048`
 > > +       if [ $iosize -lt 1024 ]; then
 > > +               iosize=3D`expr $iosize + 1024`
 > > +       fi
 >=20
 > IOW: iosize=3D`expr $RANDOM % 1024 + 1024`

Yeah, good suggestion but maybe 1M~2M hole size is not sufficient,
I plan to extend to 5M(max) in next version.

 >=20
 > > +       $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" "${lowerdir}/${te=
stfile}_random_holefile" >>$seqres.full
 > > +       pos=3D`expr $pos + $iosize + $iosize`
 > > +done
 > > +
 > > +_scratch_mount
 > > +
 > > +# Open the files should succeed, no errors are expected.
 > > +for f in $SCRATCH_MNT/*; do
 > > +       $XFS_IO_PROG -c "open" $f >>$seqres.full
 > > +done
 > > +
 > > +echo "Silence is golden"
 > > +
 > > +# Check all copy-up files in upper layer.
 > > +iosize=3D`stat -c %o "${lowerdir}/${testfile}_empty_holefile"`
 > > +if [ $iosize -le 1024 ]; then
 > > +       ioszie=3D1
 >=20
 > typo: ioszie

I'll fix in v2.

 >=20
 > > +else
 > > +       iosize=3D`expr $iosize / 1024`
 > > +fi
 > > +
 > > +while [ $iosize -le 2048 ]; do
 > > +       diff "${lowerdir}/${testfile}_iosize${iosize}K_holefile" "${up=
perdir}/${testfile}_iosize${iosize}K_holefile" >>$seqres.full
 > > +       iosize=3D`expr $iosize + $iosize`
 > > +done
 > > +
 > > +diff "${lowerdir}/${testfile}_empty_holefile"  "${upperdir}/${testfil=
e}_empty_holefile"  >>$seqres.full
 > > +diff "${lowerdir}/${testfile}_random_holefile" "${upperdir}/${testfil=
e}_random_holefile" >>$seqres.full
 >=20
 > This expression does not fail the test if file differ?
 > Did you mean:
 >=20
 > diff "${lowerdir}/${testfile}_empty_holefile"
 > "${upperdir}/${testfile}_empty_holefile"  >>$seqres.full || \
 >     echo ${testfile}_empty_holefile" copy up failed

Yeah, it's more useful for investigating problem.


 >=20
 > > +
 > > +# success, all done
 > > +status=3D0
 > > +exit
 > > diff --git a/tests/overlay/066.out b/tests/overlay/066.out
 > > new file mode 100644
 > > index 00000000..b60cc24c
 > > --- /dev/null
 > > +++ b/tests/overlay/066.out
 > > @@ -0,0 +1,2 @@
 > > +QA output created by 066
 > > +Silence is golden
 > > diff --git a/tests/overlay/group b/tests/overlay/group
 > > index ef8517a1..1dec7db9 100644
 > > --- a/tests/overlay/group
 > > +++ b/tests/overlay/group
 > > @@ -68,3 +68,4 @@
 > >  063 auto quick whiteout
 > >  064 auto quick copyup
 > >  065 auto quick mount
 > > +066 auto quick copyup
 >=20
 > I'm curious, how long does the test run with and without copy up hole
 > optimization patch?

I'm using NVMe SSD disk so the performance(bw & iops) is quite good,
below figure from the result of xfstest  for test case overlay/066.

xfs: 7s(before) =3D> 6s(after)
ext4: 7s(before) =3D> 6s(after)

Maybe there will be remarkable difference on bigger sparse file,=20
if anyone interested on this I can add more test files(big) but it will als=
o
increase  test time significantly.

Thanks,
Chengguang


