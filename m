Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282325;
	b=aNIiEzeymMlax74D/BkvrYYNs3FkaMarIYsOPfqzQ6pf91+LlRyXuasBDZ9Kz4ckhRY8
	 774gnBGTObxsiEQ4vvHO7QoovwBILqPhHXBWxeTtqLZPB3ggxu9oag1YPi87HlK3o9D8t
	 L/ImaIbA4vuaalh+5QpBST0olux4+yDPMSilNmlBhQr0toqozuumR1xeAdxuIwZv17glG
	 MxL2q38OastTvR75IAkXZFRYhZMn06kJcUd5Lv5XOxjmo+PYQYamEuPYg5gLmqd3C3y3B
	 bA1I5emFEDOM1G6tIkOG4GmIiyrhlbBZIjOjk6BW3WvYo3IoWddugRR2eCEoq3FAcKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282325;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3ly2KYNJ9k4LBXvYbKtghQJxpj2UAoA6Fe2R68ADP+E=;
	b=qDEjtQuliKC/oCmC6Sd23azJY8Oc6v5HSu+a+0Ib6+Y6jcHiZii73k5Volab9gpMqwYk
	 5l7clieO46qhjHI6VYEtrQ9cY1Fe5TjhO8pg4Vu+Bis8OlcwrrC2zblejC2CdQ0tU1I9k
	 TikJwu/3OWnv1AEBzzwJzO1Q7HGG47AVzu16iKfSGle28/cDguruyQdP/F//NVHF9PP4b
	 mztZm8ZbwG0HQX8qOPvFniA8lwG0NFj6QM24cwiYiHf5LBotTrznIa7G5r8BKkLHT48rq
	 5Xu0TF5Gt8aPlE5xg+I+Bw57CuVAtyyt3+yrz5dAPTSWrU5urrS5jEViEtYvyGRkbAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2rKSqGa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02335606A320
	for <fstests@vger.kernel.org>; Sat, 21 Nov 2026 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2rKSqGa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63371F000C4;
	Sat, 21 Nov 2026 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795282324;
	bh=3ly2KYNJ9k4LBXvYbKtghQJxpj2UAoA6Fe2R68ADP+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2rKSqGaF0UUjntKy4t6PBHsRk9YuEM/rRLnq39l3bT+8i975lRZWWADGD33S8nD4
	 557sKXGW2Jlv59jrxfTSX7wnLF4GtotDeHPf9grOe0zQSaMKvbLSTqIRewH6X7EI9+
	 gJKUKEhSM+XguRqBLlkoFfeafIWkMK5TkaW5foHFVkcX0PD0u2TvWImoG55TD7D66i
	 ZwOBzeJ/5cAshfxwxyWWMiZZVQFHGmAo5OOWTrXHq80cII0Mwb8p60+kgs9t0sygtn
	 CUO+1vB8g3z7p+XGYH2G1EKwHpVhWVM1dsFwlqCTcE7dFcAEjdC2lWn6W7cokI4Gww
	 AxNckcg1JUUzQ==
Date: Sun, 22 Nov 2026 01:31:58 +0800
From: Zorro Lang <zlang@kernel.org>
To: koraynilay <koray.fra@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: add test for garbled stat output from
 negative nanoseconds
Message-ID: <awHTU6F4imBlRW7p@zlang-mailbox>
Mail-Followup-To: koraynilay <koray.fra@gmail.com>, 
	fstests@vger.kernel.org
References: <20261121162003.234307-1-koray.fra@gmail.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121162003.234307-1-koray.fra@gmail.com>

On Sat, Nov 21, 2026 at 05:20:03PM +0100, koraynilay wrote:
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
> v2 changes:
> - use _fixed_by_fs_commit for ksmbd and cifs
> - add _fixed_by_fs_commit for ntfs3
> - fix cleanup function
> - remove useless comment
> - wrap more the other comments so they're easier to read
> 
> Thanks.
> 
>  tests/generic/812     | 48 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/812.out |  3 +++
>  2 files changed, 51 insertions(+)
>  create mode 100755 tests/generic/812
>  create mode 100644 tests/generic/812.out
> 
> diff --git a/tests/generic/812 b/tests/generic/812
> new file mode 100755
> index 00000000..eb76f2e5
> --- /dev/null
> +++ b/tests/generic/812
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 koraynilay.  All Rights Reserved.
> +#
> +# FS QA Test No. 812
> +#
> +# Based on generic/258, but tests timestamps prior to epoch with sub-second
> +# precision.
> +#
> +# ksmbd, cifs, ntfs3 and other filesystem drivers violate timespec64
> +# non-negative nanoseconds constraint, garbling output of stat.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick bigtime
> +
> +_fixed_by_fs_commit cifs 6a75ce0866bb \
> +	"smb: client: fix negative timestamps being read from smb"
> +_fixed_by_fs_commit cifs f2f961e0983c \
> +	"ksmbd: fix negative timestamps being saved to disk"
> +_fixed_by_fs_commit ntfs3 xxxxxxxxxxxx \
> +	"ntfs3: fix negative timestamps corrupting stat output"
> +
> +_require_test
> +_require_negative_timestamps
> +
> +TESTFILE=$TEST_DIR/timestamp-test.txt
> +# we use 123456700 instead of 123456789 because some
> +# filesystems support only 100ns precision
> +DATE="1960-01-01 01:01:01.123456700 UTC"
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f "$TESTFILE"
> +}
> +

Haha, I probably didn't explain that clearly. I didn't mean changing the `rm`
line in _cleanup. What I meant forcefully running `rm -f $TESTFILE` right
before touch -d below, so that any existing file doesn't interfere with the
test, since we don't strictly require TEST_DIR to be completely cleaned
up after every test case run.

Don't worry about sending a new version, I'll fix it when I merge. Then...

Reviewed-by: Zorro Lang <zlang@kernel.org>

> +# create a file with a timestamp prior to the
> +# epoch with nanosecond precision
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
