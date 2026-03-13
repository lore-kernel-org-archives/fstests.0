Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABEB3E0C67
	for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430584; cv=none; b=s3fvkRqL2HDhR35L5h9UeaBLNkXXINX9ZEwfY9E+IQZAu4DtpzyYuDAmSVV0vvC53QS5MMbj542aApwMwyzhp4cIPGf5SbDmSk5NULKdngAwzGX7nxSR3zUpFK1qSCJtLj6oYaWjDRrjJwPz7ldzM4UnLNvm3BWWmfSd+alOzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430584; c=relaxed/simple;
	bh=s75qgKoKq+vNltbFCY5W99sUuXGovgNbY/Z7Z0RTqao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKNqpZ7XnOVQyKaBcvuQMMYJ2KdPPgi7/Md3s/SzjYqgcTRT7PFESB2Cg0NhDXRNELDF0zA7E+gaQS/ncRN7Aiq2Y/YAiTqrdYsKLh519rYZCL4RcxJBwMDh+0zjH3CWBbKxL6fYGLDigX92obUN8i8Fad4nUXM+rvns262lekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lm0V2dRV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G486Z505; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lm0V2dRV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G486Z505"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773430574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F6vLNkYI0Glv4imYlLdghWO+G939IWoHMCjoj79IDKc=;
	b=Lm0V2dRVJT2Maw+NuKtkCUcKmIDdC5ohjj+dFhtGQ3Tc7L8tiRZXhSAnq/jXgOS/qmQtmw
	HGJXtLs4RiduWLawQAFKvwHvwpaatP2gUHbIv9SWkXqT0097QAhO+lnPWI/eyJbtldqUQM
	SL+vvF5/Tgh9/30pgGqAwI80Ufgu5mw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-ppiM28p-PDunEIDHQ2WeNQ-1; Fri, 13 Mar 2026 15:36:13 -0400
X-MC-Unique: ppiM28p-PDunEIDHQ2WeNQ-1
X-Mimecast-MFC-AGG-ID: ppiM28p-PDunEIDHQ2WeNQ_1773430572
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829a9d3073bso1051569b3a.2
        for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773430572; x=1774035372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6vLNkYI0Glv4imYlLdghWO+G939IWoHMCjoj79IDKc=;
        b=G486Z505tYGa41ooa0fJywkW5gA1GeHmiwPsNL5yM4Ud5dFyNV/rLoqi6RMhF7qY+3
         EFGaNvogrTxpR9tbdAuHlZGI/rOeWqrln2GNVP3jj508iwtFnIrmJbBxitmqDCQq3wOR
         3ND5U+pukU9VdenrTrm0d62HL/bvXnXxwDinfJohQZ+hbLKIOSdOhF88u6rdaDIHlrwv
         EHC6OvqFC6+hw+Txa3zLSDzOpGaALIthT3SzG2kpYYsxGC7oJYFCtkZoN5JmpQQYP+VQ
         1lZAv4zQFdjaJAmyy7XqcMfAL3gwCLvGhuhvGX0LuTWRGLd560+ANhQ43BqZ/EVuGLJZ
         S2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430572; x=1774035372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6vLNkYI0Glv4imYlLdghWO+G939IWoHMCjoj79IDKc=;
        b=eWy2MgG6cfUHDlWReZYkgTFE0mZ/Kx2aO+aHCBNnepxO3TGlyveeqxAmna7ZWGq9iu
         NmR0zGoDuUI7GwpiFlK+tF6lgIglqRNZfkMgNcSPJ0WaOA8utTxR7awVzVW+NHcFOmEE
         r4A4b/Y/03ru1/ZvdhEtCVZAhNMi/6fV9CSp3Wq5RGpkV7LFiT0NGgGdYsi6wnIyZ5pZ
         pvsH0FbYQiIKQNTqFcoOByDI7/Grr6e6bkVwFNcelom0au4Nj0ZVEx3dHOq0fWAU7Iw2
         dHPCdoIUfRb0CnnjNBN9B+RT9KIzPRXIeWSSaQHq8zc2KR5Zggvt4jazCH97LAmKtXzm
         RQTQ==
X-Gm-Message-State: AOJu0YzW+svVpi5ZaHnJ39pmNtL7YYjoslHDGa5lKOM4i1pECydOKOkY
	4nZsWnYHN8t9S33hxwt7bDvz+A0zW32dxjUY114avilVy4THzXUN+mQj89+HfQhb8QGGx4Bi/Ud
	FdvpxbxLjZ7n5ETvwTJQ/plKJX0TbP7dSKJWrjO9NRpYLayy4aJzr2reDKe4=
