Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1103385BC
	for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308643; cv=pass; b=OzyHOc8kGWHVwSUlzMoHqSERrsyf+nslEwd6Z+4SRhKVo1RpkdB9XHy5U3sTH5dgpc4R1UwE6smPNhAMBawT7WM5zVj3omolqAckVFA0NfXIdqwPx6jWuvQ51A9J5ztVz1flJgGOQNEMShSupSdbMzgpB8gGufuZsg0/MdzxSZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308643; c=relaxed/simple;
	bh=WGtScifobNSYGbJcRmFzquiAfwsnUoYT3UZ2y226DLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LPkGfWGmf6Ec/xWePUTMwTBj//GS/Jngq3EmTi8bJG4ZaUqvpXdzBZhSJlbdyz/UCCp7DYv9WhdtsOEnx+TjgTsGbi/9UzWnrgHCpbx8cX7e+jxearH+gm4f5I6muFq1rnJn3P2+VqkBsHreCQny4F3HcdQrL94Y/bqh9l5O01g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy96bRSL; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy96bRSL"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2b2c9eccso61971191cf.2
        for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 10:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784308640; cv=none;
        d=google.com; s=arc-20260327;
        b=dmTAjaX6I+nbwdapgGbCxzh4VP/RZHa7trMtu2T+HI85Cjr3dxNJlvl1+YD+XkZjgf
         CM74iJJUSkOOsuFBGCUWn5y/MOyvmhwCO3vsOk0CjwELdBBgLT2w9IS5TsWq32lDshPV
         SE3fVI3ygsWkp9JhnfDSxc3SEHwox+z7SQ/QnygdT4Ma4VcIB9pkuKQGoHvLAPNOlliX
         MiaBYpDehLRXo/dknjcZqy1PEB3uuuh11xIXZGCMwIl3BytWp0jNZ6eBv/sUfd1DOCRY
         Lunkw/pg5Q6mhIfzpN9ew/7m4mA0Nwhup7LPKOIprFDychf/Bmj++wyHf4GIwbgM7ins
         HT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKcKSE1S0PBSSU2cHQyRxB3gDdNA0xeiL5p97feeUIM=;
        fh=fvw09PKoZe2NimKFJVT6V71UFugyaGJcw76PXn7qdtk=;
        b=Kg1ve7GWuPFSbkjk8tOhNMrEZ1tAXr+wwiYgcaac+ifkEW4rWjqt0cFGN/0s8D4+88
         U8M9zqjsx175FdN+k759h6nx/KXiy8iTZHuWfmYy+Vts58De036Q8jLDY+NaSRtmcs1K
         MbgH+aYxIxyQIbJGXIrCBsaAOtQsytz6mM84qGitzsHZJrj2f55fynzqD/a0GyQHdx5F
         W+y6CeEmpCx/7E71icGlPq16rTHzLaa8C9FM9NAnr/nOAAtga2BuxfpNez3DKeihkkxl
         2uHqPMPgrMMemdvqIEZJlL4hvaiyeJA36CeZ8VbNeWUT9iQNk5VKjCam6sEC6cSZS56S
         QCFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784308640; x=1784913440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKcKSE1S0PBSSU2cHQyRxB3gDdNA0xeiL5p97feeUIM=;
        b=Cy96bRSL+huB/VOogwdPWDJcm4sUK7MKdWoza/7ETPTf5tvNPwB6Dfd8+XnKbVTd0n
         mpnbuUELPC0sBh5ntdDZGjPuoN07QsTUl/em0j+NojxjI9D+3UfilbpQsf4OfokxLgmd
         2lg8zMA4je/9Ocix07JQOVjrW683eqRrlTWlBKOba0eegc47f4AQkfpgtwMC+omESeOs
         Z7TqnWye32CFGS3bI6TlJfGpvqD8UWbN9odjslrySu8xj43CSevNPosC02Aui+cx8oJo
         8kC3hFHlOKV0yOuiRNyQs2dh7WbAwpHTJCYtnW5Uhpylp6j9rrvp6LNKKnPMC/34kTru
         I/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784308640; x=1784913440;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oKcKSE1S0PBSSU2cHQyRxB3gDdNA0xeiL5p97feeUIM=;
        b=LlLmyDU3PcUPCu1d6ngZ3JK2gbIKfGBuLiQ9baqfsIVCogfqdbd2nbw3aBhyBbX7Jh
         Poy58PoSkFmm4orlc5h2LYq48DdSKMn2HEqjRRVAVxne8kC4wf455/VDEjorLPwdtevP
         GWAUasVQTQHPgBHUz1GOdhs6j5aSJUtpxr72sn1ArsVXyGDF481QRtPUvlYclwOHeTp0
         LYHbiruOYOgZe9kITkLpttWcAiTn8oVSsZ5jiMvL4Ycb5mh+gaq6WRogrTSpdsT2+U/Z
         fnp/dy6W7EEVj2O61cvGstVZWYQffqac8GpfNePIEMAkBb8B0OlorgijkdWXz3nvDzJh
         Ss7g==
