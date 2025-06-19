Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AA22D79F
	for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 07:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319915; cv=none; b=gIN5sK+CIwQeQt7qWCi3a8szSA+fbPhpGgFgLUUQ+NOdaZd4fCeFCLdETvdDoc5E49P+YswZJi2MEdK/NkFDmLPOk+4kIHM8jyAtFmne3fCNYOcQGS9A7F0l4VO8Bezr090NrkDWGZaO69YJ6uJkBeZhtVbuztbrS4kgEql1rQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319915; c=relaxed/simple;
	bh=69S7s/gMK3/kq+D9zBGtSXp92k8m92sRoVNxC4kIIUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obmpHpUbExWNgCQZ1zKHXWlJ6+xRpoMPzvBHvn4CmNFO2QNt4yLzkX9EFafbdX9Iw8ZFA5QyDXrE9rNtBlV2OYY+ZM+9Qtb9QyzWAGLLIv2+925OTQIGhS6MfhJcaiSIzw1x8zvBGhWVW0NG2NJgtq++eIMDsU8wQ69AO1Dbejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL2RYdzF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL2RYdzF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750319912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+iG89nZsXRr+M5YfaA9nYawnYrSq4Yc0MsrlgGzqFc=;
	b=OL2RYdzFz+5YGOimVe/mVvp016JN+Ld7NkVd0/aaPRrBh7YNaoHkdgj6YJTpudjdgQBfw4
	2qRkKeZhZVLRlsLRxKUjEVpkpCrxF2h1bxXyr6InxeOSU4SqmEuHXdsYsLUz8xMQ9/jyKv
	O9AXVFr/R/srbj64cGr5F1x9TcghWXc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-SGbsaLa2MsuSHyzNrv2qVQ-1; Thu, 19 Jun 2025 03:58:30 -0400
X-MC-Unique: SGbsaLa2MsuSHyzNrv2qVQ-1
X-Mimecast-MFC-AGG-ID: SGbsaLa2MsuSHyzNrv2qVQ_1750319910
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313fb0ec33bso524329a91.2
        for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 00:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750319909; x=1750924709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+iG89nZsXRr+M5YfaA9nYawnYrSq4Yc0MsrlgGzqFc=;
        b=NDK1ldIcF3dgfAVIT1w7OQqt/KavvhzyzQP4w2GGj35fSLMrqRbzwyChY3n3YWADEx
         7sEkif4el5TssF0PVxtTJSAYm3BMVFTygS6VXrT3KfthqOn7fbfA8hHXLnSUSzhE2fRz
         h5ZNKPRnGjlqJ/J6HFHq5to2/Yt2tCG4PsblU13Qj2xIp3l0vQ7Cez0/mY8RgHE3gLfh
         VfowWJh4OCgqfJ0uE274PPTeOIGonNmpkFgmfB7iEKF5AK+MYtCf4N/+NQo/o9rVGR9u
         9BCoddbFdfh+uq1RQn7/PYeJZ4k852k9Ae5JErtsF7IfXKSE3kCqPhDYf9Mi7xLLUwIe
         6Qkg==
X-Gm-Message-State: AOJu0YynXMxL4HKEHpd0dmSLKGKRErTZLo8ApnOeExWZ2QDsPzmeZzAn
	cRDtexVGSG0AhrpfySgbugmfef2HoBrIePytRB72MmPwfD+MODV/Gd8AuFndFDnJ8zaVMHyUqEj
	BVbgoN5Y7AofPapsJ5bc5OCmN6qF3EScQ9Hb93d6B/ZboFCpy1vk0sk9sTC8=
X-Gm-Gg: ASbGncsoMpyCIp0OT8vqBdnOBwAeUXHT4bKBftw70+KXSGlBrnBEMUcbkNwk+psofOo
	Yp5RbYb+W88s8XYbit7tTo6MbbiIbKfH7b3Jxy4dp1hPb4ShC6DqdoOM1+W5mxphhOc2VINpsYq
	CRBKsz4X36lG6tdwjV31AgLF/Pc05L/A+KA/bqA8hneaG6ITeb3+rGyDeH59C+yLAe+hPaAyoqE
	LPdC3l/uuSkkQEVDJ5h0iewhPN5+ek+WJCfAkJVu/0X2sKGia29l4wwa5sNn+W4xS4BZ8HOJZFV
	lsrgcQbWQYEo/3BVSffXrDvjUK7wmfCjQhrefFdjMzVYye2+CEf5YstGNoY+vHk=
X-Received: by 2002:a17:90b:3e4d:b0:311:ea13:2e6e with SMTP id 98e67ed59e1d1-313f1db9fd3mr30794827a91.28.1750319909509;
        Thu, 19 Jun 2025 00:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFxkhCucIBtAR1U1WGowwdWAYzIIR/RIGxqnRDFe1835QVEmVmLx8Dfb1/5HZkLqeaNQg+fA==
