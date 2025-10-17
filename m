Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8F333452
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 20:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732757; cv=none; b=gSesXu3++2if+iYfufof+tLIW/iEFWge4pQMde7K/HNv/mjn/TIoFnAV6V7YKx7uLKKshYnNFHUN0JhV3V2HJ6h2ggeqX7+MDy4guuSe+BE4MKheW2uAGkpLNPIshLYf1gHSZDiub1dKQAch2J3AC4B2UjZFTQHGZjKJuk5/spo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732757; c=relaxed/simple;
	bh=jM5A3TelHkeicjfx+wxJIKYR3jCvvcb2IvEl8LyEalw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMwgzy+JIr1wISYxJMCCV0DeoCGXVT4WfbSQxIxzRDvuJRR3qcptbwUmBoalm0D65+kn+gVccDerzgcW2UpJD9r4eL7C/zsxTcIvz0d7TtGBIrBkdyY7lhIfDYJum/OL6xsSGMk6dj8xOYfJwp4cabTXd7gI/vuvb7KH90LYtUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbIRHnbV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbIRHnbV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760732754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SC+5NC1S5pdFEKz3wHqgv0vTb+teR0zOymxzWocp7FQ=;
	b=DbIRHnbVX/Z08LtPqG/OECf7DBYLjPihzxx3ATNYHIdt35OlKIED8hQhXOydCWkyKRWcGx
	IfrhWMU9Jsp8xTNme/GEBNJISKiKaHn7r1hJzzobaztlucTNbidoredwUY7TSEr0qtrC1L
	VsWy1zU4HsLA01TVdanLxRH0Gd99sKc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-9WsrYgvHOdaC7lV8DtSxRQ-1; Fri, 17 Oct 2025 16:25:51 -0400
X-MC-Unique: 9WsrYgvHOdaC7lV8DtSxRQ-1
X-Mimecast-MFC-AGG-ID: 9WsrYgvHOdaC7lV8DtSxRQ_1760732750
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2909e6471a9so18054605ad.0
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 13:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732750; x=1761337550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SC+5NC1S5pdFEKz3wHqgv0vTb+teR0zOymxzWocp7FQ=;
        b=rUa6MhjD6pWU+AschoKMGFARBqevGaaUisck6JokFSbZtas6/L9OlltoB+KHFqxpbO
         XkvS30OEC8iAtwOxS+zQM1s/byO/6rM7srAnscgOqumT1n8tYtkGBZjw2gUTcfG+WsgF
         GGnC6hzQTUjq+ER0E0agKG7mSggZiVG6Qw4c4eupRINBryQ49uBX98NGrDOyh+jhdc9H
         KDtZkOQy6It9JaVqotcKeGZtMTydXYjesWCcHF0eQIsPAPEEN4F7TW8fY0gOm+J1ieR+
         Cu8QMmreUK0OSohqe2pyrDvOYZoo7ctPB7K1x9cZB4oYG2qUn/gdywuNxQisLG2ayiq6
         s/vA==
X-Gm-Message-State: AOJu0YwCBY+Us9QL7VMRXnHOlj/lYcqzrlPokY3alG9TxWEg8CbQJTvC
	lOwFDEgtWaa2YwGiWJbo4LCAAMLoO3oZewSmQ2uCreFzq5XMee7BJPjaFMj40fbmUxxKJO9RZu/
	KZFnhSW/+Ufct6ebjJ9PUUtj8cp/9LC3NDN47Vwfvw+VWlYos11BaFQ2EVs0=
X-Gm-Gg: ASbGncv8AjYbWVPmkl6ujinEtxmmAZeq/MHHg8IXBFMEur3k6rTMHbRgEFmZgM2rhtp
	6OHflgXt2f5fh0r3YCmfb4/9yho72dyBh2VzR7PHALN02wb/+ES2CGzH9z2Pmhl0M6wuUUEmmiC
	gJ8X6vPvWJwCwwjHaJ3JhdwKyf/eMkpG3LV1f+gIh2DuzMdWuxYRXkNmRBDGpec37h7IX9dO/R+
	jH3qMvwVuG3470mQr7QMllTY8/131EPI8ZBPV7AoNV9CvzHdrSR0XGPyPc3bQt8wGQc/JRFVeNm
	cu/1P8uA0zriTJI1t5RMpWQ4cCKACzFQL7cCku46AYrfXgzqt1xmIyccDH2InN8M1PU+F7R9ZV1
	r87/vuS+HAztep7IdQkovV20Z84+6T4hMlzJrzXM=
