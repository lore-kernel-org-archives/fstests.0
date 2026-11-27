Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779844;
	b=uuJwDZkwxxI/fVzUxXA8h2krvmKUN7gnB78enV6tV55rSmd8AwghSBc3gy//Bwi2id+Y
	 1pflh0+apjXHOPkeQwLLB4a6oJ3lJM95hdZA3VzSwfXJ5ErrVAUomdFxnjtilrc+honR5
	 ot4lNYPIbiknxAgPf0MfaG42cEoC/SNUzN0Cry5KDmB+xy6Lb1tamKL4Ahfu/WxWvOboY
	 6PpJjQmlkpgQiriTLNEwRrZPh4+DwuF7h/p8Htoijg7pK+1jTTEw3b/uw12Llt2K7n5yy
	 UVujiHPZfO28G1fUtt8vN5q7LHM7gX4LsN4ZpN7lZGED/XHg9EuBbbVGqz0xJM0rEFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779844;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=F2BophWJFZfec9hYrNMl4Cd6X5M7MOVj0pUhzlX87LY=;
	b=msspkKkMr2/a3as5I2yLDIzLK4VgE3VyToST6pTiCZEu2+GxLsBW3MTI26u6WK58ii4S
	 IGKMPmzlzG61bCemcxG+X+/PKANdb1+NTH0SpoEySM73Kfjark7Wx6fhrsDdIMQLeFh1B
	 LqdaHa5EYhE2Ep3jwIR35lZQfy/R5yujjboYhtHBxqFRiXa29vnflhzhXkxH1HxYJeDzA
	 l41wYgzNL0QcJ6FuTejwzJ5e2D0m0u4snSlpdeT4ovH4tN6cJueupxadoEeze7wB4Am89
	 E2UHbfni0MPkkU+aREr9TOXrxXGTrkf00YJUTPHD2iL2XyEueWhWYtNiiKvMNsnaVNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hJYMARPK;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11A606A331
	for <fstests@vger.kernel.org>; Fri, 27 Nov 2026 11:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E11A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hJYMARPK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=F2BophWJFZfec9hYrNMl4Cd6X5M7MOVj0pUhzlX87LY=;
	b=hJYMARPKIJrFgoVVhX3+g50vVxxmy7YlSvAHcpigTrMnnmSXm5Ke7FJPom26DM
	hpWbdnBR/KCgnsWz020/dCFKp52cg8Rqk2XO/8hs7P7OEzU0+01UK5FvIm8IXn8k
	oRi0CNrHJx5Nr7P70Bu1QxWmzFL1tV5TaytoCzrqE5puk=
Received: from [IPV6:2409:8900:1fda:c14d:49cd:379b:bab1:5955] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBX3uXbbAlr5ohfHg--.10556S2;
	Fri, 27 Nov 2026 19:43:25 +0800 (CST)
Message-ID: <9c2b4abe-8150-4b90-ac31-c3c3de90034e@163.com>
Date: Fri, 27 Nov 2026 19:43:23 +0800
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] generic: test a short copy into a hole of reused
 blocks
To: ernest.borowski.git@proton.me, fstests@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
References: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
 <20261126-ntfs-reproducers-v2-4-7d5fa5a688b9@proton.me>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261126-ntfs-reproducers-v2-4-7d5fa5a688b9@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBX3uXbbAlr5ohfHg--.10556S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFyxCr4DCF45Aw18uFyDKFg_yoWxZrW7pF
	WrtF15trs2g3y7u34fuF1UJFyrCw4fZF429ryIgFykZrZ8Wr4fKFWaqr1jqFWUtr13Gw4q
	vwsY934fWr1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07USLvNUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6R9vOmsJbN-QYQAA3D



在 2026/11/27 04:29, Ernest Borowski via B4 Relay 写道:
> From: Ernest Borowski <ernest.borowski.git@proton.me>
> 
> When a buffered write into a hole stops part way through a block because
> its source buffer runs into an unreadable page, only the bytes copied are
> dirty. A filesystem that allocates in units larger than the blocks it
> tracks as dirty, as ntfs does, has to zero the rest of the allocation, or
> reads return what the reused clusters held before. On ntfs the rest of the
> cluster read back the old file contents after an fsync and a remount, with
> 4 KiB and with 64 KiB clusters; the fix is "ntfs: zero the rest of a new
> cluster after a short buffered write" from the ntfs delayed allocation
> series, not merged yet. Fill a 512 MiB filesystem with data, so that the
> blocks the hole gets held data before, free the blocks of a filled file by
> truncating it to zero and back, write its last byte, write two and a half
> blocks into the hole from a buffer whose readable part ends in the first,
> second or third block, and compare the file with the expected contents
> after a remount. The write has to return a count between one and the
> readable length. The test does not run with the discard mount option,
> which may zero the freed blocks.
> 
> Link: https://lore.kernel.org/all/20261124-b4-ntfs-delalloc-fixes-v2-0-f394c800ec03@proton.me/
> Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
> ---
>   tests/generic/818     | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/818.out |  2 ++
>   2 files changed, 90 insertions(+)
> 
> diff --git a/tests/generic/818 b/tests/generic/818
> new file mode 100755
> index 00000000..ae669fac
> --- /dev/null
> +++ b/tests/generic/818
> @@ -0,0 +1,88 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
> +#
> +# FS QA Test No. 818
> +#
> +# A buffered write into a hole whose copy from user space stops part way
> +# through a block, because the source buffer runs into an unreadable page,
> +# must leave everything it did not write reading as zeroes once the data is on
> +# the disk.  The blocks the hole gets may have held data before, so a block
> +# that is allocated but only partly written would expose that old data.
> +#
> +# Fill a small filesystem with data, so that every block the hole can get held
> +# data before.  Then fill a file and fsync it, truncate it to zero and back to
> +# its size so that its old blocks are free again, write its last byte, and
> +# write two and a half blocks at a block boundary from a buffer with only part
> +# of it readable.  After an fsync and a remount the file must hold the bytes
> +# the write returned and zeroes around them.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
> +	"ntfs: zero the rest of a new cluster after a short buffered write"
> +
> +_require_scratch
> +# Compressed data would not fill the filesystem.
> +_require_no_compress
> +_require_test_program "pwrite-short-copy"
> +# Online discard can make freed blocks read back as zeroes, which hides the
> +# missing zeroing.
> +_exclude_scratch_mount_option "discard"

