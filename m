Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B494285CA3
	for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703369; cv=none; b=F85W3/rTRTDHc/TNGOvbcAcfvfALGOE95AOUe4oDc05BJQoAplsdDCV/Ncr4FbMVno34Fp0J1AfF59POgoivzOCJTQ0ItJutXmlvXNRCWcy3k31zIZBedIupUrkEi9tRtULF3u80br9haSznVvZNHhDpb6gmipKbbfl90wbJc4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703369; c=relaxed/simple;
	bh=EwwSvN92DNca0HSCST/dQDHzvEqsfgz5P7FZH5OXtuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kt7W/QI4AAi/FDn1VcOTFIulNZrl3znRFmBkCo9vsDaKeQur+c3i/g7Jn+1ngNYXJ5a5WK/mjrvCC5HetunfjqhmCZqA1P2FYOsu5p8mgDUaarhCvhG2XuIlmwPuamy4WKyJrfKb7IxFAyKvyLZR9HT//HEx+gqoeFuNIGR3tpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3ezCmFy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uCSQaL4A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3ezCmFy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uCSQaL4A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dKHq98ZoMSm9VcTZGrlO9/i5n6OjC1jlHCDsJvcwSSg=;
	b=I3ezCmFyIB/8n/hk6pvbwv5on6PJft07Uu9Qt9Ms+Awcs/qfcWSw08Ta2aZ2hGtxpJGst5
	ApJlUOPld7pJoWtd6iXAiBcWyje4StjNmSe+ICSk9Vpu9+g5FnNMY3iItc5+6GnMxblWLQ
	OTMprojCO0zXxHihmQWMi7uvPxVYVoo=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-bT-i_kFhN2aZiU2K8hqMoA-1; Thu, 29 Jan 2026 11:16:05 -0500
X-MC-Unique: bT-i_kFhN2aZiU2K8hqMoA-1
X-Mimecast-MFC-AGG-ID: bT-i_kFhN2aZiU2K8hqMoA_1769703364
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81ed3e6b917so1019886b3a.1
        for <fstests@vger.kernel.org>; Thu, 29 Jan 2026 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769703363; x=1770308163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dKHq98ZoMSm9VcTZGrlO9/i5n6OjC1jlHCDsJvcwSSg=;
        b=uCSQaL4A2rzOca9P2ng5VkcTdf9lCbzVgb+PvSCEaJGKgOx/vhpCNLsriejvDeVcRn
         Pw1aI8wA5BdsKe2y8CWbczv/TaNJBOs+sx3NlCfe+gJ6Oj84oi8iDhRmAoU9WSQPmTsi
         qUO0sSsYh+eeWUbodasiHEeE6GTRmE39q1zTGfCUcy2hgpPo8pZBg5eoWua80+bwUc8B
         GbEbex6/DtiDkOMablf6Ur3EIWDIULrzbLdDQGWxnFF8ILEiuwi/1cfNgUDnhKZ6HoYP
         2iC/9YY5fBBfYU7QQMhz8/gaQEkNFA7P5EfZv74CA34Zpz3T5t2PHHCCdFH9PskaJlIX
         c0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769703363; x=1770308163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKHq98ZoMSm9VcTZGrlO9/i5n6OjC1jlHCDsJvcwSSg=;
        b=VG0BDmMwVoy1F6Z3LPlgTr6FYViRgyHVx1+W5i73aHAIafnKSQ+BfnnYH4t+gGaYrA
         TVufofRR7vOMzhj3urEA5uiovyzFI2qXPND6YzdIQqhZA1wWp4R42ubKeCWm0mYM4j1x
         kZh8HE7ddUOIYJgW9WEFDbIYB+Y7dc1IAXRT/xhjZIDv12yOLku14oTU1VB4GxfQ++Rp
         9xrMc/AD8NUXlBFdRD1ZvHI4yodsmvXfoo19InvEY9UcHoK0kC47b4a27iZhZzqK0eaL
         IJiF7CFpHms26hTBfXF3ThHOPDTrPtUfsK3vZsclMK2lFLGbswd3P178CLFXKPD0tuak
         6epg==
