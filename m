Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3551E9B22
	for <fstests@vger.kernel.org>; Sun,  2 Mar 2025 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932800; cv=none; b=WlxNvAOnWm6SXjoSW18WKLcvW0DbQ+aPsLViVGPN/TwAXpRviDyYNumeL02WNDJZDuHiZ8OHKFN8HFoR+bDv0m2z+C9eWvEx0+HoaCUHLiJsZIzgWFqE+D+DmvsO0a8+kYYrW+TTazQd1BjkGVvwcHHrXgHNgu7NudzEBAyaD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932800; c=relaxed/simple;
	bh=23NgAlYx62reAu+ggECBlcYsEoTD6+aQkf7BHFHgX74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0Qi4lCPyEQ6ZRtEganYC3VpJFPK0M4TXaqFqBwCg1Xo88diX41u7Tdv95CtM/NIHPuW7+feEq8w7jmKWQSV92Mvo3zEeP1cxg7uBJW/TqNZpGbX+bEO1TIxCipGWO8eo0lORTxNd/71K8Z3JhghjNn3RFDo6TTAOQbB5jqu2dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcVtJzwg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcVtJzwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740932796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mFsVOxiPlqkWz3Et6QfH7t/t+wtS30NQfOu8HYwWikI=;
	b=WcVtJzwgBMumsEvcKBqzu+v4zc0Xwxm7zHwH9ReIePMPhbIIoypNkfFipPOlUN+WGDnVYf
	1tnS+3Lpp6d1ObeczmJ6ya3iXE6hqUBS/oleoB6y5aaOxA9d+7AfDNp6k+1JyXMnzNK7aU
	mnU+FWvr/LkXJ5lpqjPt/9OhPdslXxc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-LJ8aOl4rNqeFu13VmfKt0w-1; Sun, 02 Mar 2025 11:26:15 -0500
X-MC-Unique: LJ8aOl4rNqeFu13VmfKt0w-1
X-Mimecast-MFC-AGG-ID: LJ8aOl4rNqeFu13VmfKt0w_1740932774
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fe9527c041so7388562a91.0
        for <fstests@vger.kernel.org>; Sun, 02 Mar 2025 08:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932774; x=1741537574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFsVOxiPlqkWz3Et6QfH7t/t+wtS30NQfOu8HYwWikI=;
        b=vQF7x1hlfUyBj4a1G/JStB0CqoOQ+6CKJ53tbPclUQ7RlAkxV+ONlvvzY7vzcGyWn4
         j+o9sVjoFbqW0DqKXipXwTO5U60rPzsfMwDt394f92qu3ai0rIrOSZ4UZGxnIsHbdFw3
         H/MelP0jXS6A0SEBpZCWoCTIapMyDDwc6Q54YV3m+fyOGDEZqvlMuoo5aGsLUfy325dq
         pT3jTvTQicUVNEI4I3tMzkpEIe6TqMtfPtnOvpdFAqf8WqQYPHrrkF6mTetkt1uqHRq5
         f5N3S1HA6Qde33DnIrm+1m5C1mj6IpTT60ZiXtYNxGAo782OFAXP1qFkspDNLy6NlQG6
         8zMA==
X-Gm-Message-State: AOJu0Yyhe7fOUznePeLH6igk3D0eV1zCjsoroUK8WmDsIjV5P6+Y3UCl
	6u/qH7t78Xb0cb2d9hOeoF5mdNK6lEnbZ6b3Xy8zUEk6OiueH42SKn2BO8smvT3e/cePL/jNw7D
	RJXGfgYStM0xT5uhyzZ7RkE7whu+VvopycUwpg9iJC5fOUPiLQDecqPI=
X-Gm-Gg: ASbGncsyJGKakBHRD5D/GAIz+TWW03yFTte8P8ifyxexy5+pD6foBFEizwd6KCOl9c3
	1my4nRd9Kdq3imO8+PEASUgwrp0hJ40IQg0kMHFkJO0UWqfnLWAuwFWThrFyrC9wycPBiWd9XGc
	AhdbW1X5VRevhk+DSFBIbJtj8e5hIPpxr7ryIkqDzd/SnKSklWwY9sWSu8eD0jpu8dwMhKAOfzX
	1Je7EicDSMZMCi4WV48qwmu0gUcTYLIsiU31bus6XPAZbZf/H7uN30PIpDXvoAcjjyLEO2nGG/j
	eird1/6jksfYa2Q96na6/hrUGG+OKF6lT124bPYGvKJ7idc8SDv+h5q7