X-Forwarded-Encrypted: i=1; AHgh+RodQVzN2kjqPzAr9LgUAdUBx6Sbzk/0TiJZzqoEkET0LZeXE+s+1TMfv+63hWBx2CB6aOzJQJEG@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwEU3r2iAg+PA/QeRnkwuGyB5UMmEa+HqzSy6wgNOF5bJM1ah
	g+hU7VLoDbg4VWtiNIzHj7/saGNAdPkJsbhY8PwnMyvlRciftMu3UXVHddtTrVOMfrha2hAEud6
	QyVcVUgZbD0y2XlVf4efcR1lRGZladC1dUg9l3Ls=
X-Gm-Gg: AfdE7ckd1rXikeUnB7H2cPNHrUmBZGyTD4nhkPYRRqHNBABW/Wn/kni/F4v9HYQmet9
	XN6njEnt+KbXrt6fQzvDcW6/kccvE9enmc5AVdWO0unfrF27341oLUCxupRt35tkxyNNAkLY1mn
	9/i+0k+Eq347BCez68MUzIDbdSnRI6iPZT9a4T5YSFuXg1doblAkUKbxL0Gcdv6SJD9ggQbzt8t
	dIiWRuKEJRLErYFCf/LBWqW8G3oIbg7ywEFvKr+mK98LD6c+smXL91CHsGgk1f4zVlTrNrp/F7t
	4i4l8v0rS58c9CtqrlTNUnQyesaJS6LvDIemQVWNHbHr5Br49XQM4+hVjEOfCxTKgJ34Dlenxtj
	etsUHhH5mTCEjIycparMyIagspSH84Iyasc7TFy3C4vgnwtu5xVvWsE7BcaxHYLedCzgidRjG/r
	/h
X-Received: by 2002:a05:620a:470a:b0:92e:da7b:561b with SMTP id
 af79cd13be357-930b3e8b036mr399399585a.19.1784308639735; Fri, 17 Jul 2026
 10:17:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713151658.533155-1-chenxiaosong@chenxiaosong.com> <alpZg9nrDzS3T9cL@zlang-mailbox>
In-Reply-To: <alpZg9nrDzS3T9cL@zlang-mailbox>
From: Steve French <smfrench@gmail.com>
Date: Fri, 17 Jul 2026 12:17:07 -0500
X-Gm-Features: AUfX_myY8PBjAgM0NHJiAcGwmRFZJGcmMrWMEdMkaA4KjKTEjE4YmeN-nqHEigU
Message-ID: <CAH2r5mss5uBDy11eNs4fGpQ4c5UVFH6xRmg0RfGknMasDw1hMw@mail.gmail.com>
Subject: Re: [PATCH] cifs/002: check nlink returned by fstat()
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>, lukas@herbolt.com, smfrench@gmail.com, 
	linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	senozhatsky@chromium.org, dhowells@redhat.com, metze@samba.org, 
	linux-cifs@vger.kernel.org, fstests@vger.kernel.org, 
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 12:07=E2=80=AFPM Zorro Lang <zlang@kernel.org> wrot=
e:
>
> On Mon, Jul 13, 2026 at 03:16:58PM +0000, ChenXiaoSong wrote:
> > From: ChenXiaoSong <chenxiaosong@kylinos.cn>
> >
> > Add a CIFS test to verify that fstat(2) returns the expected
> > st_nlink value as hardlinks are created and removed.
> >
> > Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> > ---
>
> Wow, a new CIFS test case :)

