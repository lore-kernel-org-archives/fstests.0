Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020157316
	for <fstests@vger.kernel.org>; Fri,  9 Feb 2024 05:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707456402; cv=none; b=eswCpADNkyPqatUySAug+C93RJrWSjl+7eCk1dY4fK+JufUtm4JpRQ/RLx/8B4h2PCj4sanJ88afFn+kWQgDfuv0Lp3MfddJWjWoPlHSN+052fPJseQ5oAy5SiDjZ9vUmxFW54LGe+75sCZ4ZT+QBm/9lx/EZCnq/1OdrgNI88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707456402; c=relaxed/simple;
	bh=NIxxNckcwnBcJ0gxR0Eo1Efye/vIzvTp2RwDo2/wb8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/BVWC3UFCxUicT+IMFy5sS2Z+MHWmxVpMRfTjkio8sdZTtL632itnSglcR6rbJsw0WpeuX46Zh7zPfZaAUuzS1AK0u8Fq3M0xrU7xIK5Qt32Z5oOBqcSAexzjq5RpGWRiQDIn0E7KAbnMBWTvDrRO7OJ8hvjAgSCSjdjYL6JRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SjIYJnYZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjIYJnYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707456399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9sZmsEH9nDLpQQFRF72pno9wjk/CvQL3KOnQrVwpe5g=;
	b=SjIYJnYZNJ/a8tBi8VDIGDyBYlzebjj3EEYDEW6OG1FZiwTaWKPUNESNJqksqd4R/wXd35
	k3XwuZqtIRQhvN1AQUNfkoVu6jSEk1zfkPakEv/H+FmBM6chWXWGdL997NvsUe3w0v3mft
	ocIxSg1e9s6e1cvmbkZj6pD2tOuQibs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-d9KRtLKcMhChCaAOdhf22w-1; Fri, 09 Feb 2024 00:26:37 -0500
X-MC-Unique: d9KRtLKcMhChCaAOdhf22w-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d8c924c8bbso644637a12.3
        for <fstests@vger.kernel.org>; Thu, 08 Feb 2024 21:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707456396; x=1708061196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sZmsEH9nDLpQQFRF72pno9wjk/CvQL3KOnQrVwpe5g=;
        b=ERTegHtNKF+K4YyLF+WVHhx9wE1UUO+v9VRwd8a70rklkPtZTKDLDAbzR7LhIN2mof
         RH0IbtwgKt9Bar7BU8AUR9XWkTfnfTwYBBxRwAvHLK8ftv9T1cgPNte0rn0aCpueAM3i
         urMki4dFfBd82IEro8QJQ3g1Zrk2mw7KHh60pJQVBvg3WNm1sszFJggkft1GlNqC320U
         T3Qj+zXl3MKaw9OHA00WCXVWudi9fhDO6in57vBb09kTSyo/r7hmgJc5FF1J2UBhABym
         jfGRy48ktIoIGgmUjIhPgDBL/Nwp4SBf+6RWtCXpEESfDKjbSKDf6jIdNdeYzoCApw7Q
         nSDg==
X-Gm-Message-State: AOJu0YyI7SjgrSIYiuRDOPKCMItSGHnwj6zV3iWAqf3sdl/yzkNTm9Vj
	hWAstuX/5wxEUS3ol2Noc11bVZ5Yg+YcSyoTNoJ0Zdmno4I1N6Q6wYNMO6nKP10uT6ag0K1VxGB
	OndnuNJ2CfcZVNnl4btR8HhpgVHNeNUuaNu6eFGJEDL/TC8WbYKjbXao2n934Df4=
X-Received: by 2002:a05:6a21:2d06:b0:19e:39d4:284c with SMTP id tw6-20020a056a212d0600b0019e39d4284cmr852890pzb.29.1707456396314;
        Thu, 08 Feb 2024 21:26:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXBoNmxlbfze/fTiODXnCpjixOiH7l8HMLMjbJ9o3gsgtrJcA1upDbs3fuEfcgTRFIFL8Euw==
