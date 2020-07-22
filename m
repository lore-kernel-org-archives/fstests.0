Return-Path: <SRS0=o+XN=BB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52FBC433E3
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 11:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9FA7206F5
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkBW6wKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgGVLw2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgGVLw2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jul 2020 07:52:28 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5AC0619DC
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2020 04:52:28 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id p25so978469vsg.4
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2020 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=avxtOlqkPbRP+/qiWd19Sk5mWeDTBr12kOc+pWXSZVU=;
        b=gkBW6wKuBhwL2JJppmofBG9pSBCSDOuV9hattGGpz3hZyoeAkOqkHzJrvmiQw8D01C
         BJYX7odMEOU/8Wb4ZHwJX5Utan3RJVK94oVTJftBD1ya/5OY0rKph7kCpMheHnYGb0zC
         FzQHrrkpeqnvnbg5tPSH0BTKZEbFFMZgqWcr7Jbn4X+uLaopf8ON+/TNzSw1Wz8FvmTq
         kHejmBZx0AkAQkxdVKn8Ku8xXkBxgwsiJUD9Gb+z+Bl8nposoDDn2fq+3VoeXb4ri2vA
         Ecl2HbnasCRz+oRZI+T+4iU0REP0z4M3NCh8OJaog58J1pOxQMAyI/miWnRUWVXTmRpW
         z3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=avxtOlqkPbRP+/qiWd19Sk5mWeDTBr12kOc+pWXSZVU=;
        b=NPd1KLL3k7nzQkWwU3CCx9vj7nANG10IrqsWjbn9YxL1+Jzw3KadIwWWsq4aOsy7bB
         4c5VP6cXnVatnrQUxqvGi5/xZsqgHRIEEZ0AfpnSZIDgojeGgmSI9S3BddE2I2Wd2y8h
         Q39vqb84C0adawc9jy0uxOvvWmG6Uz3+oMUo4XxRpidIs057aDHpajwE0SA4xHk1ZtkQ
         Oysd+QVlZovGwbA5m9KC5zCxgj/rcG5FW9FkyEFyDqQRrlRKDZB28Az9lYsO+/SkznAU
         rmtqkjHMzgTq/RUKpQnncMk6W0LxSVta45+cW85LUHq8h6S7xD/YhxlJKiG1z2qi66Gs
         z2Gg==
X-Gm-Message-State: AOAM5327tg9hPZCanhS8PMDts5DI3S2ou3fcVY1sCd83tEk72xi5QA1D
        6XtcliYQBSl5xQOZknrcTmGHbNvBdHbnCvW9Tj8zng==
X-Google-Smtp-Source: ABdhPJyTz7kwKAm/L42jjqLjjEuIp41wM4/Y7ZpaARiUWP9E1VCOUSI2vN+aear9GKeacWnDIxlRW0ssG6SFmUyo850=
X-Received: by 2002:a67:fa5a:: with SMTP id j26mr21908031vsq.95.1595418747221;
 Wed, 22 Jul 2020 04:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200722063832.dpxn7weosdy2zp64@xzhoux.usersys.redhat.com> <20200722115848.GB2937@dhcp-12-102.nay.redhat.com>
In-Reply-To: <20200722115848.GB2937@dhcp-12-102.nay.redhat.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 22 Jul 2020 12:52:16 +0100
Message-ID: <CAL3q7H7_H_FOZA0e60JR0BiiXq-t_-itXpfdpPCxdgTKFe21_g@mail.gmail.com>
Subject: Re: [PATCH] generic/501: count with PAGE_SIZE instead of KB
To:     Murphy Zhou <jencce.kernel@gmail.com>,
        fstests <fstests@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 22, 2020 at 12:48 PM Zorro Lang <zlang@redhat.com> wrote:
