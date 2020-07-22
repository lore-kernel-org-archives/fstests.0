Return-Path: <SRS0=o+XN=BB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2940C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 12:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4BC20657
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 12:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJdCW+Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbgGVM7p (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgGVM7o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jul 2020 08:59:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19009C0619DC
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2020 05:59:44 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x9so963590plr.2
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2020 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EdZZjEF4QKNPyX54Ee/gBTJ+5jJO0i3AiJa4KgnPwvQ=;
        b=GJdCW+WqQerF7SS/tWJu17jH7y1cs3gaJkXdYGFkoxgyuISx5bogKhtwNps9wWgxXP
         ii1nkm0sMtR1tjot3mqGoWxG8RNeKU6MA6JLh7RUt0Bds2I8OnFpPUO/GW0VLeXViL+d
         YxUYrKHbkfXzp9lPc9HpzNc6qdQtKpx+e28xWgRJ5dP/SyldX1YlBNTcsE0YfhKmBkaA
         jGHO40WVWeCCI3i9pkNNbfWBWd0EDQ0mvC+LGUbhDsVT1gsOr2TPnvEMkYeZKaxHEY7u
         u5gzq6EeO4ArDsfVsA1VN3Mgk+frQ/kmagIB6GY7r3zD88NoQdr82/Q0zDPysvicnBpB
         eNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EdZZjEF4QKNPyX54Ee/gBTJ+5jJO0i3AiJa4KgnPwvQ=;
        b=i8boyRPVJBqDt26ObMwGJ3u5m4xQbjRff2llLbEG+NOm8vx1qyIJq0PbT5A8cJejuV
         R1b5nWvC7oI35HeD+fL3oX8VNffWczzfib4KxsppKI+OcIjcF2ApoKBZ6G0qwmc7lUmX
         gliiUxzo3EK0Xi+8fJM6EA1+GY/tpgeUe/sHyA6XRPWm2o1WR0cJeHaoHsQm7a1x50gq
         mb5TwpAcGzrnOV1Ggs4S60f73TRvm6NSXC0q/xAfecK825dCdDi96WYjXjvUjW8zY7mo
         ebi+c0h7ZS5NRQ/ODxTa05/pJ+HESW0v1QULNTHtPlCq5X2UpvLTl/0ikMNmO+nqF3aQ
         bHZg==
X-Gm-Message-State: AOAM531WYvXupaps93AbwrauWtAXIghJph/zgtaTVMqF7m2OIXMTex4W
        KGH7xakBtt7Z6E+/pHDK6bo=
X-Google-Smtp-Source: ABdhPJxq6FcSuLuGwYJKfVGFXMzjmV3Pj+qPfbO8ScVHPTUJ1/grT5IaoegIh8y6Et7Ru4MPavH9rA==
X-Received: by 2002:a17:902:bb8c:: with SMTP id m12mr18783696pls.274.1595422783512;
        Wed, 22 Jul 2020 05:59:43 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n2sm2755816pfq.140.2020.07.22.05.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:42 -0700 (PDT)
Date:   Wed, 22 Jul 2020 20:59:35 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        fstests <fstests@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/501: count with PAGE_SIZE instead of KB
Message-ID: <20200722125935.b727a4hviblacwci@xzhoux.usersys.redhat.com>
References: <20200722063832.dpxn7weosdy2zp64@xzhoux.usersys.redhat.com>
 <20200722115848.GB2937@dhcp-12-102.nay.redhat.com>
 <CAL3q7H7_H_FOZA0e60JR0BiiXq-t_-itXpfdpPCxdgTKFe21_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7_H_FOZA0e60JR0BiiXq-t_-itXpfdpPCxdgTKFe21_g@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 22, 2020 at 12:52:16PM +0100, Filipe Manana wrote:
> On Wed, Jul 22, 2020 at 12:48 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Jul 22, 2020 at 02:38:32PM +0800, Murphy Zhou wrote:
> > > Hard coded reflink offset/length numbers are not working well on 64K page
> > > size arch like ppc64le, reporting:
> > >       +XFS_IOC_CLONE_RANGE: Invalid argument
> > >
> > > Because they are not aligned with the current PAGE_SIZE.
> > >
> > > Translate original numbers into multiples of PAGE_SIZE. Then we're writing
> > > different testfiles with different md5sums when PAGE_SIZE is different.
> > > So we need to link different output file based on the current PAGE_SIZE.
> > >
> > > This testcase is covering a btrfs regression which has been fixed in
> > > v4.18. I tried to reproduce it on 4.17 kernel but failed with and
> > > without this patch.
> > >
> > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > ---
> > >  .gitignore                            |  1 +
> > >  tests/generic/501                     | 17 +++++++++++++----
> > >  tests/generic/{501.out => 501.out.4K} |  0
> > >  tests/generic/501.out.64K             |  5 +++++
> > >  4 files changed, 19 insertions(+), 4 deletions(-)
> > >  rename tests/generic/{501.out => 501.out.4K} (100%)
> > >  create mode 100644 tests/generic/501.out.64K
> > >
> > > diff --git a/.gitignore b/.gitignore
> > > index 5f5c4a0f..39318615 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -263,6 +263,7 @@
> > >  /tests/xfs/033.out
> > >  /tests/xfs/071.out
> > >  /tests/xfs/096.out
> > > +/tests/generic/501.out
> > >
> > >  # cscope files
> > >  cscope.*
> > > diff --git a/tests/generic/501 b/tests/generic/501
> > > index 0d1f6ffe..4e589cda 100755
> > > --- a/tests/generic/501
> > > +++ b/tests/generic/501
> > > @@ -9,6 +9,7 @@
> > >  # the file again and then power fail, after we mount again the filesystem, no
> > >  # file data was lost or corrupted.
> > >  #
> > > +seqfull=$0
> > >  seq=`basename $0`
> > >  seqres=$RESULT_DIR/$seq
> > >  echo "QA output created by $seq"
> > > @@ -42,14 +43,22 @@ _require_metadata_journaling $SCRATCH_DEV
> > >  _init_flakey
> > >  _mount_flakey
> > >
> > > -$XFS_IO_PROG -f -c "pwrite -S 0x18 9000K 6908K" $SCRATCH_MNT/foo >>$seqres.full
> > > -$XFS_IO_PROG -f -c "pwrite -S 0x20 2572K 156K" $SCRATCH_MNT/bar >>$seqres.full
> > > +pagesz=$(getconf PAGE_SIZE)
> > > +
> > > +if [ $pagesz -eq 65536 ] ; then
> > > +     ln -sf $seqfull.out.64K $seqfull.out
> > > +elif [ $pagesz -eq 4096 ] ; then
> > > +     ln -sf $seqfull.out.4K $seqfull.out
> > > +fi
> >
> > You can't sure there're only 4k and 64k system.
> > This case trys to make sure the md5 of $SCRATCH_MNT/bar isn't changed before and
> > after _flakey_drop_and_remount. So if you turn to use different pagesize, you
> > can silence the golden image, and compare the md5 quietly. Something likes(just
> > example):
> 
> This can be simpler. The test can be changed to use multiples of 64K,

Agree! Thanks Zorro very much for suggestion!

> so it will work everywhere (like other reflink tests).
> I'll try it out and test on 4.17 to confirm it still reproduces the
> original btrfs bug.

Ya, this is important. I'm wondering if the original bug can be
reproduced by using multiples of 64k.

Thanks!
> 
> Thanks.
> 
> >
> > diff --git a/tests/generic/501 b/tests/generic/501
> > index 0d1f6ffe..7e7f9be5 100755
> > --- a/tests/generic/501
> > +++ b/tests/generic/501
> > @@ -53,18 +53,21 @@ $XFS_IO_PROG -c "fsync" \
> >              -c "fsync" \
> >              $SCRATCH_MNT/bar >>$seqres.full
> >
> > -echo "File bar digest before power failure:"
> > -md5sum $SCRATCH_MNT/bar | _filter_scratch
> > +# File bar digest before power failure
> > +md5sum $SCRATCH_MNT/bar > $tmp.md5.org
> >
> >  # Simulate a power failure and mount the filesystem to check that no file data
> >  # was lost or corrupted.
> >  _flakey_drop_and_remount
> >
> > -echo "File bar digest after power failure:"
> > -md5sum $SCRATCH_MNT/bar | _filter_scratch
> > +# File bar digest after power failure
> > +md5sum $SCRATCH_MNT/bar > $tmp.md5.new
> > +diff -u $tmp.md5.org $tmp.md5.new
> >
> >  _unmount_flakey
> >  _cleanup_flakey
> >
> > +echo "Silence is golden"
> > +
> >  status=0
> >  exit
> > diff --git a/tests/generic/501.out b/tests/generic/501.out
> > index 5d7da017..00133b63 100644
> > --- a/tests/generic/501.out
> > +++ b/tests/generic/501.out
> > @@ -1,5 +1,2 @@
> >  QA output created by 501
> > -File bar digest before power failure:
> > -95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
> > -File bar digest after power failure:
> > -95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
> > +Silence is golden
> >
> > Thanks,
> > Zorro
> >
> > > +
> > > +$XFS_IO_PROG -f -c "pwrite -S 0x18 $((2250*pagesz)) $((1727*pagesz))" $SCRATCH_MNT/foo >>$seqres.full
> > > +$XFS_IO_PROG -f -c "pwrite -S 0x20 $((643*pagesz)) $((39*pagesz))" $SCRATCH_MNT/bar >>$seqres.full
> > >
> > >  # We clone from file foo into a range of file bar that overlaps the existing
> > >  # extent at file bar. The destination offset of the reflink operation matches
> > > -# the eof position of file bar minus 4Kb.
> > > +# the eof position of file bar minus 1 PAGE_SIZE.
> > >  $XFS_IO_PROG -c "fsync" \
> > > -          -c "reflink ${SCRATCH_MNT}/foo 0 2724K 15908K" \
> > > +          -c "reflink ${SCRATCH_MNT}/foo 0 $((681*pagesz)) $((3977*pagesz))" \
> > >            -c "fsync" \
> > >            $SCRATCH_MNT/bar >>$seqres.full
> > >
> > > diff --git a/tests/generic/501.out b/tests/generic/501.out.4K
> > > similarity index 100%
> > > rename from tests/generic/501.out
> > > rename to tests/generic/501.out.4K
> > > diff --git a/tests/generic/501.out.64K b/tests/generic/501.out.64K
> > > new file mode 100644
> > > index 00000000..7e1013b2
> > > --- /dev/null
> > > +++ b/tests/generic/501.out.64K
> > > @@ -0,0 +1,5 @@
> > > +QA output created by 501
> > > +File bar digest before power failure:
> > > +3058797b969076e91c518cb206b21163  SCRATCH_MNT/bar
> > > +File bar digest after power failure:
> > > +3058797b969076e91c518cb206b21163  SCRATCH_MNT/bar
> > > --
> > > 2.20.1
> > >
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”

-- 
Murphy
