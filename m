Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6914A01
	for <fstests@vger.kernel.org>; Sat,  2 Aug 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754122651; cv=none; b=Ji1Z3Qu5S5FEojlO3SQbSWqJds9va2HsTCGOyvE3dgrjKYbTpx64eZ0CudTtE9FDa6AmmAVEQUAp2BkLnCtO4iechaRhp270YrZdO6ZPUJqTCYeRXwxIufv81pLvkgC/LFXBKBP3APrPJCEQy8dE1z6tO4J1XVd1oc/em8vi4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754122651; c=relaxed/simple;
	bh=+bTjPwWygkPSzZjSgcLsuoB0E33NjDORwx4fmq98jcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIPWGPKj3XYN4lHpSpFHDBoX2xvyKANsef4+BSQLfIJSO7+HprRk7XBEiWZK5zzljSoey3uS/Dfhzu6aT2GtwP3i9PrJbIt2yJqHmkPgrejf/qyVZ6LozSN7I5tjvV2xKnLduUY/iNTZe6nD8+bTNcnCZeIoWZwtBaXKLFitCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=US4L/7wx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US4L/7wx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754122648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbGs+b2J6CzO5C+vKrD5OJKa3yII4cRgu9lxec7mH+0=;
	b=US4L/7wx2e5xCR1+lmVCuoFBDmPJUVlbXG4hhH4cNrKGBb1V97IAny2mJLWW9jA1mISTz7
	Yr1k50COZpvhONqwtBFxTuUfObh7Rx6e/yKrsVHtddogwo32+ryqSmh2TjaHQlyWbOSavl
	Motosh9vkqdpAFgjk9qrXZXLRbChRc8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-vYtnyP9pMXy6tU1C6SskWQ-1; Sat, 02 Aug 2025 04:17:27 -0400
X-MC-Unique: vYtnyP9pMXy6tU1C6SskWQ-1
X-Mimecast-MFC-AGG-ID: vYtnyP9pMXy6tU1C6SskWQ_1754122646
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b321087b1cdso3303167a12.2
        for <fstests@vger.kernel.org>; Sat, 02 Aug 2025 01:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754122646; x=1754727446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbGs+b2J6CzO5C+vKrD5OJKa3yII4cRgu9lxec7mH+0=;
        b=bnRqlFA81RqZ+wQTdO8duoE1KrdIiPBM51SwDlz0j1NVlGYgZu2n4aW1Sql6mSubT/
         7JhkXXibZ68AVqeoj/FN5mUJuQ3lgm4dofvYEfdDGl37pxnl3KYZmg8V0HBCzV6LP8Nd
         gI2mssZ2VvZzKgb60/QqaGMRz9wmoQDgZDshhwkesH6qJdWp/5f7OVXeieqg3RJ0g5ho
         16MY/e14POZ47kp6pJ0wRHr/i6Lae/a/b7vY5iieGyrx7cqdSmS332kB/D7B4hxBZnD8
         /vhOZsfeJuBWqe8I34OV+RDTT+nCqWkqtOO3IxFPe0XT85iVDB67AJ2rgyxKSUeEYUNJ
         mnIQ==
X-Gm-Message-State: AOJu0YygazdafsvM3eF6oMFo8Ek0uYHr0Qcs6MYgoL7mZ+mo13uorXB6
	rLwsJhpIEJbJh/0kiYRSBL63zGaP/7gtvOIMLRuPhkD6rLKPILgApU7O4sF5t46OpbsSd6r2rSU
	6sEx7Vd91QjYfSZ/Fbh+yf7rr+g1Vop2cK7Lf2CLkehZPMbQnzKWwU/QnV7YSiluYuHo=
X-Gm-Gg: ASbGncsiFLjZtPjAIdkgwoOSFjulilI0RnRlaA8EiHwUTlsmcQoBRUJOw9Nf8v38Wfe
	vSu3nimq8l2UGB/prJxmkFOX1kkGqn2Nc1UUBFnQuSSEFLcsvX6omfz6nsGa2wUqDC7+u1c1AF7
	A5HScwkf1QOraGMXpuNn0ycWhUKa21rjYwJVP837HFTpcP75u0omD2IDcx9TKBktSURiJXzyRW2
	/SxP5mR5VvcVXxlRFgv3RbVAiF3gubjUxLdMAe5KPfhZeVlvWFv0czeMReorZeqnNMAlMR8aFXR
	WN/OjeMYED6lso6K/uUwZQWUJdyHQj0PLvG1vLmRmjAn8sao0kWYa40EUpqJnuZVP70CNr1nUAV
	DmOoc
