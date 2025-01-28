Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372622619
	for <fstests@vger.kernel.org>; Tue, 28 Jan 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738092683; cv=none; b=KbXVZZD43XVvRmv0kSTo+/sPeGr/Mr4Ph8+flTLGRQv9B2cnoTWiNXYPc+MtP5M/cAAicg+aRNBS2sG+mdSzObvoZwTTO0qru92MUObcCSPs3iWErknWsNDbrd4iZoqz/BBsPvu2DDhC0y3co8lwctDxg3iWFfSVGa/35l5QFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738092683; c=relaxed/simple;
	bh=k/fThBpeobPscAMl27NCoR+SuBQaKk6zdEHAmcK6Ot8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmAl4zMOUIyXeoKewa1+VLtTXnTxO7pJWE4chz/K/4+7Ac+u5hLGaEM+TrVeOQ8XKotxFpDlZSr7ORevDAqE+RN6/smWjTBOzGb71VidHgu/+jpCVb4N7dCe0FhOWyJriwg0nnSP4o+COmY8lHhCjTe2zNNp1gaqx6CdBZQ5u3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsHwSen6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsHwSen6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F03C4CED3;
	Tue, 28 Jan 2025 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738092682;
	bh=k/fThBpeobPscAMl27NCoR+SuBQaKk6zdEHAmcK6Ot8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsHwSen6HqfcAVsOUmCNbSqxi7g44xyfoBt83YIZKn9HpbJR01obALggfh3WR7tzQ
	 oXA54IlJy97uX3Ln1l1rFV1Y/CHWT9E4ll59xDEuntii2VtHMQMwiLlt5JNIFtq4Us
	 G8hzA3MOISnsC5eBvrxodoo/dJtXVCngPV7u3v3abdo5zgH1Djf8VVFK1+WmEA2zed
	 q/X6bm22WRRzOItKfCwwZSmFQLm1MR3dL3uZ2BLb8nE/qRN5WVLOPk42DoDS/UMbIW
	 S4O/mFLBEZ+oV2VOvmg/PM8SyBoof2G7vtFyjrl+8Hn6WjZxCM57thzQnrtynzGqCM
	 zckkjTeg9AG/A==
Date: Tue, 28 Jan 2025 11:31:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common: skip tests using LVM when the device is no known
Message-ID: <20250128193122.GU3557695@frogsfrogsfrogs>
References: <20250128071609.676581-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128071609.676581-1-hch@lst.de>

On Tue, Jan 28, 2025 at 08:16:05AM +0100, Christoph Hellwig wrote:
> LVM has a lot of elaborate code to make the users life painful.  This
> includes claiming the device type is unknown if it doesn't match it's
> elaborately crafted internal list instead of just letting the user use
> it.  Skip tests using LVM if this is the case to avoid arcane failures
> due to missing lvm devices when using null_blk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/081 | 6 +++++-
>  tests/generic/108 | 6 +++++-
>  tests/generic/459 | 6 +++++-
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/081 b/tests/generic/081
> index 37137d937b05..97928bf4a435 100755
> --- a/tests/generic/081
> +++ b/tests/generic/081
> @@ -66,7 +66,11 @@ lvsize=$((size * 85 / 100))	 # ~256M
>  # make sure there's enough disk space for 256M lv, test for 300M here in case
>  # lvm uses some space for metadata
>  _scratch_mkfs_sized $((size * 1024 * 1024)) >>$seqres.full 2>&1
> -$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> +
> +# lvm has a hardcoded list of valid devices and fails with
> +# "device type is unknown" for those not in the list like null_blk
> +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1 || \
> +	_notrun "LVM is too stupid for this device"

Should this get turned into a common helper?

_require_lvm_support() {
	local bdev="$1"

	$LVM_PROG pvcreate --test "$bdev" || \
		_notrun "$bdev: cannot use lvm here"
}

I guess the downside is that pvcreate on my system (Debian 12) will trip
over any existing disk label and ask if you want to wipe it.  If you say
no then it returns nonzero, and if you say yes then it goes into an
infinite loop.

You can of course $WIPEFS_PROG -a $bdev but ugghh.

--D


>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
>  yes | $LVM_PROG lvcreate -L ${lvsize}M -n $lvname $vgname >>$seqres.full 2>&1
> diff --git a/tests/generic/108 b/tests/generic/108
> index f630450ec66d..4f86ec946511 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -51,7 +51,11 @@ test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
>  echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
>  
>  # create striped volume with 4MB stripe size
> -$LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
> +#
> +# lvm has a hardcoded list of valid devices and fails with
> +# "device type is unknown" for those not in the list like null_blk
> +$LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1 || \
> +	_notrun "LVM is too stupid for this device"
>  $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
> diff --git a/tests/generic/459 b/tests/generic/459
> index 40c87e20f8b9..3f5f0f2b7dc1 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -84,7 +84,11 @@ is_shutdown_or_ro()
>  _scratch_mkfs_sized $((350 * 1024 * 1024)) >>$seqres.full 2>&1
>  
>  # Create a 200MB dm-thin POOL
> -$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1
> +#
> +# lvm has a hardcoded list of valid devices and fails with
> +# "device type is unknown" for those not in the list like null_blk
> +$LVM_PROG pvcreate -f $SCRATCH_DEV >>$seqres.full 2>&1 || \
> +	_notrun "LVM is too stupid for this device"
>  $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
>  
>  $LVM_PROG lvcreate  --thinpool $poolname  --errorwhenfull y \
> -- 
> 2.45.2
> 
> 
