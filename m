Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32921BD9D8
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593616; cv=none; b=EB8G0a1taCKuH1UjvBpt1sJ70+fxteE2+eo1POF1dp7hfUSahOHCqe2lVuXuovbr166COP+u4Ms+EOkvliT2msXbrZeo2UHbD8bQl50TTbgc+klRVESB5yynMd43928TnmOC3WBjEpwMzih7FL3S/3SE75vmGRrjyeBPAY53MfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593616; c=relaxed/simple;
	bh=nJ2aaIJ1t9YQ0DX0ZcN/ZSL40rltJCZjGfDSyczOZJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFfhCxiQOhkQl73x03HzIHYShcIZ0/o+r2A6/zq6x7Jk21U5K3ugoQJFRh1mbNKon/PuTMEMEnqaLX68YLMyqd+Oi50H0cAn+JtWs7iEfZHWBufMac3HU7h2cYhDtlRoY0EnTZ5iS53rP6GeSYRhC0e0BnOsvRobUait/g5w2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cT56PKif; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cT56PKif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741593613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ufi/jLKm9O7YJJFQwF7KJlWKXsd5gJyLe1sPin/xo2k=;
	b=cT56PKifYoA3CVgVTztOjEvtSUHWuDti//yr9866gM0fsty8FGf3tqLvlrH2d1mZ3KAQ3Z
	wQ8MimCCIyuk6qntO/FqhsB5t7JjcUYG5f7ziGI+zlUkeJR6BkUtNOBJwUPHZKyYMfPshy
	1m7T63usj/Qz4AIcF9LZ23jJVUWf6Jc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-npFeISAtNci_oFmM_WIIyg-1; Mon, 10 Mar 2025 04:00:12 -0400
X-MC-Unique: npFeISAtNci_oFmM_WIIyg-1
X-Mimecast-MFC-AGG-ID: npFeISAtNci_oFmM_WIIyg_1741593612
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22410b910b0so54958705ad.2
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 01:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741593611; x=1742198411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufi/jLKm9O7YJJFQwF7KJlWKXsd5gJyLe1sPin/xo2k=;
        b=AmXk/dYHcxcurtDMZsjUuaSl3UC0FXld9B5EXaBujnGfU/EoyhbO6x7f4CRSSEtGOZ
         hoox0749M965bh24sXHUEP4Sy3FwoM4hU1zAan0NZ1jy/n+y4P9ePz/nZ71yIJ41PYeB
         IIwPjmOJuokiLdwm7Fqod7CDHhLPa51NXjzjVcJyVYAiFiBoZEqB4i7EjUF0sDCWPxGC
         SnnfbifScTj2ARkd/XGc0GKeb5kAgsRyT/2mBe98yW1NKcfNs2pD1byJXS+Ta/yGzJ9y
         uprmSlFVd2IgLqF63Qn/lh0eC4iRpJNP3pl7d01vPQXSV1Wn/YSZqpgOq+dgREdtkg2+
         axiA==
X-Forwarded-Encrypted: i=1; AJvYcCUO6fo6y0qXZ7/6cK/pMIwkO92m3mUuhWcGjC70wjfsSqgQNcfa+EHgoGuWYh3ZjRg6PkyJ6E0d@vger.kernel.org
X-Gm-Message-State: AOJu0YyW/WDrnOI/RRlRuGAYTMvlrF6wj8e6T9MpFD3HGtpeE5EN+FVC
	6wqLr/wSqrwiIi3mZ9IOZ51ouiYqxVU8giq9fL5W2ZtFrSVPkUPTc6iU159cF0Egd+jjVe6vfuk
	HziA0fmxVg0GuIkrwpqVT82EXKYUnDN2IhljiljyQ+SE0zawo5oIVh77Szmg6DKpo9Q==
