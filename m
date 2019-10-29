Return-Path: <SRS0=gkCv=YW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CFECA9EAE
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Oct 2019 11:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7F72086A
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Oct 2019 11:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGlXroN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfJ2L6z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:58:55 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35877 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2L6z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Oct 2019 07:58:55 -0400
Received: by mail-yw1-f65.google.com with SMTP id p187so4943444ywg.3;
        Tue, 29 Oct 2019 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T+X/F6SxpUYjs+uMgRC8ZwABozFXyW3vcMRCQIu1f5w=;
        b=NGlXroN0LXmexX1mjjnUQEO0wwmUm4YDzuL9Q84DZXjgEtYKCITtYfRSNIallESWIx
         ZO+wBS9zmYCaOMam2cteWTmq1stzszFx5C9TAJagNwHroK5udMECZvDnA5FpFNfziPJL
         yjWok379qEjCIXfFWt0arXTeyhvKxeNI87w0Cy8mAd5XcRDLGOzPq/f1tiL15mYJfTFz
         j2aiKP85HLM2rfmyiS0FxlA71ocJBKjWr2xoUhRIvFnoy3J+ZYKjLwy+HMeiJ9HE02UC
         QTM0VOhJDSbz1grB/FlOsRAvvZKQbvVtb4MaUa0LfiXMRlVWvbWcW6yB+ZHdQtvdGHjn
         KFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T+X/F6SxpUYjs+uMgRC8ZwABozFXyW3vcMRCQIu1f5w=;
        b=VyOIe/v5bv9Zz3laB63KqK3eo1SHevO+Cp/G2oDtAAP3hVKhat56ZYlx0oWTQyvRey
         VB4qAOEL5PNc3dT4mWZRU1LSG3hIKxrQa05qgqMsDXhQ9FbYsIpylijZeOkcyPU59P6P
         KsWA3x/4yEo9Q4MOHm8aQKAnxhk4FWH5B5XrSTiuYos7t0DxxCElKuJwegf326OVD0DE
         ybTVgc9X65wka14ihHMdUWz2t8IQdqW1OVlRSHMNjgwV8oizhNrW6VgMWp0E7lqgZJNi
         D4bld8mL2Dlg99S91fdK/y6y6O9WzZtsJJUtmHZ6pMZ6QJwC9Focw++bB0fABPc6lR42
         v2bw==
X-Gm-Message-State: APjAAAVASueypEsL7zlGaLRjUr+TmTAW6t9OjcHV2TDhMEspywhG7+Av
        /Io1Wq05OEJo4cLdY0c+77/lBhDvSnSHrYc+65u7Zc1k
X-Google-Smtp-Source: APXvYqzZDrP/OUsj3yyXQViHRiZ+em+QaUqyxPY8XzjN9VruCQQNsALiQIjCrkDm74wBJb2sF0jyoyewyWN/Pe1/fqY=
X-Received: by 2002:a0d:e347:: with SMTP id m68mr16895514ywe.183.1572350333855;
 Tue, 29 Oct 2019 04:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191029055713.28191-1-cgxu519@mykernel.net> <CAOQ4uxgzZHXOv7K++BArYmaTEHbYr5oCkgXw8WVUsQgh0uyqhg@mail.gmail.com>
 <16e173c434a.11f8ced8d40796.3954073574203284331@mykernel.net>
In-Reply-To: <16e173c434a.11f8ced8d40796.3954073574203284331@mykernel.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 29 Oct 2019 13:58:42 +0200
Message-ID: <CAOQ4uxjddbot29=cYqLMLyqT=w=pWmLOPqVzvi-5mcXQ3AB3EQ@mail.gmail.com>
Subject: Re: [PATCH] overlay/066: adjust test file size && add more test patterns
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     fstests <fstests@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 29, 2019 at 1:17 PM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-29 16:32:32 Amir Gol=
dstein <amir73il@gmail.com> =E6=92=B0=E5=86=99 ----
>  > On Tue, Oct 29, 2019 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> w=
rote:
>  > >
>  >
>  > Can you please send the patch as plain/text.
>  > Your mailer has sent it with quoted printable encoding and git am
>  > fails to apply the patch:
>  > https://lore.kernel.org/fstests/20191029055713.28191-1-cgxu519@mykerne=
l.net/raw
>  >
>
> Sorry for that,  I'm not clear for the reason, so I send you the patch in=
 attachment first.