X-Received: by 2002:a17:903:1a4c:b0:267:ba92:4d19 with SMTP id d9443c01a7336-290c99a8ed3mr63606635ad.0.1760732749972;
        Fri, 17 Oct 2025 13:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxfxr0prdBShKiiD3OH0xFK8B3tzOOnqVQzoTfYO6FzFCXRk2P6WQVkDGH421mM7plLtUZuA==
X-Received: by 2002:a17:903:1a4c:b0:267:ba92:4d19 with SMTP id d9443c01a7336-290c99a8ed3mr63606425ad.0.1760732749517;
        Fri, 17 Oct 2025 13:25:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292472197e9sm3835075ad.116.2025.10.17.13.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:25:48 -0700 (PDT)
Date: Sat, 18 Oct 2025 04:25:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: ethanwu <ethanwu@synology.com>
Cc: fstests@vger.kernel.org, ceph-devel@vger.kernel.org,
	Slava.Dubeyko@ibm.com, ethan198912@gmail.com
Subject: Re: [PATCH v3] ceph/006: test snapshot data integrity after punch
 hole operations
Message-ID: <20251017202544.3a5es5j57r6ifkwd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251009093129.2437815-1-ethanwu@synology.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009093129.2437815-1-ethanwu@synology.com>

On Thu, Oct 09, 2025 at 05:31:29PM +0800, ethanwu wrote:
> Add test to verify that Ceph snapshots preserve original file data
> when the live file is modified with punch hole operations. The test
> creates a file, takes a snapshot, punches multiple holes in the
> original file, then verifies the snapshot data remains unchanged.
> 
> Signed-off-by: ethanwu <ethanwu@synology.com>
> ---
>  v1->v2: previous version is 'ceph/006: test snapshot data integrity
>  after punch hole'.
>     1. move it to generic and add _require_snapshot check.
>     2. modify punch hole offset/len to be 64K aligned
>  v2->v3:
>     1. move test back to ceph specific since it uses ceph snapshot API.
>     2. support custom snapdirname mount option.
>     3. add _ceph_remove_snapshot and _ceph_create_snapshot functions.
> 
> ---

Thanks for your update :) I'm not familiar with ceph, so I'll try to review
this patch from fstests side. Welcome ceph list provide more review points :)

