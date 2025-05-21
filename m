Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4020D509
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814700; cv=none; b=ndgNCg4tY7XP3SYPl9v66dEABEmvDHcRwv6njC04MF9M9jeAPCD2YCZz4sMcKg7Tqn0boawIlRDahWnjnjGzX54LHbND/uj7nBglynBHBq3oqoRK4Pbi5Er8kWm1ADu2unUo5nvDG8QwMuOvSOnabEmkkoji96mwWpYqiwL+Ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814700; c=relaxed/simple;
	bh=539roYUUPN3pdqDCTq6rLSRcyDPVA5Foif7GPQH3jOY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sobVwq+1Tiv7oT6rCEwxUnM5fkhQIoBg0egyedTU7I9cuAMf4dz/rJ2e1Cs6tTxEVCRbiwEenKIVn802X5TS3CmuwFnDp5A9K0WY8uhtad6c0VuRcEYdPPJyqFolPeZDaYLgxaed84AoP1dUazEZSiNL6NdEPm+iMpP+UyV6D1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUnTsAAJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUnTsAAJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99346C4CEE4;
	Wed, 21 May 2025 08:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747814699;
	bh=539roYUUPN3pdqDCTq6rLSRcyDPVA5Foif7GPQH3jOY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PUnTsAAJfxMwrUAStyJNvRwVpinxb0AA/qGVNm3haDEVk7P5ChYx00b7aiuq+FgEq
	 sEOPyvAdlxCM4qBRtjcklBplS4uOP1tpyxA58hrKYcNNEX45ML8+PViqd/SEV1G3EO
	 0WrEPdZLxOPYXLZAMgdIL7BUFFATVWvyqYrki/b4JAMMISNr88miecQ3QYcMMbDr/F
	 JYM5kEzbjx4AHayu70HBkOUCgHzcl/q/XGQk4w3CLC04ksZtRiW93fSRZZQ1x2M+c7
	 NZ9a50qjZkFZboGlT+DMLtNuwDg/yRGzNAXfHV2Q0thS1SIy37415GjWMCMKMx34mk
	 d+Hd1Lnw1YXGQ==
Message-ID: <f734de12-bc68-4edd-bb8f-f07263878ad9@kernel.org>
Date: Wed, 21 May 2025 16:04:56 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/012: test for missing 'trimmed' flag issue
To: Chunhai Guo <guochunhai@vivo.com>, zlang@kernel.org,
 fstests@vger.kernel.org
References: <20250521064952.1373690-1-guochunhai@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250521064952.1373690-1-guochunhai@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 14:49, Chunhai Guo wrote:
> This is a regression test case to verify whether the CP_TRIMMED_FLAG is
> properly set after performing the following steps:
> 1. mount the f2fs filesystem
> 2. create a file, write data to it, then delete the file
> 3. unmount the filesystem
> 4. verify that the 'trimmed' flag is set in the checkpoint state
> 
> We should apply the commit ("f2fs: fix missing discard for active
> segments") to resolve the issue where the 'trimmed' flag is missing.

Chunhai, thanks for working on this testcase!

> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Also, as I tested, it works as expected.

Thanks,

> ---
>  tests/f2fs/012     | 39 +++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/012.out |  2 ++
>  2 files changed, 41 insertions(+)
>  create mode 100755 tests/f2fs/012
>  create mode 100644 tests/f2fs/012.out
> 
> diff --git a/tests/f2fs/012 b/tests/f2fs/012
> new file mode 100755
> index 000000000000..b3486b730fd4
> --- /dev/null
> +++ b/tests/f2fs/012
> @@ -0,0 +1,39 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Guo Chunhai.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/012
> +#
> +# This is a regression test case to verify whether the CP_TRIMMED_FLAG is
> +# properly set after performing the following steps:
> +# 1. mount the f2fs filesystem
> +# 2. create a file, write data to it, then delete the file
> +# 3. unmount the filesystem
> +# 4. verify that the 'trimmed' flag is set in the checkpoint state
> +# We should apply the commit ("f2fs: fix missing discard for active
> +# segments") to resolve the issue where the 'trimmed' flag is missing.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_fixed_by_kernel_commit 21263d035ff2 \
> +	"f2fs: fix missing discard for active segments"
> +
> +_require_scratch
> +_require_xfs_io_command "pwrite"
> +_require_command "$DUMP_F2FS_PROG" dump.f2fs
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +foo=$SCRATCH_MNT/foo
> +$XFS_IO_PROG -c "pwrite 0 1m" -c "fsync" -f $foo >> $seqres.full
> +sync
> +
> +rm $foo
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +$DUMP_F2FS_PROG $SCRATCH_DEV | grep "checkpoint state" | grep -o trimmed
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/012.out b/tests/f2fs/012.out
> new file mode 100644
> index 000000000000..00a061bb0ae4
> --- /dev/null
> +++ b/tests/f2fs/012.out
> @@ -0,0 +1,2 @@
> +QA output created by 012
> +trimmed

