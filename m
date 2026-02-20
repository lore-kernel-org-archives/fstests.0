Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C22BDC32
	for <fstests@vger.kernel.org>; Fri, 20 Feb 2026 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602497; cv=none; b=AtQbSD5Ga+rauQ0tOBLm6EDv8ULlS/6x+pioUOjEDboEZYVIeKJQFkvU+j8nlFmLZG1PuK53kxBs2kZb9WtTHM/MQRs72xbExYPQSezVk/MB7O5kaHsIKWLnyETARm6v08OAzlj6942QLfHktoYWRxra/tedbhbS0DfowNov7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602497; c=relaxed/simple;
	bh=oGD0Dqtxdam/f2v6pXkHshry2SBRwhc39ZrZ++WLS7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJsWPVKuuL9KFzr3YOR+lzuH8Ef/+LcpEPwZceVFAYRgeBWzUdDJ69rGaZPH5tSzNGaznSYdOhPOgf2LawQAmikgYacpTOyzVTgCeIhAv4LLausJQ2PyU5uagjeAso+Uo/KVx4toQxOVdeoE4ZUxBjRVBV5tXpmSZZj4ZzkZlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfVfB865; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRlPlNO+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfVfB865";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRlPlNO+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771602495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UByZ/fZkiO75MPabPlfve5T92mlXJbTpDo0SxQ0ZYiU=;
	b=ZfVfB865+5R+J5rpgoWl9MopvJ/SAjHHCwpJIfKpRG/ZBVRpQAt29BzduGDF2Fi45d6s4r
	9riuXnxbci+X2mTz4mDuX9ZgJkGyDe5BcZ+9ru1+O4P1nMaEQ3BEQi2UQdXNMEXDwO5p4N
	68zBrguy2Yeu0dTnxsIBIdqJ1+dJl38=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-6RYNBj7XNx2zq8imaP4kyw-1; Fri, 20 Feb 2026 10:48:14 -0500
X-MC-Unique: 6RYNBj7XNx2zq8imaP4kyw-1
X-Mimecast-MFC-AGG-ID: 6RYNBj7XNx2zq8imaP4kyw_1771602492
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-824a2df507eso8131595b3a.2
        for <fstests@vger.kernel.org>; Fri, 20 Feb 2026 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771602492; x=1772207292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UByZ/fZkiO75MPabPlfve5T92mlXJbTpDo0SxQ0ZYiU=;
        b=PRlPlNO+WBrF0VxI9GtciNFEjazh6B7dcJawjFIAEMXhgoDjOqkbQ9zLOZz3aheGfQ
         q/MdTm+12pyciwcm27lHCJgQiGK2ho+3ODfGnowLCPfqa/N+Bl324hYckxzXabIrCek5
         yWsllJB40vXzUx0QcW3rhZyk2k49cqW9UYaiceXUemdmE1DXwjSAqGhJD72Lgnvvpkrv
         PHCpWfPUdxBEkKRv+k6uQ8jOFCLYkZ4PL64Rzfmqbcz2eTUBFSeG02FiF2L8qDp0nDX/
         veyPyTnGADLDghIZde7O9qADe1b8GJAJua6+XZx8vmUG8dD38EHPhRBYB+Po+O1BIr5U
         werQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771602492; x=1772207292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UByZ/fZkiO75MPabPlfve5T92mlXJbTpDo0SxQ0ZYiU=;
        b=YmJmoxQQPGnC3RxpyOZqtSztzmXKttEqnv3ZDbbCBVU2rUSwYO8wyP6FtwuIx2qjtR
         d1S3mCniXoIxvXCKx2NDShn946PGxo7YwD/Wr8yirSnJvvk+yuqERl/FsovI+Bt/Oj3v
         yH+M/i0q/Nz1AY6umNN7ZrXPlAMCXCDCZ80GNfbIc2Va9yRACpgfmPz0YrFYTjHNlCmA
         PBQizvd6t7ukEGmSQ29OtVWig0dxHOnVe9XwyDpxF8LQBef95tFEn29nOnu8SSDMQhmz
         IRuc3I/ATFw39tvVGVJba+Hwp3L1nMgYTTWy9k5Kj/hB8Pi1gMstVgENfXwq8lvFFhlR
         vL1A==
X-Gm-Message-State: AOJu0YzhkiHg2Ig3u2b1EMTSLmU66Wmo5gBRSvyTsxlUHdbp5J1veSd7
	+NqM2gksi/1j1aFLexDObNBiK7AJjs0Xmhc9ltsM4F/M+0Ikb2cKasHkXYHe92QqGqcL4SXODqq
	h2ucU8znLXxbyCFZItskvQB0Lb9llGm2TxB+g/zZ7sqbTn1ozyHMaCwNwl/U=
