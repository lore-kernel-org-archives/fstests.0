Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3622339
	for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008125; cv=none; b=D2+EUcrQqY1IYgbGhp2fqbr6TqFgi9qygQLwIEiQrCDAK45V2br1Uvpk/W5IVxyw2Ewh1qWYMpwXgnZQdmElhQc06KLOSL7xcviEokrxk4xl75mJGEcOUh8wjBO7RVZEVvKIskpAA1Mo8jAVzl+XzxS9Xk1XmAtPtXzylx2YXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008125; c=relaxed/simple;
	bh=eBFdVMXD4K3y+R9IuCmqlMWzMAYo3tiDos5S5wgGzhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pa9ePVOpRIdVlI20+39NxqWYmnxaMr9vnI60xSe/E1Fj+lwRSfkXpGW0Z0zTUO1L17mRuXMxtbow6W+eL0YLHpraHfEDk0g9vrQFV+uKaUaxP2XrOphIBlAfgW1FwMz5Jr1AjT8pW3ts/oVBiOq36e4I0ll+t2PfFByWdlgwg48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ih7r3i0L; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uL7cEToR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ih7r3i0L";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uL7cEToR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769008122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VTY5Cbg4kzYNPs/GQT6uxYnLQhkqTcHtBfwSxxMgvSs=;
	b=Ih7r3i0LJGRPRVZd6ujf1VqL4xs+v+VacrWmh8FNmUOigv3x7tclA1IJY8eSTnxPJOQnFP
	WpTZp4kMVgLUlYvbWx+MxrHEHs6D/60xQJgwmbovZFK9c0cyUL7HXsZcFfXjgw8ZbTIlXP
	euiM/pZFUt2+HvHm19RZCYI+5oapvKI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-_ByCqjf5PJSwlgJDeKqBvA-1; Wed, 21 Jan 2026 10:08:41 -0500
X-MC-Unique: _ByCqjf5PJSwlgJDeKqBvA-1
X-Mimecast-MFC-AGG-ID: _ByCqjf5PJSwlgJDeKqBvA_1769008119
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352ec74a925so1843399a91.2
        for <fstests@vger.kernel.org>; Wed, 21 Jan 2026 07:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769008119; x=1769612919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTY5Cbg4kzYNPs/GQT6uxYnLQhkqTcHtBfwSxxMgvSs=;
        b=uL7cEToR3iudmy+X1wyvUGvT09VcpzNyXmekPU2TJK/hPugLfbcicEJJ/1jH8YhgmI
         GGQc6F3wlfukrrmXZ8Bu3N30oeMHlKFrB7JT/tkLdOsCYxw+M386mF6AqxR+RGhjhtvY
         PNKs7TjY6WnYKL3ybIyqkHx1YpPeKyOcUGyHdXq+cT5LRgHjXsa8ourWCIgKzPU7IDov
         5OCP1/ma3qOePxMx1Zss18ixopjxcoproLJkOxM2Uq2pZX+kgBQa/rvxoe6RqMoluxYs
         Q9oR6fDFrz1bFkoh5h5gcqjLbOBrtyKUylS9VacYh2JnocOEvrm+PQA6YLAglqx3gfI1
         Z/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769008119; x=1769612919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTY5Cbg4kzYNPs/GQT6uxYnLQhkqTcHtBfwSxxMgvSs=;
        b=kK2FvTxbswl4qsibWFf6DV6KfuHVtooM5TfDLO4LEJhqOw7Mg53HuMmhspcxQbcs7V
         Qxzj9a2EFUfXajxtGmEWWN6E5A4gDaphtxo0Wf1PZI6fUQHqjMW2AcFXU1m52ePciw91
         2cAWW1ED3k65m9O2+soKkV1I2rivVxjWS+bOjdFFnzXN14LueJpULXWP+ks3EDEu2l+0
         Ywgr2hTPFPiZe+nNjhMXdSnWby4NgknACGMSgwM3kO9IO8VQv3Q4azJbvg7MfU4hla9y
         NG9t69ARqQU/b/kCD4I4HX8u2gjiaQpzOVGf9NvmREQHN3252TUCbE4JWYaLZ/VM/a6S
         YsNw==
X-Forwarded-Encrypted: i=1; AJvYcCXi7veRI3q4FlhUQED8K9qJm+fotULNwSmjMbj9AGvZiHjcfZzDq0dsWV4K0YsKW6fjk2iV35cL@vger.kernel.org
X-Gm-Message-State: AOJu0YwVB0jGFalw2BYBkbA4Ykx4QBJJlHVkiBGgsJ5geJOGIgN9jr77
	5H73Ei/fDB54TLoE9LUXdMX0Pe/X8wXqvxQOhsLBvYLrYr3ImbXQHNdEVK7lwGsmk//03Kgu8yi
	rJFun4PaNl7gcOGj5otAuMAII+3WjVJmIrL6u5tGnz0ZnRUQPDlT+1n5it+k=
