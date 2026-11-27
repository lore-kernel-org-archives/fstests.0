Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778783;
	b=rfzZ16Vi2xFiQzGWnAgnY1pXrK8tkFw0w8AKvqODUCTucGwwiznJfR/012RbWq24cR41
	 DzmC+tdEpxG6tY6AY3Br93kZ3IGHlT1PpG0ZpRFJQwT0wRq0rwoEqhts83fyadjVkk3G3
	 1o2FvEPSupOVEiPhgpUAd5FaNBIIxXpNcdflEYHAbnF/s9FSYoqziOO0zmnv7ssQEcdZ0
	 sUzIG+47L9dLQBKVc8ZtbIIMZK3HzJPtqU3qy4jHJBW7xh84y1RtMXeyiedTokCIVVKhm
	 bYJVO4tVfiD2Zto9C3tZ2vpVO1Yc2vROXF2/CuHPD6j+UREgGUSTxcn8SHmbMm9FpAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778783;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=lS4pVVRW6QqvdfoubWQCF/rI+dOHKE2lTWIFIMGQzfM=;
	b=Vx7CCdH5hoFyNla+JWv40tZ1Q64w2nUn/V4XyuPrTl0fOv7hhtz75Js08m5GmvyMhRnF
	 F4tzv3i/xnWUKPDdPJgLXWlIlC2rHpZ3EoFS63vKAGZphaO1UXdewZJbu+WUiwitKdItl
	 YoLh3hb8cYs7C9UHwIWEhggLC5bLsIJO3VEQa5qwqVVUa07wP6S3yg3cu0b+WZv0iFDO1
	 M6PIsaovFKhJpjF+uoowADRS9iOK2oIfrEgcq2/ABwhlCpwV7cEVHS7l+5PPmlaKLdbrO
	 UZ0uvsntlBuHQ3SXa+j0Ql3+UkJMdSqkgSClo/24yJnauLSnvWVa0YFsUUCKOQRqsaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GmOn4zcM;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DED606A321
	for <fstests@vger.kernel.org>; Fri, 27 Nov 2026 11:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73DED606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GmOn4zcM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=lS4pVVRW6QqvdfoubWQCF/rI+dOHKE2lTWIFIMGQzfM=;
	b=GmOn4zcMxQjQH4EkXZHjTLjcXnjfT1tSXA1NBZgam3ymVIxAQs1r2CVY8jBNyT
	Sv48JweVNDK9CeRI6QKjfQyMe8uAXbSfasH5vjbuCrtigqBG50cYJEVaL9suNWvg
	cAz22Ctq0ZSDXSj/LctmOoGW6JUQ0lIn2Nuq0JTN+grZc=
Received: from [IPV6:2409:8900:1fda:c14d:49cd:379b:bab1:5955] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCnIYinaAlraV8EIg--.27558S2;
	Fri, 27 Nov 2026 19:25:28 +0800 (CST)
Message-ID: <c23e1ae0-18b0-4b53-abf1-2f0965253ae6@163.com>
Date: Fri, 27 Nov 2026 19:25:27 +0800
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
Subject: Re: [PATCH v2 2/4] generic: check the size after a buffered write
 runs out of space
To: ernest.borowski.git@proton.me, fstests@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
References: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
 <20261126-ntfs-reproducers-v2-2-7d5fa5a688b9@proton.me>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261126-ntfs-reproducers-v2-2-7d5fa5a688b9@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCnIYinaAlraV8EIg--.27558S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFW5uw1fKFy3GF48Wr1rZwb_yoW7AryxpF
	yF93W5KrZ7Kw47Wrn3CF15trn8CF4fXFWavr929w1kurW5Wr129FWaqryDXrWUAr1fWr4j
	vanY934IkryUXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAPEhUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6ghhLGsJaKgw7gAA3T



