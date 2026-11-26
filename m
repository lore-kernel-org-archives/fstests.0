Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795674550;
	b=yz97lgT6UhIQf63RBMYH0tv7fiw4z/UuF5nmc0FPXZASxCgRtktLUQHlGDOmSL5zr8eM
	 mCKnuwReENUbcguAibrqYPmsZPOnzza9sLAkU27YwF0YHI8hPTAgL3hEZaAcFjgybiJX8
	 SJmaDLxl9DvVgY8ry/bq9IUHxR2nNSkATRsvF01sEWNiNHLKHTUlteLZmvD2NHNhiP5w9
	 SxIzfz505NaXFGUBi4GcyaJEKI1fOxUHuMSO6HWLzr/jUFbAHbdoQXKgTKW4XctKZmw+f
	 XfXVblVyRA88EP4c7Nm5o45wqbmTE59bXpQhaOIKBy7GZvZbu6taXSUKm/OBtrlYHfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795674550;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=ZH7vGnguPt41FP/7x9/v1Iw12AHQ3ftHn6doqgojHxU=;
	b=avueAeKzH6oQSxviO3HXtxVNBMW8jV+2bZS5Au3Mm32xRj3T8gKm4SQGYHPnBdpC7R2z
	 mTrg3XrCymezDdSpIneJXlUFk+i/R4hadAPYsKnXQ6E9TjzDOdedqZ3Kd7x8pzqLVl2tm
	 SQxamcmJ+5xW7IMd3KFM4O+sB0hVhe2VNrgW+Zc+YoQQ687WTu89sCeYv8gO3blox5t1G
	 jRrZD24KIntALkmrONolRIrRJAFv3/RYpiYpz/TLhGw6Ol31o8rqjfxpP8flLT/YCjhm3
	 f5vXRf+0B+sPYJwO88FQnTOZ2XZJYHQaLLr6SdDzWK0LrdtRitQBnAX64iv5cwbFYhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SPKHWw4e;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20EE606A31C
	for <fstests@vger.kernel.org>; Thu, 26 Nov 2026 06:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D20EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SPKHWw4e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=ZH7vGnguPt41FP/7x9/v1Iw12AHQ3ftHn6doqgojHxU=;
	b=SPKHWw4ef70BUB0G1qal4xfO1mORZst1G8VAyPvxcYaX7HD90Q6wsEzQdl/Z6K
	xt04BG862Hn4oT+cjhQ+aa8vuSZORT/5PCsJEN4LnALvyAgjDu3yY1ifPbDIu0mO
	017lby2gQ5FlT6Q5rgAVFZLWQi2bGitzQKTLjsQt3Qn8M=
Received: from [IPV6:2409:8900:1fda:c14d:fe4b:463:9ed6:5819] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXN6uW0QdrcePSIA--.30686S2;
	Thu, 26 Nov 2026 14:28:39 +0800 (CST)
Message-ID: <fd96d9db-0ada-4d71-8927-c5bb756a72b5@163.com>
Date: Thu, 26 Nov 2026 14:28:38 +0800
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
Subject: Re: [PATCH 3/4] generic: test fallocate after a buffered write that
 faulted
To: ernest.borowski.git@proton.me, fstests@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
 <20261125-ntfs-reproducers-v1-3-0cc67533d803@proton.me>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <20261125-ntfs-reproducers-v1-3-0cc67533d803@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXN6uW0QdrcePSIA--.30686S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF4UurWkCrWxtFyUWr1Utrb_yoWfGr1xpF
	Wrt3ZYkr4xt347Cwn3ZF17XF1rWwsYgF4Uur1xWF93ZFZ8XF4xXFW2gr98ur48Ar47Jr4j
	vFs09ry3GFnrZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U-Z2fUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6hg3AmsH0ZiQtwAA3F



