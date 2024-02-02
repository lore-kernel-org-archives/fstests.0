Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921DA13E220
	for <fstests@vger.kernel.org>; Fri,  2 Feb 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875492; cv=none; b=mPE5ZANBSVQ5DISf6V5hYH0r103JXVzC68564pF2ANLyGe1dUI1KHbd5D5c0XfcnwYQV7KDo65REClGqREcODNpNZvWgIaa7cWBxTTYiMGc7DkGkAMPIPVE0ELeCs6LOol7wb5L/LdUc99Bdpe9ohEfqmMcs5i5wG1FVV7FRwSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875492; c=relaxed/simple;
	bh=bFnfGxdRKIJQCV6qfwCDvwL0PwXJD0KrQSDbfHM0DGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f38QvmTCIxBOJWtqiNbdYwMpLGoWTWRozvmXm6+0FlsfYMpgErV1x2s/7lxT8IJR/XXfFGF5a9ojAwxUMiNvvz7l4vJ6MaMbOHgffmro00Aici0JDUDpZa8Zlz6kAClJFplMZ5BS7ztAIp60I0bDy2lM/jVP7qwgMdVNLloufLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUuoJDe3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUuoJDe3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706875489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXEjG8mjPHwC4kQv7uQDv5mPwqoOjYLaJp9qlnZhxxc=;
	b=iUuoJDe3CqXT8V9ayb60OlbK5rvtgHCdHjsnSd4DMPHVFt5JqyIMk04b+CEjnjWl0FE8Au
	S6skMh3jPCFJixT7b4+tJGeKew7lGSW/Jq6Z92pgD/mkM5cucyQW/VXfcikA/otZ3vnnqk
	V/y18J80E/k97zQTGOEsEijo0ufr6lg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-S5meUilyNe6Zp73S_WVhug-1; Fri, 02 Feb 2024 07:04:48 -0500
X-MC-Unique: S5meUilyNe6Zp73S_WVhug-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d98231a1f7so124405ad.0
        for <fstests@vger.kernel.org>; Fri, 02 Feb 2024 04:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875486; x=1707480286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXEjG8mjPHwC4kQv7uQDv5mPwqoOjYLaJp9qlnZhxxc=;
        b=Ysz8fPeV+6c3VTuKHweQl6r8sjRrFEu4MeJ/1gpezRi5cyAnvOEhum38XxnGDzNJAq
         +IWe/LzUrS/arB1dJk01NSOhkyYw+09sDRoOf2UviEkCS1Ai53PNuBdmxbUIK/9LB3wI
         fMwInVoNE3ev29UEMq+AAjYb74S7qwli6JhfS7ZR9OHKmYqStLidgungJkcabIPyxVHU
         siAnauww3VOvvCZSJgrtZzLdmAhHyEfmgpOm2989PTFLpoHHhjsYUYxXuQHpritZ0h08
         tWjzrCiswB04gg3DOfXNa5bZwzUidW7vp+3wBcQy83xkGsArwme2rxqRfJkzX39gJxZR
         gCiQ==
X-Gm-Message-State: AOJu0YzjuJtEUP5E/Yo4dXoI9wk0QKVNEBHWxBQJPxDOwzI1/XpKfAD+
	QpGuHsSr48TUYcuCl0YbD4BBDyXScYgiWBoEVev0WDR1oYZhpIno81AAwcAgdJiYLf60Vu3DmZs
	LgKasPU126LInQn3ffufXfpeg/3r7QjM/D3OvRRa5vRP+yPavqBcCe2Tl/NkIikL5lA==
X-Received: by 2002:a17:903:2b08:b0:1d9:63db:2bd7 with SMTP id mc8-20020a1709032b0800b001d963db2bd7mr3497850plb.61.1706875486550;
        Fri, 02 Feb 2024 04:04:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEO1DqxiDpFIvQC/3JnG4itnwBC/Sun4vEl3GqqGmIoSf5aHFOpBZpQe3cDcc1OT0St7S+4Mw==