X-Forwarded-Encrypted: i=1; AJvYcCU/nxMaOhAzSvlOIWQH6EJ7pElmMZhHJ6ubLpyW6YhwiRIWhrhooLiXAjPR7Ned+ReXzsB0EhJo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JHQIlPM0+ei1j/S37mCBknfP1QBmHzfllc+Ma8hc6UcJrp52
	rl89FHDR1RScA3PhEs7T3Ps3ROimxspS+w2bml6JO/9YmUQfCdrTmixPQAQZ5JrjZKAv+1tGdRv
	NtbrJCi0Ja40D/6EljwNHCRGT1WQbtpaR1xpgFRHtkgau6vDqwIrFPxnCSUrrZhOJhJo=
X-Gm-Gg: AZuq6aLFRLFiMX83xPodTkRPA9JjpkRg4RI5NC2KGJWMmS3LaRne1d5B87sreEUV7qM
	5/3jHuCUaWk8IAhvUYRwXnLbDIgbHU0/M8lQsGYx1KGptxgqMGSF6n7hRsDVQWAkdlliHzZf7yo
	g9SJQeToXQLautijTWTGsWtv1845Txf9MuRLp/Ye28bA2nnQMutC6AWUS92FZ7mcNBWeVUuIeWG
	RuBJKvdh7O1gSKAiS3kLKpe2X2/dFs3tp1Tkx7HkHVY4Y13BDFU5K2tgisyAU+gimaW+VmqVZ73
	EwXwuMcLEaL1ZtOarOUlS01L49MXBTn2TD3xUHwGGjJ5iX+lFq+h/CaOL7A00AJvWDZkEUW/V2d
	pGN1QPdfg3CYE2aLNqPS8L0/QfrnhW0uVciReQFXFUb58BUAh3A==
X-Received: by 2002:a05:6a00:bd82:b0:821:81ef:5de8 with SMTP id d2e1a72fcca58-82369161826mr9305791b3a.12.1769703363108;
        Thu, 29 Jan 2026 08:16:03 -0800 (PST)
X-Received: by 2002:a05:6a00:bd82:b0:821:81ef:5de8 with SMTP id d2e1a72fcca58-82369161826mr9305768b3a.12.1769703362635;
        Thu, 29 Jan 2026 08:16:02 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b58f38sm6226783b3a.24.2026.01.29.08.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 08:16:02 -0800 (PST)
Date: Fri, 30 Jan 2026 00:15:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, ebiggers@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: test that truncate(2) on fsverity is blocked
Message-ID: <20260129161557.ulbwz37cyrtrvq3u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260126130927.11585-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126130927.11585-1-hch@lst.de>

On Mon, Jan 26, 2026 at 02:08:43PM +0100, Christoph Hellwig wrote:
> truncate(2) doesn't go through open and needs special code to block
> it on fsverity files.  btrfs was missing this check.
> 
> Note that truncate(2) in current core utils uses openat and ftruncate,
> so add our own little test program for it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> Changes since v1:
>  - add the new binary to .gitignore
>  - add a _require_test_program "truncate" call
>  - drop the _require_test call

Thanks, this version is good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/truncate.c        | 17 +++++++++++++++++
>  tests/generic/788     | 38 ++++++++++++++++++++++++++++++++++++++
>  tests/generic/788.out |  4 ++++
>  5 files changed, 61 insertions(+), 1 deletion(-)
>  create mode 100644 src/truncate.c
>  create mode 100755 tests/generic/788
>  create mode 100644 tests/generic/788.out
> 
> diff --git a/.gitignore b/.gitignore
> index 82c57f415301..2b5bedd59fce 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -212,6 +212,7 @@ tags
>  /src/dio-writeback-race
>  /src/unlink-fsync
>  /src/file_attr
> +/src/truncate
>  
>  # Symlinked files
>  /tests/generic/035.out
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
> index 000000000000..ac4720d740f0
> --- /dev/null
> +++ b/tests/generic/788
> @@ -0,0 +1,38 @@
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
> +_require_scratch_verity
> +_require_test_program "truncate"
> +
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

