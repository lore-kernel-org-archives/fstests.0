Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2416FC5
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746563137; cv=none; b=uyOHTJuhwk5EvZyRm0tvQM+kXHh3n7cyau40kHDil/+myORshicEBA3yKp/6xZBsbqaQPP4kH4+meiABExrWIDsA5Z02mMLmIuPii0kCsg/RZRaz6ySagr+N3fywhqJK3RWWDDPpOtKc7slHznMa0cunnJQB1E3h3hxvhihnb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746563137; c=relaxed/simple;
	bh=/VB8GJr7llVErbHR+qiSjkkTJovJDH9k0RlaSI5ggJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHLbsDWUDsEkkKrx/SUAUmgfZ0b91Fg0ROFuVX96ykOY2jmfUfiVsxCpwlyVD9/ZpOrrQEZ1I/WFJLojvuABpoJ9uyJQTFOPHU2ihZ2o/KmW7t5OtFsTK9UQQAHp4vYpjmFMLBG7/mG4h5Zklz3ACnwaqf3OHl7TW60TEqe2s34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2lY0ufM; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2lY0ufM"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523de538206so1620711e0c.2
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746563133; x=1747167933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlnfEmpHUY8kY2niHLOjtjnv0D8DMZABGlYqrDQFq7A=;
        b=S2lY0ufMCivdFgKhHhuuh7EBQ4qngKTh92GE+oVQVrdPHVxE3wPKS9mQJb21dX2Jjh
         9SMyA/5wSCNEKfAHQi/oItLZEF43oWV040qIfSPvYPuNPwmJFV6YCe+8GhKnhl8x0O1T
         MziQxIqDlNEDPRYMOHPLDcZzt87/6Z/tWjiCb8pmh4HC/b7wTYp6sgKb9+t4Nis+uE9C
         34xWzMKf5YfQXsgGQnBxNoHl/AvP1/P8glCIeFnh/2J/8nlpwdKlq++b1u69iZhimoRD
         bH5RTv9poR+SzirrOr1dyQtcuWRL40MB8cyrX3qhTb1mGVg8g3SCwYR+xLj5+SIfUuN2
         ulvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746563133; x=1747167933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlnfEmpHUY8kY2niHLOjtjnv0D8DMZABGlYqrDQFq7A=;
        b=BM86PWo0VFGbXoyC09FLhLi6yojFk/9Y8oe1yk4RJY6wbDxenusHJuBwV8BH2X+p+V
         TT9glZkL9tE3bwfyZMcPfQPLRzitpIh0x/uD6G25z+0EV+bIeuLTABbzQEfieDY428ni
         q6YkK+reFA2pIzJ6o7ASvUkDraW49WQsaun3uITL3fg4jPj9rrrtrO2C3WSR/DH4SEAw
         /MEKnuD31O5Vqcbp4l6zGWglGpRhwAYhxD4W78VmO5dslehjAsor7UogzgcVYZ5WKKIK
         DviA3p0RSoQY/RIKfU0sojdvUGWue4nKTsIFIMXSu0Tqpwv0zJ0nDSoJ/vSPmKTgzun6
         qD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYE5YJ4A6dYfxDYquPIDcBJ8pn1yveknjK8s0Fx4OjO3nyS4ODDS57Sf+IHG2m1mC84Roy19F1@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIpuEAbxCmvUrs7/SqqfYBmX7e9jh0phkCiGCeZhnY3rWbwAf
	ngy1bP5bloM9+1h+Sao/xCn4onah8VsNjzqjPy99eePALMWXICUP20eHA6ztdtuZayEnDWzkleW
	NyfcJFsipHrhSfx2aewvdZWNnm/w=
X-Gm-Gg: ASbGncuTumgHVeXwvY9dYL9ua50PaileHXZYw9rvS79KSdC/Busxu71tRDOGs1+er/8
	ClKfYoxHZ0sbM7D9vH5aZ+NRtIQ3nXlQLeT07IUuuPErQAGn8yqwDaxOOnDy51E8vlytgo0JXjd
	OPerq4fxcsyAiVSKKtd3LpbQGpfCq/Wmb5AD9XB+YQSpYi8siK
X-Google-Smtp-Source: AGHT+IHUvIzlPkIU7lOI+Feh/5YuaNt7AJXOfDBPYz1qRlXtoG5cae2jMdSP6YFru2DlNtUqWV0P5rbJ9Ps2z7xhNgU=
X-Received: by 2002:a05:6102:80a2:b0:4c1:9780:3830 with SMTP id
 ada2fe7eead31-4dc738d3f53mr925470137.23.1746563133428; Tue, 06 May 2025
 13:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506070210.539539-1-chao@kernel.org>