X-Received: by 2002:a17:903:2b08:b0:1d9:63db:2bd7 with SMTP id mc8-20020a1709032b0800b001d963db2bd7mr3497826plb.61.1706875486188;
        Fri, 02 Feb 2024 04:04:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX2QQdbWYx+nMIhCrMm2QGbwHPBCvlL7Ez3k/sGQBEmOmBDJ+gMcjSjm0xYsXLFK+9uCep7LyYHKqxGv/J23Gmh8J0KwNEMP/9b4bOpFzFswXZr/8kbp3HAqPwy6jk=
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ke15-20020a170903340f00b001d96fce5505sm1223698plb.163.2024.02.02.04.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:04:45 -0800 (PST)
Date: Fri, 2 Feb 2024 20:04:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Aring <aahringo@redhat.com>, fstests@vger.kernel.org,
	gfs2@lists.linux.dev
Subject: Re: [PATCHv2] generic: add fcntl corner cases tests
Message-ID: <20240202120441.xukbskkr26m6egoq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20230925201827.1703857-1-aahringo@redhat.com>
 <d9981b21da65517589150792e8511bf192dd2374.camel@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9981b21da65517589150792e8511bf192dd2374.camel@kernel.org>

On Thu, Feb 01, 2024 at 12:10:44PM -0500, Jeff Layton wrote:
> On Mon, 2023-09-25 at 16:18 -0400, Alexander Aring wrote:
> > This patch adds fcntl corner cases that was being used to confirm issues
> > on a GFS2 filesystem. The GFS2 filesystem has it's own ->lock()
> > implementation and in those corner cases issues was being found and
> > fixed.
> > 
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> > changes since v2:
> > - move fcntl tests into one fcntl c file
> > - remove ofd and same owner tests, should be reflected by only one test
> > - simplify commit message (remove testname out of it)
> > - add error messages in fcntl.c to give more information if an error
> >   occur
> > 
> >  src/Makefile          |   3 +-
> >  src/fcntl.c           | 322 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/732     |  32 +++++
> >  tests/generic/732.out |   2 +
> >  4 files changed, 358 insertions(+), 1 deletion(-)
> >  create mode 100644 src/fcntl.c
> >  create mode 100755 tests/generic/732
> >  create mode 100644 tests/generic/732.out
> > 
> > diff --git a/src/Makefile b/src/Makefile
> > index 2815f919..67f936d3 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> >  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
> >  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> >  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > -	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
> > +	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> > +	fcntl
> 
> I think this function needs a less-generic name than "fcntl". Other the
> lock tests themselves look like a nice addition though.

Yeah, the "fcntl" name is too "big", please rename it to show what it trys
to test. Hi Alexander, you can tell me the new name you'd like to change,
if you don't want to send a V2. That might help to catch the fstests release
of this weekend :)

Thanks,
Zorro

