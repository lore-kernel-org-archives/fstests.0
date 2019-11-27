Return-Path: <SRS0=I7qB=ZT=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953ECC432C0
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Nov 2019 08:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C25C2073F
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Nov 2019 08:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZEERZNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfK0IEC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:04:02 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44609 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfK0IEC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Nov 2019 03:04:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id v201so15308114lfa.11
        for <fstests@vger.kernel.org>; Wed, 27 Nov 2019 00:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GUmNG0m3bmvOXF9veJiF+AYl17Sq1fhZ4UfRX2UiLV4=;
        b=jZEERZNByjjOEL/+0HlzBWSZtvTTLomvPLqN1XJvGTsPelBTzmw6deNBP6GIXVv1Wg
         AgRfS3QY3K0EzzLi3AVsBDnY15FNbMT0TOkiSNzU3dGZ7hsBzASxKGorWNubTxuhhHP6
         gENBt3d5Mvfue4vy77oSTB/YM68lo6z888mmQ0oxn+brQpU7XvXjCfUHv/rQfyX9X6wH
         T+EnPXtK0pQyUeLvxxAy80iO+GUY5gNHcbUvJwjX7O0rGtWHOmlYxR5+YrpMR7mwrw38
         Xt9f9US0hT5pwqFl32MMlrId/ioUTYOaEX1PSiqzUm2YK8nkSD8xsJYCQ8NCTn6oDipp
         BUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GUmNG0m3bmvOXF9veJiF+AYl17Sq1fhZ4UfRX2UiLV4=;
        b=WtLE8jDjk9XxCT9PE2Q0NJHK5ePE27bO341kcmmNnMemkj9Re8s1dcZ4DTc1ZOeTAa
         7IafRQdAtn4cM7C0jhyzpKvIbvV3gWS7gWlj5S91tRm89Sque2VV3FnxeLrr/O/O3pwF
         LHJ8M78ACHXyHJMxg27fP8iVA7CuwIXeYUfvhNoWf+cCvEdwT2cyN66YwYZi9ghhfh6D
         V6pMMRPiQaOJ35iHSHdTUW7dbBLtl4wsYVJA0VVOd56zP3xUnosfT5Kpfp3aIoE/r9cv
         l7rhMtGs7USKJmhPHrwfSP5fPQwwcxGgV27jHOf6q6sIj6mcj+hF/vLwZiH0Xb6B2r4y
         DhXg==
X-Gm-Message-State: APjAAAVTcUYnHf3xNWvWzWOEYnOaOk8HJxrAnAgKGzvMQOC3nquw4sM6
        qRXkNj5To5PrQJWfeH1WsZ8RZQiZwCylHr9qAZ4=
X-Google-Smtp-Source: APXvYqypbFog2RCZ8dC0sDuxvZ8cMSIukTjKwYDp6ytbmz5vaP3b5DVpecUsm8crSUWLELPvJ/hl9dppwOLH4YEEIyg=
X-Received: by 2002:ac2:5464:: with SMTP id e4mr27750135lfn.47.1574841837991;
 Wed, 27 Nov 2019 00:03:57 -0800 (PST)
MIME-Version: 1.0
References: <CAAPJbvqksutxzznPO1T5Z_pQA-=SuKHLuzp_TOyJu7s3W2tL=Q@mail.gmail.com>
 <20191126160609.GG6212@magnolia>
In-Reply-To: <20191126160609.GG6212@magnolia>
From:   Sun Yong <sunyong0511@gmail.com>
Date:   Wed, 27 Nov 2019 16:03:45 +0800
Message-ID: <CAAPJbvraAtZsJCCKYGSK+QrHvhrBh=herwasU5G9SkD88piNsQ@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: transport two ext4 tests from LTP
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests@vger.kernel.org, Yong Sun <yosun@suse.com>,
        Eryu Guan <guaneryu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Darrick, Eryu,