This probably makes more sense as a generic test rather than cifs test
since it doesn't have anything cifs specific.
There are some additional cifs tests that could be added though.
Bharath has a git tree with some of the cifs specific
tests that could be added to the official repo:
https://github.com/bharathsm-ms/xfstests-dev



> >  src/Makefile       |   2 +-
> >  src/fstat.c        | 200 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/cifs/002     |  62 ++++++++++++++
> >  tests/cifs/002.out |   2 +
> >  4 files changed, 265 insertions(+), 1 deletion(-)
> >  create mode 100644 src/fstat.c
> >  create mode 100755 tests/cifs/002
> >  create mode 100644 tests/cifs/002.out
> >
> > diff --git a/src/Makefile b/src/Makefile
> > index 31ac43b2..b0886279 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -6,7 +6,7 @@
> >  TOPDIR =3D ..
> >  include $(TOPDIR)/include/builddefs
> >
> > -TARGETS =3D dirstress fill fill2 getpagesize holes lstat64 \
> > +TARGETS =3D dirstress fill fill2 getpagesize holes lstat64 fstat \
> >       nametest permname randholes runas truncfile usemem \
> >       mmapcat append_reader append_writer dirperf metaperf \
> >       devzero feature alloc fault fstest t_access_root \
> > diff --git a/src/fstat.c b/src/fstat.c
> > new file mode 100644
> > index 00000000..59221186
> > --- /dev/null
> > +++ b/src/fstat.c
> > @@ -0,0 +1,200 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2026 KylinSoft Co., Ltd. All rights reserved.
> > + * Author(s): ChenXiaoSong <chenxiaosong@kylinos.cn>
> > + *
> > + *  from
> > + *  src/lstat64.c
> > + *  Copyright (c) 2000-2002 Silicon Graphics, Inc.
> > + *  All Rights Reserved.
> > + */
> > +
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <time.h>
> > +#include <sys/stat.h>
> > +#include <sys/sysmacros.h>
> > +
> > +long timebuf;
> > +
> > +void
> > +timesince(long timesec)
> > +{
> > +     long    d_since;        /* days */
> > +     long    h_since;        /* hours */
> > +     long    m_since;        /* minutes */
> > +     long    s_since;        /* seconds */
> > +
> > +     s_since =3D timebuf - timesec;
> > +     d_since =3D s_since / 86400l ;
> > +     s_since -=3D d_since * 86400l ;
> > +     h_since =3D s_since / 3600l ;
> > +     s_since -=3D h_since * 3600l ;
> > +     m_since =3D s_since / 60l ;
> > +     s_since -=3D m_since * 60l ;
> > +
> > +     printf("(%05ld.%02ld:%02ld:%02ld)\n",
> > +                     d_since, h_since, m_since, s_since);
> > +}
> > +
> > +void
> > +usage(void)
> > +{
> > +     fprintf(stderr, "Usage: fstat [-t] filename ...\n");
> > +     exit(1);
> > +}
> > +
> > +int
> > +main(int argc, char **argv)
> > +{
> > +     struct stat     sbuf;
> > +     int             i, c;
> > +     int             terse_flag =3D 0;
> > +
> > +     while ((c =3D getopt(argc, argv, "t")) !=3D EOF) {
> > +             switch (c) {
> > +                     case 't':
> > +                             terse_flag =3D 1;
> > +                             break;
> > +
> > +                     case '?':
> > +                             usage();
> > +             }
> > +     }
> > +     if (optind =3D=3D argc) {
> > +             usage();
> > +     }
> > +
> > +     time(&timebuf);
> > +
> > +     for (i =3D optind; i < argc; i++) {
> > +             char mode[] =3D "----------";
> > +             int fd;
> > +
> > +             fd =3D open(argv[i], O_RDONLY | O_NONBLOCK);
> > +             if (fd < 0) {
> > +                     perror(argv[i]);
> > +                     continue;
> > +             }
> > +
> > +             if (fstat(fd, &sbuf) < 0) {
> > +                     perror(argv[i]);
> > +                     close(fd);
> > +                     continue;
> > +             }
> > +
> > +             if (terse_flag) {
> > +                     printf("%s %llu ", argv[i], (unsigned long long)s=
buf.st_size);
> > +             }
> > +             else {
> > +                     printf("  File: \"%s\"\n", argv[i]);
> > +                     printf("  Size: %-10llu", (unsigned long long)sbu=
f.st_size);
> > +             }
> > +
> > +             if (sbuf.st_mode & S_IXOTH)
> > +                     mode[9] =3D 'x';
> > +             if (sbuf.st_mode & S_IWOTH)
> > +                     mode[8] =3D 'w';
> > +             if (sbuf.st_mode & S_IROTH)
> > +                     mode[7] =3D 'r';
> > +             if (sbuf.st_mode & S_IXGRP)
> > +                     mode[6] =3D 'x';
> > +             if (sbuf.st_mode & S_IWGRP)
> > +                     mode[5] =3D 'w';
> > +             if (sbuf.st_mode & S_IRGRP)
> > +                     mode[4] =3D 'r';
> > +             if (sbuf.st_mode & S_IXUSR)
> > +                     mode[3] =3D 'x';
> > +             if (sbuf.st_mode & S_IWUSR)
> > +                     mode[2] =3D 'w';
> > +             if (sbuf.st_mode & S_IRUSR)
> > +                     mode[1] =3D 'r';
> > +             if (sbuf.st_mode & S_ISVTX)
> > +                     mode[9] =3D 't';
> > +             if (sbuf.st_mode & S_ISGID)
> > +                     mode[6] =3D 's';
> > +             if (sbuf.st_mode & S_ISUID)
> > +                     mode[3] =3D 's';
> > +
> > +             if (!terse_flag)
> > +                     printf("   Filetype: ");
> > +             switch (sbuf.st_mode & S_IFMT) {
> > +             case S_IFSOCK:
> > +                     if (!terse_flag)
> > +                             puts("Socket");
> > +                     mode[0] =3D 's';
> > +                     break;
> > +             case S_IFDIR:
> > +                     if (!terse_flag)
> > +                             puts("Directory");
> > +                     mode[0] =3D 'd';
> > +                     break;
> > +             case S_IFCHR:
> > +                     if (!terse_flag)
> > +                             puts("Character Device");
> > +                     mode[0] =3D 'c';
> > +                     break;
> > +             case S_IFBLK:
> > +                     if (!terse_flag)
> > +                             puts("Block Device");
> > +                     mode[0] =3D 'b';
> > +                     break;
> > +             case S_IFREG:
> > +                     if (!terse_flag)
> > +                             puts("Regular File");
> > +                     mode[0] =3D '-';
> > +                     break;
> > +             case S_IFLNK:
> > +                     if (!terse_flag)
> > +                             puts("Symbolic Link");
> > +                     mode[0] =3D 'l';
> > +                     break;
> > +             case S_IFIFO:
> > +                     if (!terse_flag)
> > +                             puts("Fifo File");
> > +                     mode[0] =3D 'f';
> > +                     break;
> > +             default:
> > +                     if (!terse_flag)
> > +                             puts("Unknown");
> > +                     mode[0] =3D '?';
> > +             }
> > +
> > +             if (terse_flag) {
> > +                     printf("%s %d,%d\n", mode, (int)sbuf.st_uid, (int=
)sbuf.st_gid);
> > +                     close(fd);
> > +                     continue;
> > +             }
> > +
> > +             printf("  Mode: (%04o/%s)", (unsigned int)(sbuf.st_mode &=
 07777), mode);
> > +             printf("         Uid: (%d)", (int)sbuf.st_uid);
> > +             printf("  Gid: (%d)\n", (int)sbuf.st_gid);
> > +             printf("Device: %2d,%-2d", major(sbuf.st_dev),
> > +                             minor(sbuf.st_dev));
> > +             printf("  Inode: %-9llu", (unsigned long long)sbuf.st_ino=
);
> > +             printf(" Links: %-5ld", (long)sbuf.st_nlink);
> > +
> > +             if ( ((sbuf.st_mode & S_IFMT) =3D=3D S_IFCHR)
> > +                 || ((sbuf.st_mode & S_IFMT) =3D=3D S_IFBLK) )
> > +                     printf("     Device type: %2d,%-2d\n",
> > +                             major(sbuf.st_rdev), minor(sbuf.st_rdev))=
;
> > +             else
> > +                     printf("\n");
> > +
> > +             printf("Access: %.24s",ctime(&sbuf.st_atime));
> > +             timesince(sbuf.st_atime);
> > +             printf("Modify: %.24s",ctime(&sbuf.st_mtime));
> > +             timesince(sbuf.st_mtime);
> > +             printf("Change: %.24s",ctime(&sbuf.st_ctime));
> > +             timesince(sbuf.st_ctime);
> > +
> > +             if (i+1 < argc)
> > +                     printf("\n");
> > +
> > +             close(fd);
> > +     }
> > +     exit(0);
> > +}
> > diff --git a/tests/cifs/002 b/tests/cifs/002
> > new file mode 100755
> > index 00000000..5f1eaffc
> > --- /dev/null
> > +++ b/tests/cifs/002
> > @@ -0,0 +1,62 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2026 KylinSoft Co., Ltd. All rights reserved.
> > +# Author(s): ChenXiaoSong <chenxiaosong@kylinos.cn>
> > +#
> > +# FS QA Test No. cifs/002
>
> Although we are considering removing this specific line in the future, it=
 is
