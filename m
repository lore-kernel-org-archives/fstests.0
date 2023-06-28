Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF51EB64D7
	for <linux-fstests@archiver.kernel.org>; Wed, 28 Jun 2023 15:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjF1PTJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 28 Jun 2023 11:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23298 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231268AbjF1PTI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Jun 2023 11:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687965496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tjh9nIWe06Ci+GHIqPuiwxWvdXgsHTVUcWD8U2D9bUo=;
        b=YI+vuP7Qu+xo08ZAUZDMWMCFEbVcd+qDz0oCZaHoF08y9MLs9KyD999vKaqfxbbPjAYHCR
        BBM1Jr0H5li52zdsHXiW3kGRI8prMHdfz7hYLP59dktDwa4T3/1QSQF6n1jkujMa6kn615
        SRA41Ay+oMamI4mQJCx2FOR4ztHqdH8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-IfFR56u9OumeTqRxS5tgEA-1; Wed, 28 Jun 2023 11:16:41 -0400
X-MC-Unique: IfFR56u9OumeTqRxS5tgEA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55b2c6cc461so330366a12.2
        for <fstests@vger.kernel.org>; Wed, 28 Jun 2023 08:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687965388; x=1690557388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjh9nIWe06Ci+GHIqPuiwxWvdXgsHTVUcWD8U2D9bUo=;
        b=K9L3Ra41c0p5RqE3bPKdiS6OcAX+N4PbZRXYX2+mwbBsFFTjPQLTjnYaeuofINHLjh
         IDsRdDqMJ5lqIcN9rTbIEOKoMfNjDDwhPmP8OR8TkihcJDvAT1fo5ZOZR79Ka0gUpvTv
         M5g6JIfy+iOlmVsbV+wVaCG9qr1VWl5s2THw7uK8Ny8oZpFBYCgrvytgJymP5J8GuJhO
         C/BACIMvVy3gLyoibl6/FshvlQtcf3I7dGGBangCwDctBFTPzGtNl2/Zntf9mSCZzCkY
         eQGiuZW0gHnoPnsp1+D55l49+U41eZpm6M3P8DXdjQdktCZ+2POoo981IgfbjWzTcn7a
         vLeQ==
X-Gm-Message-State: AC+VfDwiQ5fCdUNXIO6irVQOwsBpmsc1/eoz49N+ilT8zI00w0BNhCOI
        bhgK1KdGYHibN+a/bgX10me9geVjIk2M/QB8Hzzn15A9yFAm9FkJ6X5A4vBmrraPPPQlrvH6EiS
        DihHO/okl4klyhXEYyneF3BLgV/wI
X-Received: by 2002:a05:6a20:190:b0:12b:68f6:411d with SMTP id 16-20020a056a20019000b0012b68f6411dmr3737326pzy.49.1687965388005;
        Wed, 28 Jun 2023 08:16:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GYlY7G1Olfr+du55Urjs0fWHPmW+XOBHyuwtr0DgTE7NL5R9ddDL1j35xoWNEaLwJkQspDg==
X-Received: by 2002:a05:6a20:190:b0:12b:68f6:411d with SMTP id 16-20020a056a20019000b0012b68f6411dmr3737296pzy.49.1687965387562;
        Wed, 28 Jun 2023 08:16:27 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n12-20020aa78a4c000000b0065dd1e7c3c2sm2812511pfa.184.2023.06.28.08.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:16:27 -0700 (PDT)
Date:   Wed, 28 Jun 2023 23:16:22 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] common/btrfs: handle dmdust as mounted device in
 _btrfs_buffered_read_on_mirror()
Message-ID: <20230628151622.nhsr5mevja5h372y@zlang-mailbox>
References: <20230626060052.8913-1-wqu@suse.com>
 <20230626173212.edlu34txg5t4luc6@zlang-mailbox>
 <c06e6b05-0a88-1466-0283-fa53cec2e06a@gmx.com>
 <20230628113403.yymofvkvzrix7uev@zlang-mailbox>
 <98f33b4e-7cb9-4819-fe0a-4decb555ca23@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f33b4e-7cb9-4819-fe0a-4decb555ca23@gmx.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 28, 2023 at 07:40:14PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/6/28 19:34, Zorro Lang wrote:
> > On Tue, Jun 27, 2023 at 05:23:31AM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2023/6/27 01:32, Zorro Lang wrote:
> > > > On Mon, Jun 26, 2023 at 02:00:52PM +0800, Qu Wenruo wrote:
> > > > > [BUG]
> > > > > After commit ab41f0bddb73 ("common/btrfs: use _scratch_cycle_mount to
> > > > > ensure all page caches are dropped"), the test case btrfs/143 can fail
> > > > > like below:
> > > > > 
> > > > >    btrfs/143 6s ... [failed, exit status 1]- output mismatch (see ~/xfstests/results//btrfs/143.out.bad)
> > > > >       --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
> > > > >       +++ ~/xfstests/results//btrfs/143.out.bad 2023-06-19 17:04:00.575033899 +0100
> > > > >       @@ -1,37 +1,6 @@
> > > > >        QA output created by 143
> > > > >        wrote 131072/131072 bytes
> > > > >        XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > > >       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > > > ................
> > > > >       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > > > ................
> > > > >       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > > > ................
> > > > >       -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> > > > > ................
> > > > > 
> > > > > [CAUSE]
> > > > > Test case btrfs/143 uses dm-dust device to emulate read errors, this
> > > > > means we can not use _scratch_cycle_mount to cycle mount $SCRATCH_MNT.
> > > > > 
> > > > > As it would go mount $SCRATCH_DEV, not the dm-dust device to
> > > > > $SCRATCH_MNT.
> > > > > This prevents us to trigger read-repair (since no error would be hit)
> > > > > thus fail the test.
> > > > > 
> > > > > [FIX]
> > > > > Since we can mount whatever device at $SCRATCH_MNT, we can not use
> > > > > _scratch_cycle_mount in this case.
> > > > > 
> > > > > Instead implement a small helper to grab the mounted device and its
> > > > > mount options, and use the same device and mount options to cycle
> > > > > $SCRATCH_MNT mount.
> > > > > 
> > > > > This would fix btrfs/143 and hopefully future test cases which use dm
> > > > > devices.
> > > > > 
> > > > > Reported-by: Filipe Manana <fdmanana@suse.com>
> > > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > > ---
> > > > >    common/btrfs | 14 ++++++++++++--
> > > > >    1 file changed, 12 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/common/btrfs b/common/btrfs
> > > > > index 175b33ae..4a02b2cc 100644
> > > > > --- a/common/btrfs
> > > > > +++ b/common/btrfs
> > > > > @@ -601,8 +601,18 @@ _btrfs_buffered_read_on_mirror()
> > > > >    	# The drop_caches doesn't seem to drop every pages on aarch64 with
> > > > >    	# 64K page size.
> > > > >    	# So here as another workaround, cycle mount the SCRATCH_MNT to ensure
> > > > > -	# the cache are dropped.
> > > > > -	_scratch_cycle_mount
> > > > > +	# the cache are dropped, but we can not use _scratch_cycle_mount, as
> > > > > +	# we may mount whatever dm device at SCRATCH_MNT.
> > > > > +	# So here we grab the mounted block device and its mount options, then
> > > > > +	# unmount and re-mount with the same device and options.
> > > > > +	local mount_info=$(_mount | grep "$SCRATCH_MNT")
> > > > > +	if [ -z "$mount_info" ]; then
> > > > > +		_fail "failed to grab mount info of $SCRATCH_MNT"
> > > > > +	fi
> > > > > +	local dev=$(echo $mount_info | $AWK_PROG '{print $1}')
> > > > > +	local opts=$(echo $mount_info | $AWK_PROG '{print $6}' | sed 's/[()]//g')
> > > > 
> > > > The `findmnt` can help to get $dev and $opts:
> > > > 
> > > >     local dev=$(findmnt -n -T $SCRATCH_MNT -o SOURCE)
> > > >     local opts=$(findmnt -n -T $SCRATCH_MNT -o OPTIONS)
> > > > 
> > > > If you hope to check you can keep:
> > > > 
> > > >     if [ -z "$dev" -o -z "$opts" ];then
> > > >             _fail "failed to grab mount info of $SCRATCH_MNT"
> > > >     fi
> > > 
> > > That's really helpful!
> > > 
> > > > 
> > > > > +	_scratch_unmount
> > > > > +	_mount $dev -o $opts $SCRATCH_MNT
> > > > 
> > > > I'm wondering can this help that, after you get the "real" device name:
> > > > 
> > > >     SCRATCH_DEV=$dev _scratch_cycle_mount
> > > 
> > > AFAIK we still need to specify the mount option.
> > > 
> > > As it's possible previous mount is specifying certain mount option
> > > that's not in MOUNT_OPTIONS environment variables.
> > > 
> > > E.g. mounting a specific subvolume or a temporary mount option.
> > > 
> > > Thus I believe we may still need to specific the mount options.
> > 
> > Hmm... if the _scratch_cycle_mount doesn't support dmdust, others dmxxxx
> > (e.g. dmdelay, dmthin, dmerror, dmflaky) have similar problem, right?
> 
> Yes, but my point here is, although "SCRATCH_DEV=$dev
> _scratch_cycle_mount" can work for most cases, it can still miss the
> specific mount option of the current mount.
> 
> Thus we still need to go "_mount $dev -o $opts $SCRATCH_MNT", just for
> the extra mount options.

OK, let's merge this patch to fix this small regression issue at first. Then
I'll think about how to make _scratch_cycle_mount work with dmXXXX in another
patch.

Please send a V2 to use findmnt, I'll merge it in next fstests release.

Thanks,
Zorro

> 
> Thanks,
> Qu
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > >    	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> > > > >    		exec $XFS_IO_PROG \
> > > > >    			-c "pread -b $size $offset $size" $file) ]]; do
> > > > > --
> > > > > 2.39.0
> > > > > 
> > > > 
> > > 
> > 
> 

