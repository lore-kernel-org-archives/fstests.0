Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023BC358D37
	for <fstests@vger.kernel.org>; Sun, 11 Oct 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744589; cv=none; b=I/8B1Pf5PGqok9wNu6NUAod4aiWm77joR6Obxr/Ug9c4AfgBzDV6QnTvueR60bKpKsz+zjm7XMJ+YqXmDjiH5YwPcjyUUhiYYpwnPXHT495lFBFPnGvqaj+NOHLZol/Pz0IE5wBc32dLhjnYNOLUIX70lumHTF17FXzP81/Vseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744589; c=relaxed/simple;
	bh=Lp6+d/IGB88XdPb53ZhjjVQcpkm7KzdJTkf4vwFUUhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I+i4T5HZt5nk2DwdME8xx4kjc934VV608uLSNCnOTwA+ig7CS8fReExdcMIaELwSJutPW6Lnc7RFjIiDmeNWt3nz+6V50it23mslpGNkH/7aeXJeLOKKTLUc9hM4PWxBwwUcHB+HLMjuQPZ/HACwnUllbdC66KEvOly5ia3j6fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJwia5xT; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJwia5xT"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3550c917fd3so1869308eec.0
        for <fstests@vger.kernel.org>; Sun, 11 Oct 2026 11:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791744587; x=1792349387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tKRpzrghFngBRJcUHTjfSey90EYzjLArlerIP3BVno8=;
        b=dJwia5xTpV7HopvZf79gHbQxpA+hJ7xEZ6baAT0+47MyJ6OtK2ImZGbS/9aNzJpwrA
         vOMByQkzcRZtxATTJBxipPq65wYKGazhdQKGFnO3NVS10Vhx0BmsiSZtkzfB3tGrQV9o
         /4DFnWoYsNBHEW3bVzdIjz+BQmzS6QoYrEndZ8SDrOVBDFeWy0ajWEq2MlAD+Ghsw0VH
         SOKhsnbkD3nZXj7D9o7OyPCqkH9+O+NVzelLcmIuz4xofPcsYfoZZhkGLHZtDUtGqL/t
         /2azQk/HLFqQy38UuFcxYB5Ray0SZPGRAs4F9YtajVGN11bb+1FH5ctQM6Umg4Sfb6f6
         00Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791744587; x=1792349387;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tKRpzrghFngBRJcUHTjfSey90EYzjLArlerIP3BVno8=;
        b=DuLA7maLJh8E7HI3NyMPW+LKIbuFEVpU4+yTSx68PF8HgXEbK8iPOtTdSxnb1Zuptt
         0CxFv8tj7ckJeXzcurbUzdHtAxY2WktzfLgWjdzVBwl9rqUHtqB2UWcXPf7EQbU477YW
         SGyAdWkD4RJ2z7YtovRVeAW2GxDwKQ3ORZ+xxA8kJMSQiJwXG58YxqTEXY7rsf7FmNDZ
         f2PhXwuZm50m3hWeyLguubSaipiZ+HK9G5PkbQkrw5uzzGBDWsT4/RSuynFBdhqAUIRI
         MjCY6cd1RCsj8HEEGPMttcgVBky1Ai/KevDnP8XPrq9de2M6xZZZ1l81dwg3XjIEFaO5
         pNxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYNnlxEeWeHJUNe6YYVEaYkql3biN/fV+fZg74QeXYbScmZ4ezJllAqawyMcRYNx4l4PWUsY2c@vger.kernel.org
X-Gm-Message-State: AFq9FYKQz7ic+CEosWQQYXjkgIy6IFjZ6PvipYFNs73wqt7u2UWtDq5x
	VSw2b6ykNXI2bsER+dyD62oH2UELBuZDh+Uua9tU5/5D0XezHj+KBDaZ
X-Gm-Gg: AYBFou1EhthqFacpU74tFdovjyE430fMlfeVLGKDvpK3o83TdVoEJ4ZL4UJbRmOyM0I
	k6uacA8+yUG3azZ//apaMhlrQfnHYQQ0UgK/HKv98WvrZbrKHrbmdniBaIjPE8U2ubpyVjNmvTa
	TdPCss/h9Clo4l1f0n8TxCGwvqKE/gDXmzehy9078nAfVVBpZFDbMuv9U0Li6FQEqT+xKNg33pI
	qeEXfJCcU84Z760z7TjhTc+RWN1/02F/h+03mcB/YsNHM9Q/z5+xDe2uQCXZ1JZRZrC9mzo/kf3
	0yaiBlLW67wXICIqN+eY02ajtUIKHsRZky9Z+gQEH7V443dmOPN9J7Q1HL4BO9m0C1LPXx4dgt6
	nKnOtxAAZYv2pVrXxMGuTN96uDd8hLe/Fuo7XpFCgl+2y7a3rbVElO0Zf1Pe1Ms+3ggF/h9Atdc
	RbaP/CfRYQzlvrz+NwjUM2XGPpT0UTQz3f2bMWxLeuljQHuUw2lbtbDzBhkh8CbgpNXSfcQbGEU
	6qQJAeyk641SG0S+kCKjqykou1oJBX6LfSyjhvFPS4+5hyz
X-Received: by 2002:a05:7022:3d14:b0:143:7001:7645 with SMTP id a92af1059eb24-16a62600d3emr14165453c88.47.1791744586804;
        Sun, 11 Oct 2026 11:49:46 -0700 (PDT)
