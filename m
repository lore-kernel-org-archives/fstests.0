Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7A22689C
	for <fstests@vger.kernel.org>; Sat, 10 Jan 2026 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768008893; cv=none; b=lK60ksNEYkBZO/WdH6hS1rZvp6g6TJCFsLvQReNUqmQU5aGJt/uw+LRQpfnZGjmTK7NYmhHDYY+K5mQB3ZTWVz707+o1KzX4ZgKHEEY1qHKThLqS2SE8YBWtaKSmqE7atqWez4Rdbnsw2fISq6mTgorqFK/FO9VyaAswWjErqfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768008893; c=relaxed/simple;
	bh=L3Bsg9YguiSw8jrViTqIRgr5edrfbTEKF7ddMrq9yfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZm2V8PIaSSAtyPXfEpn2vqHD3TcqexAtCqMSpVZPeoDQHZGqKRMLgNV+eWa/rhcepprJgRpq77FAOef0wI30YUzGV4Mf1yMBt3Kk0U3JVypbRuVp3Ma0vtE7RNqwH+gL+S6KGR6L1VgAetIEe+Pg5gzL7e8M9geLDYevbg4zPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYxuqZp0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYxuqZp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6812C4CEF1;
	Sat, 10 Jan 2026 01:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768008892;
	bh=L3Bsg9YguiSw8jrViTqIRgr5edrfbTEKF7ddMrq9yfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYxuqZp0P0nVYRvveNZRe84osqJQfrpZvG0cxaCX5J89qYjmODLw8C6YVk97MU1++
	 KgXoRGLCB8xcqjvs6C/vb7p7adtZhIsWZrhRAWDUV/rWK94KiQGatRYrU+a75UVNSN
	 887gHGv5Gj8mGh7DuvzFU4PXAdi+Dc8maQsCyc0ydeK9wqf2XDv25gnYHx1BqUU6Xm
	 +RnAax+2mCDIhCGNNlDoLJ6apmIBPDsfil4Rn6etFTP4DOpCORnLowgqkPI29gVmO+
	 LBaWQAOg+Dlm2wGPNpIZ8oootcjGX2cTUuj1aGML4pdVojSXfhLvPIgGkuT/CFJR/k
	 k8KAjYWs+22dg==
Date: Fri, 9 Jan 2026 17:34:52 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH v2] generic/108: fix test hand upon failure to create LV
Message-ID: <20260110013452.GA15541@frogsfrogsfrogs>
References: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98f8ef5ff92632a0be336a563ebda36cfe898348.1767782181.git.ojaswin@linux.ibm.com>

On Wed, Jan 07, 2026 at 04:07:44PM +0530, Ojaswin Mujoo wrote:
> In case the lvcreate operation fails, we don't catch the error and
> proceed as usual. The test then tries to wait for the LV to come up
> but it never does, causing a hang.
> 
> To fix this:
> 1. Add a check to ensure SCSI_DEBUG dev is of required size
> 2. Additionally, fail if there are errors while creating the LV.
> 
> Context for completeness:
> 
> This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
> of =m, causing it to create an 8MB SCSI debug device. This led to the
> lvcreate operation to fail with:
> 
>   Insufficient suitable allocatable extents for logical volume lv_108: 68 more required
> 
> However the test never caught this resulting in a hang.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>

Ooops.  Yeah, I think it's a good idea to check the scsi_debug size and
to bail out if lvcreate fails.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/108 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index 4f86ec94..05d743a9 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -50,6 +50,11 @@ SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 $size`
>  test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
>  echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
>  
> +got_size_kb=$(_get_device_size $SCSI_DEBUG_DEV)
> +
> +[[ $got_size_kb -lt $((size * 1024)) ]] &&
> +	_notrun "Need SCSI debug device of size $(( size * 1024 )) KB. Got $got_size_kb KB"
> +
>  # create striped volume with 4MB stripe size
>  #
>  # lvm has a hardcoded list of valid devices and fails with
> @@ -60,7 +65,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
>  yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
> -	>>$seqres.full 2>&1
> +	>>$seqres.full 2>&1 || _fail "Failed to create LVM lv"
>  _udev_wait /dev/mapper/$vgname-$lvname
>  
>  # _mkfs_dev exits the test on failure, this makes sure test lv is created by
> -- 
> 2.51.0
> 
> 
