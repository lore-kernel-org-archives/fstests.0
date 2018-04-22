Received: from mail-pf0-f195.google.com ([209.85.192.195]:47001 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeDVKmS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Apr 2018 06:42:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so6902993pfe.13
        for <fstests@vger.kernel.org>; Sun, 22 Apr 2018 03:42:18 -0700 (PDT)
Date: Sun, 22 Apr 2018 18:42:12 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: test record locks across execve
Message-ID: <20180422104212.GA3333@desktop>
References: <1522764225-17798-1-git-send-email-xzhou@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1522764225-17798-1-git-send-email-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Xiong Zhou <xzhou@redhat.com>
Cc: fstests@vger.kernel.org, berrange@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, Apr 03, 2018 at 10:03:45PM +0800, Xiong Zhou wrote:
> According to fcntl(2) man page, record locks are preserved across
> an execve(2). This is a regression case for this.
>=20
> Signed-off-by: Xiong Zhou <xzhou@redhat.com>

Sorry for the late review..

> ---
>=20
> Thanks Daniel for the report and reproducer!
> Jeff Layton is fixing this in kernel upstream.

If it's already fixed, can you please reference the commit id in the
log?

>=20
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/t_locks_execve.c  | 86 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/generic/482     | 70 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/482.out |  2 ++
>  tests/generic/group   |  1 +
>  6 files changed, 161 insertions(+), 1 deletion(-)
>  create mode 100644 src/t_locks_execve.c
>  create mode 100755 tests/generic/482
>  create mode 100644 tests/generic/482.out
>=20
> diff --git a/.gitignore b/.gitignore
> index 368d11c..192ca35 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -121,6 +121,7 @@
>  /src/t_getcwd
>  /src/t_holes
>  /src/t_immutable
> +/src/t_locks_execve
>  /src/t_mmap_cow_race
>  /src/t_mmap_dio
>  /src/t_mmap_fallocate
> diff --git a/src/Makefile b/src/Makefile
> index 0d3feae..6ca5636 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -15,7 +15,7 @@ TARGETS =3D dirstress fill fill2 getpagesize holes ls=
tat64 \
>  	holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
>  	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
>  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> -	t_ofd_locks
> +	t_ofd_locks t_locks_execve
> =20
>  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pattern=
_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/t_locks_execve.c b/src/t_locks_execve.c
> new file mode 100644
> index 0000000..a93c6ca
> --- /dev/null
> +++ b/src/t_locks_execve.c
> @@ -0,0 +1,86 @@
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <sys/wait.h>
> +
> +static void err_exit(char *op, int errn)
> +{
> +	fprintf(stderr, "%s: %s\n", op, strerror(errn));
> +	exit(errn);
> +}
> +
> +void *thread_fn(void *arg)
> +{
> +	/* execve will release threads */
> +	while(1) sleep(1);
> +	return NULL;
> +}
> +
> +static void checklock(int fd)
> +{
> +	pid_t child =3D fork();
> +	if (child < 0)
> +		err_exit("fork", errno);
> +	if (child =3D=3D 0) {
> +		struct flock fl =3D {
> +			.l_type =3D F_WRLCK,
> +			.l_whence =3D SEEK_SET,
> +			.l_start =3D 0,
> +			.l_len =3D 1,
> +		};

The struct flock used here is the same as in main(), make it a global
struct?

> +
> +		if (fcntl(fd, F_GETLK, &fl) < 0)
> +			err_exit("getlk", errno);
> +
> +		if (fl.l_type =3D=3D F_UNLCK)
> +			printf("Lock released\n");

I'd like to see more descriptive error message here.

> +		exit(0);

exit with non-zero on failure?

> +	}
> +	waitpid(child, NULL, 0);
> +}
> +
> +int main(int argc, char **argv) {

int main(...)
{
...
}

> +
> +	int fd;
> +	/* passing fd in argv[2] in execve */
> +	if (argc =3D=3D 3) {
> +		fd =3D atoi(argv[2]);
> +		checklock(fd);
> +		exit(0);
> +	}
> +
> +	fd =3D open(argv[1], O_WRONLY|O_CREAT, 0755);
> +	if (fd < 0)
> +		err_exit("open", errno);
> +	struct flock fl =3D {
> +		.l_type =3D F_WRLCK,
> +		.l_whence =3D SEEK_SET,
> +		.l_start =3D 0,
> +		.l_len =3D 1,
> +	};
> +	if (fcntl(fd, F_SETLK, &fl) < 0)
> +		err_exit("setlk", errno);
> +
> +	pthread_t th;
> +	pthread_create(&th, NULL, thread_fn, &fd);

I'm not sure why we need a thread here. Add more comments?

> +
> +	int flags;
> +	if ((flags =3D fcntl(fd, F_GETFD)) < 0)
> +		err_exit("getfd", errno);
> +	flags &=3D ~FD_CLOEXEC;
> +	if (fcntl(fd, F_SETFD, flags) < 0)
> +		err_exit("setfd", errno);
> +
> +	char fdstr[10];
> +	snprintf(fdstr, sizeof(fdstr), "%d", fd);
> +	char *newargv[] =3D { argv[0], argv[1], fdstr, NULL };

Better to declare all the variables at the beginning of main.

> +	execve(argv[0], newargv, NULL);
> +	return 0;
> +}
> diff --git a/tests/generic/482 b/tests/generic/482
> new file mode 100755
> index 0000000..f7cb251
> --- /dev/null
> +++ b/tests/generic/482
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# FS QA Test 482
> +#
> +# This is testing
> +#
> +#  "Record locks are not inherited by a child created via fork(2),
> +#   but are preserved across an execve(2)."
> +#
> +# from fcntl(2) man page.
> +#
> +# Author: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> +#
> +#---------------------------------------------------------------------=
--
> +# Copyright (c) 2018 RedHat Inc.  All Rights Reserved.

"Red Hat"?

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
> +#---------------------------------------------------------------------=
--
> +#
> +
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1	# failure is the default!
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
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +
> +# prepare a 4k testfile in TEST_DIR
> +$XFS_IO_PROG -f -c "pwrite -S 0xFF 0 4096" \
> +	$TEST_DIR/t_lock_execve_file >> $seqres.full 2>&1
> +
> +# run test programe
> +$here/src/t_locks_execve $TEST_DIR/t_lock_execve_file
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/generic/482.out b/tests/generic/482.out
> new file mode 100644
> index 0000000..f5e17c8
> --- /dev/null
> +++ b/tests/generic/482.out
> @@ -0,0 +1,2 @@
> +QA output created by 482
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index e867606..0bf3c1f 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -484,3 +484,4 @@
>  479 auto quick metadata
>  480 auto quick metadata
>  481 auto quick log metadata
> +482 auto lock quick

Please re-number it when resending :)

Thanks,
Eryu

> --=20
> 1.8.3.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
