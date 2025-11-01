Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333B1BD9F0
	for <fstests@vger.kernel.org>; Sat,  1 Nov 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007881; cv=none; b=e24bkA8CTx91MBGWxAHFrWCUq9I0qooS1wYaj2QmAFgmynNOXKUmd/pIPFsucdO+bbWqsER6ihnfSjTEiZIAWXI16QqAUKbSYQejkhJ+cZpsP8vgIyiY2JVkpDarAWDMXlwyVxJemRdNsSW5WD58rO+4LHD8vvR2CWnLyC5zHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007881; c=relaxed/simple;
	bh=5xrtme0M35LHb7Ravpc/2oqNOBSqV33UC7vg9B2GkC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSd34FAb7RxzcxePL5gjGlhOq5pgIR/Wxsi/CeRnMgtEuuqTBwJTHX+fO6iN4gDM14x+ik+3Vs7SKLSKa5rsmOPbvZIRbK8l3YsE42XxCkUieWFt0XjfAbtpzhvMMCOtqKh23H1GpS0h9j/dVHyDCseh8RZWyOCtXjGNhxU7XG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kqp0ICJo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aP1Qe/7Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kqp0ICJo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aP1Qe/7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762007878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Umq9M+XmGlgwHm4b4VdDdK4FbbajOy940uei2dPKvrQ=;
	b=Kqp0ICJo6SDW0IhESoNUklBV+zhhq2Bqv7tpehfhbIQx7wFpKWD5EAUWJqGttuWtSuXFJI
	S6hJXIJDw/YoOb25Jkw98ROd6am0TiiDIpzKBhVACnVjIUMvgBqBrmoR9f3hrsYow56F9I
	wYgcZwMyQQhcVRSYTgSL4WmveveJeO4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-fsLmyiPfM9ao2r4Ii6KnsA-1; Sat, 01 Nov 2025 10:37:57 -0400
X-MC-Unique: fsLmyiPfM9ao2r4Ii6KnsA-1
X-Mimecast-MFC-AGG-ID: fsLmyiPfM9ao2r4Ii6KnsA_1762007877
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78117b8e49fso6661077b3a.3
        for <fstests@vger.kernel.org>; Sat, 01 Nov 2025 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762007876; x=1762612676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Umq9M+XmGlgwHm4b4VdDdK4FbbajOy940uei2dPKvrQ=;
        b=aP1Qe/7Q3LISBP5WR54L+baUzi6fl7/mUohZnGsc4WMy/p0jywB2/gQ2bCrMLGYBrZ
         5khTXrpcncgjhlx8ZcaLoqkEykPvh+QHOd5Sd/VAfDWg+Ew8EYB/MmxXQpjXwgrzBuCu
         wfb8hazXLxdpgiFk8GlqhkpgeG/7iURx7h2gnuUSOT13r7RtH4SwO4FeNHcVlW+LClmV
         8pbnq0a9i2zdICrsywto3CUm+6FpjrUV35fqP7UJ0Lvv7KEpI6RckcW/UqufN+PhMOYk
         SQCRgMrVFu85vb7USNAi4r/hJtjdnNYkUKKSnBITdnrP4yWs88qQWSEQrcNUCaisEJvH
         Hnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007876; x=1762612676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Umq9M+XmGlgwHm4b4VdDdK4FbbajOy940uei2dPKvrQ=;
        b=XK6X00x2/C1q8kdAWFl0B2ly4XdlV7WQ/3k9doHpASJjmHAFi7WqPzu/gNWx20C7wC
         5eI+mDigrxz7jWrbKgbVfVfFwUEE5JIQxkaAZHhLhboYhA8M09q65jigVxNijWA9MJPF
         ZHPEhXHW2cLPGxR2/uEFzW8KVrwJfUP/PPOvfQdAIaRJaZqZ2tCME8tY4WQNRrFi2GFp
         aLTZEcCP4HUxnPjpYOJl0ltvOuZ81Dm++H9EqFIkLJLgC67XwdVh/Gkk5hCgy5lDgvb3
         NDbBV0DBo03/Q8Jx1eC5Yu03mfUfSQlfB0bQDAi0ZofbKWIAwluOz2gp0mrJO/Li/RWF
         6B4w==
X-Gm-Message-State: AOJu0YwigK0MB8Pgb+sr9mk4cJUjla/VTtBM7far5ZzBtoj44Srg+Ak6
	YYV6Iygslk77bXPi804CqgjejzZND5BQqNq7mqOxjMwUQDTKqFLYOe7kHOcxWVZCNz99PQ1JLYA
	RleprR30M/bOQ6NxjWBYyCGhyWB/RarnGk4fimHC0P8gyAOQS/Mczpfeoe7byCM5Yethm3w==
