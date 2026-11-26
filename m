Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675151;
	b=bINokdEmJ3dTmxtLiXT85v844RPWjQ9WovmQMDUjF6r+gHdhByIBoMYlGovA5xBbg/yF
	 CQqR8VqAqTDQvWq92Gpb0VzHU0LL1RxWvk4ezVMYuMsDUYxHJgBwp9yBeQAae4msbAi5s
	 EAtCbbshujuMvX4EvsOa34K0NbaRTsbT/tMEn7wi3FMkNMIXisg+rzoaTjqMW1ZHrazwS
	 fr+F9FzsS3yckUafyGCpZf1N4mLnJLqR29FSfyySMMouMVCI4vgw6lF0WrAuEDXET53F2
	 nLiiLvyXWi9vIFdTl1Uvy21KF0Oo9Zx7dkLK+Xi+Nn53/zrsBbrsu5EaPRJ+WzPyQJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675151;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=VoIVUCNtcY4UeRVmlU1KIubXSUlqBqHw4QhOLZwzs4I=;
	b=B9yF9na5wRG5HKHh0hrfhHpSPP/H+/h8UObnhxP/GFLb2VR/IP0DznMlbK+mmxpbw5/Q
	 CXIZP7qBV3HCj4/Yb31j4EcIoH+3oa2RWXGtOMIY+O3SymAHwk4nY3xtjz3YDGURUSnv0
	 8RwXzNxAsmyLEVczFWueA9h90+jkEgn8h/pmkW41RqUSyOAWKh5FotiuPvvGi8t1CFEvx
	 lzeCGaq6Kto9WdFzEAICAXS392Z7mHG72yGK7syGQsI9qMzzrWb17XPasNdTPHYq72bsF
	 F10jXQw/D6vMoAH/qjK2/SiwGkbYQ2yFqxI6ZE6DVC/U2S8ZwTF4a29gypZ1LrElrZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="YI9/QJh+";
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F979606A32C
	for <fstests@vger.kernel.org>; Thu, 26 Nov 2026 06:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F979606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YI9/QJh+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=VoIVUCNtcY4UeRVmlU1KIubXSUlqBqHw4QhOLZwzs4I=;
	b=YI9/QJh+7SkOcJdGlqQFNd/0hgK51yYj1ILQfceGQ+qRYLFpFCeTdimeral/AK
	RztZ7y6lMwqI0ZfpCFRABKmY8jrKr98TqKqn/WiS3u93LLhJybNR+joA/9TPZ73o
	eEIdrNB9bLRXqI0KAJ0QN2p6jEBnHrdF6/YSSdEExHY9Y=
Received: from [IPV6:2409:8900:1fda:c14d:fe4b:463:9ed6:5819] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBX5Jfr0wdrS4fUIA--.30970S2;
	Thu, 26 Nov 2026 14:38:36 +0800 (CST)
Message-ID: <8e55e631-96e0-464d-b29b-0db2f56c2911@163.com>
Date: Thu, 26 Nov 2026 14:38:35 +0800
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
Subject: Re: [PATCH 4/4] generic: test a short copy into a hole of reused
 blocks
To: ernest.borowski.git@proton.me, fstests@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
 <20261125-ntfs-reproducers-v1-4-0cc67533d803@proton.me>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261125-ntfs-reproducers-v1-4-0cc67533d803@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBX5Jfr0wdrS4fUIA--.30970S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WFy7ZFyxZryruFy5uF4kZwb_yoW7XrWxpF
	yrta45trs7K347u34fuF17Jr9Ykws3uFWa9ryIqrykuFZ8Wr4IvFyYqryqvF4Utr1fWr4j
	vrsYk3yfWr1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UatCcUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QzMl2sH0+zUJQAA3c



在 2026/11/26 03:03, Ernest Borowski via B4 Relay 写道:
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
> series, not merged yet. Free the blocks of a filled file by truncating it
> to zero and back, write its last byte, write two and a half blocks into the
> hole from a buffer that is readable for 1000, 5096 or 12800 bytes, and
> compare the file with the expected contents after a remount.
> 
> Link: https://lore.kernel.org/all/20261124-b4-ntfs-delalloc-fixes-v2-0-f394c800ec03@proton.me/
> Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
> ---
>   tests/generic/818     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/818.out |  2 ++
>   2 files changed, 60 insertions(+)
> 
> diff --git a/tests/generic/818 b/tests/generic/818
> new file mode 100755
> index 00000000..97c30767
> --- /dev/null
> +++ b/tests/generic/818
> @@ -0,0 +1,58 @@
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
> +# Fill a file and fsync it, truncate it to zero and back to its size so that
> +# its old blocks are free again, write its last byte, then write two and a
> +# half blocks at a block boundary from a buffer with only part of it readable.
> +# After an fsync and a remount the file must hold the bytes the write returned
> +# and zeroes around them.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
> +
> +_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
> +	"ntfs: zero the rest of a new cluster after a short buffered write"
> +
> +_require_scratch
> +_require_test_program "pwrite-short-copy"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +blksz=$(_get_file_block_size $SCRATCH_MNT)
> +size=$((32 * blksz))
> +off=$((8 * blksz))
> +len=$((2 * blksz + blksz / 2))
> +file=$SCRATCH_MNT/file
> +
> +# _scratch_cycle_mount sets $ret, so the write's result is kept in $written.
> +# Short copies that end in the first, second and third block of the write.
> +for copy in $((blksz / 4)) $((blksz + blksz / 4)) $((2 * blksz + blksz / 8)); do
> +	$XFS_IO_PROG -f -c "pwrite -q -S 0xab 0 $size" -c fsync \
> +		-c "truncate 0" -c "truncate $size" \
> +		-c "pwrite -q -S 0x01 $((size - 1)) 1" $file

Hi Ernest,
    The later write may get different blocks from the ones filled with 
0xab.
    There is also the discard case: if freeing the old blocks causes them
to read back as zeroes, the test may no longer detect the missing zeroing.
    Would it make sense to exclude discard configurations that clear the
freed data, and make reuse of the patterned blocks more reliable?
That would help avoid a pass simply because the newly allocated blocks 
already contain zeroes.

Thanks,
Baolin.

> +	written=$($here/src/pwrite-short-copy $file $off $len $copy)

Hi Ernest,
    Could we check the result here before continuing?
    The helper exits with status zero even when pwrite() fails; it
reports the negative errno on stdout. If it prints -EIO, -EFAULT, or
zero and the file is unchanged, the expected file still matches and the
test can pass without exercising a short write.

    Checking the helper's exit status and requiring 0 < written <= copy
and written < len should catch this. Unexpected errors should fail the
test.
    If we cannot get a positive short write with this setup, retrying or
skipping would be better than reporting a pass.

Thanks,
Baolin.

> +	echo "copy $copy: write of $len bytes at $off returned $written" >> $seqres.full
> +	$XFS_IO_PROG -c fsync $file
> +	_scratch_cycle_mount
> +
> +	rm -f $tmp.expected
> +	$XFS_IO_PROG -f -c "truncate $size" \
> +		-c "pwrite -q -S 0x01 $((size - 1)) 1" $tmp.expected
> +	[ "$written" -gt 0 ] && \
> +		$XFS_IO_PROG -c "pwrite -q -S 0x5c $off $written" $tmp.expected
> +	cmp -s $file $tmp.expected || \
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

