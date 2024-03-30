Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6216846F
	for <fstests@vger.kernel.org>; Sat, 30 Mar 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711782734; cv=none; b=jrJ05BnGAkI7L795Bn2HvJOixYpzf+Ji6iXh7/ACbBS8tDMD9z3u2NUa+VJ36FO3/c5Ocx3ZGwvL3dmO17ZZM0x6zGhFkPu3puIvVyICjnyVw98OzWGvzX7TApSam0piRG5UhDbrJ8VYB5cegAMpyp8TbpYF6CkKa3OU2M06oFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711782734; c=relaxed/simple;
	bh=l0qm6+C94zwsm/rezM2g/KDziYftbBxRBGvW5LdvXxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tY2qkykd7wTWYIPUkXRwkGL/+/ffOSfcThvMwrYgMdDeAWaLSKKhUkL7hn5Yhe1dEGlwIL9Sgo3+49lfw4YnwfVOWZzXz5vB3SC0TNJbzPX9f3Axy2JoxwdRZhl/mqQFfPFaQBmYSkIzIyflBn3B0vpu/EhsRbXI0z7hkQXR7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VdLayx1Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VdLayx1Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711782730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wSfuh3hgBN5v+TJQtMt4wHJKKzn/IMeC4fo6vXTl7gQ=;
	b=VdLayx1YyBkbi8qhgw9yNo+2unhqBfK8+5BUvRGzNLTqOvVfPFEbRiyuCn4VZg66xD71Z+
	q2w6iX4gzEO/0NKgfdsFYKDKWiTrz9VvmYB/tgQxLx/VOm/RP2wGkFCtvCxQG19fyG4gpV
	31ApXMOE3JRtN4PCNI5xB3zXWDW9j64=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-N1mPmz0WNAGNebVwJp4IjQ-1; Sat, 30 Mar 2024 03:12:06 -0400
X-MC-Unique: N1mPmz0WNAGNebVwJp4IjQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a1fa1a83aeso2235167a91.1
        for <fstests@vger.kernel.org>; Sat, 30 Mar 2024 00:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711782725; x=1712387525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSfuh3hgBN5v+TJQtMt4wHJKKzn/IMeC4fo6vXTl7gQ=;
        b=DDSgIbNsEu2rkrFnCaBUScSmmYJQVe7x9EmTtQcEyXn8pdlVSb7ACMn0975CgNR8pY
         IE+DIZdUFSRfdrQjSqj9JSTTV1BiIsOpj0AkBiBYW6s8oAOXoY1Pd4upLAP+WuIegNHK
         G4hkRS+B6+6XyCJz8ELQkXI2Kfn2CmhDfIHoraXW2+UF4Bf2VJrHgqt5h8QAJFZHSubW
         cPPJVDTcr58449UY1pPx7GE/UktTcVHDYaaV04gR3sHqsFZSI5dVR2xxLRgazS/ta/NQ
         QUMrClp72XqYf+hb7Ie4RqxRvU4nK9KJq2nCE14u/C0V7IJlHp+oGB9otgZw9G33hVwO
         eITg==
X-Forwarded-Encrypted: i=1; AJvYcCXDjUXyo2COLWpMYlle8WKqlvaeRgIZ8viokPDZWOqttqk11xCtOHicJqsg5MeZqUoqWsqcrxfno9WIJsL4AV3KhvtL5sAC+Q==
X-Gm-Message-State: AOJu0YyzyVZcRJcCJ2kVZpeL3++byrMGlV11THcNOT2H6flhnj0avQyf
	XmjQXiLbsO9yhIewS5FxSneKXzc51O4AgMHWDNj1ao2s3lMWcx/5AQB9RzvQm9ajROd0+Isct6E
	w7BpwfbF4yzBnX8ZFzpTlGjEA9nqlIh8NYND7HT+IsAis2xkMME3p+54=