X-Gm-Gg: AZuq6aLWRb+eN5amFq4FcwicJNoKVeNdBdbYgnfQV98QWUjr3/JVnjWCYJd6S8Wo3s0
	g29OwZBPdGt7sKw8CsZKOCCsDeEhLiSVgWQBq1U2lLB/RdjHnttK3/tLRBx9oQMTMXE4uG3UTRC
	3ASp91DR5snsK1XeJZbHQbPQmBJ9HfLLhcRXDCOTGolrqAko7M8mNHBsf0xXlk/BMXZYxQ+sjht
	U33Ui2nuEKbFQidjQTE7eiwMKMI66SDAibKqMFUFp4uZmOSeWe8cnRsrJO784mVin2u5sQ8Lzt0
	gnmKX8Ij1qYDjW6jcKZMzkVdck/ki21WXRDMGZYHQ/3b70Nqq2ALnVScnHKMOXIgSLWoMtc0CP/
	bj/idOj0C/03C55RbyHlZqgC6OBZXEFDtCFlukXtLVd9EAKYrTp84jAchj9+y/A==
X-Received: by 2002:a05:6a00:4296:b0:81f:9b09:ad02 with SMTP id d2e1a72fcca58-826da8d7d6amr306941b3a.1.1771602492047;
        Fri, 20 Feb 2026 07:48:12 -0800 (PST)
X-Received: by 2002:a05:6a00:4296:b0:81f:9b09:ad02 with SMTP id d2e1a72fcca58-826da8d7d6amr306912b3a.1.1771602491587;
        Fri, 20 Feb 2026 07:48:11 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b94562sm23054638b3a.54.2026.02.20.07.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:48:11 -0800 (PST)
Date: Fri, 20 Feb 2026 23:48:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test fsync of a file truncated to a length of
 zero
Message-ID: <20260220154807.jdya3knqauhvnq46@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f4a25aa2a17255493a9887e0ba6610a307a4961a.1771352543.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4a25aa2a17255493a9887e0ba6610a307a4961a.1771352543.git.fdmanana@suse.com>

On Tue, Feb 17, 2026 at 06:33:30PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we truncate a file to 0, fsync it, add a hard link to the
> file and then fsync the parent directory, after a power failure the file
> has a size of 0 (and the hardlink exists too).
> 
> This exercises a bug fixed by the following kernel patch for btrfs:
> 
>   "btrfs: fix zero size inode with non-zero size after log replay"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Thanks Filipe, this patch is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/788     | 59 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/788.out |  5 ++++
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/generic/788
>  create mode 100644 tests/generic/788.out
> 
> diff --git a/tests/generic/788 b/tests/generic/788
> new file mode 100755
> index 00000000..0234cc7f
> --- /dev/null
> +++ b/tests/generic/788
> @@ -0,0 +1,59 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 788
> +#
> +# Test that if we truncate a file to 0, fsync it, add a hard link to the file
> +# and then fsync the parent directory, after a power failure the file has a
> +# size of 0 (and the hardlink exists too).
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
> +	"btrfs: fix zero size inode with non-zero size after log replay"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_scratch_mount
> +
> +mkdir $SCRATCH_MNT/dir
> +$XFS_IO_PROG -f -c "pwrite -S 0xab 0 64K" $SCRATCH_MNT/dir/foo | _filter_xfs_io
> +
> +# Persist the file and directory.
> +_scratch_sync
> +
> +# Truncate the file to 0 and fsync it.
> +$XFS_IO_PROG -c "truncate 0" -c "fsync" $SCRATCH_MNT/dir/foo
> +
> +# Create a link to foo in the same dir.
> +ln $SCRATCH_MNT/dir/foo $SCRATCH_MNT/dir/bar
> +
> +# Fsync the directory.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +echo "file size after power failure: $(stat -c %s $SCRATCH_MNT/dir/foo)"
> +echo "file link count after power failure: $(stat -c %h $SCRATCH_MNT/dir/foo)"
> +[ -f $SCRATCH_MNT/dir/bar ] || echo "link dir/bar is missing"
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/788.out b/tests/generic/788.out
> new file mode 100644
> index 00000000..37f3f36a
> --- /dev/null
> +++ b/tests/generic/788.out
> @@ -0,0 +1,5 @@
> +QA output created by 788
> +wrote 65536/65536 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +file size after power failure: 0
> +file link count after power failure: 2
> -- 
> 2.47.2
> 
> 

