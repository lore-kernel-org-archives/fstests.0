Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674442;
	b=0vphGFdbIoJd4JIlfV8en2FTMxXTu8oPafoL7VhHGc+GZT1fi96AYevfZEyByTC7jacU
	 SYRTcbgrtUF9RkAWCasNu94mQRPIt14yqbFgAZTr5XOMl/BvKK52TZIruoNlMa1dsJSpI
	 p4lvnTV8wVpaOKyOQHVb5XGdp1VyibX39NbuaywxVzGfLJDLqz7OQm3RkY9gLnmppny6Z
	 5/Su3dmi7mng1BrMHOuu28vpJWm25FtCcmBw7aIJL/g8lc3/MydAQv/gwG7ceItr8iP7Y
	 C69Sf9999p2EC3xMqhFTzHgqudyy91O209fwH2astQXrMkSZwjZiFsQnPMhO0tSZ5uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674442;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=IEYkJEow+ORSt39vLPUHZNqoyYPqxadJuAtprzzE5qQ=;
	b=Iav7lqI7gUcdOPYDfNJRjYPkuAV2fg3nDFlNYIuyLTami/CqUHtDa7zNEgPustoB50F1
	 cr0ltMJvp6bQNX/62o/sa7TSVAgLoKItZV2GutB73bqkAOmutGK0G3J4iPXL+hd0DpxRv
	 Cjnw+GrxmPml52KTHt4gN55OxSwhQ+Ed8YDMiFj7vaOvzEDHuYa8uD1j2NgEmiZQ5zh1P
	 9oJjs++ghsLA0J8gagwSzSM76UHHHIQBPm+GXWrNZxw3cBmWemAMGUpXD/WiAdalCchBa
	 1/6MJrsD2fsPLUiwmvIv4Jvw9FGhsJcRJjCJ5YsYJbrfaU1bp2dwWfjQO6zcpt3uycQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=G2FYGLOK;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EF0606A31C
	for <fstests@vger.kernel.org>; Thu, 26 Nov 2026 06:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2EF0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=G2FYGLOK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=IEYkJEow+ORSt39vLPUHZNqoyYPqxadJuAtprzzE5qQ=;
	b=G2FYGLOKo4qdGEvdLtSHC9B/tBMXcAxRXfSqbD00aNEE8Xsj8CjuU7onaHH0fe
	IbjHsPDSCGwqYeipicQwRP1jzW8fTApoHixPXNg1RKhOFaBtAbJruMczlyS4kOjX
	WtI4R/PrHxfPzax1AAetx2MiKRBWx1L7yzINRJikIjsek=
Received: from [IPV6:2409:8900:1fda:c14d:fe4b:463:9ed6:5819] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXn9Mo0QdrqPtLKA--.14715S2;
	Thu, 26 Nov 2026 14:26:50 +0800 (CST)
Message-ID: <d485f4ea-89ca-432d-a6aa-de39ee968d81@163.com>
Date: Thu, 26 Nov 2026 14:26:43 +0800
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
Subject: Re: [PATCH 2/4] generic: check the size after a buffered write runs
 out of space
To: ernest.borowski.git@proton.me, fstests@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
 <20261125-ntfs-reproducers-v1-2-0cc67533d803@proton.me>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261125-ntfs-reproducers-v1-2-0cc67533d803@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXn9Mo0QdrqPtLKA--.14715S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW3ZF1DGF4rtFyUWFykKrg_yoWrCF4xpa
	4FkF98trW8K3W7GrySkF1Yyr95Crs3ZFWakryI9a4kZrWDWr1xuFWagryqqrWDAr1fWr4Y
	yan5Ka4xKr1UXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWKZAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gob5WsH0Sp65gAA3V



