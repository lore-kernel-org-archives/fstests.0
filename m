Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA41FB89D
	for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729877573; cv=none; b=XPrdxyl4MENwyoKMINe2HE+HkBj6gi+OrS64K0f96s2uPtUXa7s0mJc3wrWtEh27mMnI2uqpymJvs3Bf9hF7t3yQ7HxP95UAKuM0w/U2NmcKm2Fz/hUWKXDEb74CODI1AoLHNjewf3IfDXwRtFk+Kld8ekmohbIRS+LkQOG85Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729877573; c=relaxed/simple;
	bh=MNy1gOgdKFLiZlcoBBYxaQqJG6QgoYPyInihJs3CFfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qt2F9kdjK0EitpU9D0ElSqsHMZAcGIGz61aC+oxf8wUtcHrcLkeqPK0OiODV4y8VBzqxqGguPxiN0+P2CTOcsFuVLhCIcFIcqudqpjKvnoVOpJEqr4oLV3bxnx1VMV2ljEepDHrJ01t8KHla4gXhWfmJUgo17C9HDV7s7A8De/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d28BT5T3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d28BT5T3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729877570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xclptLE0qZUOdIEQs4JojCYB6M+rk4Y2iz9b+UtLTaE=;
	b=d28BT5T34FVEAglftF7NF9iBmbn+oJlvQV0VpBYg6j9jKRjOw1MVQjpAUrS8oDaxuadGyR
	qaIBcsrGGbpXuLrAjjHYuzqxu4LYaO/lv1SM3YcLD09iEDZIiNZGUXcIJImaGPstOseZ3H
	45z980Xp5Dwzzk0R6nCawdXRny+q2XE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-gC_eY5RAMHWuUISH2-CLtw-1; Fri, 25 Oct 2024 13:32:48 -0400
X-MC-Unique: gC_eY5RAMHWuUISH2-CLtw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20c7ea6b060so23670945ad.1
        for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 10:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729877567; x=1730482367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xclptLE0qZUOdIEQs4JojCYB6M+rk4Y2iz9b+UtLTaE=;
        b=Hmv5Uq3WOg2+jDi1rUcPOXpxT5a4X3F8pEiCt+huZEmJXHIzgLQBKsc7vCcAMldrN4
         YV1DAlbqKTQ5OOge196bz1tifINKT1uv1STwzGqXeZd8KRztYoGfL6w9Gi2el22Ucgd0
         JLQjaZOjvK5it8RNrX/0sEPX6twPeKCI4Qm5A2E7H/j3KqPxSFCr+oQleyJg9Esg8gYt
         yUBjobul7NB48AhfHHhhq13Bl0I8x/63pc4ajS15Ia40+W54w9pwd6o3k1dzu8Cajz1z
         oEgXeQCrMvETRCcZbB4GyZ8BoY0MgVzpu0kQ2APxPCfrtZvMD+5rYVBI3Jrq/mWh/tZx
         YRaQ==
X-Gm-Message-State: AOJu0YxtwNggxQJ19mfJXA1Hci7TE82pSTnKuAk/iNNDlYgZC2eT3CUj
	vRhOCquQjR/2GM1C2IGV5FhuzLfWMc75zjZIAxhiO9ELP3y7ROZTvL4XyTm/RTOvYAWQ9gfh/2u
	oo1x8ROMT7XwvAoZ/GMj9yCEHi9ihPocOnMm90r634Eya/oN5PssMtj4=
X-Received: by 2002:a17:903:2a8f:b0:20c:79bf:6793 with SMTP id d9443c01a7336-20fa9deab02mr139541635ad.3.1729877567542;
        Fri, 25 Oct 2024 10:32:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4hQ+wtsLmYtDOizUOX5NjpFI0DaIEkOzlVLtcFCqAB0xLmbnjLckf4YGW6qvNfgSUfI8xdg==
X-Received: by 2002:a17:903:2a8f:b0:20c:79bf:6793 with SMTP id d9443c01a7336-20fa9deab02mr139541245ad.3.1729877567144;
        Fri, 25 Oct 2024 10:32:47 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc043d13sm11580065ad.233.2024.10.25.10.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:32:46 -0700 (PDT)
