Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D52E3399
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742894132; cv=none; b=svV54RndQTZ+44XrQ1Ir2gmFNyIrAeIcRVbBRmAUpzxN77bIm9zcBalq4y0tDzYkXKcQG6ryxHBBRfd7SiW8riU/EbGjnWjro1oPIHZrlzMPwbacQvMpfjze0t4mtYiUMF8bhHyuQco+jqn173iFuWX5wNQIM3xZ2smzeNcBDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742894132; c=relaxed/simple;
	bh=BDYl50AWJpEUL6kl8zVcz5BaIDFlUGP2gRwRKgyKzio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZiSJIP2Z6be4RtbHBb6cvSDt4x7JdfSUi/xr6FruA/QQEeTAGlUtTjbTLpwn7Z/L4fMO02aL/pmfE0jkxd/z/h/yRgp7k5IVFLyPBkG/ad4b/OkH/rxBVNFroRKV3AH/4R96RR3QS0E40AmF/eBlNaDhnjRHz0LMDfPwTyonbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=r2yhSP6c; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="r2yhSP6c"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22580c9ee0aso104775845ad.2
        for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742894130; x=1743498930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PuWY4FxnO4+NOwwcfeuO+0rdzoMVdvrsuUW0ofjodWo=;
        b=r2yhSP6cQpHk++8J2lfJ9xo24UQ2F83la2BddIeR+s+9yXGx8MgXlKCz3uRVuRdttC
         ZFEJ2mil2ukosFQydbDnYQ2eBdzQQ5YYj6hpxlXl7SJ78vuwZawyHdBlGP8Xr76QKs3A
         SXu52ZLTLtPvXK5vBLlDEGAjXiHWzrPe7YTXk3KRXTJsRg+K77sgw8B62Jydl9cMdLh6
         1JBzUFOK2pjr5300tpHnEJ37wzbdRrk/Kb0U6PiDonQUm4pBjB/t+H4EljzA6zUqWDwr
         DxKYUGVPV3BE8QGXrTal9uak/mazXXmZSQ8QmhC73KrLQql/m5cjZQb9FXy1Gfe/pi9v
         4VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742894130; x=1743498930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuWY4FxnO4+NOwwcfeuO+0rdzoMVdvrsuUW0ofjodWo=;
        b=ebgu/DvwelHUoSKINWQAxUsTaU/f0kUpQ5IKZGfTQsgme17NsRkAaYex1Ntr7jjTAr
         cT0QyeruhvNSikjsK3luhrILwJGAxNjIvX+XfvDqhC1/iSL9fCoLjOZH83EFiy5R+GrR
         sIaEXqxjHBI/vDRtH4l+Hf5niEx+jG0pM+Takc/bJJTyCd+IepkO+1XZwY0yCH+w5ITY
         SaxlCu5s467mSYCnNNvBgkwq6xTRjwrrjuROFUHaAdgro0uEcHHfgXEutS65kDPlNU0F
         TcuoTPE/iWj4Vwcl5ZPIfQ4S3K0HfJu03+/i8xrz+MHiL1KTDxqKnFzQfmON+ij8sZE6
         bOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzan0IkOIyw1Xd1TyOlgJ9ft9mgC7Vz0mWnHli5koWrVFj+NWAAI90irp9eF3z/KUci3fon+2R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qvnqoaj0uAaPD6f9pilH3UIOepdjKu8nubBZlQvWVPj9rAg4
	e63vxH5AMCi4osZCCzEey++kOZSiVjh2iuqLiSILUx6j/T0y27GyYzBAS5jTkOEn0hZ4saQQg02
	r
X-Gm-Gg: ASbGncvgUbdd8Gl7y8iVAkb5Ej/qWHm9Dlqe/IwUuCwtmXjCYnbR3dJWRoawEcMcSXV
	vcByXsIR3nGgHtqHneuX84Zf8vyc0vi/fjpp8fnL1pEm1LJX/GKVhVONpA7sSzx8+YXWaYfzizp
	QU4aHU+rxQb+qse/JeY0+24+Ex9eTyJt/NkJwtHgyv7nCnhkvvZMH6SxjJB/bby48wdRecmC5gj
	NBnB+1sx1yzz2uiLfubXbtil5mqJEV10QLyJpac3yuJ7ND95M/gopag1KiLzvzsAjrH+5xOdewo
	8j3SLs1GKsLbj/hC7Zd/xWtkUTrchysWdbE7+TOxgG8fBz+FKCufaW09CzUw3RhHVBNgXJc3XKi
	HViVWI2CPkUa85pDBew9MDoSSi4bN9zM=
