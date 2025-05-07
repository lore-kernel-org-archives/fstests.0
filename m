Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D707263D
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646128; cv=none; b=YiS7C6UuzRsOMi4bNdZsyGUfh3r2s8rP2jecysvD+eI+Oh0hpKF7HPUSy7dpZPV6peljO3kcYlKw4siztJtzhKIEpdEMm1c3tYk6Mq0cMfHBTVai7Rl37sleINV1X/qOdH2BWCrKaIufvIridKRAH5fFczTOW1AKzuIsXf54skQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646128; c=relaxed/simple;
	bh=0vhJzVS/YjW/+YHPRWICRWG6763NSWBcnMwJtfpl2pw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=En0NBP76XaR8WZNFQMv07UrAQzXY5g++ZtaGjuVCMMRi8v6GUjiqeHGQXPS3jWpbUtqUt2T/Jmu5fVlHDegLZZSncnLx8Fud8lhTMN2vB2HWvkDnO/R74yJt/8DHS0fGRWO4XGCq3GtDTdY9n1cvot7ZHDbYult8qsO6rBiD8aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/EgnbDE; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/EgnbDE"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so64931241.2
        for <fstests@vger.kernel.org>; Wed, 07 May 2025 12:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746646126; x=1747250926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI5e2s/ZqBLSFNyrrFhzwS6FBaHtvh3ICndpotrAyzY=;
        b=M/EgnbDEbRZC27XXqnU+9mM1M68T6vTPnVpikO3rL3LtMnsJBOHju5TCoLbLqAMpwf
         8go0HYjnX6M8ZRRR6PXMm2g93TbYeIZbLsC3Q2RtmTzauPKJSk3Yff5EUPBA5I7mnnkr
         I02kV+dz00l9MZPuhi9/2Iqc1eLD2bBt3paorTKVkfh7mv0GUgI6Xkx9WXGwSbUyr1gk
         a7MEeJCEieMkZuA7kjEOkfgmS3mb6aoUCGyy/Oqi8dGRKvWc6yen9meyO0tk//ZWhCkB
         giFPGEs9XLcmThijx+7Ex76pYnycrMQpE6Tj1h0CHKfMvLSyFbWw+Q0aEDe/uMi2+vd3
         acKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746646126; x=1747250926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI5e2s/ZqBLSFNyrrFhzwS6FBaHtvh3ICndpotrAyzY=;
        b=tSMhYSkv77JVcZYUzyzp/x+o13E4cyXTrpWjkGNXo23f7BCTwGonfadds/ZkSHxnuu
         K6DgHlzMRVVhj9Q55W1/tziH6dAwpp0Y3hN5yMwl2DnJw+fbpldntSCCB3RnnKrG1PH3
         ubfCNFcl2Q5Zw4fpALNUbLteb6g3/RcgfMlOjX9d91y6OgvVnJRkc1p0Pd6Ec47/c7AJ
         7ZpQpz+X2sPk8DijpELG+mvbQAf9lhS0WT4zmEtRY0QKA0VuOB27o0v3tyjJXv2SUfmD
         s/jNYBUiD4qW9wGGU672q/JvklJ5uytBPIE8Y2SG3N4O9bRmY5W+4jkruqT2VtgEnzgb
         cS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1Xfx+65SUkGSonS+slvQ+pyHv6l1Sf8YZWvzseX7CQpf3dLZVSkpddED0Sdql1EQiZInTPzl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RXsIrUSM62fbrLn/PEVzkhtFIgP//ZwhgftBL8re4QqToiRe
	rIgyIoI98vYbM0YcIeFlVJcTKX2CoCWYCw2VM2TZ1CUMfKdZWr6yYDztZrzqWL8OuvWQUu//2Mu
	IXLkrxjUVUSmtazmRWWxOgnCNeRQ=
X-Gm-Gg: ASbGnctd1A2rAaTxMshfYLNBzraSR4lFxfMTUW5Q0see0S+OJzN5YN+p0lZjLgZnmvZ
	OAvW0CnVNHOCTjPcDNe8uaJ8w9PX4dxemDeY1Xcb6/HpMq10z5i1jdLYE/1/hkuN82FGWlh50Ks
	bSet8fnPaqQuFThdx9bGUPbUYPa2KaOHG9RU/pST3uOy0CudJbbO/D
X-Google-Smtp-Source: AGHT+IGTUur5Z1uwjuuUSgp15UO1ErZBv/7v8MDPUx2hO/xulNe5fbZcC3efnFYzh6Vu5u8+bpdgmbt9WcyuaqXtPp0=
X-Received: by 2002:a05:6102:3e08:b0:4c5:904d:f358 with SMTP id
 ada2fe7eead31-4ddad0ea95amr943468137.23.1746646125763; Wed, 07 May 2025
 12:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506070210.539539-1-chao@kernel.org> <CACOAw_xzP+dfhhFsOLTOagU-QPeUUOzSpyZLO7dArvAe4F8H8g@mail.gmail.com>
 <041198dd-c6b5-4c7e-baa2-89a9f1297317@kernel.org>
