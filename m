Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E933468C
	for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363164; cv=none; b=NyTF2TF5SKEkBF11B2H8olx5RkmskBij4/v5A1LQnTonmuGO2g3beQ6dzCzRdTj1BAiFhQ6P2YvylAW3iTu0/ujID3205w85QjxqIKZ9kI1MFj3OKx8smk6i7YYRcnmv2k+0K7w1A2MFQhI+EVc0mjPH2F8b/4LVhHeWSOe71wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363164; c=relaxed/simple;
	bh=JgT62Lnttw4TmjgP+81HCBxO1wREshkBqXqcBdM0gBk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFuIcXxJMac9/yyFuadj9qF5KRp8BSdzBeZZCnwP6SaYyZx45rNEpehCG3cQ+WNQi0K4n9o2LXrPbWWsodTjtdJCcAGpirkstsG7K+ab9skJ+5ryhdT2lwOJtlEQ8FDGf0vzhAhyi9k0wZigGumPuu8uUS636Iw//n48So68Q+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmpqT1w4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmpqT1w4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b4583f0a1aso30889285ad.3
        for <fstests@vger.kernel.org>; Thu, 16 Apr 2026 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776363161; x=1776967961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZkBqpwLShezxOQJRkMuS8Yc3ua/JmEN9dt4YdFj/TM=;
        b=GmpqT1w4YPuWW6nyiZUrA0PJ8DTwkZaoZH7S2hM5CH+qcZAQ2GNV5m37QCmgPrT/+A
         soFjt8+RbLhvGOfBn/uBKwNRwjZw3mJysR3hAU8J4hICIrxX1AbgIr5cg+4c0SyElw0u
         Cwdm2pJFkjf5xhZ2tTHPLc6UZOx/qHFHszAPkPlvHIgITQtqguIURwx2W4SUQTD1pphz
         d9YgDx1I1EpHypX2yWv/7iiT+KbzQ1i80yRibnUIUQLdUnytFj+KuR3+Vmk/wtg7Xnga
         oClbCjlw6Y4aLbSdEdbQNKoG06TqTIw+eGiVjyauM+zPQy4O9I955bPQ74UO8WSR4dF+
         z1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776363161; x=1776967961;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZkBqpwLShezxOQJRkMuS8Yc3ua/JmEN9dt4YdFj/TM=;
        b=hACLH7C4kQ31cQHx3KOjMTp9Evz2Ni8mj8xQ3+8Ev3d5OQ49fFslem9rUVsWA7JT1z
         xP37JjA0nGc/nTg2arztqxhUZrmr1tXpe7emf2mKc6KYMJJ2BM8J0Y5caSWcX1RXKLV6
         YHhmFk/5o1ZkIp9ev2SI3Y9Y+67NNpHeAX+D3ihlwrRbXgzXGlEA88GD540g9u3GsO3z
         4UAQA9tn4Dzau3JpOWNOoIFN+kr+J8LB5AHyVYAJOiFIGFAY07YPMJ3GuHuxFWPIuqxl
         GNlGOCWUqNaOqy9aBV9daRzylgE4zy40Gjtpgbv3RuFqTIvw9seSzZcFWy/zHuq9U59e
         hs0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/frq7TssuqUR18ZoTJ18OI3G/sLuGFDA4jekI5X6Jw/R9Q2QgP6rNU2SJSFdPNPI0KbGRzC5zF@vger.kernel.org
X-Gm-Message-State: AOJu0YxVXEGN24PKGgrWBopB/XqTDAgIO9Rhj6YP7at+ylnPKZkyrckU
	uVUAoDEGizMEnAzxSBu/M76evTddCCSmPnLo9YoTmoeeSl/yWvgxXBwP
X-Gm-Gg: AeBDietKWc45DqE53+78at3EXFPUR4mH/rp2ITywHYnNuUNwCMn88jQuT84x+JAO3jf
	eU5caWfoFiyswqmMlzBWSEM7lBQ9gklQP723Ltc0Ku/q8kMG3u1d9rgN6BXpeCbzUvCymJ2DAd3
	nGQANPAywSro6RYhiACA0bQDtB/PmV2+Qyg0ifflXirswSV6s0Xi7E8lkEoP65akqnsGtSwo0Pr
	KYCNojbOl/CzFrYmxBczjgYncZPoELvMDBT24FH5sxI3UfYrU7c6XntJaxuWzCajQaoEcE0MIi2
	kT4JHP9PAy3NKwBSL71Z5sb5AG411TTxO5KCErrTz142xqKcHXkQa0rZnHX6QRwMARJLVS2l1MH
	aJC+XfR6WK7nygHrMhStQ2YYklkAHy1ouT9Wlvl2gqNo+AX6oi5TT5wL7hZbYNuWr2wptbWw/+o
	2HHTeFIxeX/KEYE+8/LEKnBt8I3BxDXJQ=
