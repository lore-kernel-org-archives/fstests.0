Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4A7261B
	for <fstests@vger.kernel.org>; Sat, 15 Nov 2025 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763194702; cv=none; b=P9zxMhcMFieBd/tFfMpeZag2Dl2otBFpFdlaOIRNcv3Xs6e3o4nMikcTvQURvU8hitt9DEfvBLFyqcKjCqrg+k8ZSS5BG6FDA9pJTXGgghI5aQK6u4hNnzVju0/n9fitr9LDR159ZnVkevKL9kk7p1ktYhq67+5CQboeKxtUi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763194702; c=relaxed/simple;
	bh=dbec1doifvq/1LTZER5mDbuXmkppYihrOm5VHXklab0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZ/M0Wf44qWS6EvCAthvZdwHB03+q61ubVts86Xp1D+beBD8bYmNbevO4d1BkOH54B4yDflMs1OhM8Z2Xb8qewcLC94A9nHHIm1IeEr4LjGE5unlASKtcEc0RjB7ctVZYNOKmsqhmPmlXJqjuRSjuRIoBV3kzUjxVOAf9f+stsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+znXApt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayZ0AmWD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+znXApt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayZ0AmWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763194699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n7bf5Bnu1+cJTU3MNQCIInMCMWTaSYkxe5porpErsmA=;
	b=G+znXAptfPd5dbAPEUDBI0cop6dH1399Ppj0Fi6sfSj11cxjqEMNPR4D4tLkK9x06Z+G7D
	g5EyGJH+7E18WaLMmSomDWovs+woWGAzl64/I3jWN/pK5wJp3xsl8iYK+yYlzH2sPvN1e9
	6b5Lz/OQe0bIvFyEqLvvMeNOPW2pH/Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Cmf4cz-TMSO_l5j7VCYxGw-1; Sat, 15 Nov 2025 03:18:18 -0500
X-MC-Unique: Cmf4cz-TMSO_l5j7VCYxGw-1
X-Mimecast-MFC-AGG-ID: Cmf4cz-TMSO_l5j7VCYxGw_1763194697
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso2214719a12.2
        for <fstests@vger.kernel.org>; Sat, 15 Nov 2025 00:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763194697; x=1763799497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7bf5Bnu1+cJTU3MNQCIInMCMWTaSYkxe5porpErsmA=;
        b=ayZ0AmWDRSn8tUbERvJyDgYKl6sPlD13lSAoTcHoucHcSjvlk/kgfn6bKaxqYJJBwA
         Ix+qt7bl5cJcdGPNH+wpyEnpV1PjYSnkNy/QFEBahTFxedSy2FpZ1zw4S9c8QqV77iXh
         ktoP7rH6odw4mJMXBAYJPjyOw/D9LQCvssDUUFjW9lT/Io4huqRyMh/BHWOqiNnCFj/I
         phapvwVNtQoxMe/KsNBz5qR9+B0Q1Z4A/9l4yJJvxi8/NLo65He6TqUy89/aKVKDF0nD
         sE0EzE5L59+vKBtPceC0HfdsiHfKIrTxU6bsQEgj9YVYrYiYFqWdq+fizlEeGN2Gy+Dh
         PiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763194697; x=1763799497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7bf5Bnu1+cJTU3MNQCIInMCMWTaSYkxe5porpErsmA=;
        b=j78ox+9NdupF1gtGXmuW4QeASZTSQrhfAqg8zj8FkPq7ixu64NruFVekgANr9ShqgU
         O/0vZxLZP+jvHZPUQtPLD72QHgbZGpB2EYPxdxIYT7uinX6UiDKrGgfCZM2iu3BfTQd4
         TtMHC4IMVdugeRYhJ1QKSi8aWUYqqpXDSwUiTfv5JqUeZOuSyfSUqRvFWyoH+cJwtmXc
         je1Ju0ZcNCZKz1xUoTKp/odiJ9Tdt2AWyyl0+99Pi3+zc6IYeEf39DeW9Dlpqh+9AXDh
         T0SDXpAp9+bCTJ/rgTgI1eyRgsKIz9z2dhdxUoFhlSyCnZ4FwRhc1VBXwQPE02ew5syP
         i5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWXJnJZDHamb/sLoLs1Bzim4pQ2SXX69yxNbVGHJOH0qbqzsp0ZBPB8cDDbC2q9wmzu5cgx9Ghx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/qj1QTCvCeG5qT77UbqJkbVzyX52gyuiGt3zIzx5VTqA4ycL5
	ITE4WvrA/6wB00d5w/k6pffSpJsMricsOvALunfflE/kxWwV/AuwUMHg8XX/5WuqONEsaJApR1X
	EUxyOjOwzGJBDkxxJyEHxrtWGENqz64VZaZESlaQqohZ/ZUmZXT3Ugfe32VI=