X-Received: by 2002:a17:90b:5487:b0:31a:9004:899d with SMTP id 98e67ed59e1d1-3211628f2d8mr4162956a91.18.1754122645690;
        Sat, 02 Aug 2025 01:17:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbQ3gTKeNrSDrK0ZAVQ8tCb3jpX+xVLMbXhLWiAIN7Ok4FuIhPbbqG9vHeIB/c43q3WKcbTA==
X-Received: by 2002:a17:90b:5487:b0:31a:9004:899d with SMTP id 98e67ed59e1d1-3211628f2d8mr4162922a91.18.1754122645258;
        Sat, 02 Aug 2025 01:17:25 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b434sm9379747a91.28.2025.08.02.01.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 01:17:24 -0700 (PDT)
Date: Sat, 2 Aug 2025 16:17:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/2] generic: Add integrity tests for O_DSYNC and RWF_DSYNC
 writes
Message-ID: <20250802081719.qrmme5jvwliwlgcg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
 <9b2427b42e8716c359a36624fd6363f71583941b.1753964363.git.ritesh.list@gmail.com>
 <20250801201805.6h7sa2oyrvhnalph@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <87plderdk1.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plderdk1.fsf@gmail.com>

On Sat, Aug 02, 2025 at 01:59:18AM +0530, Ritesh Harjani wrote:
> Zorro Lang <zlang@redhat.com> writes:
> 
> > On Thu, Jul 31, 2025 at 06:05:55PM +0530, Ritesh Harjani (IBM) wrote:
> >> This test verifies the data & required metadata (e.g. inode i_size for extending
> >> writes) integrity when using O_DSYNC and RWF_DSYNC during writes operations,
> >> across buffered-io, aio-dio and dio, in the event of a sudden filesystem
> >> shutdown after write completion.
> >> 
> >> Man page of open says that -
> >> O_DSYNC provides synchronized I/O data integrity completion, meaning
> >> write operations will flush data to the underlying hardware, but will
> >> only flush metadata updates that are required to allow a subsequent read
> >> operation to complete successfully.
> >> 
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  tests/generic/737     | 30 +++++++++++++++++++++++++++++-
> >>  tests/generic/737.out | 21 +++++++++++++++++++++

BTW, as you change a testcase with known case number, your subject can be
"generic/737: ..." (instead of "generic: ...").

> >>  2 files changed, 50 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/tests/generic/737 b/tests/generic/737
> >> index 99ca1f39..0f27c82b 100755
> >> --- a/tests/generic/737
> >> +++ b/tests/generic/737
> >> @@ -4,7 +4,8 @@
> >>  #
> >>  # FS QA Test No. 737
> >>  #
> >> -# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown.
> >> +# Integrity test for O_[D]SYNC and/or RWF_DSYNC with buff-io, dio, aio-dio with
> >> +# sudden shutdown.
> >>  # Based on a testcase reported by Gao Xiang <hsiangkao@linux.alibaba.com>
> >>  #
> >> 
> >> @@ -21,6 +22,15 @@ _require_aiodio aio-dio-write-verify
> >>  _scratch_mkfs > $seqres.full 2>&1
> >>  _scratch_mount
> >> 
> >> +echo "T-0: Create a 1M file using buff-io & RWF_DSYNC"
> >> +$XFS_IO_PROG -f -c "pwrite -V 1 -D -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
> >> +echo "T-0: Shutdown the fs suddenly"
> >> +_scratch_shutdown
> >> +echo "T-0: Cycle mount"
> >> +_scratch_cycle_mount
> >> +echo "T-0: File contents after cycle mount"
> >> +_hexdump $SCRATCH_MNT/testfile.t1
> >> +
> >>  echo "T-1: Create a 1M file using buff-io & O_SYNC"
> >>  $XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
> >>  echo "T-1: Shutdown the fs suddenly"
> >> @@ -48,5 +58,23 @@ _scratch_cycle_mount
> >>  echo "T-3: File contents after cycle mount"
> >>  _hexdump $SCRATCH_MNT/testfile.t3
> >> 
> >> +echo "T-4: Create a 1M file using DIO & RWF_DSYNC"
> >> +$XFS_IO_PROG -fdc "pwrite -V 1 -S 0x5a -D 0 1M" $SCRATCH_MNT/testfile.t4 > /dev/null 2>&1
> >> +echo "T-4: Shutdown the fs suddenly"
> >> +_scratch_shutdown
> >> +echo "T-4: Cycle mount"
> >> +_scratch_cycle_mount
> >> +echo "T-4: File contents after cycle mount"
> >> +_hexdump $SCRATCH_MNT/testfile.t4
> >> +
> >> +echo "T-5: Create a 1M file using AIO-DIO & O_DSYNC"
> >> +$AIO_TEST -a size=1048576 -D -N $SCRATCH_MNT/testfile.t5 > /dev/null 2>&1
> >> +echo "T-5: Shutdown the fs suddenly"
> >> +_scratch_shutdown
> >> +echo "T-5: Cycle mount"
> >> +_scratch_cycle_mount
> >> +echo "T-5: File contents after cycle mount"
> >> +_hexdump $SCRATCH_MNT/testfile.t5
> >
> > I always hit "No such file or directory" [1], is this an expected test failure
> > which you hope to uncover?
> 
> Yes, we will need this fix [1] from Jan. Sorry I missed to add that in the commit
> message. Could you please give it a try with the fix maybe?

