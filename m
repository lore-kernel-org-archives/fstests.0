Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F3F1D0DF6
	for <fstests@vger.kernel.org>; Wed, 30 Oct 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318106; cv=none; b=k78tVhODQv/KNEcPQ/zxTHMHf1Jy8ZFuQ6WmHGuIYtbHM+NhjeFeon4mAy1l+qxx3BcRzZED1vT478AMW9Is2TOFbgR6955xsC/sqn0PUZBk7e3rXJ/3xKtp72pOaQ7Ir9Qa4HM/va8xoBDINJEgoC5Bn+FNICLkaAfT3UAWVeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318106; c=relaxed/simple;
	bh=m7J9JY2zz6CQLpO/ntprYmGGrlIZkOJyqbsZDk6TgS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVaUCXq/OJQfLJHeb+MZFrSlC2R6M/o3OgZaHekRignBD1EDg0ykq3yHZPbzzy8EoiVgY14h/PDDni5BkLIY3IFgDaey7C/v6yUhiShqEdIKQKwXjkDomxeryipzM2k9jbUtDUKt4Tx0DUCDdbm92K/DHgGfz3kT9/HaBWY2KhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3htKGh0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3htKGh0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730318102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3gqgBE9ZPkNjFxKMw809O0Rl742yuHJUHDk40jz3dg=;
	b=R3htKGh0AknMAGUVvIkOZrl1qFWvG9GB6UOG/RgmIknzu8YxHmDr7KPK8tA6N0ZY8PXUEJ
	N+m3ipuGeQDVgnzFWrgEYGeLQwNAXCD2vm31kCFy+szv/FJz6SX/Rp6OMLz20YUz0QNWvD
	1+r4qIvQYtQDzmnjEeuZAsgQNMoMZyw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-YeLchDDtN4SY2wcFttpVpg-1; Wed, 30 Oct 2024 15:55:01 -0400
X-MC-Unique: YeLchDDtN4SY2wcFttpVpg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e2c3338a9dso194841a91.0
        for <fstests@vger.kernel.org>; Wed, 30 Oct 2024 12:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730318100; x=1730922900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3gqgBE9ZPkNjFxKMw809O0Rl742yuHJUHDk40jz3dg=;
        b=o7fNMyYkBPghKFDoMi8NwazOgHKPjkiml6JYM60z0vZhRtrGZyXGF7mStzpDA38oaa
         MeLH1G7M5waYaN+6P+XPnrCO725B3kXJq7GhxxTxCYaNjMbvxG3i155cpuELOadFrrE2
         RM6AdoB6ljDy1zQW224csdkJBvYbfobxSM4KwnxVdc/VxqHPLHeEO9GTphKv1/k8tsoj
         Ee+DAzxaPQMwUvMurWquFSeTZUOVR0k8kkYpKhVUYVb7ZWjHTuQ/Ci+3bRxiCvbhCx/F
         +LhTBUG/cGHnsO8rOE5EHYZtw2cqVgmJm5aCK4SqjMNk+peo+kOa4zm1WK2HQvwsFFqK
         6Mhg==
X-Gm-Message-State: AOJu0YxWsMGlhyB5wdwXalW7M6VQoiNGESjtbfzOAiCxFQNOv8BN6KJR
	fdJThQzmkhXajDkDTXlFKkqIOICtOC0ggnnxcsbP4ccfbZn0Wfs2Uy36DSzR7S3ROqQPcHfIqzD
	CIDmGMcwJLzCPt9VQcGGOpKfGP6ttXLH8QBF1kazI2eLHWUY+ieg9goU=
X-Received: by 2002:a17:90b:5447:b0:2e7:6bde:93ad with SMTP id 98e67ed59e1d1-2e93c14fcf3mr828429a91.11.1730318100279;
        Wed, 30 Oct 2024 12:55:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFqKvSJSiOeLLL2SDn4VyQgoZmyV8LjkMBQiy+qxSlfyWZZP0AoaMMa+VE3/z45C+JHQVXDA==
X-Received: by 2002:a17:90b:5447:b0:2e7:6bde:93ad with SMTP id 98e67ed59e1d1-2e93c14fcf3mr828406a91.11.1730318099962;
        Wed, 30 Oct 2024 12:54:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa57cc3sm2274397a91.32.2024.10.30.12.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:54:59 -0700 (PDT)
Date: Thu, 31 Oct 2024 03:54:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org, djwong@kernel.org,
	hch@lst.de
Subject: Re: [PATCH v2 2/2] xfs: online grow vs. log recovery stress test
 (realtime version)
Message-ID: <20241030195456.3busw2tbqqzinkm4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241029172135.329428-1-bfoster@redhat.com>
 <20241029172135.329428-3-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029172135.329428-3-bfoster@redhat.com>