>

FWIW I am using git-send-email...

>
>  > > Make many small holes in 10M test file seems not very
>  > > helpful for test coverage and it takes too much time
>  > > on creating test files. So in order to improve test
>  > > speed we adjust test file size to (10 * iosize) for
>  > > iosize aligned hole files meanwhile add more test
>  > > patterns for small random holes and small empty file.
>  > >
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > > ---
>  > >  tests/overlay/066 | 89 +++++++++++++++++++++++++++++++++++---------=
---
>  > >  1 file changed, 67 insertions(+), 22 deletions(-)
>  > >
>  > > diff --git a/tests/overlay/066 b/tests/overlay/066
>  > > index 285a5aff..fb8f5e5c 100755
>  > > --- a/tests/overlay/066
>  > > +++ b/tests/overlay/066
>  > > @@ -40,49 +40,82 @@ _require_scratch
>  > >  # Remove all files from previous tests
>  > >  _scratch_mkfs
>  > >
>  > > -# We have totally 14 test files in this test.
>  > > +# We have totally 16 test files in this test.
>  > >  # The detail as below:
>  > > -# 1 empty file(10M) + 2^0(K)..2^11(K) hole size files(each 10M) + 1=
 random hole size file(100M).
>  > > +# 1 small empty file 4K
>  > > +# 1 big empty file 4M
>  > > +# 1 small random hole file 10M
>  > > +# 1 big random hole file 100M
>  > > +#
>  > > +# 12 files with variant iosize aligned holes.
>  > > +# 2^0(K)..2^11(K) hole size files(file size =3D 10 * iosize)
>  > >  #
>  > >  # Considering both upper and lower fs will fill zero when copy-up
>  > >  # hole area in the file, this test at least requires double disk
>  > >  # space of the sum of above test files' size.
>  > >
>  > > -_require_fs_space $OVL_BASE_SCRATCH_MNT $(((10*1024*13 + 100*1024*1=
) * 2))
>  > > +_require_fs_space $OVL_BASE_SCRATCH_MNT $((((4) + (4096) + (10 * 10=
24) \
>  > > +                + (100 * 1024) + (10 * (1 + 2048) * 12 / 2)) * 2))
>  > >
>  > >  lowerdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_LOWER
>  > >  upperdir=3D$OVL_BASE_SCRATCH_MNT/$OVL_UPPER
>  > >  testfile=3D"copyup_sparse_test"
>  > >
>  > > -# Create a completely empty hole file(10M).
>  > > -file_size=3D10240
>  > > -$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_=
empty_holefile" \
>  > > +# Create a small completely empty hole file(4K).
>  > > +file_size=3D4
>  > > +$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_=
empty_small_holefile" \
>  > > +                >>$seqres.full
>  > > +
>  > > +# Create a big completely empty hole file(4M).
>  > > +file_size=3D4096
>  > > +$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_=
empty_big_holefile" \
>  > >                  >>$seqres.full
>  > >
>  > > -# Create 2^0(K)..2^11(K) hole size test files(each 10M).
>  > > +# Create 2^0(K)..2^11(K) hole size test files(file size =3D 10 * io=
size).
>  > >  #
>  > >  # The pattern is like below, both hole and data are equal to
>  > >  # iosize except last hole.
>  > >  #
>  > >  # |-- hole --|-- data --| ... |-- data --|-- hole --|
>  > >
>  > > -iosize=3D1
>  > > +min_iosize=3D1
>  > >  max_iosize=3D2048
>  > > -file_size=3D10240
>  > > -max_pos=3D`expr $file_size - $max_iosize`
>  > > +iosize=3D$min_iosize
>  > >
>  > >  while [ $iosize -le $max_iosize ]; do
>  > > +       file_size=3D$(($iosize * 10))
>  > > +       max_pos=3D$(($file_size - $iosize))
>  > >         pos=3D$iosize
>  > >         $XFS_IO_PROG -fc "truncate ${file_size}K" \
>  > >                 "${lowerdir}/${testfile}_iosize${iosize}K_holefile" =
>>$seqres.full
>  > >         while [ $pos -lt $max_pos ]; do
>  > >                 $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
>  > >                 "${lowerdir}/${testfile}_iosize${iosize}K_holefile" =
>>$seqres.full
>  > > -               pos=3D`expr $pos + $iosize + $iosize`
>  > > +               pos=3D$(($pos + $iosize * 2))
>  > >         done
>  > > -       iosize=3D`expr $iosize + $iosize`
>  > > +       iosize=3D$(($iosize * 2))
>  > >  done
>  > >
>  > > +# Create test file with many random small holes(hole size is betwee=
n 4K and 512K),
>  > > +# total file size is 10M.
>  > > +
>  > > +pos=3D4
>  > > +max_pos=3D9216
>  > > +file_size=3D10240
>  > > +min_hole=3D4
>  > > +max_hole=3D512
>  > > +
>  > > +$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_=
random_small_holefile" \
>  > > +               >>$seqres.full
>  > > +
>  > > +while [ $pos -le $max_pos ]; do
>  > > +       iosize=3D$(($RANDOM % ($max_hole - $min_hole) + $min_hole))
>  > > +       $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
>  > > +               "${lowerdir}/${testfile}_random_small_holefile" >>$s=
eqres.full
>  > > +       pos=3D$(($pos + $iosize * 2))
>  > > +done
>  > > +
>  > > +
>  > >  # Create test file with many random holes(hole size is between 1M a=
nd 5M),
>  > >  # total file size is 100M.
>  > >
>  > > @@ -92,14 +125,14 @@ file_size=3D102400
>  > >  min_hole=3D1024
>  > >  max_hole=3D5120
>  > >
>  > > -$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_=
random_holefile" \
>  > > +$XFS_IO_PROG -fc "truncate ${file_size}K" "${lowerdir}/${testfile}_=
random_big_holefile" \
>  > >                 >>$seqres.full
>  > >
>  > >  while [ $pos -le $max_pos ]; do
>  > >         iosize=3D$(($RANDOM % ($max_hole - $min_hole) + $min_hole))
>  > >         $XFS_IO_PROG -fc "pwrite ${pos}K ${iosize}K" \
>  > > -               "${lowerdir}/${testfile}_random_holefile" >>$seqres.=
full
>  > > -       pos=3D`expr $pos + $iosize + $iosize`
>  > > +               "${lowerdir}/${testfile}_random_big_holefile" >>$seq=
res.full
>  > > +       pos=3D$(($pos + $iosize * 2))
>  > >  done
>  > >
>  > >  _scratch_mount
>  > > @@ -112,18 +145,30 @@ done
>  > >  echo "Silence is golden"
>  > >
>  > >  # Check all copy-up files in upper layer.
>  > > -iosize=3D1
>  > > -while [ $iosize -le 2048 ]; do
>  > > +min_iosize=3D1
>  > > +max_iosize=3D2048
>  >
>  > My intention was that you use those "constants" defined above when cre=
ating
>  > the files, not that you re-define them when verifying the files.
>
> Maybe there is a risk that iosize is changed unexpectedly between creatin=
g first test files
> and before verifying them in the future. Now I think better solution is j=
ust compare all
> test files in lower/upper dir by one diff command.
>

Agreed.

diff -qr "${lowerdir}/" "${upperdir}/"

Would be enough and provide enough details in 066.bad should the
diff fail

Thanks,
Amir.