X-Gm-Gg: ATEYQzx09asujR+ZWVO2KANIh2GIAzg/C36gCL/sJwCKRfmN+DpmrVXmLtunVzW0xkB
	AFcz2ZRyXM7rKUHn1bBD6mXfSx9JCxvxWxcxnxAJVhvoupnn0vXPeeiC2WihUag0O43asJfJcJT
	MNzkTeuPWLr7p+WxrhYYMvmenrCjmjW6cIe3efIptVLhMjDAY9HqhUmreJWcEeHLuWUnHnkeRTe
	8/wPst4q2+bcMTd75FNFr3acICMWOTMkmVsXsCdIOXDmne8dURKmxLgFU1F8+yf01YhTY0xUBJ8
	E3rBdqB4qNAQaba+VYBC6U+nnWkFb0VBZqXLZuc1CbIoBH6I/o7xdzGBNXia8iDgINWZPljBZsl
	GyxftaiG9Vc/p0qf92yPg/mNgJmoCGDIY3hPRUlEdCRfTdbvvpkhssF6c07rDlw==
X-Received: by 2002:a05:6a00:414e:b0:80a:fc3c:f839 with SMTP id d2e1a72fcca58-82a198b2533mr3706322b3a.49.1773430572105;
        Fri, 13 Mar 2026 12:36:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:414e:b0:80a:fc3c:f839 with SMTP id d2e1a72fcca58-82a198b2533mr3706294b3a.49.1773430571528;
        Fri, 13 Mar 2026 12:36:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07366974sm6736893b3a.48.2026.03.13.12.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 12:36:11 -0700 (PDT)
Date: Sat, 14 Mar 2026 03:36:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/14] xfs: test xfs_healer can report file media errors
Message-ID: <20260313193607.2ds5gxfogf4sdfzs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <177311403712.1186408.7032564474004561606.stgit@frogsfrogsfrogs>
 <177311403923.1186408.14451135693864403499.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177311403923.1186408.14451135693864403499.stgit@frogsfrogsfrogs>