On Tue, Oct 29, 2024 at 01:21:35PM -0400, Brian Foster wrote:
> This is fundamentally the same as the previous growfs vs. log
> recovery test, with tweaks to support growing the XFS realtime
> volume on such configurations. Changes include using the appropriate
> mkfs params, growfs params, and enabling realtime inheritance on the
> scratch fs.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---



>  tests/xfs/610     | 83 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/610.out |  2 ++
>  2 files changed, 85 insertions(+)
>  create mode 100755 tests/xfs/610
>  create mode 100644 tests/xfs/610.out
> 
> diff --git a/tests/xfs/610 b/tests/xfs/610
> new file mode 100755
> index 00000000..6d3a526f
> --- /dev/null
> +++ b/tests/xfs/610
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 610
> +#
> +# Test XFS online growfs log recovery.
> +#
> +. ./common/preamble
> +_begin_fstest auto growfs stress shutdown log recoveryloop
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_stress_scratch()
> +{
> +	procs=4
> +	nops=999999
> +	# -w ensures that the only ops are ones which cause write I/O
> +	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs \
> +	    -n $nops $FSSTRESS_AVOID`
> +	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full 2>&1 &
> +}
> +
> +_require_scratch
> +_require_realtime
> +_require_command "$XFS_GROWFS_PROG" xfs_growfs
> +_require_command "$KILLALL_PROG" killall
> +
> +_cleanup()
> +{
> +	$KILLALL_ALL fsstress > /dev/null 2>&1
> +	wait
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +_scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
> +. $tmp.mkfs	# extract blocksize and data size for scratch device
> +
> +endsize=`expr 550 \* 1048576`	# stop after growing this big
> +[ `expr $endsize / $dbsize` -lt $dblocks ] || _notrun "Scratch device too small"
> +
> +nags=4
> +size=`expr 125 \* 1048576`	# 120 megabytes initially
> +sizeb=`expr $size / $dbsize`	# in data blocks
> +logblks=$(_scratch_find_xfs_min_logblocks -rsize=${size} -dagcount=${nags})
> +
> +_scratch_mkfs_xfs -lsize=${logblks}b -rsize=${size} -dagcount=${nags} \
> +	>> $seqres.full || _fail "mkfs failed"

Ahah, not sure why this case didn't hit the failure of xfs/609, do you think
we should filter out the mkfs warning too?

SECTION       -- default
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 dell-per750-41 6.12.0-0.rc5.44.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Oct 28 14:12:55 UTC 2024
MKFS_OPTIONS  -- -f -rrtdev=/dev/mapper/testvg-rtdev /dev/sda6
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 -ortdev=/dev/mapper/testvg-rtdev /dev/sda6 /mnt/scratch

xfs/610        39s
Ran: xfs/610
Passed all 1 tests

> +_scratch_mount
> +_xfs_force_bdev realtime $SCRATCH_MNT &> /dev/null
> +
> +# Grow the filesystem in random sized chunks while stressing and performing
> +# shutdown and recovery. The randomization is intended to create a mix of sub-ag
> +# and multi-ag grows.
> +while [ $size -le $endsize ]; do
> +	echo "*** stressing a ${sizeb} block filesystem" >> $seqres.full
> +	_stress_scratch
> +	incsize=$((RANDOM % 40 * 1048576))
> +	size=`expr $size + $incsize`
> +	sizeb=`expr $size / $dbsize`	# in data blocks
> +	echo "*** growing to a ${sizeb} block filesystem" >> $seqres.full
> +	$XFS_GROWFS_PROG -R ${sizeb} $SCRATCH_MNT >> $seqres.full
> +
> +	sleep $((RANDOM % 3))
> +	_scratch_shutdown
> +	ps -e | grep fsstress > /dev/null 2>&1
> +	while [ $? -eq 0 ]; do
> +		$KILLALL_PROG -9 fsstress > /dev/null 2>&1
> +		wait > /dev/null 2>&1
> +		ps -e | grep fsstress > /dev/null 2>&1
> +	done
> +	_scratch_cycle_mount || _fail "cycle mount failed"

_scratch_cycle_mount does _fail if it fails, I'll help to remove the "|| _fail ..."

> +done > /dev/null 2>&1
> +wait	# stop for any remaining stress processes
> +
> +_scratch_unmount

If this ^^ isn't a necessary step of bug reproduce, then we don't need to do this
manually, each test case does that at the end. I can help to remove it when I
merge this patch.

Others looks good to me,

Reviewed-by: Zorro Lang <zlang@redaht.com>


> +
> +echo Silence is golden.
> +
> +status=0
> +exit
> diff --git a/tests/xfs/610.out b/tests/xfs/610.out
> new file mode 100644
> index 00000000..c42a1cf8
> --- /dev/null
> +++ b/tests/xfs/610.out
> @@ -0,0 +1,2 @@
> +QA output created by 610
> +Silence is golden.
> -- 
> 2.46.2
> 
> 

