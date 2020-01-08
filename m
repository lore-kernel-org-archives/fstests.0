Return-Path: <SRS0=wN5T=25=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15728C00523
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jan 2020 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7B4206DA
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jan 2020 08:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABtg+VDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgAHIJo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:09:44 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34144 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgAHIJo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Jan 2020 03:09:44 -0500
Received: by mail-pj1-f65.google.com with SMTP id s94so6102844pjc.1
        for <fstests@vger.kernel.org>; Wed, 08 Jan 2020 00:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QXfZ4IILecjxU6Awlniw47LyBcI9QVuE4Y49ilyrblg=;
        b=ABtg+VDo7thBXlU16iXRlC2UbVmhZw0nIQxK+oK95OD7PG56eot4LKYAMHuZRxKDTl
         GzsU30Y0j5AdzQ3JSGOIPIqOK5ZPbmUzHF4dQEZlsyBpFJk20I+sKDnYpy7ZoNMrdTnd
         USh0IJNCIjP1ud99DXsL9W2W8Tv6VGY9jsX68R302rXg+8iqNoURJyZ+wdbAxh3AfFCv
         wmQNsF4Ln3A7VNJcM+omKMNQM6i0o6hHQkj40PAnYv/ZPNTG/3rwacFytYWqHw/RFDhW
         715htdQU2Tw4RKwj9gyntD8IFq5Bp/AMEEH9NqgzSYXs9GO205siGk2/aUvDtaMaIjXc
         ARKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QXfZ4IILecjxU6Awlniw47LyBcI9QVuE4Y49ilyrblg=;
        b=bqfR3x9/PKztuvf4USMYQMhWdxI+uVjRrIAZmceoAtr5UGFU+fgFsOhUeNooytcArN
         T3DUqk+5Z4TrbkJN0Q48ShIj4LAXpARE9oxQFkTzEYxhypK7o4XWuKq/Sj4gOLH94XRP
         Ol4tp/2QP98jPgu04CqctPOy/n12hEvRfmJengIIyvlRJF+89pFQr8RoLn+4CTduSQqN
         O3eSiYqYN2Awu5Ah3j5OXYchjDuQtr46OlD+VAtPrynb3y7TR4Crz177Vj5d5rVV9YlH
         JizpDKRExqT757QqDuqwQL/bpvY288r6jtp/XVbCYz5vED3hoVDt3CT9JElR3wjAPIsE
         46pg==
X-Gm-Message-State: APjAAAVskavvmHeEKNjc4D9/PL1jniV4gPiWvzS6kx6wUyHeTWLoeCrF
        k/8+fhLRbugNFEKzEc1tFDA=
X-Google-Smtp-Source: APXvYqyrrWyn4iRnakZm5IeP9XyZfohrHL42CCAUA0GyJAjqH4flDr8ScPbmp0kVr5bJOoTxfr3Iwg==
X-Received: by 2002:a17:902:8a8e:: with SMTP id p14mr4147795plo.28.1578470983611;
        Wed, 08 Jan 2020 00:09:43 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id y128sm2392085pfg.17.2020.01.08.00.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 00:09:42 -0800 (PST)
Date:   Wed, 8 Jan 2020 16:09:36 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        fstests <fstests@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Subject: Re: [PATCH v2] generic/402: Make timestamp range check conditional
Message-ID: <20200108080936.GG893866@desktop>
References: <CABeXuvr74C0DS-K4_us4CdPPFxp=7RHmCHAZQQmJrh=PZfux-w@mail.gmail.com>
 <20191228221317.16654-1-deepa.kernel@gmail.com>
 <CAOQ4uxifpjjirTyUsCm03TFx8LOvkt0xX+RNyFZU5sHNU+bfqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxifpjjirTyUsCm03TFx8LOvkt0xX+RNyFZU5sHNU+bfqA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 30, 2019 at 09:34:47AM +0200, Amir Goldstein wrote:
> On Sun, Dec 29, 2019 at 12:13 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > Addition of fs-specific timestamp range checking was added
> > in 188d20bcd1eb ("vfs: Add file timestamp range support").
> >
> > Add a check for whether the kernel supports the limits check
> > before running the associated test.
> >
> > ext4 has been chosen to test for the presence of kernel support
> > for this feature. If there is a concern that ext4 could be built
> > out of the kernel, I can include a _require_ext4() along the
> > lines of _require_ext2().
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>

Sorry for chiming in so late..

> > ---
> > * Changes since v1:
> >   used loopback device instead of mkfs scratch dev
> >
> >  common/rc         | 26 ++++++++++++++++++++++++++
> >  tests/generic/402 |  3 +++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/common/rc b/common/rc
> > index 816588d6..6248adf7 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1981,6 +1981,32 @@ _run_aiodio()
> >      return $status
> >  }
> >
> > +_require_kernel_timestamp_range()
> > +{
> > +       LOOP_FILE=$SCRATCH_MNT/loop_file
> > +       LOOP_MNT=$SCRATCH_MNT/loop_mnt
> > +
> > +       dd if=/dev/zero of=$LOOP_FILE bs=1M count=2 2>&1 | _filter_dd || _fail "loopback prep failed"
> > +
> > +       # Use ext4 with 128-byte inodes, which do not have room for extended timestamp
> > +       FSTYP=ext4 MKFS_OPTIONS=-I128 \
> > +       _mkfs_dev $LOOP_FILE >> $seqres.full 2>&1 || _fail "ext4 mkfs failed"
> > +
> > +       LOOP_DEV=$(_create_loop_device $LOOP_FILE)
> > +       mkdir -p $LOOP_MNT >> $seqres.full 2>&1 || _fail "failed to create $LOOP_MNT"
> > +       mount -t ext4 ${LOOP_DEV} ${LOOP_MNT} >> $seqres.full 2>&1 || _fail "ext4 mount failed"
> > +       notrun=false
> > +       _check_dmesg_for "ext4 filesystem being mounted at ${LOOP_MNT} supports timestamps until 2038" || \
> > +               notrun=true
> > +
> > +       umount ${LOOP_MNT} >> $seqres.full 2>&1 ||_fail "failed to umount $LOOP_MNT"
> > +       _destroy_loop_device ${LOOP_DEV} >> $seqres.full 2>&1
> > +
> > +       if $notrun; then
> > +               _notrun "Kernel does not support timestamp limits"
> > +       fi
> > +}
> > +
> 
> As a generic helper, this function has a few problems:
> 1. It assumes scratch dev is mounted (and you're not even calling it
> after _scratch_mount)
> 2. The cleanup() hook won't clean loop mnt/dev if interrupted
> 3. test doesn't have _require_loop (nor require ext4 as you mentioned)
> 
> All this leads me to think that perhaps it would be better off, at least until
> kernel has fsinfo, to keep this entire helper inside generic/402,
> while addressing
> the issues above in the test itself.
> 
> A more generic solution would be harder and IMO and overkill at this point.
> 
> What do you think?

After reading through this thread, I prefer waiting for the comming
fsinfo interface, detecting the timestamp limit support using ext2 &
loop device doesn't look "pretty" and is just a temporary solution.

Thanks,
Eryu