X-Received: by 2002:a17:90b:3e4d:b0:311:ea13:2e6e with SMTP id 98e67ed59e1d1-313f1db9fd3mr30794803a91.28.1750319909094;
        Thu, 19 Jun 2025 00:58:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2245d0sm1506716a91.3.2025.06.19.00.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:58:28 -0700 (PDT)
Date: Thu, 19 Jun 2025 15:58:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 12/12] ext4/064: Add atomic write tests for journal credit
 calculation
Message-ID: <20250619075824.cdmk322j6ynxrb5m@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <62f2d373b7ac8f1a5f49013ff64ca3051f7f803c.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f2d373b7ac8f1a5f49013ff64ca3051f7f803c.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:55PM +0530, Ojaswin Mujoo wrote:
> Test atomic writes with journal credit calculation. We take 2 cases
> here:
> 
> 1. Atomic writes on single mapping causing tree to collapse into
>    the inode
> 2. Atomic writes on mixed mapping causing tree to collapse into the
>    inode
> 
> This test is inspired by ext4/034.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/ext4/064     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/064.out |  2 ++
>  2 files changed, 77 insertions(+)
>  create mode 100755 tests/ext4/064
>  create mode 100644 tests/ext4/064.out
> 
> diff --git a/tests/ext4/064 b/tests/ext4/064
> new file mode 100755
> index 00000000..12e48ae3
> --- /dev/null
> +++ b/tests/ext4/064
> @@ -0,0 +1,75 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 034
> +#
> +# Test proper credit reservation is done when performing
> +# tree collapse during an aotmic write based allocation
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto quick quota fiemap prealloc atomicwrites
> +
> +# Import common functions.
> +
> +
> +# Modify as appropriate.
> +_exclude_fs ext2
> +_exclude_fs ext3
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "fiemap"

Great, this case notes the falloc and fiemap commands, and adds fiemap
and prealloc test groups. Other test patches refer to this.

> +_require_xfs_io_command "syncfs"
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands
> +
> +echo "----- Testing with atomi write on non-mixed mapping -----" >> $seqres.full
> +
> +echo "Format and mount" >> $seqres.full
> +_scratch_mkfs  > $seqres.full 2>&1
> +_scratch_mount > $seqres.full 2>&1
> +
> +echo "Create the original file" >> $seqres.full
> +touch $SCRATCH_MNT/foobar >> $seqres.full
> +
> +echo "Create 2 level extent tree (btree) for foobar with a unwritten extent" >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc 4k 4k" -c "pwrite 8k 4k" \
> +	     -c "pwrite 20k 4k"  -c "pwrite 28k 4k" -c "pwrite 36k 4k" \
> +	     -c "fsync" $SCRATCH_MNT/foobar >> $seqres.full
> +
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar >> $seqres.full
> +
> +echo "Convert unwritten extent to written and collapse extent tree to inode" >> $seqres.full
> +$XFS_IO_PROG -dc "pwrite -A -V1 4k 4k" $SCRATCH_MNT/foobar >> $seqres.full

_require_xfs_io_command pwrite -A

> +
> +echo "Create a new file and do fsync to force a jbd2 commit" >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/dummy >> $seqres.full
> +
> +echo "sync $SCRATCH_MNT to writeback" >> $seqres.full
> +$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT >> $seqres.full
> +
> +echo "----- Testing with atomi write on mixed mapping -----" >> $seqres.full
> +
> +echo "Create the original file" >> $seqres.full
> +touch $SCRATCH_MNT/foobar2 >> $seqres.full
> +
> +echo "Create 2 level extent tree (btree) for foobar2 with a unwritten extent" >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc 4k 4k" -c "pwrite 8k 4k" \
> +	     -c "pwrite 20k 4k"  -c "pwrite 28k 4k" -c "pwrite 36k 4k" \
> +	     -c "fsync" $SCRATCH_MNT/foobar2 >> $seqres.full
> +
> +$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar2 >> $seqres.full
> +
> +echo "Convert unwritten extent to written and collapse extent tree to inode" >> $seqres.full
> +$XFS_IO_PROG -dc "pwrite -A -V1 0k 12k" $SCRATCH_MNT/foobar2 >> $seqres.full
> +
> +echo "Create a new file and do fsync to force a jbd2 commit" >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/dummy2 >> $seqres.full
> +
> +echo "sync $SCRATCH_MNT to writeback" >> $seqres.full
> +$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT >> $seqres.full
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/ext4/064.out b/tests/ext4/064.out
> new file mode 100644
> index 00000000..d9076546
> --- /dev/null
> +++ b/tests/ext4/064.out
> @@ -0,0 +1,2 @@
> +QA output created by 064
> +Silence is golden
> -- 
> 2.49.0
> 
> 