X-Received: by 2002:a17:902:d501:b0:2b2:5099:2f3e with SMTP id d9443c01a7336-2b5f8d620a3mr605825ad.4.1776363161247;
        Thu, 16 Apr 2026 11:12:41 -0700 (PDT)
Received: from zlang-mailbox ([64.176.226.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef673sm63895805ad.17.2026.04.16.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:12:40 -0700 (PDT)
From: Zorro Lang <zorro.lang@gmail.com>
X-Google-Original-From: Zorro Lang <zlang@kernel.org>
Date: Fri, 17 Apr 2026 02:12:32 +0800
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Naohiro Aota <naohiro.aota@wdc.com>, 
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4] fstests: test premature ENOSPC in zoned garbage
 collection
Message-ID: <aeElJgmNBUflJ_Ut@zlang-mailbox>
Mail-Followup-To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
	Zorro Lang <zlang@redhat.com>, Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20260415104015.209741-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415104015.209741-1-johannes.thumshirn@wdc.com>

On Wed, Apr 15, 2026 at 12:40:15PM +0200, Johannes Thumshirn wrote:
> This test stresses garbage collection in zoned file systems by
> constantly overwriting the same file. It is inspired by a reproducer for
> a btrfs bugifx.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> Changes to v3:
> - Distinguish between SCRATCH_DEV and SCRATCH_RTDEV so both BTRFS and
>   XFS work
> - Fix typo
> 
> Link to v3:
> https://lore.kernel.org/r/20260414143341.167875-1-johannes.thumshirn@wdc.com
> 
>  tests/generic/999     | 53 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/999.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 000000000000..d3b38b676d37
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 999
> +#
> +# This test stresses garbage collection in zoned file systems by constantly
> +# overwriting the same file. It is inspired by a reproducer for a btrfs bugfix.
> +
> +. ./common/preamble
> +_begin_fstest auto quick zone
> +
> +. ./common/filter
> +
> +
> +if [ -b "$SCRATCH_RTDEV" ]; then
> +	zoned_dev=$SCRATCH_RTDEV
> +else
> +	zoned_dev=$SCRATCH_DEV
> +fi


I'll move above lines further down, specifically after the _require_scratch_size
call, when I merge this patch. Others make sense to me.

Reviewed-by: Zorro Lang <zlang@kernel.org>

> +
> +_require_scratch_size $((16 * 1024 * 1024))
> +_require_zoned_device "$zoned_dev"
> +_require_command "$BLKZONE_PROG" blkzone
> +
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_no_compress
> +
> +_fixed_by_fs_commit btrfs 7bcb04de982f \
> +	"btrfs: zoned: cap delayed refs metadata reservation to avoid overcommit"
> +_fixed_by_fs_commit btrfs 258e46a6385c \
> +	"btrfs: zoned: move partially zone_unusable block groups to reclaim list"
> +_fixed_by_fs_commit btrfs e2a7fd22378f \
> +	"btrfs: zoned: add zone reclaim flush state for DATA space_info"
> +
> +_scratch_mkfs_sized $((16 * 1024 * 1024 * 1024)) &>>$seqres.full
> +_scratch_mount
> +
> +# Overwrite the data "number of seq zones" times, this is arbitrarily chosen
> +# but triggers the original bug reliably
> +loops=$($BLKZONE_PROG report $zoned_dev | grep -c "SEQ_WRITE_REQUIRED")
> +
> +for (( i = 0; i < $loops; i++ )); do
> +	dd if=/dev/zero of=$SCRATCH_MNT/test bs=1M count=1024 status=none
> +	if [ $? -ne 0 ]; then
> +		_fail "Failed writing on iteration $i"
> +	fi
> +done
> +
> +echo "Silence is golden"
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 000000000000..3b276ca804fc
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +Silence is golden
> -- 
> 2.53.0
> 
> 