Sure, with this patch, this test passed on my side:
  FSTYP         -- xfs (debug)
  PLATFORM      -- Linux/x86_64 dell-per750-41 6.16.0-mainline+ #9 SMP PREEMPT_DYNAMIC Sat Aug  2 16:01:22 CST 2025
  MKFS_OPTIONS  -- -f /dev/mapper/testvg-scratch--devA
  MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratch--devA /mnt/scratch

  generic/737 4s ...  9s
  Ran: generic/737
  Passed all 1 tests

So this "No such file or directory" failure is a known bug, and this patch trys to
uncover it. You didn't metion that, so I thought you just try to write a
new integrity test (rather than a regression test) :-D If this change uncover a known
fix, please feel free to add _fixed_by_kernel_commit.

BTW, I saw you mark this patchset with "RFC", do you need to change it more?
Generally I won't merge RFC patches directly, although this patch looks good to
me. So when you think you've gotten enough review points, please feel free to
remove the "RFC" label and resend it :) Then ...

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
> [1]:
> https://lore.kernel.org/linux-fsdevel/20250730102840.20470-2-jack@suse.cz/
> 
> -ritesh
> 
> 
> >
> > [1]
> > # diff -u /root/git/xfstests/tests/generic/737.out /root/git/xfstests/results//generic/737.out.bad
> > --- /root/git/xfstests/tests/generic/737.out    2025-08-02 04:04:57.334489725 +0800
> > +++ /root/git/xfstests/results//generic/737.out.bad     2025-08-02 04:12:08.167934723 +0800
> > @@ -28,16 +28,14 @@
> >  *
> >  100000
> >  T-4: Create a 1M file using DIO & RWF_DSYNC
> >  T-4: Shutdown the fs suddenly
> >  T-4: Cycle mount
> >  T-4: File contents after cycle mount
> > -000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> > -*
> > -100000
> > +od: /mnt/scratch/testfile.t4: No such file or directory
> >  T-5: Create a 1M file using AIO-DIO & O_DSYNC
> >  T-5: Shutdown the fs suddenly
> >  T-5: Cycle mount
> >  T-5: File contents after cycle mount
> > -000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> > -*
> > -100000
> > +od: /mnt/scratch/testfile.t5: No such file or directory
> >
> >> +
> >>  status=0
> >>  exit
> >> diff --git a/tests/generic/737.out b/tests/generic/737.out
> >> index efe6ff1f..2bafeefa 100644
> >> --- a/tests/generic/737.out
> >> +++ b/tests/generic/737.out
> >> @@ -1,4 +1,11 @@
> >>  QA output created by 737
> >> +T-0: Create a 1M file using buff-io & RWF_DSYNC
> >> +T-0: Shutdown the fs suddenly
> >> +T-0: Cycle mount
> >> +T-0: File contents after cycle mount
> >> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> >> +*
> >> +100000
> >>  T-1: Create a 1M file using buff-io & O_SYNC
> >>  T-1: Shutdown the fs suddenly
> >>  T-1: Cycle mount
> >> @@ -20,3 +27,17 @@ T-3: File contents after cycle mount
> >>  000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> >>  *
> >>  100000
> >> +T-4: Create a 1M file using DIO & RWF_DSYNC
> >> +T-4: Shutdown the fs suddenly
> >> +T-4: Cycle mount
> >> +T-4: File contents after cycle mount
> >> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> >> +*
> >> +100000
> >> +T-5: Create a 1M file using AIO-DIO & O_DSYNC
> >> +T-5: Shutdown the fs suddenly
> >> +T-5: Cycle mount
> >> +T-5: File contents after cycle mount
> >> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> >> +*
> >> +100000
> >> --
> >> 2.49.0
> >> 
> >> 
> 