在 2026/11/26 03:03, Ernest Borowski via B4 Relay 写道:
> From: Ernest Borowski <ernest.borowski.git@proton.me>
> 
> A buffered write that runs out of free space part way returns a short
> count, and the file size has to end at the last byte it wrote. ntfs raises
> the size to the end of the whole request before it copies anything and
> keeps it after the copy stops early, so the file grows by a tail of zeroes
> that the caller never wrote; "ntfs: trim the sizes after a short write" by
> Zhan Xusheng, under review on the ntfs list, fixes that. Fill a 512 MiB
> filesystem, free 256 KiB or more again, append eight times as much to a
> file in one write(2), and check the size before and after a remount and the
> contents of the file. generic/275 also runs a filesystem out of space with
> writes, but only checks that some data was written.
> 
> Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
> ---
>   tests/generic/816     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/816.out |  2 ++
>   2 files changed, 69 insertions(+)
> 
> diff --git a/tests/generic/816 b/tests/generic/816
> new file mode 100755
> index 00000000..14432f13
> --- /dev/null
> +++ b/tests/generic/816
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
> +#
> +# FS QA Test No. 816
> +#
> +# A buffered write that runs out of space part way must leave the file size
> +# at the end of the bytes it wrote.  Fill a small filesystem, free a little
> +# space again, append more than that to a file in one write(2), and check that
> +# the size is the old size plus the count the write returned, before and after
> +# a remount, and that the file holds the old data followed by the bytes
> +# written.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw enospc
> +
> +. ./common/populate
> +
> +_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
> +	"ntfs: trim the sizes after a short write"
> +
> +_require_scratch
> +_require_no_compress
> +
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +
> +blksz=$(_get_file_block_size $SCRATCH_MNT)
> +unit=$((blksz > 65536 ? blksz : 65536))
> +old=$((4 * unit))
> +len=$((32 * unit))
> +file=$SCRATCH_MNT/file
> +
> +$XFS_IO_PROG -f -c "pwrite -q -S 0x11 0 $old" -c fsync $file
> +$XFS_IO_PROG -f -c "pwrite -q -S 0x33 0 $old" -c fsync $SCRATCH_MNT/spare
> +_fill_fs $((64 * 1024 * 1024)) $SCRATCH_MNT/fill $blksz 0 >> $seqres.full 2>&1
> +rm -f $SCRATCH_MNT/spare
> +_scratch_sync
> +$DF_PROG $SCRATCH_MNT >> $seqres.full
> +
> +# One write(2) of $len bytes at the end of the file.  xfs_io prints the count
> +# the write returned, or an error and no count when it wrote nothing.
> +$XFS_IO_PROG -c "pwrite -S 0x22 -b $len $old $len" $file > $tmp.write 2>&1
> +cat $tmp.write >> $seqres.full
> +written=$(sed -n -e 's/^wrote \([0-9]*\)\/.*/\1/p' $tmp.write)
> +written=${written:-0}
> +[ $written -lt $len ] || _notrun "could not run the filesystem out of space"

Hi Ernest,
    Could we avoid treating every missing byte count as zero here?
    For example, if xfs_io reports pwrite: Input/output error and leaves
the file unchanged, written becomes zero and both the size and content
checks pass. The error only appears in $seqres.full.
    I think unexpected errors should fail the test, with ENOSPC handled
separately. It would also be good to check that we actually get a
positive short write. A zero-byte ENOSPC result is worth checking too.

Thanks,
Baolin.

> +
> +check_size()
> +{
> +	local size=$(_get_filesize $file)
> +
> +	[ $size -eq $((old + written)) ] || \
> +		echo "$1: size $size after writing $written bytes at $old"
> +}
> +
> +check_size "after the write"
> +_scratch_cycle_mount
> +check_size "after remount"
> +
> +$XFS_IO_PROG -f -c "pwrite -q -S 0x11 0 $old" $tmp.expected
> +[ $written -gt 0 ] && \
> +	$XFS_IO_PROG -c "pwrite -q -S 0x22 $old $written" $tmp.expected
> +cmp -s $file $tmp.expected || echo "file contents differ"
> +
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/generic/816.out b/tests/generic/816.out
> new file mode 100644
> index 00000000..a9d8f943
> --- /dev/null
> +++ b/tests/generic/816.out
> @@ -0,0 +1,2 @@
> +QA output created by 816
> +Silence is golden
> 

