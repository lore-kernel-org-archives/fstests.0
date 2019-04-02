Received: from mx1.redhat.com ([209.132.183.28]:60678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbfDBOmp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 2 Apr 2019 10:42:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7CCE33005218
        for <fstests@vger.kernel.org>; Tue,  2 Apr 2019 14:42:44 +0000 (UTC)
Date: Tue, 2 Apr 2019 16:42:36 +0200
From: Lukas Czerner <lczerner@redhat.com>
Subject: Re: [PATCH v2] generic: unaligned direct AIO write test
Message-ID: <20190402144236.fijiroahfompizhs@work>
References: <20190319134951.6109-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319134951.6109-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, fsorenso@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 19, 2019 at 09:49:51PM +0800, Zorro Lang wrote:
> A simply reproducer from Frank Sorenson:
> 
>   ftruncate(fd, 65012224)
>   io_prep_pwrite(iocbs[0], fd, buf[0], 1048576, 63963648);
>   io_prep_pwrite(iocbs[1], fd, buf[1], 1048576, 65012224);
> 
>   io_submit(io_ctx, 1, &iocbs[0]);
>   io_submit(io_ctx, 1, &iocbs[1]);
> 
>   io_getevents(io_ctx, 2, 2, events, NULL)
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

I think it looks good and I do like how you've done the new
aio-dio-write-verify tool.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks!
-Lukas

> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> V2 re-write the .c program totally and changed the generic/999.
> 
> Thanks,
> Zorro
> 
>  .gitignore                                 |   1 +
>  src/aio-dio-regress/aio-dio-write-verify.c | 338 +++++++++++++++++++++
>  tests/generic/999                          |  96 ++++++
>  tests/generic/999.out                      |   2 +
>  tests/generic/group                        |   1 +
>  5 files changed, 438 insertions(+)
>  create mode 100644 src/aio-dio-regress/aio-dio-write-verify.c
>  create mode 100755 tests/generic/999
>  create mode 100644 tests/generic/999.out
> 
> diff --git a/.gitignore b/.gitignore
> index 6454e4d6..c13fb713 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -162,6 +162,7 @@
>  /src/aio-dio-regress/aio-dio-invalidate-failure
>  /src/aio-dio-regress/aio-dio-invalidate-readahead
>  /src/aio-dio-regress/aio-dio-subblock-eof-read
> +/src/aio-dio-regress/aio-dio-write-verify
>  /src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages
>  /src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer
>  /src/aio-dio-regress/aio-last-ref-held-by-io
> diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
> new file mode 100644
> index 00000000..823410d0
> --- /dev/null
> +++ b/src/aio-dio-regress/aio-dio-write-verify.c
> @@ -0,0 +1,338 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2019 Red Hat, Inc. All Rights reserved.
> + *
> + * This program is used to do AIO write test. Each <-a size=N,off=M> field
> + * specifies an AIO write. More this kind of fields will be combined to a
> + * group of AIO write, then io_submit them together. All AIO write field can
> + * overlap or be sparse.
> + *
> + * After all AIO write operations done, each [size, off] content will be read
> + * back, verify if there's corruption.
> + *
> + * Before doing a series of AIO write, an optional ftruncate operation can be
> + * chosen. To truncate the file i_size to a specified location for testing.
> + *
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
> +#define MAX_EVENT_NUM	128
> +#define IO_PATTERN	0x5a
> +
> +void
> +usage(char *progname)
> +{
> +	fprintf(stderr, "usage: %s [-t truncsize ] <-a size=N,off=M [-a ...]>  filename\n"
> +	        "\t-t truncsize: truncate the file to a special size before AIO wirte\n"
> +	        "\t-a: specify once AIO write size and startoff, this option can be specified many times, but less than 128\n"
> +	        "\t\tsize=N: AIO write size\n"
> +	        "\t\toff=M:  AIO write startoff\n"
> +	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n",
> +	        progname, progname);
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
> +/* Parameters for once AIO write&verify testing */
> +struct io_params {
> +	void          *buf;
> +	void          *cmp_buf;
> +	unsigned long buf_size;	/* the size of AIO write */
> +	unsigned long offset;	/* AIO write offset*/
> +};
> +
> +struct io_params_node {
> +	struct iocb iocb;
> +	struct io_params *param;
> +	struct io_params_node *next;
> +};
> +
> +struct io_params_node *iop_head = NULL;
> +
> +/* Suboptions of '-a' option */
> +enum {
> +	BFS_OPT = 0,
> +	OFS_OPT
> +};
> +
> +char *const token[] = {
> +	[BFS_OPT]	= "size",	/* buffer size of once AIO write */
> +	[OFS_OPT]	= "off",	/* start offset */
> +	NULL
> +};
> +
> +/* Combine each AIO write operation things to a linked list */
> +static int add_io_param(unsigned long bs, \
> +                        unsigned long off)
> +{
> +	struct io_params_node *io = NULL;
> +	struct io_params_node **p = &iop_head;
> +
> +	io = malloc(sizeof(struct io_params_node));
> +	if (!io)
> +		goto err_out;
> +
> +	io->param = malloc(sizeof(struct io_params));
> +	if (!io->param)
> +		goto err_out;
> +
> +	io->param->buf_size = bs;
> +	io->param->offset = off;
> +
> +	io->next = NULL;
> +
> +	if (bs > 0) {
> +		if (posix_memalign(&io->param->buf, getpagesize(), bs))
> +			goto err_out;
> +		io->param->cmp_buf = malloc(bs);
> +		if (io->param->cmp_buf == NULL)
> +			goto err_out;
> +		memset(io->param->buf, IO_PATTERN, bs);
> +		memset(io->param->cmp_buf, IO_PATTERN, bs);
> +	} else {
> +		return 1;
> +	}
> +
> +	/* find the tail */
> +	while(*p != NULL) {
> +		p = &((*p)->next);
> +	}
> +	*p = io;
> +
> +	return 0;
> +
> + err_out:
> +	perror("alloc memory");
> +	return 1;
> +}
> +
> +static int parse_subopts(char *arg)
> +{
> +	char *p = arg;
> +	char *value;
> +	unsigned long bsize = 0;
> +	unsigned long off = 0;
> +
> +	while (*p != '\0') {
> +		char *endp;
> +
> +		switch(getsubopt(&p, token, &value)) {
> +		case BFS_OPT:
> +			bsize = strtoul(value, &endp, 0);
> +			break;
> +		case OFS_OPT:
> +			off = strtoul(value, &endp, 0);
> +			break;
> +		default:
> +			fprintf(stderr, "No match found for subopt %s\n", \
> +			        value);
> +			return 1;
> +		}
> +	}
> +
> +	return add_io_param(bsize, off);
> +}
> +
> +static int io_write(int fd, int num_events)
> +{
> +	int err;
> +	struct io_params_node *p = iop_head;
> +	struct iocb **iocbs;
> +	struct io_event *evs;
> +	struct io_context *ctx = NULL;
> +	int i;
> +
> +	err = io_setup(num_events, &ctx);
> +	if (err) {
> +		perror("io_setup");
> +		return 1;
> +	}
> +
> +	iocbs = (struct iocb **)malloc(num_events * sizeof(struct iocb *));
> +	if (iocbs == NULL) {
> +		perror("malloc");
> +		return 1;
> +	}
> +
> +	evs = malloc(num_events * sizeof(struct io_event));
> +	if (evs == NULL) {
> +		perror("malloc");
> +		return 1;
> +	}
> +
> +	i = 0;
> +	while (p != NULL) {
> +		iocbs[i] = &(p->iocb);
> +		io_prep_pwrite(&p->iocb, fd, p->param->buf, \
> +		               p->param->buf_size, p->param->offset);
> +		p = p->next;
> +		i++;
> +	}
> +
> +	err = io_submit(ctx, num_events, iocbs);
> +	if (err != num_events) {
> +		fprintf(stderr, "error %s during %s\n",
> +		        strerror(err),
> +		        "io_submit");
> +		return 1;
> +	}
> +
> +	err = io_getevents(ctx, num_events, num_events, evs, NULL);
> +	if (err != num_events) {
> +		fprintf(stderr, "error %s during %s\n",
> +		        strerror(err),
> +		        "io_getevents");
> +		return 1;
> +	}
> +
> +	/* Try to destroy at here, not necessary, so don't check result */
> +	io_destroy(ctx);
> +
> +	return 0;
> +}
> +
> +static int io_verify(int fd)
> +{
> +	struct io_params_node *p = iop_head;
> +	ssize_t sret;
> +	int corrupted = 0;
> +
> +	while(p != NULL) {
> +		sret = pread(fd, p->param->buf, \
> +		             p->param->buf_size, p->param->offset);
> +		if (sret == -1) {
> +			perror("pread");
> +			return 1;
> +		} else if (sret != p->param->buf_size) {
> +			fprintf(stderr, "short read %zd was less than %zu\n",
> +			        sret, p->param->buf_size);
> +			return 1;
> +		}
> +		if (memcmp(p->param->buf, \
> +		           p->param->cmp_buf, p->param->buf_size)) {
> +			printf("Find corruption\n");
> +			dump_buffer(p->param->buf, p->param->offset, \
> +			            p->param->buf_size);
> +			corrupted++;
> +		}
> +		p = p->next;
> +	}
> +
> +	return corrupted;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int fd;
> +	int c;
> +	char *filename = NULL;
> +	int num_events = 0;
> +	off_t tsize = 0;
> +
> +	while ((c = getopt(argc, argv, "a:t:")) != -1) {
> +		char *endp;
> +
> +		switch (c) {
> +		case 'a':
> +			if (parse_subopts(optarg) == 0) {
> +				num_events++;
> +			} else {
> +				fprintf(stderr, "Bad subopt %s\n", optarg);
> +				usage(argv[0]);
> +			}
> +			break;
> +		case 't':
> +			tsize = strtoul(optarg, &endp, 0);
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +
> +	if (num_events > MAX_EVENT_NUM) {
> +		fprintf(stderr, "Too many AIO events, %d > %d\n", \
> +		        num_events, MAX_EVENT_NUM);
> +		usage(argv[0]);
> +	}
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
> +	if (tsize > 0) {
> +		if (ftruncate(fd, tsize)) {
> +			perror("ftruncate");
> +			return 1;
> +		}
> +	}
> +
> +	if (io_write(fd, num_events) != 0) {
> +		fprintf(stderr, "AIO write fails\n");
> +		return 1;
> +	}
> +
> +	if (io_verify(fd) != 0) {
> +		fprintf(stderr, "Data verification fails\n");
> +		return 1;
> +	}
> +
> +	close(fd);
> +	return 0;
> +}
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 00000000..96924f28
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,96 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. 999
> +#
> +# Non-page-aligned direct AIO write test with an initial truncate i_size.
> +#
> +# Uncover "ext4: Fix data corruption caused by unaligned direct AIO":
> +# (Ext4 needs to serialize unaligned direct AIO because the zeroing of
> +# partial blocks of two competing unaligned AIOs can result in data
> +# corruption.
> +#
> +# However it decides not to serialize if the potentially unaligned aio is
> +# past i_size with the rationale that no pending writes are possible past
> +# i_size. Unfortunately if the i_size is not block aligned and the second
> +# unaligned write lands past i_size, but still into the same block, it has
> +# the potential of corrupting the previous unaligned write to the same
> +# block.)
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
> +truncsize=$((bufsize+diosize))
> +
> +# Need smaller logical block size to do non-page-aligned test
> +if [ $diosize -ge $pagesize ];then
> +	_notrun "Need device logical block size($diosize) < page size($pagesize)"
> +fi
> +
> +rm -rf $localfile 2>/dev/null
> +# page-aligned aiodio write verification at first
> +$AIO_TEST -a size=$bufsize,off=0 -a size=$bufsize,off=$bufsize $localfile
> +
> +# non-page-aligned aiodio write verification
> +#          **************** **************** ****************
> +#          *    page 1&2  * *   page 3&4   * *   page 5&6   *
> +#          **************** **************** ****************
> +# existing 0000000000000000 0000000000000000 0000000000000000
> +# truncate ---------------->|
> +# write 1   ZZZZZZZZZZZZZZZ Z
> +# write 2  |<----            ZZZZZZZZZZZZZZZ Z ---->|
> +#
> +# "Write 1" writes 2 pagesize data at off=$diosize.
> +# "Write 2" seeks from 0 to "Write 1" end + page size, shift $diosize bytes each
> +# time, writes 2 pagesize data too.
> +# Verify there's not corruption each time.
> +i=0
> +while [ $((diosize * i)) -lt $((diosize + bufsize + pagesize)) ];do
> +	position=$((diosize * i++))
> +	# non-page-aligned AIO write on different i_size file
> +	$AIO_TEST -t $truncsize -a size=$bufsize,off=$diosize \
> +		  -a size=$bufsize,off=$position \
> +		  $localfile
> +	if [ $? -ne 0 ];then
> +		echo "FAIL: [$truncsize, $bufsize, $diosize, $position]"
> +		echo "-------------------------------------------------"
> +	fi
> +	rm -f $localfile
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