Date: Sat, 26 Oct 2024 01:32:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org, djwong@kernel.org,
	hch@lst.de
Subject: Re: [PATCH 1/2] xfs: online grow vs. log recovery stress test
Message-ID: <20241025173242.clzuckwfotkdkpwq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241017163405.173062-1-bfoster@redhat.com>
 <20241017163405.173062-2-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017163405.173062-2-bfoster@redhat.com>

On Thu, Oct 17, 2024 at 12:34:04PM -0400, Brian Foster wrote:
> fstests includes decent functional tests for online growfs and
> shrink, and decent stress tests for crash and log recovery, but no
> combination of the two. This test combines bits from a typical
> growfs stress test like xfs/104 with crash recovery cycles from a
> test like generic/388. As a result, this reproduces at least a
> couple recently fixed issues related to log recovery of online
> growfs operations.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---

Hi Brian,

Thanks for this new test case! Some tiny review points below :)

>  tests/xfs/609     | 69 +++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/609.out |  7 +++++
>  2 files changed, 76 insertions(+)
>  create mode 100755 tests/xfs/609
>  create mode 100644 tests/xfs/609.out
> 
> diff --git a/tests/xfs/609 b/tests/xfs/609
> new file mode 100755
> index 00000000..796f4357
> --- /dev/null
> +++ b/tests/xfs/609
> @@ -0,0 +1,69 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 609
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
> +
> +_scratch_mkfs_xfs | tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs

"_scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs" can get same output
as the .out file below.

> +. $tmp.mkfs	# extract blocksize and data size for scratch device
> +
> +endsize=`expr 550 \* 1048576`	# stop after growing this big
> +[ `expr $endsize / $dbsize` -lt $dblocks ] || _notrun "Scratch device too small"
> +
> +nags=4
> +size=`expr 125 \* 1048576`	# 120 megabytes initially
> +sizeb=`expr $size / $dbsize`	# in data blocks
> +logblks=$(_scratch_find_xfs_min_logblocks -dsize=${size} -dagcount=${nags})
> +
> +_scratch_mkfs_xfs -lsize=${logblks}b -dsize=${size} -dagcount=${nags} \
> +	>> $seqres.full

What if this mkfs (with specific options) fails? So how about || _fail "....."

> +_scratch_mount
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
> +	xfs_growfs -D ${sizeb} $SCRATCH_MNT >> $seqres.full

_require_command "$XFS_GROWFS_PROG" xfs_growfs

Then use $XFS_GROWFS_PROG

> +
> +	sleep $((RANDOM % 3))
> +	_scratch_shutdown
> +	ps -e | grep fsstress > /dev/null 2>&1
> +	while [ $? -eq 0 ]; do
> +		killall -9 fsstress > /dev/null 2>&1

_require_command "$KILLALL_PROG" killall

Then use $KILLALL_PROG

> +		wait > /dev/null 2>&1
> +		ps -e | grep fsstress > /dev/null 2>&1
> +	done
> +	_scratch_cycle_mount || _fail "cycle mount failed"
> +done > /dev/null 2>&1
> +wait	# stop for any remaining stress processes

If the testing be interrupted, the fsstress processes will cause later tests fail.
So we deal with background processes in _cleanup().
e.g.

_cleanup()
{
	$KILLALL_ALL fsstress > /dev/null 2>&1
	wait
	cd /
	rm -f $tmp.*
}

Or use a loop kill as you does above.

> +
> +_scratch_unmount
> +
> +status=0
> +exit
> diff --git a/tests/xfs/609.out b/tests/xfs/609.out
> new file mode 100644
> index 00000000..1853cc65
> --- /dev/null
> +++ b/tests/xfs/609.out
> @@ -0,0 +1,7 @@
> +QA output created by 609
> +meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
> +data     = bsize=XXX blocks=XXX, imaxpct=PCT
> +         = sunit=XXX swidth=XXX, unwritten=X
> +naming   =VERN bsize=XXX
> +log      =LDEV bsize=XXX blocks=XXX
> +realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX

So what's this output in .out file for? How about "Silence is golden"?

Thanks,
Zorro

> -- 
> 2.46.2
> 
> 