X-Received: by 2002:a05:6a21:2d06:b0:19e:39d4:284c with SMTP id tw6-20020a056a212d0600b0019e39d4284cmr852882pzb.29.1707456395949;
        Thu, 08 Feb 2024 21:26:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUP8WytfG0iSiMJE1rFaS6ZEIJrjrdSx38gJ9DRoYa6epYXNIgOi7RVthqsOklEc9Rq3wcJMWD1HHlRYmc/8TKEn1AR6iqzt7vM2pafWkHbXdyU2rmzfhlnxSdr3IllZoDaEIpkT9ptqqemiXljHmOcPpF4cw==
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902758500b001d8f2438298sm653223pll.269.2024.02.08.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:26:35 -0800 (PST)
Date: Fri, 9 Feb 2024 13:26:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: fstests@vger.kernel.org, gfs2@lists.linux.dev, jlayton@kernel.org,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
Message-ID: <20240209052631.wfbjveicfosubwns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230925201827.1703857-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925201827.1703857-1-aahringo@redhat.com>

On Mon, Sep 25, 2023 at 04:18:27PM -0400, Alexander Aring wrote:
> This patch adds fcntl corner cases that was being used to confirm issues
> on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> implementation and in those corner cases issues was being found and
> fixed.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---

Hi Alexander,

This test case directly hang on CIFS testing. Actually it's not a
real hang, the fcntl_lock_corner_tests process can be killed, but
before killing it manually, it was blocked there.

Please check if it's a case issue or cifs bug, or it's not suitable
for cifs? I'll try to delay this patch merging to next release,
leave some time to have a discission. CC cifs list to get more
reviewing.

Thanks,
Zorro

FSTYP         -- cifs
PLATFORM      -- Linux/ppc64le ibm-xxx-xxx-xxxx 6.8.0-rc3+ #1 SMP Wed Feb  7 01:38:35 EST 2024
MKFS_OPTIONS  -- //xxx-xxx-xx-xxxx.xxxx.xxx.com/SCRATCH_dev
MOUNT_OPTIONS -- -o vers=3.11,mfsymlinks,username=root,password=redhat -o context=system_u:object_r:root_t:s0 //xxx-xxx-xx-xxxx.xxxx.xxx.com/SCRATCH_dev /mnt/xfstests/scratch/cifs-client

generic/740
...
...

# ps axu|grep fcntl
root     1138909  0.0  0.0   5056     0 ?        S    Feb07   0:00 /var/lib/xfstests/src/fcntl_lock_corner_tests /mnt/xfstests/test/cifs-client/testfile
root     1138910  0.0  0.0  21760     0 ?        Sl   Feb07   0:00 /var/lib/xfstests/src/fcntl_lock_corner_tests /mnt/xfstests/test/cifs-client/testfile
# cat /proc/1138909/stack 
[<0>] 0xc00000008d068a00
[<0>] __switch_to+0x13c/0x228
[<0>] do_wait+0x15c/0x224
[<0>] kernel_wait4+0xb8/0x2c8
[<0>] system_call_exception+0x134/0x390
[<0>] system_call_vectored_common+0x15c/0x2ec
# cat /proc/1138910/stack 
[<0>] 0xc00000008de94400
[<0>] __switch_to+0x13c/0x228
[<0>] futex_wait_queue+0xa8/0x134
[<0>] __futex_wait+0xb4/0x15c
[<0>] futex_wait+0x94/0x150
[<0>] do_futex+0xe8/0x374
[<0>] sys_futex+0xa4/0x234
[<0>] system_call_exception+0x134/0x390
[<0>] system_call_vectored_common+0x15c/0x2ec