On Mon, Mar 09, 2026 at 08:52:13PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make sure that xfs_healer can actually report media errors as found by the
> kernel.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Tests and looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/1897     |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1897.out |    7 ++
>  2 files changed, 179 insertions(+)
>  create mode 100755 tests/xfs/1897
>  create mode 100755 tests/xfs/1897.out
> 
> 
> diff --git a/tests/xfs/1897 b/tests/xfs/1897
> new file mode 100755
> index 00000000000000..4670c333a2d82c
> --- /dev/null
> +++ b/tests/xfs/1897
> @@ -0,0 +1,172 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test No. 1897
> +#
> +# Check that xfs_healer can report media errors.
> +
> +. ./common/preamble
> +_begin_fstest auto quick scrub eio selfhealing
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	_dmerror_cleanup
> +}
> +
> +. ./common/fuzzy
> +. ./common/filter
> +. ./common/dmerror
> +. ./common/systemd
> +
> +_require_scratch
> +_require_scrub
> +_require_dm_target error
> +_require_command "$XFS_HEALER_PROG" "xfs_healer"
> +_require_xfs_io_command verifymedia
> +
> +filter_healer() {
> +	_filter_scratch | \
> +		grep -E '(media failed|media error)' | \
> +		sed \
> +		    -e 's/datadev/DEVICE/g' \
> +		    -e 's/rtdev/DEVICE/g' \
> +		    -e 's/ino [0-9]*/ino NUM/g' \
> +		    -e 's/gen 0x[0-9a-f]*/gen NUM/g' \
> +		    -e 's/pos [0-9]*/pos NUM/g' \
> +		    -e 's/len [0-9]*/len NUM/g' \
> +		    -e 's/0x[0-9a-f]*/NUM/g' \
> +		    -e 's|SCRATCH_MNT/a|VICTIM|g' \
> +		    -e 's|SCRATCH_MNT ino NUM gen NUM|VICTIM|g'
> +}
> +
> +filter_verify() {
> +	sed -e 's/\([a-z]*dev\): verify error at offset \([0-9]*\) length \([0-9]*\)/DEVICE: verify error at offset XXX length XXX/g'
> +}
> +
> +_scratch_mkfs >> $seqres.full
> +
> +# The dm-error map added by this test doesn't work on zoned devices because
> +# table sizes need to be aligned to the zone size, and even for zoned on
> +# conventional this test will get confused because of the internal RT device.
> +#
> +# That check requires a mounted file system, so do a dummy mount before setting
> +# up DM.
> +_scratch_mount
> +_require_xfs_scratch_non_zoned
> +_require_xfs_healer $SCRATCH_MNT
> +_scratch_unmount
> +
> +_dmerror_init
> +_dmerror_mount
> +
> +# Write a file with 4 file blocks worth of data, figure out the LBA to target
> +victim=$SCRATCH_MNT/a
> +file_blksz=$(_get_file_block_size $SCRATCH_MNT)
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((4 * file_blksz))" -c "fsync" $victim >> $seqres.full
> +unset errordev
> +verifymediadev="-d"
> +
> +awk_len_prog='{print $6}'
> +if _xfs_is_realtime_file $victim; then
> +	if ! _xfs_has_feature $SCRATCH_MNT rtgroups; then
> +		awk_len_prog='{print $4}'
> +	fi
> +	errordev="RT"
> +	verifymediadev="-r"
> +fi
> +bmap_str="$($XFS_IO_PROG -c "bmap -elpv" $victim | grep "^[[:space:]]*0:")"
> +echo "$errordev:$bmap_str" >> $seqres.full
> +
> +phys="$(echo "$bmap_str" | $AWK_PROG '{print $3}')"
> +len="$(echo "$bmap_str" | $AWK_PROG "$awk_len_prog")"
> +
> +fs_blksz=$(_get_block_size $SCRATCH_MNT)
> +echo "file_blksz:$file_blksz:fs_blksz:$fs_blksz" >> $seqres.full
> +kernel_sectors_per_fs_block=$((fs_blksz / 512))
> +
> +# Did we get at least 4 fs blocks worth of extent?
> +min_len_sectors=$(( 4 * kernel_sectors_per_fs_block ))
> +test "$len" -lt $min_len_sectors && \
> +	_fail "could not format a long enough extent on an empty fs??"
> +
> +phys_start=$(echo "$phys" | sed -e 's/\.\..*//g')
> +
> +echo "$errordev:$phys:$len:$fs_blksz:$phys_start" >> $seqres.full
> +echo "victim file:" >> $seqres.full
> +od -tx1 -Ad -c $victim >> $seqres.full
> +
> +# Set the dmerror table so that all IO will pass through.
> +_dmerror_reset_table
> +
> +cat >> $seqres.full << ENDL
> +dmerror before:
> +$DMERROR_TABLE
> +$DMERROR_RTTABLE
> +<end table>
> +ENDL
> +
> +# All sector numbers that we feed to the kernel must be in units of 512b, but
> +# they also must be aligned to the device's logical block size.
> +logical_block_size=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +kernel_sectors_per_device_lba=$((logical_block_size / 512))
> +
> +# Pretend as bad one of the device LBAs in the middle of the extent.  Target
> +# the second LBA of the third block of the four-block file extent that we
> +# allocated earlier, but without overflowing into the fourth file block.
> +bad_sector=$(( phys_start + (2 * kernel_sectors_per_fs_block) ))
> +bad_len=$kernel_sectors_per_device_lba
> +if (( kernel_sectors_per_device_lba < kernel_sectors_per_fs_block )); then
> +	bad_sector=$((bad_sector + kernel_sectors_per_device_lba))
> +fi
> +if (( (bad_sector % kernel_sectors_per_device_lba) != 0)); then
> +	echo "bad_sector $bad_sector not congruent with device logical block size $logical_block_size"
> +fi
> +_dmerror_mark_range_bad $bad_sector $bad_len $errordev
> +
> +cat >> $seqres.full << ENDL
> +dmerror after marking bad:
> +$DMERROR_TABLE
> +$DMERROR_RTTABLE
> +<end table>
> +ENDL
> +
> +_dmerror_load_error_table
> +
> +echo "Simulate media error"
> +_scratch_invoke_xfs_healer "$tmp.healer"
> +echo "verifymedia $verifymediadev -R $((bad_sector * 512)) $(((bad_sector + bad_len) * 512))" >> $seqres.full
> +$XFS_IO_PROG -x -c "verifymedia $verifymediadev -R $((bad_sector * 512)) $(((bad_sector + bad_len) * 512))" $SCRATCH_MNT 2>&1 | filter_verify
> +
> +# Now mark the bad range good so that a retest shows no media failure.
> +_dmerror_mark_range_good $bad_sector $bad_len $errordev
> +_dmerror_load_error_table
> +
> +cat >> $seqres.full << ENDL
> +dmerror after marking good:
> +$DMERROR_TABLE
> +$DMERROR_RTTABLE
> +<end table>
> +ENDL
> +
> +echo "No more media error"
> +echo "verifymedia $verifymediadev -R $((bad_sector * 512)) $(((bad_sector + bad_len) * 512))" >> $seqres.full
> +$XFS_IO_PROG -x -c "verifymedia $verifymediadev -R $((bad_sector * 512)) $(((bad_sector + bad_len) * 512))" $SCRATCH_MNT >> $seqres.full
> +
> +# Unmount filesystem to start fresh
> +echo "Kill healer"
> +_scratch_kill_xfs_healer _dmerror_unmount
> +
> +# filesystems without rmap do not translate media errors to lost file ranges
> +# so fake the output
> +_xfs_has_feature "$SCRATCH_DEV" rmapbt || \
> +	echo "VICTIM pos 0 len 0: media failed" >> $tmp.healer
> +
> +cat $tmp.healer >> $seqres.full
> +cat $tmp.healer | filter_healer
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/1897.out b/tests/xfs/1897.out
> new file mode 100755
> index 00000000000000..1bb615c3119dce
> --- /dev/null
> +++ b/tests/xfs/1897.out
> @@ -0,0 +1,7 @@
> +QA output created by 1897
> +Simulate media error
> +DEVICE: verify error at offset XXX length XXX: Input/output error
> +No more media error
> +Kill healer
> +SCRATCH_MNT DEVICE daddr NUM bbcount NUM: media error
> +VICTIM pos NUM len NUM: media failed
> 

