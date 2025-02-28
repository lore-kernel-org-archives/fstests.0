Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AD1F4C8D
	for <fstests@vger.kernel.org>; Fri, 28 Feb 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763125; cv=none; b=STc4Z7FampQIK72SmtOl4nmCVSTFdAAY/7Mj7leha0AIe7I76XmSeHxR1u2yKnGeXJ3Y2bkPaouub67JofD3dkVsmKfqTLWD1BzTN5FNoRrVFIt0UqIY6G9+yV5L8Xf8y9e8j7E1XLkNX4G7ep2RQ35482fzhSPcE+Z5eVI/R/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763125; c=relaxed/simple;
	bh=nUqCWGjT+crPwqyHua6dxz2s4z3Ov/EcUzTVJXRpyug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbSl9rBDsWk2QqBCZJCieN20+bc47UuqYzCl+2HPay3Xv4Nv1sh0LApzWJCZ+bKYK982fmmAv4hx7sPFIvyCP+MxmMXZCqom0MmLU2kfiTRf4kjwEM/ifjx8ZPlFuuppTj7QmrN2TqW3ZSWoLmIfa/gb+1RLvcz/KCWRVvfk2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjxMzqHe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjxMzqHe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECCCC4CEE2;
	Fri, 28 Feb 2025 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740763125;
	bh=nUqCWGjT+crPwqyHua6dxz2s4z3Ov/EcUzTVJXRpyug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FjxMzqHeu0aUszjprqh0DuReoGGBDr4JzXk5yXxveeuDDHNRAnzGm4+lCCcIqMafT
	 i3KMNwZPFfeO5TXbeu615Hu+3PPm3JS/rNmiLU3BwYay5wQC6oyahmhf1bnBRHh//2
	 WvRle0g/0CjKwFrVpLXEmk7fWJLONsR9GFpbeWJsqUJrYTt6xIX/czK9oELq7fyokY
	 947zFyrMcwvZ4jzMuzLokl5YzgInB+TwJpLMKVKlCV3DNmxHZU9FQ+Re4Qp0egz2Y1
	 Q+AZS6FcduTg6LkRoeDSm7Los2Z+pb65ioN6m9c2IVLVgAPdnv1+QI1a0B2h/ZwJmJ
	 ZFvbC1zrXriVQ==
Date: Fri, 28 Feb 2025 09:18:44 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH V2] generic: test zero-byte writes to file
Message-ID: <20250228171844.GB6229@frogsfrogsfrogs>
References: <3bd585ba-fe21-4f93-802a-f32f9e0f1c61@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bd585ba-fe21-4f93-802a-f32f9e0f1c61@redhat.com>

On Fri, Feb 28, 2025 at 09:13:19AM -0600, Eric Sandeen wrote:
> A bug was recently fixed in exfat where attempting to do a zero-byte
> write would yield -EFAULT; test for that here.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> V2: remove the test that file exists, fix .out file and filter xfs_io
> 
> Zorro - If there is more debate over whether or not the file should be
> removed at the end of the test, please feel free to fix it up to
> whatever makes the most people happy. ;)
> 
> diff --git a/tests/generic/762 b/tests/generic/762
> new file mode 100755
> index 00000000..25eb88b9
> --- /dev/null
> +++ b/tests/generic/762

Hee hee, another generic/762 :)

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> @@ -0,0 +1,29 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 762
> +#
> +# test zero-byte writes
> +#
> +# exfat had a regression where a zero-byte write to a file would
> +# yield -EfAULT. Should work on all filesystems - write should
> +# succeed.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Import common functions.
> +. ./common/filter
> +
> +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
> +	"exfat: short-circuit zero-byte writes in exfat_file_write_iter"
> +
> +# Modify as appropriate.
> +_require_test
> +
> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq 2>&1 | _filter_xfs_io
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/762.out b/tests/generic/762.out
> new file mode 100644
> index 00000000..918f5455
> --- /dev/null
> +++ b/tests/generic/762.out
> @@ -0,0 +1,3 @@
> +QA output created by 762
> +wrote 0/0 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> 
> 
