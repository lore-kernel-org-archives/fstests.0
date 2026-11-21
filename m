Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275751;
	b=PgMYcLsRutL38UB7owPIjxopX+dhOlwo/BKHSHaoMq/5akLco2OMGe+XeE1ugrIpE9CG
	 HpeYdkoAutMNR7ehfXR3orhHFQdpxJWpjrwhz16ZYyETIvevERAJjDx+71sf7ZThAs33w
	 4MyA1J6xuEmDMuPzfkiimNqMxOxQjh/QFm5K/j2Mo/m/8ecfXZhWh72mYRgutzanNjdQO
	 qbJnCLf09xfYGnvZ99RolnhKRjXZuGAaMPvGUt5nnL7OZVsj9YBaS/SO+ueGgemFr97IQ
	 lAsUVlrRT152s5SjGj448djoLYZrLlqiLg5CQv4TA/VLDO4WdJ2bf0S2indm5UBxWfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275751;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=mArWiHK1lR4vo9+MzLIRTle+hTRn4yaP2aY9hkEPkIA=;
	b=FzIdsbvfKKvHq2woZQESJ0hc2PLdez/N/eHm3XLtC/MdtDnwg8+TWPAuU6i86gapnogj
	 DAY/vOjISe+uJ28PUi5aMKQ/68XVH/ngDZ9Lh36zqyJfVWfXKGMnP1fQBASYTZGn84AnP
	 3CzPT2kfgcD5yJGx54rVzWgzomZpxOVEwsDN49FoyXdXVSuf8flacQwdQF5cZKrICbXv/
	 AYAGcpMzbkPq0Snh20SJq48/efII2LFgOJOWTcgCngcP5XYA0rfD6+0RPIytwi+qZFQFl
	 Rhrebo/gQByMajtJ8Rb5+tyIvz6+Jyvw9OR3RWAQ0EFZ6cSP17IRkdUqefAmyUoDfLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sw6QGTcz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA373606A320
	for <fstests@vger.kernel.org>; Sat, 21 Nov 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sw6QGTcz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E601F000C6;
	Sat, 21 Nov 2026 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795275750;
	bh=mArWiHK1lR4vo9+MzLIRTle+hTRn4yaP2aY9hkEPkIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sw6QGTczsz/VBMqSKpRTXWnVIe2rl8H/GENu1Ji3hqw8NzYvIX5sDc1xRngava/dF
	 zsvRDcJGBCRzEFDB9Tjc0V/rkOW+q6TMCOluPNGxj6kFNZqCtz/pYVtZguhTV2LFRo
	 hlY+hGFvMA64VlcbjtTeh7M+f4Q0Axh1rUIN1tDn8bWUYMtTv+jTczoPmcwHd6dZPs
	 Pc8qugTpEoYK6AnQTcrLCdagPqAtb0zbcIXA66ei5wZmTq9vmWGAFYdj0Cv29tQUgz
	 xQcDM59WJXTsM1V3cT56lQQ4LiEhJ7lOI5f74N38o5ywgz3clItMsrVzs3DiEI14zR
	 rQ7d/Lrg9a5Wg==
Date: Sat, 21 Nov 2026 23:42:22 +0800
From: Zorro Lang <zlang@kernel.org>
To: koraynilay <koray.fra@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add test for garbled stat output from negative
 nanoseconds
Message-ID: <awG4CR0mKH_dpR6z@zlang-mailbox>
Mail-Followup-To: koraynilay <koray.fra@gmail.com>, 
	fstests@vger.kernel.org
References: <20261120232240.563633-1-koray.fra@gmail.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120232240.563633-1-koray.fra@gmail.com>

On Sat, Nov 21, 2026 at 12:22:40AM +0100, koraynilay wrote:
> Some filesystems don't use set_normalized_timespec64() to handle their
> timestamps format conversion, leading to a garbled stat command output
> for timestamps.
> 
> For example:
>      from cache:   1960-01-01 01:01:01.123456789 +0000
>   after remount:   1960-01-01 01:01:02.()*+,--00 +0000
> 
> This bug also violates a struct timespec64 invariant, as documented in
> the set_normalized_timespec64() kernel-doc:
> [...]
>  * Note: The tv_nsec part is always in the range of 0 <= tv_nsec <
>  * NSEC_PER_SEC.
>  * For negative values only the tv_sec field is negative !
>  */
> 
> Example patches that fix the problem[1][2].
> 
> Link: https://lore.kernel.org/linux-cifs/20261112111637.184045-1-koray.fra@gmail.com/ [1]
> Link: https://lore.kernel.org/linux-cifs/20261112111637.184045-2-koray.fra@gmail.com/ [2]
> Signed-off-by: koraynilay <koray.fra@gmail.com>
> ---
> Thanks.
> 
>  tests/generic/812     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/812.out |  3 +++
>  2 files changed, 46 insertions(+)
>  create mode 100755 tests/generic/812
>  create mode 100644 tests/generic/812.out
> 
> diff --git a/tests/generic/812 b/tests/generic/812
> new file mode 100755
> index 00000000..de57fab6
> --- /dev/null
> +++ b/tests/generic/812
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 koraynilay.  All Rights Reserved.
> +#
> +# FS QA Test No. 812
> +#
> +# Based on generic/258, but tests timestamps prior to epoch with sub-second precision
> +#
> +# ksmbd, cifs and other filesystem drivers violate timespec64 non-negative
> +# nanoseconds constraint, garbling output of stat
> +# See commit 6a75ce0866bb1efe67947fc5536a476381d7a9d9 ("smb: client: fix negative timestamps being read from smb")
> +# See commit f2f961e0983c8f339f842e1a8c351e6963793868 ("ksmbd: fix negative timestamps being saved to disk")

A 12-character commit ID is enough. Also, please wrap the lines so they
aren't too long。

_fixed_by_fs_commit cifs 6a75ce0866bb \
	"smb: client: fix negative timestamps being read from smb"
_fixed_by_fs_commit cifs f2f961e0983c \
	"ksmbd: fix negative timestamps being saved to disk"

> +#
> +. ./common/preamble
> +_begin_fstest auto quick bigtime
> +
> +# Import common functions.
Useless ^^

> +
> +_require_test
> +_require_negative_timestamps
> +
> +TESTFILE=$TEST_DIR/timestamp-test.txt
> +# we use 123456700 instead of 123456789 because some filesystems support
> +# only 100ns precision
> +DATE="1960-01-01 01:01:01.123456700 UTC"
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.* "$TESTFILE"
> +}
> +

rm -f "$TESTFILE"

> +# Create a file with a timestamp prior to the epoch with nanosecond precision
> +touch -d "$DATE" "$TESTFILE"
> +
> +TZ=UTC stat -c "%y" "$TESTFILE"
> +
> +# unmount, remount, and check the timestamp
> +_test_cycle_mount
> +
> +TZ=UTC stat -c "%y" "$TESTFILE"
> +
> +_exit 0
> diff --git a/tests/generic/812.out b/tests/generic/812.out
> new file mode 100644
> index 00000000..f0267fbb
> --- /dev/null
> +++ b/tests/generic/812.out
> @@ -0,0 +1,3 @@
> +QA output created by 812
> +1960-01-01 01:01:01.123456700 +0000
> +1960-01-01 01:01:01.123456700 +0000
> 
> base-commit: 71641219a506ac62bfa231592394265ca812670e
> -- 
> 2.56.0
> 