X-Gm-Gg: ASbGncvSoXR/GBp/b9neJkIjNhXoSaVt5FR90mr5i2GtkwaaZfvdqdB/2y/a07XPGQE
	qlYaprSmZzCiCxSFe8o/MeTR1fvL3QrMssw02DGIYsC9paTrM2JxfsIkqi9u/e+c1GDO0t8Ox99
	rZ90I37g4uEJOgF9hn5jMcKMFVwJDvztrCbv/3GyQe/axIXfl98IX828MbaGGR5NhbYeNPxIYrl
	k0x9M4YSGGYAm4i1pckjS2p4dWx8nkaLW9s/RMfalQxQCKCH0ZIhkKCx2Z3iuDZgCt6CM6Dvo5K
	XY00FKSPFWBV00zF0QR2hfuopUssJvX23+VRU5NdcYLzq/k+RVrv4wyq
X-Received: by 2002:a05:6a21:6d97:b0:1f3:3e91:fac6 with SMTP id adf61e73a8af0-1f544ad686fmr19167413637.5.1741593611237;
        Mon, 10 Mar 2025 01:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUCtiC0tj7UEKCoeEAOjF0Kg4ISDcivql1xzEAE5j2nkoAyFKoDlK6jX1PF1Bpzz5jKNdcyg==
X-Received: by 2002:a05:6a21:6d97:b0:1f3:3e91:fac6 with SMTP id adf61e73a8af0-1f544ad686fmr19167382637.5.1741593610918;
        Mon, 10 Mar 2025 01:00:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cc75691csm2570639b3a.106.2025.03.10.01.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:00:10 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:00:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] f2fs/009: detect and repair nlink corruption
Message-ID: <20250310080006.rkvoxu55fe3qlxmd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250306081809.2397527-1-chao@kernel.org>
 <20250306081809.2397527-4-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306081809.2397527-4-chao@kernel.org>

On Thu, Mar 06, 2025 at 04:18:09PM +0800, Chao Yu wrote:
> This is a regression test to check whether fsck can handle corrupted
> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> and expects fsck.f2fs can detect such corruption and do the repair.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Hi Chao,

I planned to merge patch 1~3 at first. But as you need to change this
patch more, and might need to change other patches, so how about you
send v2 with all this patchset. I'll wait your v2 :)

Some review points as below...

>  tests/f2fs/009     | 142 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/009.out |   2 +
>  2 files changed, 144 insertions(+)
>  create mode 100755 tests/f2fs/009
>  create mode 100644 tests/f2fs/009.out
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> new file mode 100755
> index 00000000..8f6a3e11
> --- /dev/null
> +++ b/tests/f2fs/009
> @@ -0,0 +1,142 @@
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
> +_require_scratch
> +
> +dir=$SCRATCH_MNT
> +filename=$dir/foo
> +hardlink=$dir/bar
> +
> +for ((i=0;i<14;i++)) do
> +	echo "round: " $i >> $seqres.full
> +
> +	_scratch_mkfs "-f" >> $seqres.full

Can we give "-f" to _scratch_mkfs "f2fs" part? Likes:

  diff --git a/common/rc b/common/rc
  index bf24da4eb..cafe2f3dd 100644
  --- a/common/rc
  +++ b/common/rc
  @@ -993,7 +993,7 @@ _scratch_mkfs()
                  mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
                  ;;
          f2fs)
  -               mkfs_cmd="$MKFS_F2FS_PROG"
  +               mkfs_cmd="$MKFS_F2FS_PROG -f"
                  mkfs_filter="cat"
                  ;;