X-Gm-Gg: AZuq6aIcgsMAGPBiGpton19iyBOhnunbPIO1y712/7Ppa0ETf4d5zvUGobR2CqdWcad
	MVJmdwbG1XM3EvhhLB3IvSM+dcUH3SpG9rKmM3j3uCi5gD4tSVVqnPnMllVLCxEtkaXNV/PLYId
	kF3RGEAIRkqaG8+M+sdpQdVFBTl8C3Es+3h0ugtcQ8knUsigsISrxQ4J4m/4q6uqkj63/R0smjU
	teNJHcQipLuqs9OkYOiXYAIugaEw3h+0aRTeQN/HlpeY25F/iJVnOoTuGoQxTg7bJpXU9OqHYKS
	uX+n5jFD81QxPKrjsTEG3tUs4u5eTFztrUugFB5Llbd/wgFmu7072PqAwGl6tNmknNTaItzCnIb
	Z3EB6LupvoNhv0bgRap7KtaJt2IGRj6gmfRadDf71hK3+oBLFmw==
X-Received: by 2002:a05:6a20:734f:b0:319:fc6f:8adf with SMTP id adf61e73a8af0-38e45d09ca3mr5775672637.12.1769008118573;
        Wed, 21 Jan 2026 07:08:38 -0800 (PST)
X-Received: by 2002:a05:6a20:734f:b0:319:fc6f:8adf with SMTP id adf61e73a8af0-38e45d09ca3mr5775642637.12.1769008118036;
        Wed, 21 Jan 2026 07:08:38 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ca923sm8904522a91.3.2026.01.21.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:08:37 -0800 (PST)
Date: Wed, 21 Jan 2026 23:08:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, ebiggers@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic: test that truncate(2) on fsverity is blocked
Message-ID: <20260121150833.shad4rfhqd4deg2s@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260119062404.3998871-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119062404.3998871-1-hch@lst.de>

On Mon, Jan 19, 2026 at 07:24:04AM +0100, Christoph Hellwig wrote:
> truncate(2) doesn't go through open and needs special code to block
> it on fsverity files.  btrfs was missing this check.
> 
> Note that truncate(2) in current core utils uses openat and ftruncate,
> so add our own little test program for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  src/Makefile          |  2 +-
>  src/truncate.c        | 17 +++++++++++++++++
>  tests/generic/788     | 37 +++++++++++++++++++++++++++++++++++++
>  tests/generic/788.out |  4 ++++
>  4 files changed, 59 insertions(+), 1 deletion(-)
>  create mode 100644 src/truncate.c
>  create mode 100755 tests/generic/788
>  create mode 100644 tests/generic/788.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index d0a4106e6be8..577d816ae859 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
>  	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> -	dio-writeback-race unlink-fsync
> +	dio-writeback-race unlink-fsync truncate

Need to add this into .gitignore too :)

>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/truncate.c b/src/truncate.c
> new file mode 100644
> index 000000000000..4c106d26f29e
> --- /dev/null
> +++ b/src/truncate.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2026 Christoph Hellwig.
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +
> +int main(int argc, char **argv)
> +{
> +	if (truncate(argv[1], 0) < 0) {
> +		perror("truncate");
> +		exit(1);
> +	}
> +
> +	fprintf(stderr, "truncate succeeded\n");
> +}
> diff --git a/tests/generic/788 b/tests/generic/788
> new file mode 100755
> index 000000000000..02959037e7c3
> --- /dev/null
> +++ b/tests/generic/788
> @@ -0,0 +1,37 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Christoph Hellwig.
> +#
> +# FS QA Test 788
> +#
> +# Test that truncate(2) is blocked on fsverity files.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick verity
> +
> +_cleanup()
> +{
> +	cd /
> +	_restore_fsverity_signatures
> +	rm -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/verity
> +
> +_require_test

Does this case need TEST_DEV and TEST_DIR?

> +_require_scratch_verity
> +_disable_fsverity_signatures
> +
> +_scratch_mkfs_verity &>> $seqres.full
> +_scratch_mount
> +
> +fsv_file=$SCRATCH_MNT/file.fsv
> +
> +_fsv_scratch_begin_subtest "Using truncate(2) on a verity file fails"
> +_fsv_create_enable_file $fsv_file
> +$here/src/truncate $fsv_file

_require_test_program "truncate"

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/788.out b/tests/generic/788.out
> new file mode 100644
> index 000000000000..11074b71f3eb
> --- /dev/null
> +++ b/tests/generic/788.out
> @@ -0,0 +1,4 @@
> +QA output created by 788
> +
> +# Using truncate(2) on a verity file fails
> +truncate: Operation not permitted
> -- 
> 2.47.3
> 
> 