在 2026/11/26 03:03, Ernest Borowski via B4 Relay 写道:
> From: Ernest Borowski <ernest.borowski.git@proton.me>
> 
> A buffered write into a hole may reserve or map space before it copies from
> the user buffer, and when the copy faults on the first byte the write fails
> with EFAULT and must leave nothing behind. On ntfs the delayed allocation
> run it set up stayed in the runlist without any dirty data, and punching,
> collapsing or inserting a range through it shifted the run onto clusters of
> other files, so the file read their contents and ntfsck found the cluster
> bitmap inconsistent. The fixes are "ntfs: punch out the delalloc
> reservation of a failed buffered write" and "ntfs: do not shift the cluster
> number of a delalloc run on split" from the ntfs delayed allocation series,
> not merged yet. Fail a write over the first half of a sparse file, then
> punch, collapse, insert or write a range inside that half, and compare each
> file with its expected contents after a remount. The new helper
> src/pwrite-short-copy calls pwrite(2) once from a buffer whose readable
> part ends a given number of bytes in, and prints what it returned.
> 
> Link: https://lore.kernel.org/all/20261124-b4-ntfs-delalloc-fixes-v2-0-f394c800ec03@proton.me/
> Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
> ---
>   .gitignore              |   1 +
>   src/Makefile            |   2 +-
>   src/pwrite-short-copy.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
>   tests/generic/817       |  83 +++++++++++++++++++++++++++++++++++++++
>   tests/generic/817.out   |   2 +
>   5 files changed, 188 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitignore b/.gitignore
> index cdcfa06e..afce03d4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -123,6 +123,7 @@ tags
>   /src/preallo_rw_pattern_reader
>   /src/preallo_rw_pattern_writer
>   /src/punch-alternating
> +/src/pwrite-short-copy
>   /src/pwrite_mmap_blocked
>   /src/randholes
>   /src/readdir-while-renames
> diff --git a/src/Makefile b/src/Makefile
> index a1fc38d8..0b031620 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -38,7 +38,7 @@ LINUX_TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>   	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>   	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
>   	rw_hint btrfs_ioctl refluxfs xfs-exchange-to-eof \
> -	xfs-exchange-to-dirty-eof xfs-swapext-reflink
> +	xfs-exchange-to-dirty-eof xfs-swapext-reflink pwrite-short-copy
>   
>   EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>   	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/pwrite-short-copy.c b/src/pwrite-short-copy.c
> new file mode 100644
> index 00000000..2f1c36a3
> --- /dev/null
> +++ b/src/pwrite-short-copy.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
> + *
> + * Call pwrite(2) once with a source buffer that ends in an inaccessible page,
> + * so that the copy from user space stops after a given number of bytes: the
> + * write comes up short, or fails with EFAULT when no byte is readable.
> + *
> + * usage: pwrite-short-copy [-p pattern] file offset length readable
> + *
> + * The first "readable" bytes of the buffer hold the pattern byte (default
> + * 0x5c), and the page after them is PROT_NONE.  The program prints what
> + * pwrite(2) returned: the number of bytes written, or minus the errno.
> + * It exits 0 in both cases, and 1 on a usage or setup error.
> + */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +static void usage(const char *prog)
> +{
> +	fprintf(stderr,
> +		"usage: %s [-p pattern] file offset length readable\n", prog);
> +	exit(1);
> +}
> +
> +static long long parse(const char *s, const char *prog)
> +{
> +	char *end;
> +	long long v;
> +
> +	errno = 0;
> +	v = strtoll(s, &end, 0);
> +	if (errno || *end || v < 0)
> +		usage(prog);
> +	return v;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	long long offset, length, readable;
> +	size_t pagesize = getpagesize();
> +	size_t npages;
> +	int pattern = 0x5c;
> +	char *map, *buf;
> +	ssize_t ret;
> +	int fd, c;
> +
> +	while ((c = getopt(argc, argv, "p:")) != -1) {
> +		switch (c) {
> +		case 'p':
> +			pattern = parse(optarg, argv[0]) & 0xff;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +	if (argc - optind != 4)
> +		usage(argv[0]);
> +
> +	offset = parse(argv[optind + 1], argv[0]);
> +	length = parse(argv[optind + 2], argv[0]);
> +	readable = parse(argv[optind + 3], argv[0]);
> +
> +	fd = open(argv[optind], O_WRONLY);
> +	if (fd < 0) {
> +		perror(argv[optind]);
> +		return 1;
> +	}
> +
> +	/* the readable bytes end where the last, inaccessible page starts */
> +	npages = (readable + pagesize - 1) / pagesize + 1;
> +	map = mmap(NULL, npages * pagesize, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (map == MAP_FAILED) {
> +		perror("mmap");
> +		return 1;
> +	}
> +	buf = map + (npages - 1) * pagesize - readable;
> +	memset(buf, pattern, readable);
> +	if (mprotect(map + (npages - 1) * pagesize, pagesize, PROT_NONE)) {
> +		perror("mprotect");
> +		return 1;
> +	}
> +
> +	ret = pwrite(fd, buf, length, offset);
> +	if (ret < 0)
> +		printf("%d\n", -errno);
> +	else
> +		printf("%zd\n", ret);
> +
> +	if (close(fd)) {
> +		perror("close");
> +		return 1;
> +	}
> +	return 0;
> +}
> diff --git a/tests/generic/817 b/tests/generic/817
> new file mode 100755
> index 00000000..dff08a28
> --- /dev/null
> +++ b/tests/generic/817
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
> +#
> +# FS QA Test No. 817
> +#
> +# A buffered write into a hole that fails with EFAULT, because not one byte of
> +# its source buffer is readable, must not leave anything behind that later
> +# operations trip over.  After such a write over the first half of a sparse
> +# file, punch a hole through that range, collapse a range out of it, insert a
> +# range into it or write into it, and check that after a remount the file
> +# reads back as zeroes, apart from the data written.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw punch collapse insert
> +
> +_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
> +	"ntfs: punch out the delalloc reservation of a failed buffered write"
> +_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
> +	"ntfs: do not shift the cluster number of a delalloc run on split"
> +
> +_require_scratch
> +_require_test_program "pwrite-short-copy"
> +_require_xfs_io_command "fpunch"
> +_require_xfs_io_command "fcollapse"
> +_require_xfs_io_command "finsert"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +blksz=$(_get_file_block_size $SCRATCH_MNT)
> +unit=$((blksz > 65536 ? blksz : 65536))
> +size=$((16 * unit))
> +piece=$((2 * unit))
> +
> +# Data in other files, so that blocks a broken mapping points to are not zero.
> +for i in 1 2 3 4; do
> +	$XFS_IO_PROG -f -c "pwrite -q -S 0x3$i 0 $((8 * unit))" \
> +		$SCRATCH_MNT/other$i
> +done
> +_scratch_sync
> +
> +for op in none punch collapse insert write; do
> +	file=$SCRATCH_MNT/$op
> +	$XFS_IO_PROG -f -c "truncate $size" -c fsync $file
> +
> +	# EFAULT is errno 14
> +	ret=$($here/src/pwrite-short-copy $file 0 $((size / 2)) 0)
> +	[ "$ret" = "-14" ] || \
> +		echo "$op: write from an unreadable buffer returned $ret"
> +
> +	newsize=$size
> +	case $op in
> +	punch)
> +		$XFS_IO_PROG -c "fpunch $piece $piece" $file
> +		;;
> +	collapse)
> +		$XFS_IO_PROG -c "fcollapse $piece $piece" $file
> +		newsize=$((size - piece))
> +		;;
> +	insert)
> +		$XFS_IO_PROG -c "finsert $piece $piece" $file
> +		newsize=$((size + piece))
> +		;;
> +	write)
> +		$XFS_IO_PROG -c "pwrite -q -S 0x77 $piece $unit" $file
> +		;;
> +	esac
> +
> +	$XFS_IO_PROG -f -c "truncate $newsize" $tmp.$op
> +	[ $op = write ] && \
> +		$XFS_IO_PROG -c "pwrite -q -S 0x77 $piece $unit" $tmp.$op
> +done
> +
> +# Read everything back from the disk.
> +_scratch_cycle_mount
> +for op in none punch collapse insert write; do
> +	cmp -s $SCRATCH_MNT/$op $tmp.$op || \
> +		echo "$op: file contents differ after the failed write"
> +done
> +
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/generic/817.out b/tests/generic/817.out
> new file mode 100644
> index 00000000..86920a4f
> --- /dev/null
> +++ b/tests/generic/817.out
> @@ -0,0 +1,2 @@
> +QA output created by 817
> +Silence is golden
> 


Looks good to me.

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>