Hi Ernest,
    This helper checks MOUNT_OPTIONS using a substring match, so it also
matches "nodiscard" and skips the test when discard is explicitly disabled.
    It also misses discard enabled by default.
In that case, discarding the freed blocks could erase the old data that
  this test relies on.
    Could we check the effective mount options after _scratch_mount instead,
matching "discard" or "discard=..." as a complete option so that 
"nodiscard" is not excluded?

Thanks,
Baolin.

> +
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> "$seqres.full" 2>&1
> +_scratch_mount
> +
> +blksz=$(_get_file_block_size "$SCRATCH_MNT")
> +size=$((32 * blksz))
> +off=$((8 * blksz))
> +len=$((2 * blksz + blksz / 2))
> +file=$SCRATCH_MNT/file
> +
> +# Write until ENOSPC, in large and then in single blocks, so that the only free
> +# space left is what the file and the spare file free again.  _fill_fs is not
> +# used, as it may preallocate, which writes no data.  The syncs let delayed
> +# allocation give back what it reserved, so that the next pass writes it.
> +$XFS_IO_PROG -f -c "pwrite -q -S 0xab 0 $size" -c fsync "$file"
> +$XFS_IO_PROG -f -c "pwrite -q -S 0x33 0 $((2 * size))" -c fsync \
> +	"$SCRATCH_MNT/spare"
> +$XFS_IO_PROG -f -c "pwrite -S 0xcd -b 1m 0 512m" "$SCRATCH_MNT/fill1" \
> +	>> "$seqres.full" 2>&1
> +_scratch_sync
> +$XFS_IO_PROG -f -c "pwrite -S 0xcd -b $blksz 0 512m" "$SCRATCH_MNT/fill2" \
> +	>> "$seqres.full" 2>&1
> +_scratch_sync

Hi Ernest,
    Could we check the results of these fill writes and fail on errors
other than the expected ENOSPC? The _scratch_sync results should also be 
checked.
   Currently, the fill writes can fail with EIO, with the errors only 
recorded in seqres.full, and the test still proceeds to the short-copy
  checks.
    Those checks can pass even though the filesystem was not filled,
so we have not established that the newly allocated blocks previously
  contained nonzero data.

Thanks,
Baolin.

> +rm -f "$SCRATCH_MNT/spare"
> +_scratch_sync
> +$DF_PROG "$SCRATCH_MNT" >> "$seqres.full"
> +
> +# _scratch_cycle_mount sets $ret, so the write's result is kept in $written.
> +# Short copies that end in the first, second and third block of the write.
> +for copy in $((blksz / 4)) $((blksz + blksz / 4)) $((2 * blksz + blksz / 8)); do
> +	$XFS_IO_PROG -f -c "pwrite -q -S 0xab 0 $size" -c fsync \
> +		-c "truncate 0" -c "truncate $size" \
> +		-c "pwrite -q -S 0x01 $((size - 1)) 1" "$file"
> +	written=$("$here/src/pwrite-short-copy" "$file" "$off" "$len" "$copy") || \
> +		_fail "pwrite-short-copy failed"
> +	echo "copy $copy: write of $len bytes at $off returned $written" >> "$seqres.full"
> +	# The first $copy bytes of the buffer are readable, so the write must
> +	# store some of them and stop at the first unreadable byte.
> +	if [ "$written" -le 0 ] || [ "$written" -gt "$copy" ]; then
> +		echo "copy $copy: write of $len bytes at $off returned $written"
> +		continue
> +	fi
> +	$XFS_IO_PROG -c fsync "$file"
> +	# shellcheck disable=SC2119 # the mount options argument is optional
> +	_scratch_cycle_mount
> +
> +	rm -f "$tmp.expected"
> +	$XFS_IO_PROG -f -c "truncate $size" \
> +		-c "pwrite -q -S 0x01 $((size - 1)) 1" \
> +		-c "pwrite -q -S 0x5c $off $written" "$tmp.expected"
> +	cmp -s "$file" "$tmp.expected" || \
> +		echo "copy $copy: file contents differ after a short copy"
> +done
> +
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/generic/818.out b/tests/generic/818.out
> new file mode 100644
> index 00000000..cb099786
> --- /dev/null
> +++ b/tests/generic/818.out
> @@ -0,0 +1,2 @@
> +QA output created by 818
> +Silence is golden
> 