> currently still required to follow the standard format. Therefore, it sho=
uld
> be formatted as: FS QA Test 002
>
> > +#
> > +# Check that fstat(2) returns the correct hard link count for a regula=
r file.
> > +# Regression test for kernel commit:
> > +# 9dd1964ac59d ("smb/client: fix incorrect nlink returned by fstat()")
> > +#
> > +#  from
> > +#  tests/generic/002
>
> The original test case is a generic test case, this one looks similar, do=
esn't
> has any cifs specific test steps. So I think this can be a generic test c=
ase too
>
> > +#  Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved=
.
> > +#
> > +. ./common/preamble
> > +_begin_fstest metadata auto quick
>
> I think it also belong to "hardlink" group.
>
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +     rm -f $tmp.*
> > +     rm -rf $TEST_DIR/$$
>
>         cd /
>         rm -r -f $tmp.*
>         [ -d "$testdir" ] && rm -rf $testdir
>
> > +}
> > +
> > +status=3D0     # success is the default!
> > +
> > +_require_test
> > +_require_hardlinks
> > +_require_test_program fstat
>
> _fixed_by_fs_commit cifs 9dd1964ac59d \
>         "smb/client: fix incorrect nlink returned by fstat()"
>
> > +
> > +echo "Silence is goodness ..."
>
> If no specical reason, please keep the "Silence is golden".
>
> > +
> > +testdir=3D$TEST_DIR/$$
> > +mkdir -p $testdir
> > +
> > +touch $testdir/tmp.1
> > +for l in 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
> > +do
>
> for l in $(seq 2 20);do
>
> or
>
> for ((l=3D2; l<=3D20; l++))
>
> > +     ln $testdir/tmp.1 $testdir/tmp.$l
> > +     x=3D`$here/src/fstat $testdir/tmp.1 | sed -n -e '/ Links: /s/.*Li=
nks: *//p'`
>
> I'm wondering if a specific src/fstat.c is needed. Can we replace the who=
le
> src/fstat.c with `xfs_io -c stat ` ? Can you give it a try?
>
> > +     if [ "$l" -ne $x ]
> > +     then
>
> if [ "$l" -ne $x ];then
>
> > +             echo "Arrgh, created link #$l and fstat looks like ..."
> > +             $here/src/fstat $testdir/tmp.1
> > +             status=3D1
> > +     fi
> > +done
> > +
> > +for l in 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
> > +do
>
> for l in $(seq 20 -1 1);do
>
> or
>
> for ((l=3D20; l>=3D1; l--))
>
> > +     x=3D`$here/src/fstat $testdir/tmp.1 | sed -n -e '/ Links: /s/.*Li=
nks: *//p'`
> > +     if [ "$l" -ne $x ]
> > +     then
> > +             echo "Arrgh, about to remove link #$l and fstat looks lik=
e ..."
> > +             $here/src/fstat $testdir/tmp.1
> > +             status=3D1
> > +     fi
> > +     rm -f $testdir/tmp.$l
> > +done
> > +
> > +exit
>
> _exit 0
>
> Thanks,
> Zorro
>
> > diff --git a/tests/cifs/002.out b/tests/cifs/002.out
> > new file mode 100644
> > index 00000000..11426b54
> > --- /dev/null
> > +++ b/tests/cifs/002.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 002
> > +Silence is goodness ...
> > --
> > 2.43.0
> >
> >



--=20
Thanks,

Steve