X-Gm-Gg: ASbGncsWxsaUwsqmH18QNPV1HFNWjPsAWiC0QxfWLkpVJOEAj4UaREpPG6iaKE8ol8K
	7MCGqnWSfCYB1WLxcDg5p/Z2U4FI573oGCo8UhW2UJqMD3gjjYOUoWE7FgoTXSndjJgGD5dblTV
	aDtWGnus7r/dzxH2g6Jjv8DbB+9EgtOWtIYPaEk8XQOXyqdhkHIzJ9iPcu/Sx2d4rYV/wbLWNo8
	e+ZzJ+PSWx7b6AJ0GKASEZZy3/lIudUEGsvnlNfKmYXxmPEd0gH3WrJ4M/OKFHJs/txiFn33tn1
	67zdZZGpMLY2rkjcuKjbqpwHJANvCm5qPC2PpBIM9K5R6X72BwlzlAdgOu/izK5ec1un72uL5XL
	YbBLKKvxNHuN1+QKqCldMf/gUMV02j5J0lUdeF6JVWGq5BG6IyQ==
X-Received: by 2002:a05:6a20:7f87:b0:334:8a8e:6576 with SMTP id adf61e73a8af0-35ba228f8e2mr8001343637.29.1763194696861;
        Sat, 15 Nov 2025 00:18:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm3jNhItrsq5XSCCWPdNgXWrq4w0xGBjTpGBAfgkZ0XRyViROmnMGuL0JOBHbUiGsqCaS+FQ==
X-Received: by 2002:a05:6a20:7f87:b0:334:8a8e:6576 with SMTP id adf61e73a8af0-35ba228f8e2mr8001320637.29.1763194696355;
        Sat, 15 Nov 2025 00:18:16 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aeedb3sm7273038b3a.10.2025.11.15.00.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 00:18:15 -0800 (PST)
Date: Sat, 15 Nov 2025 16:18:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs/023: test sanity check condition w/ error
 injection
Message-ID: <20251115081811.iebaqc2ubh7li3ux@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251103062143.2657116-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103062143.2657116-1-chao@kernel.org>

On Mon, Nov 03, 2025 at 02:21:43PM +0800, Chao Yu wrote:
> After commit 5c1768b67250 ("f2fs: fix to do sanity check correctly on
> i_inline_xattr_size"), f2fs should handle corrupted i_inline_xattr_size
> correctly, let's add this regression testcase to check that.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - use _filter_scratch to filter scratch mountpoint
> - check output message of inject.f2fs rather than return value
> - add _require_attrs
> - add f2fs/023 to attr group
> - fail testcase if mkfs failed
>  tests/f2fs/023     | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/023.out |  2 ++
>  2 files changed, 51 insertions(+)
>  create mode 100755 tests/f2fs/023
>  create mode 100644 tests/f2fs/023.out
> 
> diff --git a/tests/f2fs/023 b/tests/f2fs/023
> new file mode 100755
> index 00000000..33108421
> --- /dev/null
> +++ b/tests/f2fs/023
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu <chao@kernel.org>
> +#
> +# FS QA Test No. f2fs/023
> +#
> +# This testcase tries to inject fault into inode.i_inline_xattr_size,
> +# and check whether sanity check of f2fs can handle fault correctly.
> +#
> +
> +. ./common/preamble
> +. ./common/attr
> +. ./common/filter
> +_begin_fstest auto quick rw attr
> +
> +_fixed_by_kernel_commit 5c1768b67250 \
> +        "f2fs: fix to do sanity check correctly on i_inline_xattr_size"
> +
> +_require_attrs
> +_require_scratch_nocheck
> +_require_inject_f2fs_command node i_inline
> +_require_inject_f2fs_command node i_inline_xattr_size
> +
> +testfile=$SCRATCH_MNT/testfile
> +
> +# remove all mkfs options to avoid layout change of on-disk inode
> +export MKFS_OPTIONS=""
> +
> +_scratch_mkfs "-O extra_attr,flexible_inline_xattr" >> $seqres.full || _fail "mkfs failed"
> +_scratch_mount "-o inline_xattr_size=512" >>$seqres.full 2>&1
> +touch $testfile
> +_scratch_unmount
> +
> +# inject .i_inline field: clear F2FS_EXTRA_ATTR bit
> +output=`$F2FS_INJECT_PROG --node --mb i_inline --nid 4 --val 0x1 $SCRATCH_DEV`
> +echo "$output" >> $seqres.full
> +echo "$output" | grep "unknown or unsupported member" && _fail "i_inline is unsupported"
> +
> +# inject .i_inline_xattr_size field from 512 to 2048
> +output=`$F2FS_INJECT_PROG --node --mb i_inline_xattr_size --nid 4 --val 2048 $SCRATCH_DEV`
> +echo "$output" >> $seqres.full
> +echo "$output" | grep "unknown or unsupported member" && _fail "i_inline_xattr_size is unsupported"

I think we might need a common helper to do f2fs injection and return
error if injection fails, if F2FS_INJECT_PROG always can't return error
properly. Anyway, that's another story. For this patch:

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +_scratch_mount
> +
> +$GETFATTR_PROG -n user.test "$testfile" 2>&1 | _filter_scratch
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/023.out b/tests/f2fs/023.out
> new file mode 100644
> index 00000000..f9635d38
> --- /dev/null
> +++ b/tests/f2fs/023.out
> @@ -0,0 +1,2 @@
> +QA output created by 023
> +getfattr: SCRATCH_MNT/testfile: Structure needs cleaning
> -- 
> 2.49.0
> 