在 2026/11/27 04:29, Ernest Borowski via B4 Relay 写道:
> From: Ernest Borowski <ernest.borowski.git@proton.me>
> 
> A buffered write that runs out of free space part way returns a short
> count, and the file size has to end at the last byte it wrote. ntfs raises
> the size to the end of the whole request before it copies anything and
> keeps it after the copy stops early, so the file grows by a tail of zeroes
> that the caller never wrote; "ntfs: trim the sizes after a short write" by
> Zhan Xusheng, under review on the ntfs list, fixes that. Fill a 512 MiB
> filesystem, free 256 KiB or more again, write eight times as much to a file
> in one write(2) that starts 64 KiB or one block before the end of the file,
> and check the size before and after a remount and the contents of the file.
> XFS and ext4 reserve space for all of a new range at once, so a write that
> started at the end of the file failed there with nothing written; this one
> stores the part over the old data and comes up short. A write error other
> than ENOSPC fails the test, and a
> write that fails with ENOSPC before storing anything is checked the same
> way but then reported as not run. generic/275 also runs a filesystem out of
> space with writes, but only checks that some data was written.
> 
> Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
> ---
>   tests/generic/816     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/816.out |  2 ++
>   2 files changed, 93 insertions(+)
> 
> diff --git a/tests/generic/816 b/tests/generic/816
> new file mode 100755
> index 00000000..625a8429
> --- /dev/null
> +++ b/tests/generic/816
> @@ -0,0 +1,91 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
> +#
> +# FS QA Test No. 816
> +#
> +# A buffered write that runs out of space part way must leave the file size
> +# at the end of the bytes it wrote.  Fill a small filesystem, free a little
> +# space again, and write more than that to a file in one write(2) that starts
> +# a little before the end of the file and goes past it.  Check that the size
> +# ends at the end of the old data or of the bytes the write returned,
> +# whichever is further, before and after a remount, and that the file holds
> +# the old data with the bytes written over it.
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
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> "$seqres.full" 2>&1
> +_scratch_mount
> +
> +blksz=$(_get_file_block_size "$SCRATCH_MNT")
> +unit=$((blksz > 65536 ? blksz : 65536))
> +old=$((4 * unit))
> +len=$((32 * unit))
> +# The write starts inside the old data: a filesystem that reserves space for
> +# all of a new range at once, as XFS does, then still stores the part over
> +# allocated blocks and comes up short instead of failing with nothing written.
> +pos=$((old - unit))
> +file=$SCRATCH_MNT/file
> +
> +$XFS_IO_PROG -f -c "pwrite -q -S 0x11 0 $old" -c fsync "$file"
> +$XFS_IO_PROG -f -c "pwrite -q -S 0x33 0 $old" -c fsync "$SCRATCH_MNT/spare"
> +_fill_fs $((64 * 1024 * 1024)) "$SCRATCH_MNT/fill" "$blksz" 0 >> "$seqres.full" 2>&1
> +rm -f "$SCRATCH_MNT/spare"
> +_scratch_sync
> +$DF_PROG "$SCRATCH_MNT" >> "$seqres.full"
> +
> +# One write(2) of $len bytes at $pos.  xfs_io prints the count
> +# the write returned, or the error when the write failed.  ENOSPC before the
> +# first byte is checked like a short write of zero bytes, any other error
> +# fails the test.
> +$XFS_IO_PROG -c "pwrite -S 0x22 -b $len $pos $len" "$file" > "$tmp.write" 2>&1
> +cat "$tmp.write" >> "$seqres.full"
> +written=$(sed -n -e 's/^wrote \([0-9]*\)\/.*/\1/p' "$tmp.write")
> +if [ -z "$written" ]; then
> +	grep -q "No space left on device" "$tmp.write" || \
> +		_fail "write failed: $(cat "$tmp.write")"
> +	written=0
> +fi
> +[ "$written" -lt "$len" ] || _notrun "could not run the filesystem out of space"
> +
> +end=$((pos + written > old ? pos + written : old))
> +errors=0
> +check_size()
> +{
> +	local size
> +
> +	size=$(_get_filesize "$file")
> +	[ "$size" -eq "$end" ] && return
> +	echo "$1: size $size after writing $written bytes at $pos"
> +	errors=$((errors + 1))
> +}
> +
> +check_size "after the write"
> +# shellcheck disable=SC2119 # the mount options argument is optional
> +_scratch_cycle_mount
> +check_size "after remount"
> +
> +$XFS_IO_PROG -f -c "pwrite -q -S 0x11 0 $old" "$tmp.expected"
> +[ "$written" -gt 0 ] && \
> +	$XFS_IO_PROG -c "pwrite -q -S 0x22 $pos $written" "$tmp.expected"
> +if ! cmp -s "$file" "$tmp.expected"; then
> +	echo "file contents differ"
> +	errors=$((errors + 1))
> +fi
> +
> +# A write that failed before storing anything must not change the file either,
> +# but it did not test a short write.
> +[ "$written" -eq 0 ] && [ "$errors" -eq 0 ] && \
> +	_notrun "the write failed with ENOSPC before storing anything"
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

Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

