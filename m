Return-Path: <SRS0=wN5T=25=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74308C00523
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jan 2020 09:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B632206DA
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jan 2020 09:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m43N3MN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAHJu2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:50:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42928 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgAHJu1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Jan 2020 04:50:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so1306632pgb.9
        for <fstests@vger.kernel.org>; Wed, 08 Jan 2020 01:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0mWP0x97kbAV9MHK19a3Zh4a17Y76UqWOcRg3bCKpzk=;
        b=m43N3MN0Q5Z0qHDavdUasDL8hB4V+LKzOofEKNUtClQhLSef0+kHXvTd7vFDind7UX
         paLf7VMpNy3QXlA1DiNX55M7/d5Zjq7/TbqYWsUh64G87YuSBbPTL7JGHEGFyr1Hj0Gt
         XHWcEI9R+r1LEgrh/kW7Wu+vemVEyNNvOrNNB7h32DVa5DtEas5lVox5pI1tU4r0VSrZ
         YySiEH6XqTEupsdRpoSGt1L67B1fSOYuI0HkEZCtscuwY201/vLr9mOfvmVDb0u87RsU
         ltGWAvHZrEwlX7MJsD20t5NHG/Pmf3qIKY+ijaQXR892W5c6ZF+3z2FTcvyUS+EDtz6H
         32GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0mWP0x97kbAV9MHK19a3Zh4a17Y76UqWOcRg3bCKpzk=;
        b=K0LIAE4l8aWlNNpZOu509+btYcixr0Uo7qqYIFfAqZGNGaC2Qbu+xYOhkaUZ4yGxT9
         qC5U9Vz7gake+VV13A//DdxvD/GMz5hydWZ1Ylp6kg7SQWtIpeSTHFMqkBhKOxVd68q/
         xMAmqNBCzZGSqi7JKh/ubPerT13cz09/pgxMB4GPNxk6VaAHkeyDbKYDN4eU2irIlL5n
         6ZHz8CwTiPMoXa/F6OywxRNUvfHuN3OtREsLDqszObfDSYstvhXSBvvFOBUDpYh02Ack
         iadcPUwFetPQ61THrjWDW3quLy9jmnXuxVe0SaBGmDGq/omnkS1LPStKL8/o06MFE6d5
         xDgQ==
X-Gm-Message-State: APjAAAWkb9dlxp8k5tXHg+SbaexQEvzFslq7u0KPiJnsKHXwoRLZjxbv
        cI/NYwsdA6+MyD7ATcn6iig=
X-Google-Smtp-Source: APXvYqxxltfdHnhm4gQOlE/5OxO2PNzDqXe2IQTBJLFogOaFkyEgQ9lbAy8ntrlR1V6yrVI3yy7bUw==
X-Received: by 2002:a63:e042:: with SMTP id n2mr4466924pgj.308.1578477026941;
        Wed, 08 Jan 2020 01:50:26 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id q15sm2882445pgi.55.2020.01.08.01.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 01:50:26 -0800 (PST)
Date:   Wed, 8 Jan 2020 17:50:21 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Subject: Re: [PATCH v2] generic/402: Make timestamp range check conditional
Message-ID: <20200108095021.GH893866@desktop>
References: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
 <20191228221317.16654-1-deepa.kernel@gmail.com>
 <CAOQ4uxifpjjirTyUsCm03TFx8LOvkt0xX+RNyFZU5sHNU+bfqA@mail.gmail.com>
 <20200108080936.GG893866@desktop>
 <CAOQ4uxhOGZfLch1HDFACD9fLczpLHxVMoY50ZyJDOyAJBp-WyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhOGZfLch1HDFACD9fLczpLHxVMoY50ZyJDOyAJBp-WyQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 08, 2020 at 10:45:29AM +0200, Amir Goldstein wrote:
> On Wed, Jan 8, 2020 at 10:09 AM Eryu Guan <guaneryu@gmail.com> wrote:
> >
> > On Mon, Dec 30, 2019 at 09:34:47AM +0200, Amir Goldstein wrote:
> > > On Sun, Dec 29, 2019 at 12:13 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > > >
> > > > Addition of fs-specific timestamp range checking was added
> > > > in 188d20bcd1eb ("vfs: Add file timestamp range support").
> > > >
> > > > Add a check for whether the kernel supports the limits check
> > > > before running the associated test.
> > > >
> > > > ext4 has been chosen to test for the presence of kernel support
> > > > for this feature. If there is a concern that ext4 could be built
> > > > out of the kernel, I can include a _require_ext4() along the
> > > > lines of _require_ext2().
> > > >
> > > > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > > > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> >
> > Sorry for chiming in so late..
> >
> > > > ---
> > > > * Changes since v1:
> > > >   used loopback device instead of mkfs scratch dev
> > > >
> > > >  common/rc         | 26 ++++++++++++++++++++++++++
> > > >  tests/generic/402 |  3 +++
> > > >  2 files changed, 29 insertions(+)
> > > >
> > > > diff --git a/common/rc b/common/rc
> > > > index 816588d6..6248adf7 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -1981,6 +1981,32 @@ _run_aiodio()
> > > >      return $status
> > > >  }
> > > >
> > > > +_require_kernel_timestamp_range()
> > > > +{
> > > > +       LOOP_FILE=$SCRATCH_MNT/loop_file
> > > > +       LOOP_MNT=$SCRATCH_MNT/loop_mnt
> > > > +
> > > > +       dd if=/dev/zero of=$LOOP_FILE bs=1M count=2 2>&1 | _filter_dd || _fail "loopback prep failed"
> > > > +
> > > > +       # Use ext4 with 128-byte inodes, which do not have room for extended timestamp
> > > > +       FSTYP=ext4 MKFS_OPTIONS=-I128 \
> > > > +       _mkfs_dev $LOOP_FILE >> $seqres.full 2>&1 || _fail "ext4 mkfs failed"
> > > > +
> > > > +       LOOP_DEV=$(_create_loop_device $LOOP_FILE)
> > > > +       mkdir -p $LOOP_MNT >> $seqres.full 2>&1 || _fail "failed to create $LOOP_MNT"
> > > > +       mount -t ext4 ${LOOP_DEV} ${LOOP_MNT} >> $seqres.full 2>&1 || _fail "ext4 mount failed"
> > > > +       notrun=false
> > > > +       _check_dmesg_for "ext4 filesystem being mounted at ${LOOP_MNT} supports timestamps until 2038" || \
> > > > +               notrun=true
> > > > +
> > > > +       umount ${LOOP_MNT} >> $seqres.full 2>&1 ||_fail "failed to umount $LOOP_MNT"
> > > > +       _destroy_loop_device ${LOOP_DEV} >> $seqres.full 2>&1
> > > > +
> > > > +       if $notrun; then
> > > > +               _notrun "Kernel does not support timestamp limits"
> > > > +       fi
> > > > +}
> > > > +
> > >
> > > As a generic helper, this function has a few problems:
> > > 1. It assumes scratch dev is mounted (and you're not even calling it
> > > after _scratch_mount)
> > > 2. The cleanup() hook won't clean loop mnt/dev if interrupted
> > > 3. test doesn't have _require_loop (nor require ext4 as you mentioned)
> > >
> > > All this leads me to think that perhaps it would be better off, at least until
> > > kernel has fsinfo, to keep this entire helper inside generic/402,
> > > while addressing
> > > the issues above in the test itself.
> > >
> > > A more generic solution would be harder and IMO and overkill at this point.
> > >
> > > What do you think?
> >
> > After reading through this thread, I prefer waiting for the comming
> > fsinfo interface, detecting the timestamp limit support using ext2 &
> > loop device doesn't look "pretty" and is just a temporary solution.
> >
> 
> I understand why you dislike the ext2+loop test, but please hear me out.
> 
> From all the fs types that are supported by the test, only btrfs and ext4 with
> large inode size are y2038 ready.
> For the rest of the cases, we actually have a way to detect kernel support
> from the dmesg warning, without the need for hacky ext2 loop mount.
> 
> So how about just:
> 1. moving  _scratch_mount before _require_timestamp_range
> 2. in _require_timestamp_range (untested):
>         if [ $tsmax -lt $((1<<32)) ] && ! _check_dmesg_for "supports

Yeah, this looks fine. I thought about searching for dmesg warning after
_scratch_mount as well, but that would _notrun if the fs is 2038-safe.
This $tsmax check fixes my concern. Thanks!

Eryu

> timestamps until 2038" ; then
>                 _notrun "Kernel does not support timestamp limits"
>         fi
> 
> It's better than nothing and it does not add much complications, nor
> is this "hacky"
> IMO.
> 
> Thoughts?
> 
> Amir.