In-Reply-To: <20250506070210.539539-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 6 May 2025 13:25:21 -0700
X-Gm-Features: ATxdqUFE0T50OHEB5NC2BsFQavHycvybb8rxlNatv2Iuqz594NYNiCR7SYQk1pc
Message-ID: <CACOAw_xzP+dfhhFsOLTOagU-QPeUUOzSpyZLO7dArvAe4F8H8g@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs/013: test to check potential
 corruption on atomic_write file
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, jaegeuk@kernel.org, 
	Daeho Jeong <daehojeong@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 12:05=E2=80=AFAM Chao Yu via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> This is a regression testcase to check whether we will handle database
> inode dirty status correctly:
> 1. mount f2fs image w/ timeout fault injection option
> 2. create a regular file, and write data into the file
> 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> 4. write transaction data to the file
> 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> 6. meanwhile loop call fsync in parallel
> Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomic
> file"), database file may become corrupted after atomic write while
> there is concurrent dirty inode flush in background.
>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix description of test steps
> - add missing "_require_kernel_config CONFIG_F2FS_FAULT_INJECTION"
> - add missing "_require_command "$F2FS_IO_PROG" f2fs_io"
> - put correct filesize in the golden output
>  tests/f2fs/013     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/013.out |  2 ++
>  2 files changed, 73 insertions(+)
>  create mode 100755 tests/f2fs/013
>  create mode 100644 tests/f2fs/013.out
>
> diff --git a/tests/f2fs/013 b/tests/f2fs/013
> new file mode 100755
> index 00000000..4cf56840
> --- /dev/null
> +++ b/tests/f2fs/013
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/013
> +#
> +# This is a regression testcase to check whether we will handle database
> +# inode dirty status correctly:
> +# 1. mount f2fs image w/ timeout fault injection option
> +# 2. create a regular file, and write data into the file
> +# 3. start transaction on the file (via F2FS_IOC_START_ATOMIC_WRITE)
> +# 4. write transaction data to the file
> +# 5. commit and end the transaction (via F2FS_IOC_COMMIT_ATOMIC_WRITE)
> +# 6. meanwhile loop call fsync in parallel
> +# Before f098aeba04c9 ("f2fs: fix to avoid atomicity corruption of atomi=
c
> +# file"), database file may become corrupted after atomic write while
> +# there is concurrent dirty inode flush in background.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +
> +_cleanup()
> +{
> +       [ -n "$atomic_write_pid" ] && kill -9 $atomic_write_pid
> +       wait
> +       cd /
> +       rm -r -f $tmp.*
> +}
> +
> +_fixed_by_kernel_commit f098aeba04c9 \
> +       "f2fs: fix to avoid atomicity corruption of atomic file"
> +
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full
> +# note that it relis on FAULT_TIMEOUT fault injection support in f2fs

relis -> relies

> +_scratch_mount "-o fault_injection=3D1,fault_type=3D4194304" >> $seqres.=
full
> +
> +dbfile=3D$SCRATCH_MNT/file.db
> +
> +# initialize database file
> +$XFS_IO_PROG -c "pwrite 0 4k" -c "fsync" -f $dbfile >> $seqres.full
> +
> +# sync filesystem to clear dirty inode
> +sync
> +
> +# start atomic_write on src.db database file and commit transaction
> +$F2FS_IO_PROG write 1 0 2 zero atomic_commit $dbfile >> $seqres.full &

I think we might have some timing issues here like background f2fs_io
ends earlier than foreground fsync() loop.

> +atomic_write_pid=3D$!
> +
> +# call fsync to flush dirty inode of database file in parallel
> +for ((j=3D0;j<1000;j++)) do
> +       $F2FS_IO_PROG fsync $dbfile >> $seqres.full
> +done
> +
> +wait $atomic_write_pid
> +unset atomic_write_pid
> +
> +# flush dirty data and drop cache
> +sync
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +stat $dbfile -c %s
> +
> +rm $dbfile
> +sync
> +
> +status=3D0
> +exit
> diff --git a/tests/f2fs/013.out b/tests/f2fs/013.out
> new file mode 100644
> index 00000000..d9271f75
> --- /dev/null
> +++ b/tests/f2fs/013.out
> @@ -0,0 +1,2 @@
> +QA output created by 013
> +8192
> --
> 2.49.0
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
