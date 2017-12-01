Received: from smtpbg62.qq.com ([103.7.29.139]:25738 "EHLO smtpbg64.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752129AbdLAEFH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 30 Nov 2017 23:05:07 -0500
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] common: Add infrastructure for syncfs syscall tests
From: Chengguang Xu <cgxu@mykernel.net>
In-Reply-To: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
Date: Fri, 1 Dec 2017 12:04:44 +0800
Message-Id: <621FF37E-8612-489C-8721-4BBC08BAB336@mykernel.net>
References: <1512100554-16368-1-git-send-email-cgxu@mykernel.net>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: eguan@redhat.com
Cc: Amir Goldstein <amir73il@gmail.com>, fstests@vger.kernel.org, cgxu <cgxu@mykernel.net>
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

Actually, in my another test case generic/470 will need to check whether =
fs supports syncfs or not.=20
I make shared infrastructure for checking that, and because it is common =
component=20
I post as an individual patch instead of including in the case of generic=
/470.


Thanks,
Chengguang.


> =D4=DA 2017=C4=EA12=D4=C21=C8=D5=A3=AC=C9=CF=CE=E711:55=A3=ACChengguang=
 Xu <cgxu@mykernel.net> =D0=B4=B5=C0=A3=BA
>=20
> This adds binary utility and common script of syncfs for the actual tes=
t scripts.
>=20
> Signed-off-by: Chengguang Xu <cgxu@mykernel.net>
> ---
> .gitignore    |  1 +
> common/syncfs | 33 +++++++++++++++++++++++++++
> configure.ac  |  1 +
> src/Makefile  |  2 +-
> src/syncfs.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
> 5 files changed, 108 insertions(+), 1 deletion(-)
> create mode 100644 common/syncfs
> create mode 100644 src/syncfs.c
>=20
> diff --git a/.gitignore b/.gitignore
> index f27c30a..54f010c 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -142,6 +142,7 @@
> /src/writemod
> /src/writev_on_pagefault
> /src/xfsctl
> +/src/syncfs
> /src/aio-dio-regress/aio-dio-append-write-read-race
> /src/aio-dio-regress/aio-dio-cow-race
> /src/aio-dio-regress/aio-dio-cycle-write
> diff --git a/common/syncfs b/common/syncfs
> new file mode 100644
> index 0000000..125ee4c
> --- /dev/null
> +++ b/common/syncfs
> @@ -0,0 +1,33 @@
> +######
> +#
> +# syncfs helpers
> +#
> +#---------------------------------------------------------------------=
--
> +# Copyright (c) 2017 Chengguang Xu <cgxu@mykernel.net>.=20
> +# All Rights Reserved.
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
> +
> +# This checks whether the syncfs syscall is supported.
> +_requires_syncfs()
> +{
> +	if test ! -x src/syncfs; then
> +		_notrun "syncfs binary not found"
> +	fi
> +
> +	if ! src/syncfs $TEST_DIR; then
> +		_notrun "kernel doesn't support syncfs syscall"
> +	fi
> +}
> diff --git a/configure.ac b/configure.ac
> index 57092f1..7207a47 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -70,6 +70,7 @@ AC_PACKAGE_WANT_LINUX_PRCTL_H
> AC_PACKAGE_WANT_LINUX_FS_H
>=20
> AC_CHECK_FUNCS([renameat2])
> +AC_CHECK_FUNCS([syncfs])
>=20
> AC_CONFIG_HEADER(include/config.h)
> AC_CONFIG_FILES([include/builddefs])
> diff --git a/src/Makefile b/src/Makefile
> index b101217..83451a9 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -23,7 +23,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize p=
reallo_rw_pattern_reader \
> 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
> 	renameat2 t_getcwd e4compact test-nextquota punch-alternating \
> 	attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_type \
> -	dio-invalidate-cache stat_test t_encrypted_d_revalidate
> +	dio-invalidate-cache stat_test t_encrypted_d_revalidate syncfs
>=20
> SUBDIRS =3D log-writes perf
>=20
> diff --git a/src/syncfs.c b/src/syncfs.c
> new file mode 100644
> index 0000000..d30a3e6
> --- /dev/null
> +++ b/src/syncfs.c
> @@ -0,0 +1,72 @@
> +/*
> + * Copyright (c) 2017, Chengguang Xu <cgxu@mykernel.net>
> + * All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation=
,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +/* This is a trivial wrapper around the syncfs syscall. */
> +
> +#include "global.h"
> +
> +#ifndef HAVE_SYNCFS
> +#include <sys/syscall.h>
> +
> +#if !defined(SYS_syncfs) && defined(__x86_64__)
> +#define SYS_syncfs 306
> +#endif /* !defined(SYS_syncfs) && defined(__x86_64__) */
> +
> +#if !defined(SYS_syncfs) && defined(__i386__)
> +#define SYS_syncfs 344
> +#endif /* !defined(SYS_syncfs) && defined(__i386__) */
> +
> +static int syncfs(int fd)
> +{
> +#ifdef SYS_syncfs
> +	return syscall(SYS_syncfs, fd);
> +#else
> +	errno =3D ENOSYS;
> +	return -1;
> +#endif /* SYS_syncfs */
> +}
> +#endif /* HAVE_SYNCFS */
> +
> +int main(int argc, char **argv)
> +{
> +	int fd, ret;
> +	const char *fpath =3D NULL;
> +
> +	if (argc !=3D 2)
> +		goto usage;
> +
> +	fpath =3D argv[1];
> +	fd =3D open(fpath, O_RDONLY);
> +	if (fd < 0) {
> +		perror("");
> +		return 1;
> +	}
> +
> +	ret =3D syncfs(fd);
> +	if (ret =3D=3D -1 && errno =3D=3D ENOSYS)
> +		ret =3D 1;
> +	else
> +		ret =3D 0;
> +
> +	close(fd);
> +	return ret;
> +
> +usage:
> +	fprintf(stderr, "usage: %s path\n", argv[0]);=20
> +	return 1;
> +}
> --=20
> 1.8.3.1
>=20
>=20