X-Google-Smtp-Source: AGHT+IE7mretUNcH2qauevhGMcyv2ME+bUwpr7TkZvXTiCQuz3MoKuqVjSbqXqiXrp10chHoDpNk5Q==
X-Received: by 2002:a05:6a20:914e:b0:1f5:862b:a583 with SMTP id adf61e73a8af0-1fe4342cc3emr34821170637.34.1742894130098;
        Tue, 25 Mar 2025 02:15:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390600a75asm9575168b3a.84.2025.03.25.02.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 02:15:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tx0Na-0000000033c-36Np;
	Tue, 25 Mar 2025 20:15:26 +1100
Date: Tue, 25 Mar 2025 20:15:26 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 6/6] f2fs/009: detect and repair nlink corruption
Message-ID: <Z-J0LnCEWX2bo9LF@dread.disaster.area>
References: <20250312072309.3989074-1-chao@kernel.org>
 <20250312072309.3989074-6-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312072309.3989074-6-chao@kernel.org>

On Wed, Mar 12, 2025 at 03:23:09PM +0800, Chao Yu wrote:
> This is a regression test to check whether fsck can handle corrupted
> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> and expects fsck.f2fs can detect such corruption and do the repair.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4:
> - remove unnecessary "_require_command fsck.f2fs"
> - clean up _fixed_by_git_commit line
> - fix to clean all tmp files in _cleanup
>  tests/f2fs/009     | 147 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/009.out |   2 +
>  2 files changed, 149 insertions(+)
>  create mode 100755 tests/f2fs/009
>  create mode 100644 tests/f2fs/009.out
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> new file mode 100755
> index 00000000..9120d8a5
> --- /dev/null
> +++ b/tests/f2fs/009
> @@ -0,0 +1,147 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/009
> +#
> +# This is a regression test to check whether fsck can handle corrupted
> +# nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> +# and expects fsck.f2fs can detect such corruption and do the repair.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +if [ ! -x "$(type -P socket)" ]; then
> +	_notrun "Couldn't find socket"
> +fi
> +
> +_require_scratch
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +_fixed_by_git_commit f2fs-tools 958cd6e \
> +	"fsck.f2fs: support to repair corrupted i_links"
> +
> +filename=$SCRATCH_MNT/foo
> +hardlink=$SCRATCH_MNT/bar
> +
> +_cleanup()
> +{
> +	if [ -n "$pid" ]; then
> +		kill $pid &> /dev/null
> +		wait
> +	fi
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +for ((i=0;i<14;i++)) do
> +	echo "round: " $i >> $seqres.full
> +
> +	_scratch_mkfs >> $seqres.full
> +	_scratch_mount
> +
> +	if [ $i == 0 ]; then
> +		touch $filename
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 1 ]; then
.....

Ok, it works, but it's a bit nasty. You want to run the same
injection and checking on all types of inodes, so factor that out
like so:

inject_and_check()
{
	local nlink=$1
	local ino=`stat -c '%i' $filename`

	echo "ino:"$ino >> $seqres.full
	echo "nlink:"$nlink >> $seqres.full

	_scratch_unmount

	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV \
		>> $seqres.full || _fail "fail to inject"

	_check_scratch_fs >> $seqres.full 2>&1 && _fail "can't find corruption"
	_repair_scratch_fs >> $seqres.full
	_check_scratch_fs >> $seqres.full 2>&1 || _fail "fsck can't fix corruption"

	_scratch_mount
	_scratch_unmount

	_scratch_mkfs >> $seqres.full
	_scratch_mount
}

And now most of the test cases become this:

_scratch_mkfs >> $seqres.full
_scratch_mount

touch $filename
inject_and_check 0

mkdir $filename
inject_and_check 1

mknod $filename c 9 0
inject_and_check 0

mknod $filename b 8 0
inject_and_check 0

.....

The whacky cases with socket and orphan inodes can be handled
by factoring inject_and_check so there's a second function that
takes both ino and nlink as parameters.

This gets rid of all the unnecessary if/elif logic and looping, 
leaving only the test code that does the work behind.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