> 
> >  
> >  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/fcntl.c b/src/fcntl.c
> > new file mode 100644
> > index 00000000..8e375357
> > --- /dev/null
> > +++ b/src/fcntl.c
> > @@ -0,0 +1,322 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
> > + */
> > +
> > +#include <pthread.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <limits.h>
> > +#include <stdlib.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdio.h>
> > +#include <wait.h>
> > +
> > +static char filename[PATH_MAX + 1];
> > +static int fd;
> > +
> > +static void usage(char *name, const char *msg)
> > +{
> > +	printf("Fatal: %s\nUsage:\n"
> > +	       "%s <file for fcntl>\n", msg, name);
> > +	_exit(1);
> > +}
> > +
> > +static void *do_equal_file_lock_thread(void *arg)
> > +{
> > +       struct flock fl = {
> > +	       .l_type = F_WRLCK,
> > +	       .l_whence = SEEK_SET,
> > +	       .l_start = 0L,
> > +	       .l_len = 1L,
> > +       };
> > +       int rv;
> > +
> > +       rv = fcntl(fd, F_SETLKW, &fl);
> > +       if (rv == -1) {
> > +	       perror("fcntl");
> > +	       _exit(1);
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +static void do_test_equal_file_lock(void)
> > +{
> > +	struct flock fl;
> > +	pthread_t t[2];
> > +	int pid, rv;
> > +
> > +	fl.l_type = F_WRLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 0L;
> > +	fl.l_len = 1L;
> > +
> > +	/* acquire range 0-0 */
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if (rv == -1) {
> > +	       perror("fcntl");
> > +		_exit(1);
> > +	}
> > +
> > +	pid = fork();
> > +	if (pid == 0) {
> > +		rv = pthread_create(&t[0], NULL, do_equal_file_lock_thread, NULL);
> > +		if (rv != 0) {
> > +			fprintf(stderr, "failed to create pthread\n");
> > +			_exit(1);
> > +		}
> > +
> > +		rv = pthread_create(&t[1], NULL, do_equal_file_lock_thread, NULL);
> > +		if (rv != 0) {
> > +			fprintf(stderr, "failed to create pthread\n");
> > +			_exit(1);
> > +		}
> > +
> > +		pthread_join(t[0], NULL);
> > +		pthread_join(t[1], NULL);
> > +
> > +		_exit(0);
> > +	}
> > +
> > +	/* wait until threads block on 0-0 */
> > +	sleep(3);
> > +
> > +	fl.l_type = F_UNLCK;
> > +	fl.l_start = 0;
> > +	fl.l_len = 1;
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if (rv == -1) {
> > +		perror("fcntl");
> > +		_exit(1);
> > +	}
> > +
> > +	sleep(3);
> > +
> > +	/* check if the ->lock() implementation got the
> > +	 * right locks granted because two waiter with the
> > +	 * same file_lock fields are waiting
> > +	 */
> > +	fl.l_type = F_WRLCK;
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if (rv == -1 && errno == EAGAIN) {
> > +		fprintf(stderr, "deadlock, pthread not cleaned up correctly\n");
> > +		_exit(1);
> > +	}
> > +
> > +	wait(NULL);
> > +}
> > +
> > +static void catch_alarm(int num) { }
> > +
> > +static void do_test_signal_interrupt_child(int *pfd)
> > +{
> > +	struct sigaction act;
> > +	unsigned char m;
> > +	struct flock fl;
> > +	int rv;
> > +
> > +	fl.l_type = F_WRLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 1;
> > +	fl.l_len = 1;
> > +
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if (rv == -1) {
> > +		perror("fcntl");
> > +		_exit(1);
> > +	}
> > +
> > +	memset(&act, 0, sizeof(act));
> > +	act.sa_handler = catch_alarm;
> > +	sigemptyset(&act.sa_mask);
> > +	sigaddset(&act.sa_mask, SIGALRM);
> > +	sigaction(SIGALRM, &act, NULL);
> > +
> > +	fl.l_type = F_WRLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 0;
> > +	fl.l_len = 1;
> > +
> > +	/* interrupt SETLKW by signal in 3 secs */
> > +	alarm(3);
> > +	rv = fcntl(fd, F_SETLKW, &fl);
> > +	if (rv == 0) {
> > +		fprintf(stderr, "fcntl interrupt successful but should fail with EINTR\n");
> > +		_exit(1);
> > +	}
> > +
> > +	/* synchronize to move parent to test region 1-1 */
> > +	write(pfd[1], &m, sizeof(m));
> > +
> > +	/* keep child alive */
> > +	read(pfd[1], &m, sizeof(m));
> > +}
> > +
> > +static void do_test_signal_interrupt(void)
> > +{
> > +	struct flock fl;
> > +	unsigned char m;
> > +	int pid, rv;
> > +	int pfd[2];
> > +
> > +	rv = pipe(pfd);
> > +	if (rv == -1) {
> > +		perror("pipe");
> > +		_exit(1);
> > +	}
> > +
> > +	fl.l_type = F_WRLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 0;
> > +	fl.l_len = 1;
> > +
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if (rv == -1) {
> > +		perror("fcntl");
> > +		_exit(1);
> > +	}
> > +
> > +	pid = fork();
> > +	if (pid == 0) {
> > +		do_test_signal_interrupt_child(pfd);
> > +		_exit(0);
> > +	}
> > +
> > +	/* wait until child writes */
> > +	read(pfd[0], &m, sizeof(m));
> > +
> > +	fl.l_type = F_WRLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 1;
> > +	fl.l_len = 1;
> > +	/* parent testing childs region, the child will think
> > +	 * it has region 1-1 locked because it was interrupted
> > +	 * by region 0-0. Due bugs the interruption also unlocked
> > +	 * region 1-1.
> > +	 */
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if (rv == 0) {
> > +		fprintf(stderr, "fcntl trylock successful but should fail because child still acquires region\n");
> > +		_exit(1);
> > +	}
> > +
> > +	write(pfd[0], &m, sizeof(m));
> > +
> > +	wait(NULL);
> > +
> > +	close(pfd[0]);
> > +	close(pfd[1]);
> > +
> > +	/* cleanup everything */
> > +	fl.l_type = F_UNLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 0;
> > +	fl.l_len = 2;
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if (rv == -1) {
> > +		perror("fcntl");
> > +		_exit(1);
> > +	}
> > +}
> > +
> > +static void do_test_kill_child(void)
> > +{
> > +	struct flock fl;
> > +	int rv;
> > +
> > +	fl.l_type = F_WRLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 0;
> > +	fl.l_len = 1;
> > +
> > +	rv = fcntl(fd, F_SETLKW, &fl);
> > +	if (rv == -1) {
> > +		perror("fcntl");
> > +		_exit(1);
> > +	}
> > +}
> > +
> > +static void do_test_kill(void)
> > +{
> > +	struct flock fl;
> > +	int pid_to_kill;
> > +	int rv;
> > +
> > +	fl.l_type = F_WRLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 0;
> > +	fl.l_len = 1;
> > +
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if (rv == -1) {
> > +		perror("fcntl");
> > +		_exit(1);
> > +	}
> > +
> > +	pid_to_kill = fork();
> > +	if (pid_to_kill == 0) {
> > +		do_test_kill_child();
> > +		_exit(0);
> > +	}
> > +
> > +	/* wait until child blocks */
> > +	sleep(3);
> > +
> > +	kill(pid_to_kill, SIGKILL);
> > +
> > +	/* wait until Linux did plock cleanup */
> > +	sleep(3);
> > +
> > +	fl.l_type = F_UNLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 0;
> > +	fl.l_len = 1;
> > +
> > +	/* cleanup parent lock */
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if (rv == -1) {
> > +		perror("fcntl");
> > +		_exit(1);
> > +	}
> > +
> > +	fl.l_type = F_WRLCK;
> > +	fl.l_whence = SEEK_SET;
> > +	fl.l_start = 0;
> > +	fl.l_len = 1;
> > +
> > +	/* check if the child still holds the lock
> > +	 * and killing the child was not cleaning
> > +	 * up locks.
> > +	 */
> > +	rv = fcntl(fd, F_SETLK, &fl);
> > +	if ((rv == -1 && errno == EAGAIN)) {
> > +		fprintf(stderr, "fcntl trylock failed but should be successful because killing child should cleanup acquired lock\n");
> > +		_exit(1);
> > +	}
> > +}
> > +
> > +int main(int argc, char * const argv[])
> > +{
> > +	if (optind != argc - 1)
> > +		usage(argv[0], "<file for fcntl> is mandatory to tell the file where to run fcntl() on it");
> > +
> > +	strncpy(filename, argv[1], PATH_MAX);
> > +
> > +	fd = open(filename, O_RDWR | O_CREAT, 0700);
> > +	if (fd == -1) {
> > +		perror("open");
> > +		_exit(1);
> > +	}
> > +
> > +	/* test to have to equal struct file_lock requests in ->lock() */
> > +	do_test_equal_file_lock();
> > +	/* test to interrupt F_SETLKW by a signal and cleanup only canceled the pending interrupted request */
> > +	do_test_signal_interrupt();
> > +	/* test if cleanup is correct if a child gets killed while being blocked in F_SETLKW */
> > +	do_test_kill();
> > +
> > +	close(fd);
> > +
> > +	return 0;
> > +}
> > diff --git a/tests/generic/732 b/tests/generic/732
> > new file mode 100755
> > index 00000000..d77f9fc2
> > --- /dev/null
> > +++ b/tests/generic/732
> > @@ -0,0 +1,32 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Alexander Aring.  All Rights Reserved.
> > +#
> > +# FS QA Test 732
> > +#
> > +# This tests performs some fcntl() corner cases. See fcntl test
> > +# program for more details.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_require_test
> > +_require_test_program fcntl
> > +
> > +echo "Silence is golden"
> > +
> > +$here/src/fcntl $TEST_DIR/testfile
> > +if [ $? -ne 0 ]
> > +then
> > +	exit
> > +fi
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/732.out b/tests/generic/732.out
> > new file mode 100644
> > index 00000000..451f82ce
> > --- /dev/null
> > +++ b/tests/generic/732.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 732
> > +Silence is golden
> 
> 
> Assuming you change the name of "fcntl" program, you can add:
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> 