Received: from ?IPV6:2406:7400:56:97af:bd42:ace4:1245:4b57? ([2406:7400:56:97af:bd42:ace4:1245:4b57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a5866477sm22605308c88.22.2026.10.11.11.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Oct 2026 11:49:46 -0700 (PDT)
Message-ID: <745a6dae-ff3c-45de-8bba-1e2efd45ca47@gmail.com>
Date: Mon, 12 Oct 2026 00:19:42 +0530
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fstests: generic: add a test case to check fsverity
 reads
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20261010090422.59743-1-wqu@suse.com>
Content-Language: en-US
From: Dhruva G <goledhruva@gmail.com>
In-Reply-To: <20261010090422.59743-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10-10-2026 14:34, Qu Wenruo wrote:
> There is a bug report that with the recently enabled large folios

Do you want to perhaps add a link to this bug report? Just for more context,
no hard requirement as such.

> support, fsverity enabled files on btrfs can trigger reproducible
> warnings about file corruption, but in the end no error is returned to
> user space.
> 
> It turns out to be a bug in the btrfs fsverity integration, where blocks
> not included in the read range are passed to be verified.
> 
> This is a long-standing bug where btrfs fsverity always assumed that one
> folio contains exactly one fs block, ignoring the fact that btrfs had
> block size < page size support before fsverity support was added.
> 
> Add a new regression test case for it. The workload is pretty simple:
> 
> - Create a 32M file
> 
> - Punch a 64K hole for every 128K
>   This will limit the read bio size to 64K, which is smaller than
>   a lot of large folios, and thus can trigger the btrfs bug.
> 
> - Enable fsverity digest and drop page cache
> 
> - Read that file
> 
> - Verify there is no "FILE CORRUPTED!" warning
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog
> v2:
> - Do not use btrfs specific mount options to limit read bio size
>   Use holes to limit the size of read bios instead, now the test case
>   can be generic other than btrfs specific.
> 
> - Add the missing _require_check_dmesg call
> 
> v1:
> https://lore.kernel.org/linux-btrfs/20261010032508.36935-1-wqu@suse.com/
> ---
>  tests/generic/807     | 56 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/807.out |  2 ++
>  2 files changed, 58 insertions(+)
>  create mode 100755 tests/generic/807
>  create mode 100644 tests/generic/807.out
> 
> diff --git a/tests/generic/807 b/tests/generic/807
> new file mode 100755
> index 00000000..24e22e8c
> --- /dev/null
> +++ b/tests/generic/807
> @@ -0,0 +1,56 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 807
> +#
> +# Verify that reading a large file with holes won't trigger fsverity warnings
> +#
> +. ./common/preamble
> +_begin_fstest auto quick verity
> +
> +_fixed_by_fs_commit btrfs xxxxxxxxxxxx \
> +	"btrfs: fix the fsverity callback where unexpected range is verified"
> +
> +. ./common/verity
> +
> +_require_xfs_io_command "fpunch"
> +_require_check_dmesg
> +_require_scratch_verity
> +
> +filesize=$(( 32 * 1024 * 1024 ))
> +interval=$(( 128 * 1024 ))
> +holesize=$(( 64 * 1024 ))
> +
> +_scratch_mkfs_verity >> $seqres.full
> +_scratch_mount
> +
> +# Create a large enough file so that readahead is triggered, and
> +# large folios are allocated during readahead.
> +_pwrite_byte "0xcd" 0 "$filesize" "$SCRATCH_MNT/foobar" > /dev/null
> +
> +# Create a hole for every $interval bytes. This should limit the read to
> +# $(( $interval - $holesize)), which should be much smaller than the maximum
> +# folio size (2M for x86_64).
> +for (( i = 0; i < $(( $filesize / $interval )); i++ )); do
> +	$XFS_IO_PROG -c "fpunch $(( $i * $interval )) $holesize" \
> +		"$SCRATCH_MNT/foobar" > /dev/null
> +done
> +
> +_fsv_enable "$SCRATCH_MNT/foobar"

Could this disable signature enforcement with _disable_fsverity_signatures
and restore it from _cleanup(), as generic/572 and generic/788 do?

With fs.verity.require_signatures=1, _require_scratch_verity() succeeds:
_fsv_can_enable() temporarily disables signature enforcement and then
restores it. The later _fsv_enable() therefore fails with EPERM because
foobar is unsigned. I reproduced the output mismatch in the local Btrfs
VM; the same test passed with require_signatures=0

> +
> +# Cycle mount to drop page cache
> +_scratch_cycle_mount
> +
> +# Read the file, unpatched btrfs will verify blocks outside the read range and
> +# trigger fs-verity warnings.
> +# But the read itself should still be fine, as the failed part will be retried.
> +cat "$SCRATCH_MNT/foobar" > /dev/null
> +
> +# Check for any kernel warnings from fs-verity on file corruption.
> +if _check_dmesg_for "FILE CORRUPTED!"; then
> +	echo "fs-verity detected corruption"
> +fi
> +echo "Silence is golden"
> +
> +_exit 0
> diff --git a/tests/generic/807.out b/tests/generic/807.out
> new file mode 100644
> index 00000000..3752a5f7
> --- /dev/null
> +++ b/tests/generic/807.out
> @@ -0,0 +1,2 @@
> +QA output created by 807
> +Silence is golden

