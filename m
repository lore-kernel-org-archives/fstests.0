Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBEB1D27BA
	for <fstests@vger.kernel.org>; Wed,  6 Nov 2024 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885713; cv=none; b=snhiuMKpkKpgcH8Yec+T/7SSfmNDjTKXI0xqNSIUh62mghODQ7tZtQqcv+hFsVIcQcqLvRduh/R2eZZJ8xpdcfBuM7vaJAseuRlOvp3COuRnABHXba5pepPQPE84sYplfle1FKGexGlDlHsaS2bhJqF6/cFW3Vsr0sKBHA0M4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885713; c=relaxed/simple;
	bh=l7fI1NXKw/SBD8o9AZP4yQV5mpTw3LKEpMKQc4ATJMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWsjqkXAEdq72HSsDkN57/JG4YYbZ24ToEwjf+XtqGdsBKQMTG3BZiHab0SK2+pwpfoGmXCMgKlyCJ4CylALvaGd9Dqpt/4gHVT8cmYKbMfAh/XhkxjZbv5c2CGnM5OJBHJ3zCk4/42uUhTFUq8cuf5ICa8xnRycgvsoPIBcbQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdDQfz0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdDQfz0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730885710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HKe1KF5nbucuJOx0n3yfo2a4CQjK6K4rag3+B2za0w0=;
	b=IdDQfz0n6zFdDjK+BZVgh0qceONVfuWIJGm7BAPE6owyPMLA3LEoyaJIG8nJlAy96rS55s
	h5dvNay2lrdr8/90blBM7ssMAMMhT1Pd5pQKXlxOs0cZ7LCfKmP36Mcjz4ILD3xIblhRhc
	yxvr3f8Ip3gNqBOZjdu9OFGeAEoFUNQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70--KOcsTKcNFi405eX-ouwJA-1; Wed, 06 Nov 2024 04:35:09 -0500
X-MC-Unique: -KOcsTKcNFi405eX-ouwJA-1
X-Mimecast-MFC-AGG-ID: -KOcsTKcNFi405eX-ouwJA
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e58e838d5so7469468b3a.1
        for <fstests@vger.kernel.org>; Wed, 06 Nov 2024 01:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885708; x=1731490508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKe1KF5nbucuJOx0n3yfo2a4CQjK6K4rag3+B2za0w0=;
        b=IxOr0ZCiKcuwob1+VOtDMWyolf0G+ZhYBt1ASRGIQhxF7VW7VsaUBFz4JiEfF8dp/r
         B9PYB7sObv37ergerkLLlvPA3Zu8WopXBo0TGApRvgJz5DriCtIkHO+O/cCoaXbd+CDW
         hQCXWUM41M4af5jN6fOkpOoZNfGndfM6GvQ5FeudEz36F92u0d2+Y/XtQbaWnMc1a9h7
         yXvSpFiQGpbvHFO4Qiy+i4rUzVWA2onjg1JdXnNOphCkmJuS6SQPNUWncTZH1bDfU5aL
         OlHxubI8axzzgkCmcJvEQUT6tUCknR2bRFIWK7uaj+ntUoqnSWlEs1vtl5LksrWcDPma
         kTyA==
X-Forwarded-Encrypted: i=1; AJvYcCXEX5hKH5DdSSkaaWc1qY09LfmDyEVA7nmrNGuuNYyKaWzc9/ygMbi0dlqvFKNjSxln61vyNoX3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7f6BqhgGO53FhuxmU+ANh4mokZeP2uKUNIG0KKLH/Dl1LztdC
	EW88egQsz84gBqj3rJVjazcQRi1PA5LvzzJheXsNt7VznJEctKMc4DgRvf/dmr/0H1dnb6KdaCB
	gGOc+K6OWgwUI11d+pH5ZL/d6xOyBCCusq0wJdf+mGzTf/EuBP/a5NXaofa2hVQ3VVg==
X-Received: by 2002:a05:6a21:3a82:b0:1d9:8275:cd70 with SMTP id adf61e73a8af0-1d9a84d0918mr51746537637.40.1730885708079;
        Wed, 06 Nov 2024 01:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmQTM5JPlVUiE8ykxtgxoAra9Kt7VojszlQ3K7CcFK0GXBaBXleK+B+y0Cb/WCdqgBI0ru3Q==
X-Received: by 2002:a05:6a21:3a82:b0:1d9:8275:cd70 with SMTP id adf61e73a8af0-1d9a84d0918mr51746512637.40.1730885707573;
        Wed, 06 Nov 2024 01:35:07 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5d4cc5sm1016800a91.45.2024.11.06.01.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:35:07 -0800 (PST)
Date: Wed, 6 Nov 2024 17:35:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4] btrfs: a new test case to verify mount behavior with
 background remounting
Message-ID: <20241106093503.3gaon45f44b3r6sv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241106054328.19842-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106054328.19842-1-wqu@suse.com>

