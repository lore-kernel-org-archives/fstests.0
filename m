Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265CC18B48C
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 05:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730178712; cv=none; b=rMse0CnA7VHDpZzWMOllgrZAZ0i231ohHO59274HVfuk6fkiBEVSTjISUvVJ/7PZgom+c/vrFzZrYDviipy/xULr+SQEYAdIul8LQUF7dzHDJmwCt2MtX5+/OSM9+ZuPBgoktSfT5DqvxVQGfYI27fthTa4NC14MKtOkrsyTYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730178712; c=relaxed/simple;
	bh=EWt0gTsiYOva1Om7KqwV9M2TJ8G2qSIg6tf9+tSDE4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tV5bodYEvOB2rMGrabFc26fqnQuYUgo+SxbPfz/GAZdG399Qkx8KPWIHoRIyCyJA+0AU3tFGdBUWjK8Q7iTk+if/2sOaDuGnuYcjdDcIQ+Ik050hF/JEdYiLkW+VbwalV51dOeC/HVyPdqYKRx6fTRp9wpgLBx5ooMtdhoChEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbreO6kR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbreO6kR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730178709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdetcuIAhi6+rXL8wWSUGzdrPqoxmssF4q0XQoAaVYg=;
	b=AbreO6kRSQUcONmRotf3/RwxLYIzVPmKb+JzROggrYNxLPPU6PFPk4WB2WJY2J9a18f/4I
	RRmuvLPfotAXrJu0L/XJz0nWcY9Q16tvvcB7E0Eaj6xELga6NNv5bEEsBXMQiGefneqHpa
	RFHi2S27+szT7VBxD3AcguwPFO/F7kU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-QAttwHGhMQ2-q6IR3SatAw-1; Tue, 29 Oct 2024 01:11:46 -0400
X-MC-Unique: QAttwHGhMQ2-q6IR3SatAw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-210d5ea3cf5so16250895ad.0
        for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 22:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730178706; x=1730783506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdetcuIAhi6+rXL8wWSUGzdrPqoxmssF4q0XQoAaVYg=;
        b=C/cmi0f57ABuXSbQSC6zKPvqNJyTnRgxaCut10jufcsyJyjnPWxYWFv/zmtYaZkPNC
         3BEkKzJZucf4o6Pn4Dl0S9HWV6r47ULvwEA4ScIblIDtQOuDF2p2Bd4qNBpX8K2/IaT4
         AqlOUC8mYH0UsgK7SOGiXo8lYtLlkR+2j8lfFbuK+VMwlMmAKov6Pd78eg+RbP3J5/yk
         dvoUB7L71SawHTxSg4zIrz/291xEpebyOHslHpBNAsjdJ3pH5ZRhIhuWh5RIrLqBgtog
         4+wnWNMke4BiRr2olygePB/pIPFNaPAxGO4sRy1uuRzMloQBprph95tfGyU3WBz1ykWX
         5NWQ==
X-Gm-Message-State: AOJu0Yx779DWA0KnEF8+e/52g996MaufGVRTaWey99AuKfIGDFjLG5GE
	b5GmM3/Ps5MTpdcnSil82cNmyDmnxHB6h0foL1TZULFSyopcUjXMzSN8kPbwGfUtRAYWiEO7tsO
	wnA1iAKocZU2pcmfqhQVyljXwE1s81F8CO+Q+LbowyH7Av8YIWX4gHYk=
X-Received: by 2002:a17:902:e887:b0:20b:a409:329 with SMTP id d9443c01a7336-210eccfcd3amr15584655ad.5.1730178705663;
        Mon, 28 Oct 2024 22:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD0RTIZOcu9l6UidN3H6KLgSn5lW49JoUiQ70688odgynMOFNCxlN8NeKw9CfRoWGmb+XLHg==
X-Received: by 2002:a17:902:e887:b0:20b:a409:329 with SMTP id d9443c01a7336-210eccfcd3amr15584465ad.5.1730178705227;
        Mon, 28 Oct 2024 22:11:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc01344fsm58879495ad.137.2024.10.28.22.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:11:44 -0700 (PDT)
Date: Tue, 29 Oct 2024 13:11:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>,
	Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Message-ID: <20241029051141.imqsprphzogzl7f5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241015153957.2099812-1-maharmstone@fb.com>
 <20241028215728.GU21840@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028215728.GU21840@frogsfrogsfrogs>