>  common/ceph        | 76 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ceph/006     | 58 +++++++++++++++++++++++++++++++++++
>  tests/ceph/006.out |  2 ++
>  3 files changed, 136 insertions(+)
>  create mode 100755 tests/ceph/006
>  create mode 100644 tests/ceph/006.out
> 
> diff --git a/common/ceph b/common/ceph
> index df7a6814..6a19527e 100644
> --- a/common/ceph
> +++ b/common/ceph
> @@ -38,3 +38,79 @@ _ceph_get_client_id()
>  {
>  	$GETFATTR_PROG --only-values -n "ceph.client_id" $TEST_DIR 2>/dev/null
>  }
> +
> +# Get the snapshot directory name from mount options
> +# Defaults to ".snap" if snapdirname option is not set
> +_ceph_get_snapdirname()
> +{
> +	local mnt_point=$1
> +	local snapdirname
> +
> +	# Extract snapdirname from mount options
> +	snapdirname=$(findmnt -n -o OPTIONS "$mnt_point" | grep -o 'snapdirname=[^,]*' | cut -d'=' -f2)
> +
> +	# Default to .snap if not set
> +	if [ -z "$snapdirname" ]; then
> +		echo ".snap"
> +	else
> +		echo "$snapdirname"
> +	fi
> +}
> +
> +# Create a CephFS snapshot
> +# _ceph_create_snapshot <directory_path> <snapshot_name>
> +# Creates a snapshot under <directory_path>/.snap/<snapshot_name>
> +# or <directory_path>/<custom_snapdir>/<snapshot_name> if snapdirname is set
> +_ceph_create_snapshot()
> +{
> +	local dir_path=$1
> +	local snap_name=$2
> +	local snapdirname
> +	local snapdir
> +	local mnt_point
> +
> +	if [ -z "$dir_path" ] || [ -z "$snap_name" ]; then
> +		echo "Usage: _ceph_create_snapshot <directory_path> <snapshot_name>"
> +		return 1
> +	fi
> +
> +	# Find the mount point for this directory
> +	mnt_point=$(df -P "$dir_path" | tail -1 | awk '{print $NF}')
> +	snapdirname=$(_ceph_get_snapdirname "$mnt_point")
> +	snapdir="$dir_path/$snapdirname/$snap_name"
> +
> +	mkdir "$snapdir" || return 1
> +	echo "$snapdir"
> +}
> +
> +# Remove a CephFS snapshot
> +# _ceph_remove_snapshot <directory_path> <snapshot_name>
> +_ceph_remove_snapshot()
> +{
> +	local dir_path=$1
> +	local snap_name=$2
> +	local snapdirname
> +	local snapdir
> +	local mnt_point
> +
> +	if [ -z "$dir_path" ] || [ -z "$snap_name" ]; then
> +		echo "Usage: _ceph_remove_snapshot <directory_path> <snapshot_name>"
> +		return 1
> +	fi
> +
> +	# Find the mount point for this directory
> +	mnt_point=$(df -P "$dir_path" | tail -1 | awk '{print $NF}')
> +	snapdirname=$(_ceph_get_snapdirname "$mnt_point")
> +	snapdir="$dir_path/$snapdirname/$snap_name"
> +
> +	rmdir "$snapdir" 2>/dev/null

What if the snapdir can't be removed? Is that possible?

> +}
> +
> +# this test requires ceph snapshot support
> +_require_ceph_snapshot()
> +{
> +	local snapdirname=$(_ceph_get_snapdirname "$TEST_DIR")
> +	local test_snapdir="$TEST_DIR/$snapdirname/test_snap_$$"
> +	mkdir "$test_snapdir" 2>/dev/null || _notrun "Ceph snapshots not supported (requires fs flag 'allow_snaps' and client auth capability 'snap')"

Is "$snapdirname" created before calling this function? Do we need "-p" option?

> +	rmdir "$test_snapdir"
> +}
> diff --git a/tests/ceph/006 b/tests/ceph/006
> new file mode 100755
> index 00000000..a5af6ca3
> --- /dev/null
> +++ b/tests/ceph/006
> @@ -0,0 +1,58 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2025 Synology All Rights Reserved.
> +#
> +# FS QA Test No. ceph/006
> +#
> +# Test that snapshot data remains intact after punch hole operations
> +# on the original file.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick snapshot
> +
> +. common/ceph
> +
> +_require_test
> +_require_xfs_io_command "pwrite"

I think "pwrite" is nearly always supported, don't need to check it :)

> +_require_xfs_io_command "fpunch"
> +_require_ceph_snapshot
> +_exclude_test_mount_option "test_dummy_encryption"
> +
> +# TODO: commit is not merged yet. Update with final commit SHA once merged.
> +_fixed_by_kernel_commit 1b7b474b3a78 \
> +	"ceph: fix snapshot context missing in ceph_zero_partial_object"
> +
> +workdir=$TEST_DIR/test-$seq
> +_ceph_remove_snapshot $workdir snap1
> +rm -rf $workdir
> +mkdir $workdir
> +
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1048576" $workdir/foo > /dev/null
> +
> +snapdir=$(_ceph_create_snapshot $workdir snap1)

As you just "return 1" if the _ceph_create_snapshot fails, what if the
snapshot isn't created? So how about calling "_fail" if it fails.

> +
> +original_md5=$(md5sum $snapdir/foo | cut -d' ' -f1)
> +
> +$XFS_IO_PROG -c "fpunch 0 65536" $workdir/foo
> +$XFS_IO_PROG -c "fpunch 131072 65536" $workdir/foo
> +$XFS_IO_PROG -c "fpunch 262144 65536" $workdir/foo
> +$XFS_IO_PROG -c "fpunch 393216 65536" $workdir/foo
> +
> +# Make sure we don't read from cache
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +snapshot_md5=$(md5sum $snapdir/foo | cut -d' ' -f1)
> +
> +if [ "$original_md5" != "$snapshot_md5" ]; then
> +    echo "FAIL: Snapshot data changed after punch hole operations"
> +    echo "Original md5sum: $original_md5"
> +    echo "Snapshot md5sum: $snapshot_md5"
> +fi
> +
> +_ceph_remove_snapshot $workdir snap1

Better to make sure the snapshot is removed in _cleanup.

Thanks,
Zorro

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ceph/006.out b/tests/ceph/006.out
> new file mode 100644
> index 00000000..675c1b7c
> --- /dev/null
> +++ b/tests/ceph/006.out
> @@ -0,0 +1,2 @@
> +QA output created by 006
> +Silence is golden
> -- 
> 2.43.0
> 
> 
> Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.
> 

