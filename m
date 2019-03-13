Received: from userp2120.oracle.com ([156.151.31.85]:59536 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCMBMZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Mar 2019 21:12:25 -0400
Date: Tue, 12 Mar 2019 18:12:08 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] generic: unaligned direct AIO write test
Message-ID: <20190313011208.GI4660@magnolia>
References: <20190312091944.2044-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312091944.2044-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, fsorenso@redhat.com, lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 12, 2019 at 05:19:44PM +0800, Zorro Lang wrote:
> A simply reproducer from Frank Sorenson:
> 
>   ftruncate(fd, 65012224)
>   io_prep_pwrite(iocbs[0], fd, buf[0], 1048576, 63963648);
>   io_prep_pwrite(iocbs[1], fd, buf[1], 1048576, 65012224);
> 
>   io_prep_pwrite(iocbs[2], fd, buf[2], 1048576, 66060800);
>   io_prep_pwrite(iocbs[3], fd, buf[3], 1048576, 67109376);
> 
>   io_submit(io_ctx, 1, &iocbs[0]);
>   io_submit(io_ctx, 1, &iocbs[1]);
>   io_submit(io_ctx, 1, &iocbs[2]);
>   io_submit(io_ctx, 1, &iocbs[3]);
> 
>   io_getevents(io_ctx, 4, 4, events, NULL)
> 
> help to find an ext4 corruption:
>            **************** **************** ****************
>            *    page 1    * *    page 2    * *    page 3    *
>            **************** **************** ****************
>   existing 0000000000000000 0000000000000000 0000000000000000
>   write 1    AAAAAAAAAAAAAA AA
>   write 2                     BBBBBBBBBBBBBB BB
> 
>   result   00AAAAAAAAAAAAAA 00BBBBBBBBBBBBBB BB00000000000000
>   desired  00AAAAAAAAAAAAAA AABBBBBBBBBBBBBB BB00000000000000
> 
> This issue remind us we might miss unaligned AIO test for long time.
> We thought fsx cover this part, but looks like it's not. So this case
> trys to cover unaligned direct AIO write test on file with different
> initial truncate i_size.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> The aio-dio-write-verify.c nearly copy from aio-dio-eof-race.c, then change
> a few logic. I've changed aio-dio-eof-race.c several times, to fit different
> new AIO test cases. But this time I need to truncate the file, then it won't
> write at EOF. This against the motive of aio-dio-eof-race.c. So I think it's
> time to shift a new program to do more AIO write test.
> 
> It's only my personal opinion :)
> 
> Thanks,
> Zorro
> 
>  src/aio-dio-regress/aio-dio-write-verify.c | 223 +++++++++++++++++++++
>  tests/generic/999                          |  71 +++++++
>  tests/generic/999.out                      |   2 +
>  tests/generic/group                        |   1 +
>  4 files changed, 297 insertions(+)
>  create mode 100644 src/aio-dio-regress/aio-dio-write-verify.c
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
> new file mode 100644
> index 00000000..402ddcdb
> --- /dev/null
> +++ b/src/aio-dio-regress/aio-dio-write-verify.c
> @@ -0,0 +1,223 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Red Hat, Inc. All Rights reserved.
> + *
> + * AIO writes from a start offset on a truncated file, verify there's not
> + * data corruption.
> + */
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <ctype.h>
> +
> +#include <libaio.h>
> +
> +unsigned long buf_size = 0;
> +unsigned long size_KB  = 0;
> +#define IO_PATTERN	0x5a
> +
> +void
> +usage(char *progname)
> +{
> +	fprintf(stderr, "usage: %s [-s datasize] [-b bufsize] [-o startoff] [-t truncsize] filename\n"
> +	        "\t-s datasize: specify the minimum data size(KB), doesn't count holes\n"
> +	        "\t-b bufsize: buffer size\n"
> +	        "\t-o startoff: start offset to write data, 0 by default\n"
> +	        "\t-t truncsize: truncate the file to a special size at first 0 by default\n",
> +	        progname);
> +	exit(1);
> +}
> +
> +void
> +dump_buffer(
> +	void	*buf,
> +	off64_t	offset,
> +	ssize_t	len)
> +{
> +	int	i, j;
> +	char	*p;
> +	int	new;
> +
> +	for (i = 0, p = (char *)buf; i < len; i += 16) {
> +		char    *s = p;
> +
> +		if (i && !memcmp(p, p - 16, 16)) {
> +			new = 0;
> +		} else {
> +			if (i)
> +				printf("*\n");
> +			new = 1;
> +		}
> +
> +		if (!new) {
> +			p += 16;
> +			continue;
> +		}
> +
> +		printf("%08llx  ", (unsigned long long)offset + i);
> +		for (j = 0; j < 16 && i + j < len; j++, p++)
> +			printf("%02x ", *p);
> +		printf(" ");
> +		for (j = 0; j < 16 && i + j < len; j++, s++) {
> +			if (isalnum((int)*s))
> +				printf("%c", *s);
> +			else
> +				printf(".");
> +		}
> +		printf("\n");
> +
> +	}
> +	printf("%08llx\n", (unsigned long long)offset + i);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct io_context *ctx = NULL;
> +	struct io_event evs[2];
> +	struct iocb iocb1, iocb2;
> +	struct iocb *iocbs[] = { &iocb1, &iocb2 };
> +	void *buf;
> +	int fd, err = 0;
> +	off_t bytes;
> +	int c;
> +	char *cmp_buf = NULL;
> +	char *filename = NULL;
> +	/* start offset to write */
> +	long long startoff = 0;
> +	/* truncate size */
> +	off_t tsize = 0;
> +
> +	while ((c = getopt(argc, argv, "s:b:o:t:")) != -1) {
> +		char *endp;
> +
> +		switch (c) {
> +		case 's':	/* XXX MB size will be extended */
> +			size_KB = strtol(optarg, &endp, 0);
> +			break;
> +		case 'b':	/* buffer size */
> +			buf_size = strtol(optarg, &endp, 0);
> +			break;
> +		case 'o':	/* start offset */
> +			startoff = strtoll(optarg, &endp, 0);
> +			break;
> +		case 't':	/* initial truncate size */
> +			tsize = strtoul(optarg, &endp, 0);
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (size_KB == 0)	/* default size is 64KB */
> +		size_KB = 64;
> +	if (buf_size < 2048)	/* default minimum buffer size is 2048 bytes */
> +		buf_size = 2048;
> +
> +	if (optind == argc - 1)
> +		filename = argv[optind];
> +	else
> +		usage(argv[0]);
> +
> +	fd = open(filename, O_DIRECT | O_CREAT | O_TRUNC | O_RDWR, 0600);
> +	if (fd == -1) {
> +		perror("open");
> +		return 1;
> +	}
> +
> +	/* truncate the file to a special size at first */
> +	if (tsize != 0) {
> +		ftruncate(fd, tsize);
> +		if (fd == -1) {

Huh?  ret = ftruncate(...); if (ret) ?

> +			perror("ftruncate");
> +			return 1;
> +		}
> +	}
> +
> +	err = posix_memalign(&buf, getpagesize(), buf_size);
> +	if (err) {
> +		fprintf(stderr, "error %s during %s\n",
> +			strerror(err),
> +			"posix_memalign");
> +		return 1;
> +	}
> +	cmp_buf = malloc(buf_size);
> +	memset(cmp_buf, IO_PATTERN, buf_size);
> +
> +	err = io_setup(5, &ctx);
> +	if (err) {
> +		fprintf(stderr, "error %s during %s\n",
> +			strerror(err),
> +			"io_setup");
> +		return 1;
> +	}
> +
> +	bytes = 0;
> +	/* Keep extending until size_KB */
> +	while (bytes < size_KB * 1024) {
> +		ssize_t sret;
> +		int i;
> +
> +		memset(buf, IO_PATTERN, buf_size);
> +
> +		io_prep_pwrite(&iocb1, fd, buf, buf_size/2, \
> +		               startoff + bytes + 0*buf_size/2);
> +		io_prep_pwrite(&iocb2, fd, buf, buf_size/2, \
> +		               startoff + bytes + 1*buf_size/2);
> +
> +		err = io_submit(ctx, 2, iocbs);
> +		if (err != 2) {
> +			fprintf(stderr, "error %s during %s\n",
> +				strerror(err),
> +				"io_submit");
> +			return 1;
> +		}
> +
> +		err = io_getevents(ctx, 2, 2, evs, NULL);
> +		if (err != 2) {
> +			fprintf(stderr, "error %s during %s\n",
> +				strerror(err),
> +				"io_getevents");
> +			return 1;
> +		}
> +
> +		for (i = 0; i < err; i++) {
> +			/*
> +			 * res is unsigned for some reason, so this is the best
> +			 * way to detect that it contains a negative errno.
> +			 */
> +			if (evs[i].res > buf_size / 2) {
> +				fprintf(stderr, "pwrite: %s\n",
> +					strerror(-evs[i].res));
> +				return 1;
> +			}
> +		}
> +		fsync(fd);

Ignoring the return value here...

--D

> +
> +		/*
> +		 * And then read it back, then compare with original content.
> +		 */
> +		sret = pread(fd, buf, buf_size, startoff + bytes);
> +		if (sret == -1) {
> +			perror("pread");
> +			return 1;
> +		} else if (sret != buf_size) {
> +			fprintf(stderr, "short read %zd was less than %zu\n",
> +				sret, buf_size);
> +			return 1;
> +		}
> +		if (memcmp(buf, cmp_buf, buf_size)) {
> +			printf("Find corruption\n");
> +			dump_buffer(buf, 0, buf_size);
> +			return 1;
> +		}
> +
> +		/* Calculate how many bytes we've written after pread */
> +		bytes += buf_size;
> +	}
> +
> +	return 0;
> +}
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 00000000..6fcc593a
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 999
> +#
> +# Non-page-aligned direct AIO write test. AIO write from unalinged offset
> +# on a file with different initial truncate i_size.
> +#
> +# Uncover "ext4: Fix data corruption caused by unaligned direct AIO"
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_aiodio aio-dio-write-verify
> +_require_test_program "feature"
> +
> +localfile=$TEST_DIR/tst-aio-dio-testfile
> +diosize=`_min_dio_alignment $TEST_DEV`
> +pagesize=`src/feature -s`
> +bufsize=$((pagesize * 2))
> +filesize=$((bufsize * 3 / 1024))
> +
> +# Need smaller logical block size to do non-page-aligned test
> +if [ $diosize -ge $pagesize ];then
> +	_notrun "Need device logical block size($diosize) < page size($pagesize)"
> +fi
> +
> +rm -rf $localfile 2>/dev/null
> +# page-aligned aiodio write verification at first
> +$AIO_TEST -s $((bufsize * 10)) -b $bufsize $localfile
> +
> +# non-page-aligned aiodio write verification
> +i=0
> +while [ $((diosize * i)) -lt $bufsize ];do
> +	truncsize=$((diosize * i++))
> +	# non-page-aligned AIO write on different i_size file
> +	$AIO_TEST -s $filesize -b $bufsize -o $diosize -t $truncsize $localfile
> +	if [ $? -ne 0 ];then
> +		echo "[FAIL] $AIO_TEST -s $filesize -b $bufsize -o $diosize -t $truncsize $localfile"
> +	fi
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 00000000..3b276ca8
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 15227b67..b1f93d99 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -534,3 +534,4 @@
>  529 auto quick attr
>  530 auto quick unlink
>  531 auto quick unlink
> +999 auto quick aio
> -- 
> 2.17.2
> 