X-Received: by 2002:a05:6a00:3d47:b0:730:8e97:bd76 with SMTP id d2e1a72fcca58-734ac35f72cmr15283543b3a.9.1740932774182;
        Sun, 02 Mar 2025 08:26:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwQUStev++hLjI40uuRdO40fCWFKFinwD42Ng6eXKVVwLxNvtFGiP36q6KtI0ZTuINV/Gtzw==
X-Received: by 2002:a05:6a00:3d47:b0:730:8e97:bd76 with SMTP id d2e1a72fcca58-734ac35f72cmr15283522b3a.9.1740932773837;
        Sun, 02 Mar 2025 08:26:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a62asm7405492b3a.18.2025.03.02.08.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:26:13 -0800 (PST)
Date: Mon, 3 Mar 2025 00:26:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/1] common: test statfs reporting with project quota
Message-ID: <20250302162610.y4l453sjzlw75agr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <173992590656.4080455.15086949489894120802.stgit@frogsfrogsfrogs>
 <173992590675.4080455.17713454161928793525.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173992590675.4080455.17713454161928793525.stgit@frogsfrogsfrogs>

On Tue, Feb 18, 2025 at 05:03:39PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a test to check that statfs on a directory tree with a project
> quota will report the quota limit and available blocks; and that the
> available blocks reported doesn't exceed that of the whole filesystem.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/1955     |  114 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1955.out |   13 +++++
>  2 files changed, 127 insertions(+)
>  create mode 100755 tests/generic/1955
>  create mode 100644 tests/generic/1955.out
> 
> 
> diff --git a/tests/generic/1955 b/tests/generic/1955
> new file mode 100755
> index 00000000000000..e431b3c4e3fd5d
> --- /dev/null
> +++ b/tests/generic/1955
> @@ -0,0 +1,114 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024-2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test No. 1955
> +#
> +# Make sure that statfs reporting works when project quotas are set on a
> +# directory tree.
> +#
> +. ./common/preamble
> +_begin_fstest auto quota
> +
> +_fixed_by_git_commit kernel XXXXXXXXXXXXXX \
> +	"xfs: don't over-report free space or inodes in statvfs"


Ext4 fails on this test [1], is it a known issue of ext4 besides xfs?

Thanks,
Zorro

[1]
FSTYP         -- ext4
PLATFORM      -- Linux/aarch64 hpe-apollo-cn99xx-14-vm-28 6.14.0-rc4+ #1 SMP PREEMPT_DYNAMIC Sat Mar  1 16:57:43 EST 2025
MKFS_OPTIONS  -- -F /dev/vda3
MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/vda3 /mnt/xfstests/scratch