Thank you so much for both of your review and helpful suggestions.
Some days before I had sent a
v4(https://patchwork.kernel.org/patch/11241473/) which solved wrap
issue, but no need to review that version in case there has some issue
to fix. I'll take all suggestions by Darrick in next version, or split
it into separate patches, and let you know when I finished.

Thanks,
Yong

Darrick J. Wong <darrick.wong@oracle.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=88=
27=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:06=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Mon, Nov 04, 2019 at 03:30:55PM +0800, Sun Yong wrote:
> > Recently LTP upstream removed some ext4 tests[1]. And two of them is
> > still valid to keep. So I transport those two tests here.
> >
> > ext4-nsec-timestamps, which is used to test nanosec timestamps of
> > ext4, rewrite into ext4/043 and 044.
> > ext4-subdir-limit, which is used to test subdirectory limit of ext4,
> > rewrite into ext4/045.
>
> Might be a good idea to split these into separate patches...
>
> > [1] https://marc.info/?l=3Dlinux-fsdevel&m=3D157190623919681&w=3D2
> >
> > Signed-off-by: Sun Yong <yosun@suse.com>
> > ---
> > v2: Correct copyright information
> > ---
> > diff --git a/src/Makefile b/src/Makefile
> > index ce6d8610..387293d1 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -16,7 +16,8 @@ TARGETS =3D dirstress fill fill2 getpagesize holes ls=
tat64 \
> >      holetest t_truncate_self t_mmap_dio af_unix t_mmap_stale_pmd \
> >      t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
> >      t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> > -    t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent
> > +    t_ofd_locks t_locks_execve t_mmap_collision mmap-write-concurrent =
\
> > +    t_ext4_file_time t_create_short_dirs t_create_long_dirs
> >
> >  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pattern=
_reader \
> >      preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/t_create_long_dirs.c b/src/t_create_long_dirs.c
> > new file mode 100644
> > index 00000000..76a886aa
> > --- /dev/null
> > +++ b/src/t_create_long_dirs.c
> > @@ -0,0 +1,155 @@
> > +/*********************************************************************=
*********/
> > +/*
> >         */
>
> Don't wrap, like Eryu asked.
>
> > +/* Copyright (c) 2009 FUJITSU LIMITED
> >         */
> > +/*
> >         */
> > +/* This program is free software;  you can redistribute it and/or
> > modify      */
> > +/* it under the terms of the GNU General Public License as published
> > by       */
> > +/* the Free Software Foundation; either version 2 of the License, or
> >         */
> > +/* (at your option) any later version.
>
> SPDX headers instead of GPL boilerplate, please.
>
> >         */
> > +/*
> >         */
> > +/* This program is distributed in the hope that it will be useful,
> >         */
> > +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
> >         */
> > +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> >         */
> > +/* the GNU General Public License for more details.
> >         */
> > +/*
> >         */
> > +/* You should have received a copy of the GNU General Public License
> >         */
> > +/* along with this program;  if not, write to the Free Software
> >         */
> > +/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> > 02110-1301 USA    */
> > +/*
> >         */
> > +/* Author: Li Zefan <lizf@cn.fujitsu.com>
> >         */
> > +/*
> >         */
> > +/*********************************************************************=
*********/
> > +
> > +#define _POSIX_C_SOURCE 200809L
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <time.h>
> > +#include <fcntl.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include "config.h"
> > +
> > +#define NAME_LEN    255
> > +#define NCHARS        62
> > +#define MAX_LEN1    62
> > +#define MAX_LEN2    (62 * 62)
> > +#define MAX_LEN3    (62 * 62 * 62)
>
> 62?
>
> Oh, 26 + 26 + 10.
>
> > +
> > +/* valid characters for the directory name */
> > +char chars[NCHARS + 1] =3D
> > +    "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
> > +
> > +/* to store the generated directory name */
> > +char name[NAME_LEN + 1];
> > +int names;
> > +int parent_fd;
> > +
> > +/*
> > + * init_name - initialize the directory name
> > + *
> > + * Generate a randomized directory name, and then we generate more
> > + * directory names based on it.
> > + */
> > +void init_name(void)
> > +{
> > +    int i;
> > +
> > +    srand(time(NULL));
> > +
> > +    for (i =3D 0; i < NAME_LEN; i++)
> > +        name[i] =3D chars[rand() % 62];
> > +}
> > +
> > +void create_dir(void)
> > +{
> > +    if (mkdirat(parent_fd, name, S_IRWXU)) {
> > +        perror("mkdir");
> > +        exit(1);
> > +    }
> > +}
> > +
> > +/*
> > + * create_dirs - create @names directory names
> > + * @n: how many names to be created
> > + *
> > + * if n <=3D 62,       we need to modify 1 char of the name
> > + * if n <=3D 62*62,    we need to modify 2 chars
> > + * if n <=3D 62*62*62, we need to modify 3 chars
> > + */
> > +void create_dirs(int n)
> > +{
> > +    int i, j, k;
> > +    int depth;
> > +
> > +    if (n <=3D MAX_LEN1)
> > +        depth =3D 1;
> > +    else if (n <=3D MAX_LEN2)
> > +        depth =3D 2;
> > +    else
> > +        depth =3D 3;
> > +
> > +    for (i =3D 0; i < NCHARS; i++) {
> > +        name[0] =3D chars[i];
> > +        if (depth =3D=3D 1) {
> > +            create_dir();
> > +            if (--n =3D=3D 0)
> > +                return;
> > +            continue;
> > +        }
> > +
> > +        for (j =3D 0; j < NCHARS; j++) {
> > +            name[1] =3D chars[j];
> > +            if (depth =3D=3D 2) {
> > +                create_dir();
> > +                if (--n =3D=3D 0)
> > +                    return;
> > +                continue;
> > +            }
> > +
> > +            for (k =3D 0; k < NCHARS; k++) {
> > +                name[2] =3D chars[k];
> > +                create_dir();
> > +                if (--n =3D=3D 0)
> > +                    return;
> > +            }
> > +        }
> > +    }
> > +}
>
> I would've thought you could just do:
>
> for (i =3D 0; i < n; i++) {
>         snprintf(name, sizeof(name) - 1, "%0*d", depth, n);
>         mkdirat(dir, name, ...);
> }
>
> instead of this nested loopy thing, since the goal is to end up with a
> subdirectory containing somewhere between 1 and 238328 names in it,
> right?
>
> Unless there's some speedup that nested looping gets us?
>
> > +
> > +void usage()
> > +{
> > +    fprintf(stderr, "Usage: create_long_dirs nr_dirs parent_dir\n");
> > +}
> > +
> > +/*
> > + * Create long-name directories
> > + * @argv[1]: directory number
> > + * @argv[2]: parent directory
> > + */
> > +int main(int argc, char *argv[])
> > +{
> > +    if (argc !=3D 3) {
> > +        usage();
> > +        return 1;
> > +    }
> > +
> > +    names =3D atoi(argv[1]);
> > +    if (names > MAX_LEN3 || names <=3D 0) {
> > +        usage();
> > +        return 1;
> > +    }
> > +
> > +    parent_fd =3D open(argv[2], O_RDONLY);
> > +    if (parent_fd =3D=3D -1) {
> > +        perror("open parent dir failed");
> > +        return 1;
> > +    }
> > +
> > +    init_name();
> > +
> > +    create_dirs(names);
> > +
> > +    return 0;
> > +}
> > diff --git a/src/t_create_short_dirs.c b/src/t_create_short_dirs.c
> > new file mode 100644
> > index 00000000..c5733b9d
> > --- /dev/null
> > +++ b/src/t_create_short_dirs.c
> > @@ -0,0 +1,158 @@
> > +/*********************************************************************=
*********/
> > +/*
> >         */
> > +/* Copyright (c) 2009 FUJITSU LIMITED
> >         */
> > +/*
> >         */
> > +/* This program is free software;  you can redistribute it and/or
> > modify      */
> > +/* it under the terms of the GNU General Public License as published
> > by       */
> > +/* the Free Software Foundation; either version 2 of the License, or
> >         */
> > +/* (at your option) any later version.
> >         */
> > +/*
> >         */
> > +/* This program is distributed in the hope that it will be useful,
> >         */
> > +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
> >         */
> > +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> >         */
> > +/* the GNU General Public License for more details.
> >         */
> > +/*
> >         */
> > +/* You should have received a copy of the GNU General Public License
> >         */
> > +/* along with this program;  if not, write to the Free Software
> >         */
> > +/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> > 02110-1301 USA    */
> > +/*
> >         */
> > +/* Author: Li Zefan <lizf@cn.fujitsu.com>
> >         */
> > +/*
> >         */
> > +/*********************************************************************=
*********/
> > +
> > +#define _POSIX_C_SOURCE 200809L
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include "config.h"
> > +
> > +/* valid characters for a directory name */
> > +char chars[] =3D
> > "0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
> > +
> > +/* to store the generated directory name */
> > +char name[10];
> > +int names;
> > +int parent_fd;
> > +
> > +/* NCHARS =3D 10 + 26 + 26 =3D 62 */
> > +#define NCHARS        62
> > +#define MAX_LEN1    62
> > +#define MAX_LEN2    (62 * 62)
> > +#define MAX_LEN3    (62 * 62 * 62)
> > +#define MAX_NAMES    (MAX_LEN1 + MAX_LEN2 + MAX_LEN3)
> > +
> > +void create_dir(void)
> > +{
> > +    if (mkdirat(parent_fd, name, S_IRWXU)) {
> > +        perror("mkdir");
> > +        exit(1);
> > +    }
> > +}
> > +
> > +/*
> > + * create_1 - create length-1 directory names
> > + * @n: how name names to be created
> > + */
> > +void create_1(int n)
> > +{
> > +    int i;
> > +
> > +    name[1] =3D '\0';
> > +    for (i =3D 0; i < NCHARS; i++) {
> > +        name[0] =3D chars[i];
> > +        create_dir();
> > +        if (--n =3D=3D 0)
> > +            return;
> > +    }
> > +}
> > +
> > +/*
> > + * create_2 - generate length-2 directory names
> > + * @n: how many names to be created
> > + */
> > +void create_2(int n)
> > +{
> > +    int i, j;
> > +
> > +    name[2] =3D '\0';
> > +    for (i =3D 0; i < NCHARS; i++) {
> > +        name[0] =3D chars[i];
> > +        for (j =3D 0; j < NCHARS; j++) {
> > +            name[1] =3D chars[j];
> > +            create_dir();
> > +            if (--n =3D=3D 0)
> > +                return;
> > +        }
> > +    }
> > +}
> > +
> > +/*
> > + * create_3 - generate length-3 directory names
> > + * @n: how many names to be created
> > + */
> > +void create_3(int n)
> > +{
> > +    int i, j, k;
> > +
> > +    name[3] =3D '\0';
> > +    for (i =3D 0; i < NCHARS; i++) {
> > +        name[0] =3D chars[i];
> > +        for (j =3D 0; j < NCHARS; j++) {
> > +            name[1] =3D chars[j];
> > +            for (k =3D 0; k < NCHARS; k++) {
> > +                name[2] =3D chars[k];
> > +                create_dir();
> > +                if (--n =3D=3D 0)
> > +                    return;
> > +            }
> > +        }
> > +    }
> > +}
> > +
> > +void usage()
> > +{
> > +    fprintf(stderr, "Usage: create_short_dirs nr_dirs parent_dir\n");
> > +}
> > +
> > +/*
> > + * Create short-name directoriess
> > + * @argv[1]: director number
> > + * @argv[2]: the parent directory
> > + */
> > +int main(int argc, char *argv[])
>
> How does this program differ from the other one?
>
> > +{
> > +    if (argc !=3D 3) {
> > +        usage();
> > +        return 1;
> > +    }
> > +
> > +    names =3D atoi(argv[1]);
> > +    if (names > MAX_NAMES || names <=3D 0) {
> > +        usage();
> > +        return 1;
> > +    }
> > +
> > +    parent_fd =3D open(argv[2], O_RDONLY);
> > +    if (parent_fd =3D=3D -1) {
> > +        perror("open parent dir");
> > +        return 1;
> > +    }
> > +
> > +    create_1(names);
> > +    if (names <=3D MAX_LEN1)
> > +        return 0;
> > +
> > +    names -=3D MAX_LEN1;
> > +    create_2(names);
> > +    if (names <=3D MAX_LEN2)
> > +        return 0;
> > +
> > +    names -=3D MAX_LEN2;
> > +    create_3(names);
> > +
> > +    return 0;
> > +}
> > diff --git a/src/t_ext4_file_time.c b/src/t_ext4_file_time.c
> > new file mode 100644
> > index 00000000..a10adb3d
> > --- /dev/null
> > +++ b/src/t_ext4_file_time.c
> > @@ -0,0 +1,69 @@
> > +/*********************************************************************=
*********/
> > +/*
> >         */
> > +/* Copyright (c) 2009 FUJITSU LIMITED
> >         */
> > +/*
> >         */
> > +/* This program is free software;  you can redistribute it and/or
> > modify      */
> > +/* it under the terms of the GNU General Public License as published
> > by       */
> > +/* the Free Software Foundation; either version 2 of the License, or
> >         */
> > +/* (at your option) any later version.
> >         */
> > +/*
> >         */
> > +/* This program is distributed in the hope that it will be useful,
> >         */
> > +/* but WITHOUT ANY WARRANTY;  without even the implied warranty of
> >         */
> > +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> >         */
> > +/* the GNU General Public License for more details.
> >         */
> > +/*
> >         */
> > +/* You should have received a copy of the GNU General Public License
> >         */
> > +/* along with this program;  if not, write to the Free Software
> >         */
> > +/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> > 02110-1301 USA    */
> > +/*
> >         */
> > +/* Author: Li Zefan <lizf@cn.fujitsu.com>
> >         */
> > +/*
> >         */
> > +/*********************************************************************=
*********/
> > +
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <unistd.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +
> > +/*
> > + * Usage: file_time <filename> <atime|mtime|ctime> <sec|nsec>
> > + */
> > +int main(int argc, char *argv[])
> > +{
> > +    time_t t;
>
> Is this program going to fail on 32-bit systems?
>
> > +    struct stat st;
> > +
> > +    if (argc !=3D 4) {
> > +        fprintf(stderr, "Wrong argument num!\n");
> > +        return 1;
> > +    }
> > +
> > +    if (stat(argv[1], &st) !=3D 0) {
> > +        perror("stat failed");
> > +        return 1;
> > +    }
> > +
> > +    if (strcmp(argv[3], "sec") =3D=3D 0) {
> > +        if (strcmp(argv[2], "atime") =3D=3D 0)
> > +            t =3D st.st_atime;
> > +        else if (strcmp(argv[2], "mtime") =3D=3D 0)
> > +            t =3D st.st_mtime;
> > +        else
> > +            t =3D st.st_ctime;
> > +    } else if (strcmp(argv[3], "nsec") =3D=3D 0) {
> > +        if (strcmp(argv[2], "atime") =3D=3D 0)
> > +            t =3D st.st_atim.tv_nsec;
> > +        else if (strcmp(argv[2], "mtime") =3D=3D 0)
> > +            t =3D st.st_mtim.tv_nsec;
> > +        else
> > +            t =3D st.st_ctim.tv_nsec;
> > +    } else {
> > +        fprintf(stderr, "Wrong argument: %s\n", argv[3]);
> > +        return 1;
> > +    }
> > +
> > +    printf("%lu\n", t);
> > +
> > +    return 0;
> > +}
> > diff --git a/tests/ext4/043 b/tests/ext4/043
> > new file mode 100755
> > index 00000000..b6e5df9f
> > --- /dev/null
> > +++ b/tests/ext4/043
> > @@ -0,0 +1,64 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 043
> > +#
> > +# Transfer from ltp/testcases/kernel/fs/ext4-new-features/ext4_nsec_ti=
mestamps
> > +# Test file timestamps is second with 128 inode size
>
> (Huh?)
>
> OH, "Test file timestamps are only precise to seconds with 128-byte inode=
s."
>
> > +#
> > +seq=3D`basename $0`
> > +seqres=3D$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +tmp=3D/tmp/$$
> > +status=3D1    # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +    cd /
> > +    rm -f $tmp.*
> > +    _scratch_cleanup_files
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs ext3 ext4
> > +_supported_os Linux
> > +
> > +_require_scratch
> > +_require_test_program "t_ext4_file_time"
> > +_require_command "$TUNE2FS_PROG" tune2fs
> > +
> > +echo "Silence is golden"
> > +
> > +echo "Start test timestamps with 128 inode size one device
> > $SCRATCH_DEV" >$seqres.full
> > +_scratch_mkfs_ext4 -I 128 >> $seqres.full 2>&1
> > +tune2fs -O extents $SCRATCH_DEV >>$seqres.full 2>&1
>
> $TUNE2FS_PROG
>
> Also, why turn on extents?
>
> > +_scratch_mount
> > +
> > +touch "${SCRATCH_MNT}/tmp_file"
> > +
> > +atime=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime nsec`
> > +mtime=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime nsec`
> > +ctime=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime nsec`
> > +
> > +if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
> > +        echo "Timestamp is not second(atime: $atime, mtime: $mtime,
> > ctime: $ctime)" >> $seqres.full
>
> OH, this test checks for nonzero value in the nsec fields when ext4
> doesn't support the extended timestamp fields.
>
> > +        _scratch_unmount >> $seqres.full 2>&1
>
> No need to unmount at the end of the test; fstests will do that for you.
> For that matter all you need here is:
>
> if [ $atime -ne 0 .... ]; then
>         echo "nsec should be zero when extended timestamps are disabled"
>         echo "atime: $atime..."
> fi
>
> Without any of the "_scratch_unmount" or "exit".  If we fail the if test
> and emit the message, the change in golden output will be sufficient for
> fstests to mark the test failed.
>
> > +        exit
> > +fi
> > +echo "Ext4 nanosecond timestamps test with 128 inode size pass" >> $se=
qres.full
> > +_scratch_unmount >> $seqres.full 2>&1
> > +
> > +# no BUG_ON, all done
>
> BUG_ON?  What are you talking about?  Is there a fix commit that goes
> with this?
>
> Also, if this will crash recent kernels then this should be in the
> dangerous group, not auto.
>
> > +status=3D0
> > +exit
> > diff --git a/tests/ext4/043.out b/tests/ext4/043.out
> > new file mode 100644
> > index 00000000..f90f0a57
> > --- /dev/null
> > +++ b/tests/ext4/043.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 043
> > +Silence is golden
> > diff --git a/tests/ext4/044 b/tests/ext4/044
> > new file mode 100755
> > index 00000000..3e899f5a
> > --- /dev/null
> > +++ b/tests/ext4/044
> > @@ -0,0 +1,112 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 044
> > +#
> > +# Transfer from ltp/testcases/kernel/fs/ext4-new-features/ext4_nsec_ti=
mestamps
> > +# Test file timestamps is nanosecond with 256 inode size
>
> "Test file timestamps are precise to nanoseconds with 256-byte inodes."
>
> > +#
> > +seq=3D`basename $0`
> > +seqres=3D$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +tmp=3D/tmp/$$
> > +status=3D1    # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +    cd /
> > +    rm -f $tmp.*
> > +    _scratch_cleanup_files
>
> Don't bother erasing the scratch fs files, the next _scratch_mkfs will
> do that for you.
>
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
>
> I don't think we need filter here...?
>
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs ext3 ext4
> > +_supported_os Linux
> > +_require_scratch
> > +_require_test_program "t_ext4_file_time"
> > +
> > +echo "Silence is golden"
> > +
> > +echo "Test timestamps with 256 inode size one device $SCRATCH_DEV"
> > >$seqres.full
> > +_scratch_mkfs_ext4 -t ext3 -I 256 >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Create file
> > +touch "${SCRATCH_MNT}/tmp_file"
> > +sleep 1
> > +
> > +# Change atime, ctime and mtime of the file
> > +touch "${SCRATCH_MNT}/tmp_file"
> > +
> > +cur_time=3D`date '+%s %N'`
> > +sec=3D`echo $cur_time | awk {'print $1'}`
> > +nsec=3D`echo $cur_time | awk {'print $2'}`
> > +
> > +sec_atime=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime se=
c`
> > +sec_mtime=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime se=
c`
> > +sec_ctime=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime se=
c`
> > +nsec_atime=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime n=
sec`
> > +nsec_mtime=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime n=
sec`
> > +nsec_ctime=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime n=
sec`
> > +
> > +# Test nanosecond
> > +if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]; th=
en
> > +        echo "The timestamp is not nanosecond(nsec_atime: $nsec_atime,=
 \
> > +              nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime)" >>
> > $seqres.full
> > +        _scratch_unmount >> $seqres.full 2>&1
> > +        exit
> > +fi
> > +
> > +diff1=3D$(( $sec_atime - $sec ))
> > +diff2=3D$(( $sec_mtime - $sec ))
> > +diff3=3D$(( $sec_ctime - $sec ))
> > +
> > +# Test difference between file time and current time
> > +if [ $diff1 -gt 1 -o $diff2 -gt 1 -o $diff2 -gt 1 ]; then
> > +        echo "The timestamp is wrong, it must be earlier than the
> > current time we got. \
> > +             (sec_atime: $sec_atime, sec_mtime: $sec_mtime,
> > sec_ctime: $sec_ctime, \
> > +             cur_time[s]: $sec)" >> $seqres.full
> > +        _scratch_unmount >> $seqres.full 2>&1
> > +        exit
> > +fi
> > +_scratch_unmount >> $seqres.full 2>&1
> > +
> > +# Test mount to ext3 and then mount back to ext4
> > +mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
>
> Hm... what /is/ the rule about changing filesystem types?  Do we just
> open-code _try_scratch_mount to force ext3 here?
>
> _mount -t ext3 `_scratch_mount_options $*` || _fail "ext3 mount failed"
>
> > +if [ $? -ne 0 ]; then
> > +        echo "$SCRATCH_DEV fail in mounting to ext3" >> $seqres.full
> > +        _scratch_unmount >> $seqres.full 2>&1
> > +        exit
> > +fi
> > +_scratch_unmount >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +nsec_atime2=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file atime =
nsec`
> > +nsec_mtime2=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file mtime =
nsec`
> > +nsec_ctime2=3D`$here/src/t_ext4_file_time $SCRATCH_MNT/tmp_file ctime =
nsec`
> > +
> > +if [ $nsec_atime -ne $nsec_atime2 -o $nsec_ctime -ne $nsec_ctime2 -o \
> > +     $nsec_mtime -ne $nsec_mtime2 ]; then
> > +        echo "File nanosecond timestamp has changed \
> > +                        unexpected. Before[atime mtime ctime]: $nsec_a=
time \
> > +                        nsec_mtime $nsec_ctime, After[atime mtime ctim=
e]: \
> > +                        $nsec_atime2 $nsec_mtime2 $nsec_ctime2)" >>
> > $seqres.full
> > +        _scratch_unmount >> $seqres.full 2>&1
> > +        exit
>
> If you really want to bail out early, do it with _fail, i.e.
>
> _fail "File nanosecond timestamp has changed..."
>
> Please consider doing all these checks individually, not in one huge if
> statement.
>
> > +fi
> > +_scratch_unmount >> $seqres.full 2>&1
> > +
> > +# no BUG_ON, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/ext4/044.out b/tests/ext4/044.out
> > new file mode 100644
> > index 00000000..12a61dc4
> > --- /dev/null
> > +++ b/tests/ext4/044.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 044
> > +Silence is golden
> > diff --git a/tests/ext4/045 b/tests/ext4/045
> > new file mode 100755
> > index 00000000..c70baa97
> > --- /dev/null
> > +++ b/tests/ext4/045
> > @@ -0,0 +1,148 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test No. 045
> > +#
> > +# Transfer from
> > ltp/testcases/kernel/fs/ext4-new-features/ext4_subdir_limit_test
> > +#
> > +# Test subdirectory limit of ext4.
> > +# We create more than 32000 subdirectorys on the ext4 filesystem.
>
> "subdirectories"
>
> > +#
> > +seq=3D`basename $0`
> > +seqres=3D$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +tmp=3D/tmp/$$
> > +status=3D1    # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +SHORT_DIR=3D1
> > +LONG_DIR=3D2
> > +FAIL=3D1
> > +PASS=3D0
> > +prev_block_size=3D0
> > +prev_result=3D$FAIL
> > +
> > +_cleanup()
> > +{
> > +    cd /
> > +    rm -f $tmp.*
> > +    _scratch_cleanup_files
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs ext4
> > +_supported_os Linux
> > +
> > +_require_scratch
> > +_require_test_program "t_create_short_dirs"
> > +_require_test_program "t_create_long_dirs"
> > +_require_command "$TUNE2FS_PROG" tune2fs
> > +_require_command "$E2FSCK_PROG" e2fsck
> > +_require_dumpe2fs
> > +
> > +echo "Silence is golden"
> > +
> > +# Run a test case
> > +# $1: Number of directories to create
> > +# $2: create short dir or long dir
> > +# $3: parent directory
> > +# $4: filesystem block size
> > +_workout()
>
> Local functions should not be prefixed with "_"; those are reserved for
> common/ library functions.
>
> > +{
> > +    local dir_name_len=3D
> > +    if [ $2 -eq $SHORT_DIR ]; then
> > +        dir_name_len=3D"short name"
> > +    else
> > +        dir_name_len=3D"long name"
> > +    fi
> > +
> > +    echo "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
> > +          "Parent dir: $3, Block size: $4" >> $seqres.full 2>&1
> > +
> > +    # Only mkfs if block size has been changed, or previous case faile=
d
> > +    if [ $prev_result -ne $PASS -o $4 -ne $prev_block_size ]; then
> > +        $MKFS_EXT4_PROG -F -b $4 -I 256 $SCRATCH_DEV >> $seqres.full 2=
>&1
>
> _scratch_mkfs -b $4 -I 256 ?
>
> > +        prev_block_size=3D$4
> > +        tune2fs -O extents $SCRATCH_DEV >> $seqres.full 2>&1
>
> $TUNE2FS_PROG, do not call tune2fs directly.
>
> Also, why don't you just format the fs with extents turned on in the
> first place?
>
> > +    fi
> > +    prev_result=3D$FAIL
> > +
> > +    _scratch_mount
> > +
> > +    # create directories
> > +    mkdir -p $3 2> /dev/null
> > +
> > +    if [ $2 -eq $SHORT_DIR ]; then
> > +        $here/src/t_create_short_dirs $1 $3
> > +    else
> > +        $here/src/t_create_long_dirs $1 $3
> > +    fi
> > +
> > +    if [ $? -ne 0 ]; then
> > +        nr_dirs=3D`ls $3 | wc -l`
> > +        echo "Failed to create directories - $nr_dirs"
> > +        _scratch_unmount
> > +        return
> > +    fi
> > +
> > +    # delete directories
> > +    cd $3
> > +    ls | xargs rmdir
> > +    if [ $? -ne 0 ]; then
> > +        echo "Failed to remove directories in $3"
> > +        cd - > /dev/null
> > +        _scratch_unmount
> > +        return
> > +    fi
> > +    cd - > /dev/null
> > +    _scratch_unmount
> > +
> > +    # check dir_nlink is set
> > +    dumpe2fs $SCRATCH_DEV 2> /dev/null | grep '^Filesystem features'
>
> $DUMPE2FS_PROG
>
> > | grep -q dir_nlink
> > +    if [ $? -ne 0 ]; then
> > +        echo "Feature dir_nlink is not set, please check $seqres.full
> > for detail"
> > +        return
> > +    fi
> > +
> > +    # run fsck to make sure the filesystem has no errors
> > +    $E2FSCK_PROG -fy $SCRATCH_DEV >> $seqres.full 2>&1
> > +    if [ $? -ne 0 ]; then
> > +        echo "fsck: the filesystem has errors, please check
> > $seqres.full for detail"
>
> _check_scratch_fs?
>
> > +        return
> > +    fi
> > +
> > +    prev_result=3D$PASS
> > +}
> > +
> > +# main
> > +DIR_LEN=3D( $SHORT_DIR $LONG_DIR )
> > +PARENT_DIR=3D( "$SCRATCH_MNT" "$SCRATCH_MNT/sub" )
> > +BLOCK_SIZE=3D( 1024 2048 4096 )
> > +
> > +for ((i =3D 0; i < 3; i++)); do
> > +    for ((j =3D 0; j < 2; j++)); do
> > +        for ((k =3D 0; k < 2; k++)); do
> > +            if [ ${DIR_LEN[$k]} -eq $LONG_DIR -a \
> > +                    ${BLOCK_SIZE[$i]} -eq 1024 ]; then
> > +                continue
> > +            fi
> > +            _workout 65537 ${DIR_LEN[$k]} ${PARENT_DIR[$j]} ${BLOCK_SI=
ZE[$i]}
> > +        done
> > +    done
> > +done
> > +
> > +_scratch_unmount >> $seqres.full 2>&1
> > +
> > +# no BUG_ON, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/ext4/045.out b/tests/ext4/045.out
> > new file mode 100644
> > index 00000000..66276cfa
> > --- /dev/null
> > +++ b/tests/ext4/045.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 045
> > +Silence is golden
> > diff --git a/tests/ext4/group b/tests/ext4/group
> > index 9dfc0d35..8419cdea 100644
> > --- a/tests/ext4/group
> > +++ b/tests/ext4/group
> > @@ -45,6 +45,9 @@
> >  040 dangerous_fuzzers
> >  041 dangerous_fuzzers
> >  042 auto quick
> > +043 auto quick
> > +044 auto quick
> > +045 auto
>
> "dir" group too?
>
> --D
>
> >  271 auto rw quick
> >  301 aio auto ioctl rw stress defrag
> >  302 aio auto ioctl rw stress defrag