On Mon, Oct 28, 2024 at 02:57:28PM -0700, Darrick J. Wong wrote:
> On Tue, Oct 15, 2024 at 04:39:34PM +0100, Mark Harmstone wrote:
> > Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
> > race could mean that csums weren't getting written to the log tree,
> > leading to corruption when it was replayed.
> > 
> > The patches to detect log this tree corruption are in btrfs-progs 6.11.
> > 
> > Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> > ---
> > This is a genericized version of the test I originally proposed as
> > btrfs/333.
> > 
> >  tests/generic/757     | 71 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/757.out |  2 ++
> >  2 files changed, 73 insertions(+)
> >  create mode 100755 tests/generic/757
> >  create mode 100644 tests/generic/757.out
> > 
> > diff --git a/tests/generic/757 b/tests/generic/757
> > new file mode 100755
> > index 00000000..6ad3d01e
> > --- /dev/null
> > +++ b/tests/generic/757
> > @@ -0,0 +1,71 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test 757
> > +#
> > +# Test async dio with fsync to test a btrfs bug where a race meant that csums
> > +# weren't getting written to the log tree, causing corruptions on remount.
> > +# This can be seen on subpage FSes on Linux 6.4.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick metadata log recoveryloop
> > +
> > +_fixed_by_kernel_commit e917ff56c8e7 \
> > +	"btrfs: determine synchronous writers from bio or writeback control"
> > +
> > +fio_config=$tmp.fio
> > +
> > +. ./common/dmlogwrites
> > +
> > +_require_scratch
> > +_require_log_writes
> > +
> > +cat >$fio_config <<EOF
> > +[global]
> > +iodepth=128
> > +direct=1
> > +ioengine=libaio
> > +rw=randwrite
> > +runtime=1s
> > +[job0]
> > +rw=randwrite
> > +filename=$SCRATCH_MNT/file
> > +size=1g
> > +fdatasync=1
> > +EOF
> > +
> > +_require_fio $fio_config
> > +
> > +cat $fio_config >> $seqres.full
> > +
> > +_log_writes_init $SCRATCH_DEV
> > +_log_writes_mkfs >> $seqres.full 2>&1
> > +_log_writes_mark mkfs
> > +
> > +_log_writes_mount
> > +
> > +$FIO_PROG $fio_config > /dev/null 2>&1
> > +_log_writes_unmount
> > +
> > +_log_writes_remove
> > +
> > +prev=$(_log_writes_mark_to_entry_number mkfs)
> > +[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
> > +cur=$(_log_writes_find_next_fua $prev)
> > +[ -z "$cur" ] && _fail "failed to locate next FUA write"
> > +
> > +while [ ! -z "$cur" ]; do
> > +	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
> > +
> > +	_check_scratch_fs
> 
> This test fails on xfs because (afaict) replaying the log to $cur
> results in $SCRATCH_DEV being a filesystem with a dirty log; and
> xfs_repair fails when it is given a filesystem with a dirty log.
> 
> I then fixed the test to mount and unmount the filesystem to recovery
> the dirty log before invoking xfs_repair:
> 
> 	# xfs_repair won't run if the log is dirty
> 	if [ $FSTYP = "xfs" ]; then
> 		_scratch_mount
> 		_scratch_unmount
> 	fi

Thanks Darrick, you're right.
I'm wondering can we always do a mount&unmount at here, no matter the
$FSTYP, if that doesn't affect the testing of other filesystems?

> 	_check_scratch_fs
> 
> But now the test takes a very long time to run because (on my system
> anyway) the fio run can initiate 17,000 FUAs, which means that this loop
> runs that many times.  100 iterations takes about 45 seconds, which is
> about two hours.
> 
> Is it necessary to iterate the loop that many times to reproduce
> whatever issue btrfs had?

Yes, it takes much long time on my side too:
 FSTYP         -- ext4
 PLATFORM      -- Linux/x86_64 dell-per750-47 6.12.0-rc4+ #1 SMP PREEMPT_DYNAMIC Fri Oct 25 14:25:45 EDT 2024
 MKFS_OPTIONS  -- -F /dev/sda4
 MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sda4 /mnt/xfstests/scratch

 generic/757        4247s
 Ran: generic/757
 Passed all 1 tests

So better to reduce the testing time as much as possible, and remove it
from the "quick" group. (Maybe we can have a tag to mark those cases need
much long time too).

This patch has been merged into for-next branch, as:

  cf97fa373 generic: add test for missing btrfs csums in log when doing async on subpage vol

Please send another (or other two) patch to fix above 2 problems.

Thanks,
Zorro

> 
> --D
> 
> > +
> > +	prev=$cur
> > +	cur=$(_log_writes_find_next_fua $(($cur + 1)))
> > +	[ -z "$cur" ] && break
> > +done
> > +
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/757.out b/tests/generic/757.out
> > new file mode 100644
> > index 00000000..dfbc8094
> > --- /dev/null
> > +++ b/tests/generic/757.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 757
> > +Silence is golden
> > -- 
> > 2.44.2
> > 
> > 
> 