In-Reply-To: <041198dd-c6b5-4c7e-baa2-89a9f1297317@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 7 May 2025 12:28:33 -0700
X-Gm-Features: ATxdqUFqcDDlERVoUm3dNGNJ9toEIMWGLyphRgWOnRxEaFX4BIrOyfk2WIa1-lc
Message-ID: <CACOAw_xDWjS-MzUMOaMSZ-XhiE3rEbonipzS63b8bZNA+NhLuw@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs/013: test to check potential
 corruption on atomic_write file
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org, 
	Daeho Jeong <daehojeong@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 8:17=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 5/7/25 04:25, Daeho Jeong wrote:
> > On Tue, May 6, 2025 at 12:05=E2=80=AFAM Chao Yu via Linux-f2fs-devel
> > <linux-f2fs-devel@lists.sourceforge.net> wrote:
> >>
> >> This is a regression testcase to check whether we will handle database
> >> inode dirty status correctly:
> >> 1. mount f2fs image w/ timeout fault injection option
> >> 2. create a regular file, and write data into the file
> >> 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> >> 4. write transaction data to the file
> >> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> >> 6. meanwhile loop call fsync in parallel
> >> Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomi=
c
> >> file"), database file may become corrupted after atomic write while
> >> there is concurrent dirty inode flush in background.
> >>
> >> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> >> Cc: Daeho Jeong <daehojeong@google.com>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >> v2:
> >> - fix description of test steps
> >> - add missing "_require_kernel_config CONFIG_F2FS_FAULT_INJECTION"
> >> - add missing "_require_command "$F2FS_IO_PROG" f2fs_io"
> >> - put correct filesize in the golden output
> >>  tests/f2fs/013     | 71 +++++++++++++++++++++++++++++++++++++++++++++=
+
> >>  tests/f2fs/013.out |  2 ++
> >>  2 files changed, 73 insertions(+)
> >>  create mode 100755 tests/f2fs/013
> >>  create mode 100644 tests/f2fs/013.out
> >>
> >> diff --git a/tests/f2fs/013 b/tests/f2fs/013
> >> new file mode 100755
> >> index 00000000..4cf56840
> >> --- /dev/null
> >> +++ b/tests/f2fs/013
> >> @@ -0,0 +1,71 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> >> +#
> >> +# FS QA Test No. f2fs/013
> >> +#
> >> +# This is a regression testcase to check whether we will handle datab=
ase
> >> +# inode dirty status correctly:
> >> +# 1. mount f2fs image w/ timeout fault injection option
> >> +# 2. create a regular file, and write data into the file
> >> +# 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> >> +# 4. write transaction data to the file
> >> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE=
)
> >> +# 6. meanwhile loop call fsync in parallel
> >> +# Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of at=
omic
> >> +# file"), database file may become corrupted after atomic write while
> >> +# there is concurrent dirty inode flush in background.
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto quick
> >> +_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
> >> +_require_command "$F2FS_IO_PROG" f2fs_io
> >> +
> >> +_cleanup()
> >> +{
> >> +       [ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
> >> +       wait
> >> +       cd /
> >> +       rm -r -f $tmp.*
> >> +}
> >> +
> >> +_fixed_by_kernel_commit f098aeba04c9 \
> >> +       "f2fs: fix to avoid atomicity corruption of atomic file"
> >> +
> >> +_require_scratch
> >> +
> >> +_scratch_mkfs >> $seqres.full
> >> +# note that it relis on FAULT_TIMEOUT fault injection support in f2fs
> >
> > relis -> relies
>
> Will fix.
>
> >
> >> +_scratch_mount "-o fault_injection=3D1,fault_type=3D4194304" >> $seqr=
es.full
> >> +
> >> +dbfile=3D$SCRATCH_MNT/file.db
> >> +
> >> +# initialize database file
> >> +$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $dbfile >> $seqres.full
> >> +
> >> +# sync filesystem to clear dirty inode
> >> +sync
> >> +
> >> +# start atomic_write on src.db database file and commit transaction
> >> +$F2FS_IO_PROG write 1 0 2 zero atomic_commit $dbfile >> $seqres.full =
&
> >
> > I think we might have some timing issues here like background f2fs_io
> > ends earlier than foreground fsync() loop.
>
> What about adding a sysfs entry to control timeout, by default it's
> 1 second, we can tune it to 5 second for this case?

Ah, so TIMEOUT fault will induce 1 second delay in the kernel path?
Then, I am okay with that.

>
> Thanks,
>
> >
> >> +atomic_write_pid=3D$!
> >> +
> >> +# call fsync to flush dirty inode of database file in parallel
> >> +for ((j=3D0;j<1000;j++)) do
> >> +       $F2FS_IO_PROG fsync $dbfile >> $seqres.full
> >> +done
> >> +
> >> +wait $atomic_write_pid
> >> +unset atomic_write_pid
> >> +
> >> +# flush dirty data and drop cache
> >> +sync
> >> +echo 3 > /proc/sys/vm/drop_caches
> >> +
> >> +stat $dbfile -c %s
> >> +
> >> +rm $dbfile
> >> +sync
> >> +
> >> +status=3D0
> >> +exit
> >> diff --git a/tests/f2fs/013.out b/tests/f2fs/013.out
> >> new file mode 100644
> >> index 00000000..d9271f75
> >> --- /dev/null
> >> +++ b/tests/f2fs/013.out
> >> @@ -0,0 +1,2 @@
> >> +QA output created by 013
> >> +8192
> >> --
> >> 2.49.0
> >>
> >>
> >>
> >> _______________________________________________
> >> Linux-f2fs-devel mailing list
> >> Linux-f2fs-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