>
> On Wed, Jul 22, 2020 at 02:38:32PM +0800, Murphy Zhou wrote:
> > Hard coded reflink offset/length numbers are not working well on 64K pa=
ge
> > size arch like ppc64le, reporting:
> >       +XFS_IOC_CLONE_RANGE: Invalid argument
> >
> > Because they are not aligned with the current PAGE_SIZE.
> >
> > Translate original numbers into multiples of PAGE_SIZE. Then we're writ=
ing
> > different testfiles with different md5sums when PAGE_SIZE is different.
> > So we need to link different output file based on the current PAGE_SIZE=
.
> >
> > This testcase is covering a btrfs regression which has been fixed in
> > v4.18. I tried to reproduce it on 4.17 kernel but failed with and
> > without this patch.
> >
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  .gitignore                            |  1 +
> >  tests/generic/501                     | 17 +++++++++++++----
> >  tests/generic/{501.out =3D> 501.out.4K} |  0
> >  tests/generic/501.out.64K             |  5 +++++
> >  4 files changed, 19 insertions(+), 4 deletions(-)
> >  rename tests/generic/{501.out =3D> 501.out.4K} (100%)
> >  create mode 100644 tests/generic/501.out.64K
> >
> > diff --git a/.gitignore b/.gitignore
> > index 5f5c4a0f..39318615 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -263,6 +263,7 @@
> >  /tests/xfs/033.out
> >  /tests/xfs/071.out
> >  /tests/xfs/096.out
> > +/tests/generic/501.out
> >
> >  # cscope files
> >  cscope.*
> > diff --git a/tests/generic/501 b/tests/generic/501
> > index 0d1f6ffe..4e589cda 100755
> > --- a/tests/generic/501
> > +++ b/tests/generic/501
> > @@ -9,6 +9,7 @@
> >  # the file again and then power fail, after we mount again the filesys=
tem, no
> >  # file data was lost or corrupted.
> >  #
> > +seqfull=3D$0
> >  seq=3D`basename $0`
> >  seqres=3D$RESULT_DIR/$seq
> >  echo "QA output created by $seq"
> > @@ -42,14 +43,22 @@ _require_metadata_journaling $SCRATCH_DEV
> >  _init_flakey
> >  _mount_flakey
> >
> > -$XFS_IO_PROG -f -c "pwrite -S 0x18 9000K 6908K" $SCRATCH_MNT/foo >>$se=
qres.full
> > -$XFS_IO_PROG -f -c "pwrite -S 0x20 2572K 156K" $SCRATCH_MNT/bar >>$seq=
res.full
> > +pagesz=3D$(getconf PAGE_SIZE)
> > +
> > +if [ $pagesz -eq 65536 ] ; then
> > +     ln -sf $seqfull.out.64K $seqfull.out
> > +elif [ $pagesz -eq 4096 ] ; then
> > +     ln -sf $seqfull.out.4K $seqfull.out
> > +fi
>
> You can't sure there're only 4k and 64k system.
> This case trys to make sure the md5 of $SCRATCH_MNT/bar isn't changed bef=
ore and
> after _flakey_drop_and_remount. So if you turn to use different pagesize,=
 you
> can silence the golden image, and compare the md5 quietly. Something like=
s(just
> example):

This can be simpler. The test can be changed to use multiples of 64K,
so it will work everywhere (like other reflink tests).
I'll try it out and test on 4.17 to confirm it still reproduces the
original btrfs bug.

Thanks.

>
> diff --git a/tests/generic/501 b/tests/generic/501
> index 0d1f6ffe..7e7f9be5 100755
> --- a/tests/generic/501
> +++ b/tests/generic/501
> @@ -53,18 +53,21 @@ $XFS_IO_PROG -c "fsync" \
>              -c "fsync" \
>              $SCRATCH_MNT/bar >>$seqres.full
>
> -echo "File bar digest before power failure:"
> -md5sum $SCRATCH_MNT/bar | _filter_scratch
> +# File bar digest before power failure
> +md5sum $SCRATCH_MNT/bar > $tmp.md5.org
>
>  # Simulate a power failure and mount the filesystem to check that no fil=
e data
>  # was lost or corrupted.
>  _flakey_drop_and_remount
>
> -echo "File bar digest after power failure:"
> -md5sum $SCRATCH_MNT/bar | _filter_scratch
> +# File bar digest after power failure
> +md5sum $SCRATCH_MNT/bar > $tmp.md5.new
> +diff -u $tmp.md5.org $tmp.md5.new
>
>  _unmount_flakey
>  _cleanup_flakey
>
> +echo "Silence is golden"
> +
>  status=3D0
>  exit
> diff --git a/tests/generic/501.out b/tests/generic/501.out
> index 5d7da017..00133b63 100644
> --- a/tests/generic/501.out
> +++ b/tests/generic/501.out
> @@ -1,5 +1,2 @@
>  QA output created by 501
> -File bar digest before power failure:
> -95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
> -File bar digest after power failure:
> -95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
> +Silence is golden
>
> Thanks,
> Zorro
>
> > +
> > +$XFS_IO_PROG -f -c "pwrite -S 0x18 $((2250*pagesz)) $((1727*pagesz))" =
$SCRATCH_MNT/foo >>$seqres.full
> > +$XFS_IO_PROG -f -c "pwrite -S 0x20 $((643*pagesz)) $((39*pagesz))" $SC=
RATCH_MNT/bar >>$seqres.full
> >
> >  # We clone from file foo into a range of file bar that overlaps the ex=
isting
> >  # extent at file bar. The destination offset of the reflink operation =
matches
> > -# the eof position of file bar minus 4Kb.
> > +# the eof position of file bar minus 1 PAGE_SIZE.
> >  $XFS_IO_PROG -c "fsync" \
> > -          -c "reflink ${SCRATCH_MNT}/foo 0 2724K 15908K" \
> > +          -c "reflink ${SCRATCH_MNT}/foo 0 $((681*pagesz)) $((3977*pag=
esz))" \
> >            -c "fsync" \
> >            $SCRATCH_MNT/bar >>$seqres.full
> >
> > diff --git a/tests/generic/501.out b/tests/generic/501.out.4K
> > similarity index 100%
> > rename from tests/generic/501.out
> > rename to tests/generic/501.out.4K
> > diff --git a/tests/generic/501.out.64K b/tests/generic/501.out.64K
> > new file mode 100644
> > index 00000000..7e1013b2
> > --- /dev/null
> > +++ b/tests/generic/501.out.64K
> > @@ -0,0 +1,5 @@
> > +QA output created by 501
> > +File bar digest before power failure:
> > +3058797b969076e91c518cb206b21163  SCRATCH_MNT/bar
> > +File bar digest after power failure:
> > +3058797b969076e91c518cb206b21163  SCRATCH_MNT/bar
> > --
> > 2.20.1
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