X-Received: by 2002:a17:903:258a:b0:1e0:a1c7:572c with SMTP id jb10-20020a170903258a00b001e0a1c7572cmr3643276plb.18.1711782725505;
        Sat, 30 Mar 2024 00:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZxybFUwvsRPzzvfaSmzhi58LRSaIHXEP38dchssw1hYNPJsiW2EhaKziaBRK0zHBvJQqwig==
X-Received: by 2002:a17:903:258a:b0:1e0:a1c7:572c with SMTP id jb10-20020a170903258a00b001e0a1c7572cmr3643255plb.18.1711782724749;
        Sat, 30 Mar 2024 00:12:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709026b8200b001dc05535632sm4548412plk.170.2024.03.30.00.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 00:12:04 -0700 (PDT)
Date: Sat, 30 Mar 2024 15:12:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Christoph Hellwig <hch@lst.de>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] generic: test MADV_POPULATE_READ with IO errors
Message-ID: <20240330071200.jmljkdyccwgdzmej@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <171150739778.3286541.16038231600708193472.stgit@frogsfrogsfrogs>
 <171150742156.3286541.2986329968568619601.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171150742156.3286541.2986329968568619601.stgit@frogsfrogsfrogs>

On Tue, Mar 26, 2024 at 07:43:41PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This is a regression test for "mm/madvise: make
> MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly".
> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/1835     |   65 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1835.out |    4 +++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/generic/1835
>  create mode 100644 tests/generic/1835.out
> 
> 
> diff --git a/tests/generic/1835 b/tests/generic/1835
> new file mode 100755
> index 0000000000..07479ab712
> --- /dev/null
> +++ b/tests/generic/1835
> @@ -0,0 +1,65 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1835
> +#
> +# This is a regression test for a kernel hang that I saw when creating a memory
> +# mapping, injecting EIO errors on the block device, and invoking
> +# MADV_POPULATE_READ on the mapping to fault in the pages.
> +#
> +. ./common/preamble
> +_begin_fstest auto rw
                         ^^ eio

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	_dmerror_unmount
> +	_dmerror_cleanup
> +}
> +
> +# Import common functions.
> +. ./common/dmerror
> +
> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly"
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_xfs_io_command madvise -R
> +_require_scratch
> +_require_dm_target error
> +_require_command "$TIMEOUT_PROG" "timeout"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_dmerror_init
> +
> +filesz=2m
> +
> +# Create a file that we'll read, then cycle mount to zap pagecache
> +_dmerror_mount
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $filesz" "$SCRATCH_MNT/a" >> $seqres.full
> +_dmerror_unmount
> +_dmerror_mount
> +
> +# Try to read the file data in a regular fashion just to prove that it works.
> +echo read with no errors
> +timeout -s KILL 10s $XFS_IO_PROG -c "mmap -r 0 $filesz" -c "madvise -R 0 $filesz" "$SCRATCH_MNT/a"

timeout -> $TIMEOUT_PROG

Others looks good to me, if there's not more review points, I'll merge this
patch with above changes, after testing done.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +_dmerror_unmount
> +_dmerror_mount
> +
> +# Load file metadata and induce EIO errors on read.  Try to provoke the kernel;
> +# kill the process after 10s so we can clean up.
> +stat "$SCRATCH_MNT/a" >> $seqres.full
> +echo read with IO errors
> +_dmerror_load_error_table
> +timeout -s KILL 10s $XFS_IO_PROG -c "mmap -r 0 $filesz" -c "madvise -R 0 $filesz" "$SCRATCH_MNT/a"
> +_dmerror_load_working_table
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/1835.out b/tests/generic/1835.out
> new file mode 100644
> index 0000000000..1b03586e8c
> --- /dev/null
> +++ b/tests/generic/1835.out
> @@ -0,0 +1,4 @@
> +QA output created by 1835
> +read with no errors
> +read with IO errors
> +madvise: Bad address
> 

