Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E95D2E4
	for <fstests@vger.kernel.org>; Tue,  7 Nov 2023 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9T91YsT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C7710CE
	for <fstests@vger.kernel.org>; Tue,  7 Nov 2023 00:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699344330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hvGQnhU2ZFAAplXg33YoO0DUkXYNC/77vLwpFjqZ8GM=;
	b=R9T91YsTowbZ/mr/xPqHZSCPKW0D5FQoT3Z05jtO1gB268x69rjjLb00LjdfWl8bfb0CBW
	harYVy/t6W8+KMBo9TwMm5D3gS9s3hdgX6aSN5fGZvHpVb9fHZa8441p7o4mRNdnXtyUdx
	UyPMF1n65I/VLCjEDQxqgc+mbbge45c=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-rtcQOQ6vPhae6Al5D8_NJw-1; Tue, 07 Nov 2023 03:05:28 -0500
X-MC-Unique: rtcQOQ6vPhae6Al5D8_NJw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5bd26ef66d1so4295008a12.2
        for <fstests@vger.kernel.org>; Tue, 07 Nov 2023 00:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344327; x=1699949127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvGQnhU2ZFAAplXg33YoO0DUkXYNC/77vLwpFjqZ8GM=;
        b=xDr4sbSGWLxw7r+at76Prmdkh+o4NIS64s2ja22KdwZU3Zsq3N4AkEjDyI1jdTBO1H
         9PUSF8f6T4iOQiNSSL7OR1p0Uyp/NaDoZQLHyvX0z39i0Wj0VtCkwj6/vpfQ5qt9dX7K
         5bIvmhYfcnVFD2UX9IvvfvHPePk1g0sc5aLHBEFM6gE9ErxWAqUsN+wJ+r9qTwlD9DRb
         yE1JSI8NLlVNz5EdPnO9pwQp+/zrmW2mVIznT4vy6ws6Tc6yUKktWm87R+tMe89s4XUL
         iuws9qwvaQ5ZujrqpAOcExMW6ee9Dokmn0XbpLWyQ7kYhvWVXGhJchBs6TqzMyzKpVod
         oSqQ==
X-Gm-Message-State: AOJu0YyOQlEqBmtIJiTeaViflAANCfLyZiBM6MHDI1Xc8IiUBy7suQxs
	uxXRMkzaVT7Vb5ta+J/RJpJv78tDU6zuswVwcWNfh16jPjAkJg82JhzbxdoXy5tyfiCrSTG3xxj
	OhLAMDw8/DeVXrkD5BQ==
X-Received: by 2002:a05:6a20:8427:b0:16c:b95c:6d35 with SMTP id c39-20020a056a20842700b0016cb95c6d35mr41845298pzd.50.1699344327351;
        Tue, 07 Nov 2023 00:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH980ifGnKjDIgKdIi5O7KljqP2XZF7ItZOrbzXUCgeMLbR1ZihkwU7tpKmmio84dhRLFsRvw==
X-Received: by 2002:a05:6a20:8427:b0:16c:b95c:6d35 with SMTP id c39-20020a056a20842700b0016cb95c6d35mr41845274pzd.50.1699344326960;
        Tue, 07 Nov 2023 00:05:26 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w19-20020aa78593000000b006b4ac8885b4sm6940918pfn.14.2023.11.07.00.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:05:26 -0800 (PST)