generic/762       - output mismatch (see /var/lib/xfstests/results//generic/762.out.bad)
    --- tests/generic/762.out	2025-03-01 17:23:52.961878242 -0500
    +++ /var/lib/xfstests/results//generic/762.out.bad	2025-03-01 19:13:03.026588012 -0500
    @@ -6,8 +6,10 @@
     root blocks2 is in range
     dir blocks2 is in range
     root bavail2 is in range
    -dir bavail2 is in range
    +dir bavail2 has value of 1821553
    +dir bavail2 is NOT in range 360666.9 .. 367953.1
     root blocks3 is in range
    ...
    (Run 'diff -u /var/lib/xfstests/tests/generic/762.out /var/lib/xfstests/results//generic/762.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      XXXXXXXXXXXXXX xfs: don't over-report free space or inodes in statvfs

Ran: generic/762
Failures: generic/762
Failed 1 of 1 tests

> +
> +. ./common/filter
> +. ./common/quota
> +
> +_require_quota
> +_require_scratch
> +_require_xfs_io_command 'chproj'
> +_require_xfs_io_command "falloc"
> +
> +_scratch_mkfs >$seqres.full 2>&1
> +_scratch_enable_pquota
> +_qmount_option "prjquota"
> +_qmount
> +_force_vfs_quota_testing $SCRATCH_MNT
> +_require_prjquota $SCRATCH_DEV
> +
> +mkdir $SCRATCH_MNT/dir
> +
> +bsize() {
> +	$XFS_IO_PROG -c 'statfs' $1 | grep f_bsize | awk '{print $3}'
> +}
> +
> +blocks() {
> +	$XFS_IO_PROG -c 'statfs' $1 | grep f_blocks | awk '{print $3}'
> +}
> +
> +bavail() {
> +	$XFS_IO_PROG -c 'statfs' $1 | grep f_bavail | awk '{print $3}'
> +}
> +
> +bsize=$(bsize $SCRATCH_MNT)
> +orig_bavail=$(bavail $SCRATCH_MNT)
> +orig_blocks=$(blocks $SCRATCH_MNT)
> +
> +# Set a project quota limit of half the free space, make sure both report the
> +# same number of blocks
> +pquot_limit=$(( orig_bavail / 2 ))
> +setquota -P 55 0 $((pquot_limit * bsize / 1024))K 0 0 $SCRATCH_DEV
> +$XFS_IO_PROG -c 'chproj 55' -c 'chattr +P' $SCRATCH_MNT/dir
> +
> +# check statfs reporting
> +fs_blocks=$(blocks $SCRATCH_MNT)
> +dir_blocks=$(blocks $SCRATCH_MNT/dir)
> +
> +_within_tolerance "root blocks1" $fs_blocks $orig_blocks 1% -v
> +_within_tolerance "dir blocks1" $dir_blocks $pquot_limit 1% -v
> +
> +fs_bavail=$(bavail $SCRATCH_MNT)
> +expected_dir_bavail=$pquot_limit
> +dir_bavail=$(bavail $SCRATCH_MNT/dir)
> +
> +_within_tolerance "root bavail1" $fs_bavail $orig_bavail 1% -v
> +_within_tolerance "dir bavail1" $dir_bavail $expected_dir_bavail 1% -v
> +
> +# use up most of the free space in the filesystem
> +rem_free=$(( orig_bavail / 10 ))	# bsize blocks
> +fallocate -l $(( (orig_bavail - rem_free) * bsize )) $SCRATCH_MNT/a
> +
> +if [ $rem_free -gt $pquot_limit ]; then
> +	echo "rem_free $rem_free greater than pquot_limit $pquot_limit??"
> +fi
> +
> +# check statfs reporting
> +fs_blocks=$(blocks $SCRATCH_MNT)
> +dir_blocks=$(blocks $SCRATCH_MNT/dir)
> +
> +_within_tolerance "root blocks2" $fs_blocks $orig_blocks 1% -v
> +_within_tolerance "dir blocks2" $dir_blocks $pquot_limit 1% -v
> +
> +fs_bavail=$(bavail $SCRATCH_MNT)
> +dir_bavail=$(bavail $SCRATCH_MNT/dir)
> +
> +_within_tolerance "root bavail2" $fs_bavail $rem_free 1% -v
> +_within_tolerance "dir bavail2" $dir_bavail $rem_free 1% -v
> +
> +# use up 10 blocks of project quota
> +$XFS_IO_PROG -f -c "pwrite -S 0x99 0 $((bsize * 10))" -c fsync $SCRATCH_MNT/dir/a >> $seqres.full
> +
> +# check statfs reporting
> +fs_blocks=$(blocks $SCRATCH_MNT)
> +dir_blocks=$(blocks $SCRATCH_MNT/dir)
> +
> +_within_tolerance "root blocks3" $fs_blocks $orig_blocks 1% -v
> +_within_tolerance "dir blocks3" $dir_blocks $pquot_limit 1% -v
> +
> +fs_bavail=$(bavail $SCRATCH_MNT)
> +dir_bavail=$(bavail $SCRATCH_MNT/dir)
> +
> +_within_tolerance "root bavail3" $fs_bavail $rem_free 1% -v
> +_within_tolerance "dir bavail3" $dir_bavail $((rem_free - 10)) 1% -v
> +
> +# final state diagnostics
> +$XFS_IO_PROG -c 'statfs' $SCRATCH_MNT $SCRATCH_MNT/dir | grep statfs >> $seqres.full
> +repquota -P $SCRATCH_DEV >> $seqres.full
> +df $SCRATCH_MNT >> $seqres.full
> +ls -laR $SCRATCH_MNT/ >> $seqres.full
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/1955.out b/tests/generic/1955.out
> new file mode 100644
> index 00000000000000..3601010962193e
> --- /dev/null
> +++ b/tests/generic/1955.out
> @@ -0,0 +1,13 @@
> +QA output created by 1955
> +root blocks1 is in range
> +dir blocks1 is in range
> +root bavail1 is in range
> +dir bavail1 is in range
> +root blocks2 is in range
> +dir blocks2 is in range
> +root bavail2 is in range
> +dir bavail2 is in range
> +root blocks3 is in range
> +dir blocks3 is in range
> +root bavail3 is in range
> +dir bavail3 is in range
> 