X-Gm-Gg: ASbGncv5EB/4Y1dmxQ7XpiLmnt2fLO10J8X8HPDCFMJ5LYzZXjMDEpzYW6f+EfEK9sQ
	Xi80fgOKORMm3UzuZwtenW2fmIE38PFU8IWqr7uxql4tfOtYLhR5BhplhIXgU/gJ0LAoOg5E5lo
	v3AQGgsYSraCJdnUIxFRn+ty8MCjzGenm+7p103ljGCsr+TUgfP0XHnJEsFJHtkIt2lFyLJgc2H
	jAMpVWgrBBKzeO7WDxSyHE8Qh/AKdKU/kTIszilGe49Wm6JCRGztQKtVZjDKE/elWmbSlhuNAXB
	/Q7HQUWTaJB9usPQ7XyPXDPTgg5jHrw8UFHp+Z1VExoY8kUKql1yYLO//TpQeLTltW3q+ggAiRl
	n8M6UDb2KBN2+keRFZ2ViOYwUGHtxk4ADsOemtsU=
X-Received: by 2002:a05:6a20:431e:b0:33b:4747:a258 with SMTP id adf61e73a8af0-348cc8e36c8mr10262100637.46.1762007875866;
        Sat, 01 Nov 2025 07:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1bramBp29coOQwB1J5tkWmqu1MB/4bEq06symZeYDhvMyDSCCWzUIWyD9PIId0tf8vL8GtQ==
X-Received: by 2002:a05:6a20:431e:b0:33b:4747:a258 with SMTP id adf61e73a8af0-348cc8e36c8mr10262078637.46.1762007875378;
        Sat, 01 Nov 2025 07:37:55 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d9261c1fsm5428119b3a.30.2025.11.01.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:37:54 -0700 (PDT)
Date: Sat, 1 Nov 2025 22:37:50 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test a scenario of dir fsync after adding a
 link to a subdir
Message-ID: <20251101143637.oiapisxxxl2q3qzk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <92f178d04f74f9281b97d67bdf402e7a5e3baec9.1761752457.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f178d04f74f9281b97d67bdf402e7a5e3baec9.1761752457.git.fdmanana@suse.com>

On Wed, Oct 29, 2025 at 03:46:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we add a new directory to the root directory, change a file
> in the root directory, fsync the file, add a hard link for the file inside
> the new directory and then fsync the root directory, after a power failure
> the root directory has the entry for the new directory.
> 
> This is a regression test for the following btrfs patch:
> 
>  "btrfs: do not update last_log_commit when logging inode due to a new name"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/780     | 73 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/780.out | 10 ++++++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tests/generic/780
>  create mode 100644 tests/generic/780.out
> 
> diff --git a/tests/generic/780 b/tests/generic/780
> new file mode 100755
> index 00000000..d4977b06
> --- /dev/null
> +++ b/tests/generic/780
> @@ -0,0 +1,73 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 780
> +#
> +# Test that if we add a new directory to the root directory, change a file in
> +# the root directory, fsync the file, add a hard link for the file inside the
> +# new directory and then fsync the root directory, after a power failure the
> +# root directory has the entry for the new directory.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_dm_target flakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: do not update last_log_commit when logging inode due to a new name"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our test file.
> +touch $SCRATCH_MNT/foo
> +
> +# Make sure it's durably persisted.
> +_scratch_sync
> +
> +# Create a test directory in the root dir.
> +mkdir $SCRATCH_MNT/dir
> +
> +# Write some data to the file and fsync it.
> +$XFS_IO_PROG -c "pwrite -S 0xab 0 64K" \
> +	     -c "fsync" $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Add a hard link for our file inside the test directory.
> +# On btrfs this causes updating the file's inode and both parent
> +# directories in the log tree (in memory only).
> +ln $SCRATCH_MNT/foo $SCRATCH_MNT/dir/bar
> +
> +# Fsync the root directory.
> +# We expect it to persist the entry for directory "dir".
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# The directory "dir" should be present as well as file "foo".
> +# Filter the 'lost+found' that only exists in some filesystems like ext4.
> +echo "Root content:"
> +ls -1 $SCRATCH_MNT | grep -v 'lost+found'
> +
> +# Also check file "foo" has the expected data.
> +echo "File data:"
> +_hexdump $SCRATCH_MNT/foo
> +
> +_unmount_flakey
> +
> +_exit 0
> diff --git a/tests/generic/780.out b/tests/generic/780.out
> new file mode 100644
> index 00000000..3be43734
> --- /dev/null
> +++ b/tests/generic/780.out
> @@ -0,0 +1,10 @@
> +QA output created by 780
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Root content:
> +dir
> +foo
> +File data:
> +000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
> +*
> +010000
> -- 
> 2.47.2
> 
> 