> +	_scratch_mount >> $seqres.full
> +
> +	if [ $i == 0 ]; then
> +		touch $filename
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		nlink=0
> +	elif [ $i == 1 ]; then
> +		mkdir $filename
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		nlink=1
> +	elif [ $i == 2 ]; then
> +		mknod $filename c 9 0
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		nlink=0
> +	elif [ $i == 3 ]; then
> +		mknod $filename b 8 0
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		nlink=0
> +	elif [ $i == 4 ]; then
> +		mkfifo $filename
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		nlink=0
> +	elif [ $i == 5 ]; then
> +		socket -s $filename >> $seqres.full 2>&1 &
> +		pid=$!
> +		sleep 2
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		kill $pid >> $seqres.full 2>&1
> +		nlink=0
> +	elif [ $i == 6 ]; then
> +		ln -s $dir/empty $filename
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		nlink=0
> +	elif [ $i == 7 ]; then
> +		# orphan inode
> +		touch $filename
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		$F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
> +		stat $filename >> $seqres.full
> +		rm $filename
> +		$F2FS_IO_PROG shutdown 1 $dir/ >> $seqres.full
> +		sleep 6
> +		nlink=1
> +	elif [ $i == 8 ]; then
> +		# hardlink on file
> +		touch $filename
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 9 ]; then
> +		# hardlink on charactor
> +		mknod $filename c 9 0
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 10 ]; then
> +		# hardlink on blockdev
> +		mknod $filename b 8 0
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 11 ]; then
> +		# hardlink on pipe
> +		mkfifo $filename
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 12 ]; then
> +		# hardlink on socket
> +		socket -s $filename >> $seqres.full 2>&1 &
> +		pid=$!
> +		sleep 2
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		kill $pid >> $seqres.full 2>&1
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 13 ]; then
> +		# hardlink on symlink
> +		ln -s $dir/empty $filename
> +		ino=`stat $filename | awk '/Inode:/ {print $4}'`
> +		ln $filename $hardlink
> +		nlink=0
> +	fi
> +
> +	if [ $i != 7 ]; then
> +		stat $dir/* >> $seqres.full
> +	fi
> +	echo "ino:"$ino >> $seqres.full
> +	echo "nlink:"$nlink >> $seqres.full
> +
> +	_scratch_unmount
> +
> +	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV >> $seqres.full
> +	if [ $? != 0 ]; then
> +		exit
> +	fi
> +
> +	export FSCK_OPTIONS="-f"

You've set below code in _repair_scratch_fs():

    f2fs)
        fsck -t $FSTYP -f $SCRATCH_DEV
        ;;

The FSCK_OPTIONS="-f" is useless.

> +	_repair_scratch_fs >> $seqres.full
> +	if [ $? != 1 ]; then

What does $?=1 mean? Does $?=1 mean finding corruption and fixed, $?=0 mean no corruption?

If you want to detect there's a corruption, then fix it, then check if it's fixed. How about
calling _check_scratch_fs at first to get the corruption error you expect, then call
_repair_scratch_fs to fix it. Then call _check_scratch_fs to make sure the corruption is
fixed?

Something likes (just a rough example)

_check_scratch_fs >>$seqres.full 2>&1 && _fail "can't find corruption"
_repair_scratch_fs >> $seqres.full
_check_scratch_fs

> +		_fail "fsck can not detect and repair zero nlink corruption "$i
> +		exit
> +	fi
> +
> +	export FSCK_OPTIONS=""
> +	_check_scratch_fs >> $seqres.full

I think _check_scratch_fs outputs nothing if run passed, right?

_check_scratch_fs calls _check_generic_filesystem for f2fs, the FSCK_OPTIONS
is "null" by default, so above FSCK_OPTIONS="" is useless too.

> +	if [ $? != 0 ]; then
> +		_fail "fsck hasn't fixed nlink corruption "$i
> +		exit
> +	fi
> +
> +	_scratch_mount >> $seqres.full

">> $seqres.full" isn't necessary.

> +	_scratch_unmount
> +done
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/009.out b/tests/f2fs/009.out
> new file mode 100644
> index 00000000..7e977155
> --- /dev/null
> +++ b/tests/f2fs/009.out
> @@ -0,0 +1,2 @@
> +QA output created by 009
> +Silence is golden
> -- 
> 2.48.1
> 
> 

