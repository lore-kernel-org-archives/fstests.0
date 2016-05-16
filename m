Received: from mx1.redhat.com ([209.132.183.28]:51883 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbcEPM0K (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 16 May 2016 08:26:10 -0400
Date: Mon, 16 May 2016 08:26:07 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] generic: Test handling of private file mappings
Message-ID: <20160516122607.GA30098@bfoster.bfoster>
References: <1463045427-13633-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463045427-13633-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: Jan Kara <jack@suse.cz>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, May 12, 2016 at 11:30:27AM +0200, Jan Kara wrote:
> Test handling of private file mappings in the kernel. Check that writes
> of only one thread / process are seen in each page and that none of
> these make it into the original file.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  src/holetest.c        | 121 +++++++++++++++++++++++++++++++++++++-------------
>  tests/generic/352     |  60 +++++++++++++++++++++++++
>  tests/generic/352.out |  73 ++++++++++++++++++++++++++++++
>  tests/generic/group   |   1 +
>  4 files changed, 223 insertions(+), 32 deletions(-)
>  create mode 100644 tests/generic/352
>  create mode 100644 tests/generic/352.out
> 
> diff --git a/src/holetest.c b/src/holetest.c
> index 03c03604ab18..edd85fe7b170 100644
> --- a/src/holetest.c
> +++ b/src/holetest.c
> @@ -70,6 +70,7 @@ long page_offs[THREADS];
>  int use_wr[THREADS];
>  int prefault = 0;
>  int use_fork = 0;
> +int use_private = 0;
>  
>  uint64_t get_id(void)
>  {
> @@ -90,24 +91,52 @@ void prefault_mapping(char *addr, long npages)
>  	}
>  }
>  
> +int verify_mapping(char *vastart, long npages, uint64_t *expect)
> +{
> +	int errcnt = 0;
> +	int i;
> +	char *va;
> +
> +	for (va = vastart; npages > 0; va += page_size, npages--) {
> +		for (i = 0; i < THREADS; i++) {
> +			if (*(uint64_t*)(va + page_offs[i]) != expect[i]) {
> +				printf("ERROR: thread %d, "
> +				       "offset %08lx, %08lx != %08lx\n", i,
> +				       (va + page_offs[i] - vastart),
> +				       *(uint64_t*)(va + page_offs[i]),
> +				       expect[i]);
> +				errcnt++;
> +			}
> +		}
> +	}
> +	return errcnt;
> +}
> +
>  void *pt_page_marker(void *args)
>  {
>  	void **a = args;
>  	char *va = (char *)a[1];
>  	long npages = (long)a[2];
> -	long pgoff = (long)a[3];
> +	long i;
> +	long pgoff = page_offs[(long)a[3]];
>  	uint64_t tid = get_id();
> +	long errors = 0;
>  
>  	if (prefault && use_fork)
>  		prefault_mapping(va, npages);
>  
> -	va += pgoff;
> -
>  	/* mark pages */
> -	for (; npages > 0; va += page_size, npages--)
> -		*(uint64_t *)(va) = tid;
> +	for (i = 0; i < npages; i++)
> +		*(uint64_t *)(va + pgoff + i * page_size) = tid;
>  
> -	return NULL;
> +	if (use_private && use_fork) {
> +		uint64_t expect[THREADS] = {};
> +
> +		expect[(long)a[3]] = tid;
> +		errors = verify_mapping(va, npages, expect);
> +	}
> +
> +	return (void *)errors;
>  }  /* pt_page_marker() */
>  
>  void *pt_write_marker(void *args)
> @@ -115,7 +144,7 @@ void *pt_write_marker(void *args)
>  	void **a = args;
>  	int fd = (long)a[0];
>  	long npages = (long)a[2];
> -	long pgoff = (long)a[3];
> +	long pgoff = page_offs[(long)a[3]];
>  	uint64_t tid = get_id();
>  	long i;
>  
> @@ -130,18 +159,18 @@ int test_this(int fd, loff_t sz)
>  {
>  	long npages;
>  	char *vastart;
> -	char *va;
>  	void *targs[THREADS][4];
>  	pthread_t t[THREADS];
>  	uint64_t tid[THREADS];
> -	int errcnt;
> +	int errcnt = 0;
>  	int i;
>  
>  	npages = sz / page_size;
>  	printf("INFO: sz = %llu\n", (unsigned long long)sz);
>  
>  	/* mmap it */
> -	vastart = mmap(NULL, sz, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	vastart = mmap(NULL, sz, PROT_READ | PROT_WRITE,
> +		       use_private ? MAP_PRIVATE : MAP_SHARED, fd, 0);
>  	if (MAP_FAILED == vastart) {
>  		perror("mmap()");
>  		exit(20);
> @@ -155,7 +184,7 @@ int test_this(int fd, loff_t sz)
>  		targs[i][0] = (void *)(long)fd;
>  		targs[i][1] = vastart;
>  		targs[i][2] = (void *)npages;
> -		targs[i][3] = (void *)page_offs[i];
> +		targs[i][3] = (void *)(long)i;
>  	}
>  
>  	for (i = 0; i < THREADS; i++) {
> @@ -186,40 +215,58 @@ int test_this(int fd, loff_t sz)
>  			}
>  			/* Child? */
>  			if (!tid[i]) {
> +				void *ret;
> +
>  				if (use_wr[i])
> -					pt_write_marker(&targs[i]);
> +					ret = pt_write_marker(&targs[i]);
>  				else
> -					pt_page_marker(&targs[i]);
> -				exit(0);
> +					ret = pt_page_marker(&targs[i]);
> +				exit(ret ? 1 : 0);
>  			}
>  			printf("INFO: process %d created\n", i);
>  		}
>  	}
>  
>  	/* wait for them to finish */
> -	for (i = 0; i < THREADS; i++)
> -		if (!use_fork)
> -			pthread_join(t[i], NULL);
> -		else
> -			waitpid(tid[i], NULL, 0);
> +	for (i = 0; i < THREADS; i++) {
> +		if (!use_fork) {
> +			void *status;
> +
> +			pthread_join(t[i], &status);
> +			if (status)
> +				errcnt++;
> +		} else {
> +			int status;
> +
> +			waitpid(tid[i], &status, 0);
> +			if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
> +				errcnt++;
> +		}
> +	}
>  
>  	/* check markers on each page */
> -	errcnt = 0;
> -	for (va = vastart; npages > 0; va += page_size, npages--) {
> -		for (i = 0; i < THREADS; i++) {
> -			if (*(uint64_t*)(va + page_offs[i]) != tid[i]) {
> -				printf("ERROR: thread %d, "
> -				       "offset %08lx, %08lx != %08lx\n", i,
> -				       (va + page_offs[i] - vastart),
> -				       *(uint64_t*)(va + page_offs[i]), tid[i]);
> -				errcnt += 1;
> -			}
> +	/* For private mappings & fork we should see no writes happen */
> +	if (use_private && use_fork)
> +		for (i = 0; i < THREADS; i++)
> +			tid[i] = 0;
> +	errcnt = verify_mapping(vastart, npages, tid);
> +	munmap(vastart, sz);
> +
> +	if (use_private) {
> +		/* Check that no writes propagated into original file */
> +		for (i = 0; i < THREADS; i++)
> +			tid[i] = 0;
> +		vastart = mmap(NULL, sz, PROT_READ, MAP_PRIVATE, fd, 0);
> +		if (vastart == MAP_FAILED) {
> +			perror("mmap()");
> +			exit(20);
>  		}
> +		errcnt += verify_mapping(vastart, npages, tid);
> +		munmap(vastart, sz);
>  	}
>  
>  	printf("INFO: %d error(s) detected\n", errcnt);
>  
> -	munmap(vastart, sz);
>  
>  	return errcnt;
>  }
> @@ -242,7 +289,7 @@ int main(int argc, char **argv)
>  	for (i = 1; i < THREADS; i++)
>  		page_offs[i] = page_offs[i-1] + step;
>  
> -	while ((opt = getopt(argc, argv, "fwrF")) > 0) {
> +	while ((opt = getopt(argc, argv, "fwrFp")) > 0) {
>  		switch (opt) {
>  		case 'f':
>  			/* ignore errors */
> @@ -260,6 +307,10 @@ int main(int argc, char **argv)
>  			/* create processes instead of threads */
>  			use_fork = 1;
>  			break;
> +		case 'p':
> +			/* Use private mappings for testing */
> +			use_private = 1;
> +			break;
>  		default:
>  			fprintf(stderr, "ERROR: Unknown option character.\n");
>  			exit(1);
> @@ -267,10 +318,16 @@ int main(int argc, char **argv)
>  	}
>  
>  	if (optind != argc - 2) {
> -		fprintf(stderr, "ERROR: usage: holetest [-fwrF] "
> +		fprintf(stderr, "ERROR: usage: holetest [-fwrFp] "
>  			"FILENAME FILESIZEinMB\n");
>  		exit(1);
>  	}
> +	if (use_private && use_wr[0]) {
> +		fprintf(stderr, "ERROR: Combinations of writes and private"
> +			"mappings not supported.\n");
> +		exit(1);
> +	}
> +
>  	path = argv[optind];
>  	sz = strtol(argv[optind + 1], &endch, 10);
>  	if (*endch || sz < 1) {
> diff --git a/tests/generic/352 b/tests/generic/352
> new file mode 100644
> index 000000000000..fb4be9848f4c
> --- /dev/null
> +++ b/tests/generic/352
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# FSQA Test No. 352
> +#
> +# Test races between private file mapping faults from racing processes or
> +# threads
> +#
> +#-----------------------------------------------------------------------
> +#
> +# Copyright (C) 2016 SUSE Linux Products GmbH. All Rights Reserved.
> +# Author: Jan Kara <jack@suse.cz>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
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
> +# get standard environment and checks
> +. ./common/rc
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_test_program "holetest"
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +src/holetest -f -p $SCRATCH_MNT/testfile 16
> +src/holetest -f -p $SCRATCH_MNT/testfile 256
> +src/holetest -f -p -F $SCRATCH_MNT/testfile 16
> +src/holetest -f -p -F $SCRATCH_MNT/testfile 256
> +
> +status=0
> +exit
> diff --git a/tests/generic/352.out b/tests/generic/352.out
> new file mode 100644
> index 000000000000..35324cc32725
> --- /dev/null
> +++ b/tests/generic/352.out
> @@ -0,0 +1,73 @@
> +QA output created by 352
> +
> +INFO: zero-filled test...
> +INFO: sz = 16777216
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: posix_fallocate test...
> +INFO: sz = 16777216
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: ftruncate test...
> +INFO: sz = 16777216
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: zero-filled test...
> +INFO: sz = 268435456
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: posix_fallocate test...
> +INFO: sz = 268435456
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: ftruncate test...
> +INFO: sz = 268435456
> +INFO: thread 0 created
> +INFO: thread 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: zero-filled test...
> +INFO: sz = 16777216
> +INFO: process 0 created
> +INFO: process 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: posix_fallocate test...
> +INFO: sz = 16777216
> +INFO: process 0 created
> +INFO: process 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: ftruncate test...
> +INFO: sz = 16777216
> +INFO: process 0 created
> +INFO: process 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: zero-filled test...
> +INFO: sz = 268435456
> +INFO: process 0 created
> +INFO: process 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: posix_fallocate test...
> +INFO: sz = 268435456
> +INFO: process 0 created
> +INFO: process 1 created
> +INFO: 0 error(s) detected
> +
> +INFO: ftruncate test...
> +INFO: sz = 268435456
> +INFO: process 0 created
> +INFO: process 1 created
> +INFO: 0 error(s) detected
> diff --git a/tests/generic/group b/tests/generic/group
> index 36fb75933a13..effe6aac2d47 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -354,3 +354,4 @@
>  349 blockdev quick rw
>  350 blockdev quick rw
>  351 blockdev quick rw
> +352 auto
> -- 
> 2.6.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