Date: Tue, 7 Nov 2023 16:05:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <carlos@maiolino.me>
Subject: Re: [Bug report][fstests generic/047] Internal error !(flags &
 XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.
 Caller xfs_dabuf_map.constprop.0+0x26c/0x368 [xfs]
Message-ID: <20231107080522.5lowalssbmi6lus3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231029041122.bx2k7wwm7otebjd5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUiECgUWZ/8HKi3k@dread.disaster.area>
 <20231106192627.ilvijcbpmp3l3wcz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZUlNroz8l5h1s1oF@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUlNroz8l5h1s1oF@dread.disaster.area>

On Tue, Nov 07, 2023 at 07:33:50AM +1100, Dave Chinner wrote:
> On Tue, Nov 07, 2023 at 03:26:27AM +0800, Zorro Lang wrote:
> > On Mon, Nov 06, 2023 at 05:13:30PM +1100, Dave Chinner wrote:
> > > On Sun, Oct 29, 2023 at 12:11:22PM +0800, Zorro Lang wrote:
> > > > Hi xfs list,
> > > > 
> > > > Recently I always hit xfs corruption by running fstests generic/047 [1], and
> > > > it show more failures in dmesg[2], e.g:
> > > 
> > > OK, g/047 is an fsync test.
> > > 
> > > > 
> > > >   XFS (loop1): Internal error !(flags & XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.  Caller xfs_dabuf_map.constprop.0+0x26c/0x368 [xfs]
> > > 
> > > Ok, a directory block index translated to a hole in the file
> > > mapping. That's bad...
> ....
> > > > _check_xfs_filesystem: filesystem on /dev/loop1 is inconsistent (r)
> > > > *** xfs_repair -n output ***
> > > > Phase 1 - find and verify superblock...
> > > > Phase 2 - using internal log
> > > >         - zero log...
> > > >         - scan filesystem freespace and inode maps...
> > > >         - found root inode chunk
> > > > Phase 3 - for each AG...
> > > >         - scan (but don't clear) agi unlinked lists...
> > > >         - process known inodes and perform inode discovery...
> > > >         - agno = 0
> > > > bad nblocks 9 for inode 128, would reset to 0
> > > > no . entry for directory 128
> > > > no .. entry for root directory 128
> > > > problem with directory contents in inode 128
> > > > would clear root inode 128
> > > > bad nblocks 8 for inode 131, would reset to 0
> > > > bad nblocks 8 for inode 132, would reset to 0
> > > > bad nblocks 8 for inode 133, would reset to 0
> > > > ...
> > > > bad nblocks 8 for inode 62438, would reset to 0
> > > > bad nblocks 8 for inode 62439, would reset to 0
> > > > bad nblocks 8 for inode 62440, would reset to 0
> > > > bad nblocks 8 for inode 62441, would reset to 0
> > > 
> > > Yet all the files - including the data files that were fsync'd - are
> > > all bad.
> > > 
> > > Aparently the journal has been recovered, but lots of metadata
> > > updates that should have been in the journal are missing after
> > > recovery has completed? That doesn't make a whole lot of sense -
> > > when did these tests start failing? Can you run a bisect?
> > 
> > Hi Dave,
> > 
> > Thanks for your reply :) I tried to do a kernel bisect long time, but
> > find nothing ... Then suddently, I found it's failed from a xfsprogs
> > change [1].
> > 
> > Although that's not the root cause of this bug (on s390x), it just
> > enabled "nrext64" by default, which I never tested on s390x before.
> > For now, we know this's an issue about this feature, and only on
> > s390x for now.
> 
> That's not good. Can you please determine if this is a zero-day bug
> with the nrext64 feature? I think it was merged in 5.19, so if you
> could try to reproduce it on a 5.18 and 5.19 kernels first, that
> would be handy.

Unfortunately, it's a bug be there nearly from beginning. The linux v5.19
can trigger this bug (with latest xfsprogs for-next branch):

FSTYP         -- xfs (debug)
PLATFORM      -- Linux/s390x s390x-kvm-026 5.19.0 #1 SMP Tue Nov 7 00:44:49 EST 2023
MKFS_OPTIONS  -- -f -m crc=1,finobt=1,rmapbt=0,reflink=1,bigtime=1,inobtcount=1 /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/fstests/SCRATCH_DIR

generic/047       _check_xfs_filesystem: filesystem on /dev/loop1 failed scrub
(see /var/lib/xfstests/results//generic/047.full for details)
_check_xfs_filesystem: filesystem on /dev/loop1 is inconsistent (r)
(see /var/lib/xfstests/results//generic/047.full for details)
_check_dmesg: something found in dmesg (see /var/lib/xfstests/results//generic/047.dmesg)
- output mismatch (see /var/lib/xfstests/results//generic/047.out.bad)
    --- tests/generic/047.out	2023-11-07 01:18:41.687291490 -0500
    +++ /var/lib/xfstests/results//generic/047.out.bad	2023-11-07 01:19:32.237271471 -0500
    @@ -1 +1,1000 @@
     QA output created by 047
    +file /mnt/fstests/SCRATCH_DIR/1 missing - fsync failed
    +file /mnt/fstests/SCRATCH_DIR/2 missing - fsync failed
    +file /mnt/fstests/SCRATCH_DIR/3 missing - fsync failed
    +file /mnt/fstests/SCRATCH_DIR/4 missing - fsync failed
    +file /mnt/fstests/SCRATCH_DIR/5 missing - fsync failed
    +file /mnt/fstests/SCRATCH_DIR/6 missing - fsync failed
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/047.out /var/lib/xfstests/results//generic/047.out.bad'  to see the entire diff)
Ran: generic/047
Failures: generic/047
Failed 1 of 1 tests

  [  252.399348] XFS (loop1): Corruption detected. Unmount and run xfs_repair
  [  252.399349] XFS (loop1): xfs_dabuf_map: bno 8388608 inode 128
  [  252.399351] XFS (loop1): [00] br_startoff 8388608 br_startblock -2 br_blockcount 1 br_state 0
  [  252.399367] XFS (loop1): Internal error !(flags & XFS_DABUF_MAP_HOLE_OK) at line 2572 of file fs/xfs/libxfs/xfs_da_btree.c.  Caller xfs_dabuf_map.constprop.0+0x26c/0x370 [xfs]
  [  252.399452] CPU: 1 PID: 129486 Comm: 047 Kdump: loaded Not tainted 5.19.0 #1
  [  252.399454] Hardware name: IBM 8561 LT1 400 (KVM/Linux)
  [  252.399455] Call Trace:
  [  252.399469]  [<000000010fe8b17a>] dump_stack_lvl+0x62/0x80 
  [  252.399471]  [<000003ff8021e3c0>] xfs_corruption_error+0x70/0xa0 [xfs] 
  [  252.399561]  [<000003ff801dcbd6>] xfs_dabuf_map.constprop.0+0x2a6/0x370 [xfs] 
  [  252.399646]  [<000003ff801df1ce>] xfs_da_read_buf+0x6e/0x130 [xfs] 
  [  252.399731]  [<000003ff801df2d0>] xfs_da3_node_read+0x40/0x80 [xfs] 
  [  252.399816]  [<000003ff801e0732>] xfs_da3_node_lookup_int+0x82/0x560 [xfs] 
  [  252.399900]  [<000003ff801f08de>] xfs_dir2_node_lookup+0x3e/0x150 [xfs] 
  [  252.399986]  [<000003ff801e49de>] xfs_dir_lookup+0x1ee/0x220 [xfs] 
  [  252.400071]  [<000003ff80235da0>] xfs_lookup+0x60/0x110 [xfs] 
  [  252.400161]  [<000003ff802310b2>] xfs_vn_lookup+0x62/0xa0 [xfs] 
  [  252.400251]  [<000000010f86eb7a>] __lookup_slow+0x9a/0x170 
  [  252.400253]  [<000000010f87381a>] walk_component+0x14a/0x1e0 
  [  252.400255]  [<000000010f874098>] path_lookupat+0x88/0x1f0 
  [  252.400257]  [<000000010f87569a>] filename_lookup+0xaa/0x1a0 
  [  252.400259]  [<000000010f866a66>] vfs_statx+0x86/0x120 
  [  252.400261]  [<000000010f866da4>] vfs_fstatat+0x74/0xa0 
  [  252.400263]  [<000000010f867038>] __do_sys_newfstatat+0x28/0x50 
  [  252.400264]  [<000000010fe8eeb0>] __do_syscall+0x1d0/0x200 
  [  252.400266]  [<000000010fe9d6c2>] system_call+0x82/0xb0 


And the v5.18 doesn't support this feature, so ...

 [   95.265522] XFS (loop0): Superblock has unknown incompatible features (0x20) enabled.
 [   95.265533] XFS (loop0): Filesystem cannot be safely mounted by this kernel.
 [   95.265535] XFS (loop0): SB validate failed with error -22.

If you need, tell me which commit (list) is the beginning we support
this feature. Or which commit you feel it's dangerous, I can give it
a specific testing.

Thanks,
Zorro

> 
> Also, from your s390 kernel build, can you get the pahole output
> for the struct xfs_dinode both for a good kernel and a bad kernel?
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