# strace -p 1138909
strace: Process 1138909 attached
wait4(-1, 
(nothing more output)
strace: Process 1138909 detached
^C <detached ...>
# strace -p 1138910
strace: Process 1138910 attached
futex(0x7fff97a8f110, FUTEX_WAIT_BITSET|FUTEX_CLOCK_REALTIME, 1138912, NULL, FUTEX_BITSET_MATCH_ANY
(nothing more output)
^Cstrace: Process 1138910 detached
 <detached ...>


> changes since v2:
> - move fcntl tests into one fcntl c file
> - remove ofd and same owner tests, should be reflected by only one test
> - simplify commit message (remove testname out of it)
> - add error messages in fcntl.c to give more information if an error
>   occur
> 
>  src/Makefile          |   3 +-
>  src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/732     |  32 +++++
>  tests/generic/732.out |   2 +
>  4 files changed, 358 insertions(+), 1 deletion(-)
>  create mode 100644 src/fcntl.c
>  create mode 100755 tests/generic/732
>  create mode 100644 tests/generic/732.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index 2815f919..67f936d3 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> -	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
> +	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> +	fcntl
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/fcntl.c b/src/fcntl.c
> new file mode 100644
> index 00000000..8e375357
> --- /dev/null
> +++ b/src/fcntl.c
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
> + */
> +
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <limits.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <wait.h>
> +
> +static char filename[PATH_MAX + 1];
> +static int fd;
> +
> +static void usage(char *name, const char *msg)
> +{
> +	printf("Fatal: %s\nUsage:\n"
> +	       "%s <file for fcntl>\n", msg, name);
> +	_exit(1);
> +}
> +
> +static void *do_equal_file_lock_thread(void *arg)
> +{
> +       struct flock fl = {
> +	       .l_type = F_WRLCK,
> +	       .l_whence = SEEK_SET,
> +	       .l_start = 0L,
> +	       .l_len = 1L,
> +       };
> +       int rv;
> +
> +       rv = fcntl(fd, F_SETLKW, &fl);
> +       if (rv == -1) {
> +	       perror("fcntl");
> +	       _exit(1);
> +       }
> +
> +       return NULL;
> +}
> +
> +static void do_test_equal_file_lock(void)
> +{
> +	struct flock fl;
> +	pthread_t t[2];
> +	int pid, rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0L;
> +	fl.l_len = 1L;
> +
> +	/* acquire range 0-0 */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +	       perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		rv = pthread_create(&t[0], NULL, do_equal_file_lock_thread, NULL);
> +		if (rv != 0) {
> +			fprintf(stderr, "failed to create pthread\n");
> +			_exit(1);
> +		}
> +
> +		rv = pthread_create(&t[1], NULL, do_equal_file_lock_thread, NULL);
> +		if (rv != 0) {
> +			fprintf(stderr, "failed to create pthread\n");
> +			_exit(1);
> +		}
> +
> +		pthread_join(t[0], NULL);
> +		pthread_join(t[1], NULL);
> +
> +		_exit(0);
> +	}
> +
> +	/* wait until threads block on 0-0 */
> +	sleep(3);
> +
> +	fl.l_type = F_UNLCK;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	sleep(3);
> +
> +	/* check if the ->lock() implementation got the
> +	 * right locks granted because two waiter with the
> +	 * same file_lock fields are waiting
> +	 */
> +	fl.l_type = F_WRLCK;
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1 && errno == EAGAIN) {
> +		fprintf(stderr, "deadlock, pthread not cleaned up correctly\n");
> +		_exit(1);
> +	}
> +
> +	wait(NULL);
> +}
> +
> +static void catch_alarm(int num) { }
> +
> +static void do_test_signal_interrupt_child(int *pfd)
> +{
> +	struct sigaction act;
> +	unsigned char m;
> +	struct flock fl;
> +	int rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 1;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	memset(&act, 0, sizeof(act));
> +	act.sa_handler = catch_alarm;
> +	sigemptyset(&act.sa_mask);
> +	sigaddset(&act.sa_mask, SIGALRM);
> +	sigaction(SIGALRM, &act, NULL);
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	/* interrupt SETLKW by signal in 3 secs */
> +	alarm(3);
> +	rv = fcntl(fd, F_SETLKW, &fl);
> +	if (rv == 0) {
> +		fprintf(stderr, "fcntl interrupt successful but should fail with EINTR\n");
> +		_exit(1);
> +	}
> +
> +	/* synchronize to move parent to test region 1-1 */
> +	write(pfd[1], &m, sizeof(m));
> +
> +	/* keep child alive */
> +	read(pfd[1], &m, sizeof(m));
> +}
> +
> +static void do_test_signal_interrupt(void)
> +{
> +	struct flock fl;
> +	unsigned char m;
> +	int pid, rv;
> +	int pfd[2];
> +
> +	rv = pipe(pfd);
> +	if (rv == -1) {
> +		perror("pipe");
> +		_exit(1);
> +	}
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	pid = fork();
> +	if (pid == 0) {
> +		do_test_signal_interrupt_child(pfd);
> +		_exit(0);
> +	}
> +
> +	/* wait until child writes */
> +	read(pfd[0], &m, sizeof(m));
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 1;
> +	fl.l_len = 1;
> +	/* parent testing childs region, the child will think
> +	 * it has region 1-1 locked because it was interrupted
> +	 * by region 0-0. Due bugs the interruption also unlocked
> +	 * region 1-1.
> +	 */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == 0) {
> +		fprintf(stderr, "fcntl trylock successful but should fail because child still acquires region\n");
> +		_exit(1);
> +	}
> +
> +	write(pfd[0], &m, sizeof(m));
> +
> +	wait(NULL);
> +
> +	close(pfd[0]);
> +	close(pfd[1]);
> +
> +	/* cleanup everything */
> +	fl.l_type = F_UNLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 2;
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +}
> +
> +static void do_test_kill_child(void)
> +{
> +	struct flock fl;
> +	int rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLKW, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +}
> +
> +static void do_test_kill(void)
> +{
> +	struct flock fl;
> +	int pid_to_kill;
> +	int rv;
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	pid_to_kill = fork();
> +	if (pid_to_kill == 0) {
> +		do_test_kill_child();
> +		_exit(0);
> +	}
> +
> +	/* wait until child blocks */
> +	sleep(3);
> +
> +	kill(pid_to_kill, SIGKILL);
> +
> +	/* wait until Linux did plock cleanup */
> +	sleep(3);
> +
> +	fl.l_type = F_UNLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	/* cleanup parent lock */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if (rv == -1) {
> +		perror("fcntl");
> +		_exit(1);
> +	}
> +
> +	fl.l_type = F_WRLCK;
> +	fl.l_whence = SEEK_SET;
> +	fl.l_start = 0;
> +	fl.l_len = 1;
> +
> +	/* check if the child still holds the lock
> +	 * and killing the child was not cleaning
> +	 * up locks.
> +	 */
> +	rv = fcntl(fd, F_SETLK, &fl);
> +	if ((rv == -1 && errno == EAGAIN)) {
> +		fprintf(stderr, "fcntl trylock failed but should be successful because killing child should cleanup acquired lock\n");
> +		_exit(1);
> +	}
> +}
> +
> +int main(int argc, char * const argv[])
> +{
> +	if (optind != argc - 1)
> +		usage(argv[0], "<file for fcntl> is mandatory to tell the file where to run fcntl() on it");
> +
> +	strncpy(filename, argv[1], PATH_MAX);
> +
> +	fd = open(filename, O_RDWR | O_CREAT, 0700);
> +	if (fd == -1) {
> +		perror("open");
> +		_exit(1);
> +	}
> +
> +	/* test to have to equal struct file_lock requests in ->lock() */
> +	do_test_equal_file_lock();
> +	/* test to interrupt F_SETLKW by a signal and cleanup only canceled the pending interrupted request */
> +	do_test_signal_interrupt();
> +	/* test if cleanup is correct if a child gets killed while being blocked in F_SETLKW */
> +	do_test_kill();
> +
> +	close(fd);
> +
> +	return 0;
> +}
> diff --git a/tests/generic/732 b/tests/generic/732
> new file mode 100755
> index 00000000..d77f9fc2
> --- /dev/null
> +++ b/tests/generic/732
> @@ -0,0 +1,32 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
> +#
> +# FS QA Test 732
> +#
> +# This tests performs some fcntl() corner cases. See fcntl test
> +# program for more details.
> +#
> +. ./common/preamble
> +_begin_fstest auto
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_test
> +_require_test_program fcntl
> +
> +echo "Silence is golden"
> +
> +$here/src/fcntl $TEST_DIR/testfile
> +if [ $? -ne 0 ]
> +then
> +	exit
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/generic/732.out b/tests/generic/732.out
> new file mode 100644
> index 00000000..451f82ce
> --- /dev/null
> +++ b/tests/generic/732.out
> @@ -0,0 +1,2 @@
> +QA output created by 732
> +Silence is golden
> -- 
> 2.31.1
> 