On Wed, Nov 06, 2024 at 04:13:28PM +1030, Qu Wenruo wrote:
> [BUG]
> When there is a process in the background remounting a btrfs, switching
> between RO/RW, then another process try to mount another subvolume of
> the same btrfs read-only, we can hit a race causing the RW mount to fail
> with -EBUSY:
> 
> [CAUSE]
> During the btrfs mount, to support mounting different subvolumes with
> different RO/RW flags, we have a small hack during the mount:
> 
>   Retry with matching RO flags if the initial mount fail with -EBUSY.
> 
> The problem is, during that retry we do not hold any super block lock
> (s_umount), this meanings there can be a remount process changing the RO
> flags of the original fs super block.
> 
> If so, we can have an EBUSY error during retry.
> And this time we treat any failure as an error, without any retry and
> cause the above EBUSY mount failure.
> 
> [FIX]
> The fix is already sent to the mailing list.
> The fix is to allow btrfs to have different RO flag between super block
> and mount point during mount, and if the RO flag mismatch, reconfigure
> the fs to RW with s_umount hold, so that there will be no race.
> 
> [TEST CASE]
> The test case will create two processes:
> 
> - Remounting an existing subvolume mount point
>   Switching between RO and RW
> 
> - Mounting another subvolume RW
>   After a successful mount, unmount and retry.
> 
> This is enough to trigger the -EBUSY error in less than 5 seconds.
> To be extra safe, the test case will run for 10 seconds at least, and
> follow TIME_FACTOR for extra loads.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
> Changelog:
> v4:
> - Add the missing reviewed-by tag from Filipe
> 
> v3:
> - Also remove the default temporaray files in cleanup
> 
> - Unset mount/remount pid and avoid killing them if unset during cleanup
> 
> - Remove the mount points to avoid name conflicts
> 
> - Extra comments on the the final unmounts for both mount point and
>   cleanup
> 
> v2:
> - Better signal handling for both remount and mount workload
>   Need to do the extra handling for both workload
> 
> - Wait for any child process to exit before cleanup
> 
> - Keep the stderr of the final rm command
> 
> - Keep the stderr of the unmount of $subv1_mount
>   Which should always be mounted.
> 
> - Use "$UMOUNT_PROG" instead of direct "umount"
> 
> - Use "_mount" instead of direct "mount"
> 
> - Fix a typo of "block"
> ---

Thanks for this new test case, this version is good to me:

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/325     | 107 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/325.out |   2 +
>  2 files changed, 109 insertions(+)
>  create mode 100755 tests/btrfs/325
>  create mode 100644 tests/btrfs/325.out
> 
> diff --git a/tests/btrfs/325 b/tests/btrfs/325
> new file mode 100755
> index 00000000..0f4984f1
> --- /dev/null
> +++ b/tests/btrfs/325
> @@ -0,0 +1,107 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 325
> +#
> +# Test that mounting a subvolume read-write will success, with another
> +# subvolume being remounted RO/RW at background
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount remount
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix mount failure due to remount races"
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -rf -- $tmp.*
> +	[ -n "$mount_pid" ] && kill $mount_pid &> /dev/null
> +	[ -n "$remount_pid" ] && kill $remount_pid &> /dev/null
> +	wait
> +	$UMOUNT_PROG "$subv1_mount" &> /dev/null
> +	$UMOUNT_PROG "$subv2_mount" &> /dev/null
> +	rm -rf -- "$subv1_mount" "$subv2_mount"
> +}
> +
> +# For the extra mount points
> +_require_test
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol1 >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol2 >> $seqres.full
> +_scratch_unmount
> +
> +subv1_mount="$TEST_DIR/subvol1_mount"
> +subv2_mount="$TEST_DIR/subvol2_mount"
> +rm -rf "$subv1_mount" "$subv2_mount"
> +mkdir -p "$subv1_mount"
> +mkdir -p "$subv2_mount"
> +_mount "$SCRATCH_DEV" "$subv1_mount" -o subvol=subvol1
> +
> +# Subv1 remount workload, mount the subv1 and switching it between
> +# RO and RW.
> +remount_workload()
> +{
> +	trap "wait; exit" SIGTERM
> +	while true; do
> +		_mount -o remount,ro "$subv1_mount"
> +		_mount -o remount,rw "$subv1_mount"
> +	done
> +}
> +
> +remount_workload &
> +remount_pid=$!
> +
> +# Subv2 rw mount workload
> +# For unpatched kernel, this will fail with -EBUSY.
> +#
> +# To maintain the per-subvolume RO/RW mount, if the existing btrfs is
> +# mounted RO, unpatched btrfs will retry with its RO flag reverted,
> +# then reconfigure the fs to RW.
> +#
> +# But such retry has no super block lock hold, thus if another remount
> +# process has already remounted the fs RW, the attempt will fail and
> +# return -EBUSY.
> +#
> +# Patched kernel will allow the superblock and mount point RO flags
> +# to differ, and then hold the s_umount to reconfigure the super block
> +# to RW, preventing any possible race.
> +mount_workload()
> +{
> +	trap "wait; exit" SIGTERM
> +	while true; do
> +		_mount "$SCRATCH_DEV" "$subv2_mount"
> +		$UMOUNT_PROG "$subv2_mount"
> +	done
> +}
> +
> +mount_workload &
> +mount_pid=$!
> +
> +sleep $(( 10 * $TIME_FACTOR ))
> +
> +kill "$remount_pid" "$mount_pid"
> +wait
> +unset remount_pid mount_pid
> +
> +# Subv1 is always mounted, thus the umount should never fail.
> +$UMOUNT_PROG "$subv1_mount"
> +
> +# Subv2 may have already been unmounted, so here we ignore all output.
> +# This may hide some errors like -EBUSY, but the next rm line would
> +# detect any still mounted subvolume so we're still safe.
> +$UMOUNT_PROG "$subv2_mount" &> /dev/null
> +
> +# If above unmount, especially subv2 is not properly unmounted,
> +# the rm should fail with some error message
> +rm -r -- "$subv1_mount" "$subv2_mount"
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
> new file mode 100644
> index 00000000..cf13795c
> --- /dev/null
> +++ b/tests/btrfs/325.out
> @@ -0,0 +1,2 @@
> +QA output created by 325
> +Silence is golden
> -- 
> 2.46.0
> 
> 

