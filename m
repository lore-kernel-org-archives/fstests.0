Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A925B67C
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702000; cv=none; b=fBcUF1r8E+sKOsrNQhfVGk/N7U3IOiJc++/6HR/QCIevB45vPGs6xK3r7t0YlasSBEWQ0ptSyPp+DS5hJdAi/NW/ufbZy31CyEWMxZTfk8Ky6Or9rkrDgQ+nQNtORJm/6Qb/iFKmxxjuCevTgfJUyGv62HdI5UvYqOYzFyeFK5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702000; c=relaxed/simple;
	bh=W2M2KT5iH+lmCWaCaMPQDMXW8QxzIVPta4dYyNiCi0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiIq9XW5L1i/vLzFmshYg0/JpeAmEFtx3/jEsxCnQugZquXrBXM7oLXTCpSmzAW/Xvp2S+ty9EWwQOQ9LmAm/026vM/aUP+c0gWTgjI0SIK3zIrqlu4xJeQ7NIgocXYBCNqt91ig17yYxoYLE3ncvxbKrhrtiAPSHdEPAc+LD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OfTA8Fa+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfTA8Fa+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741701997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0OPOZ7he65BOXlfA9oSho8t0fS/rmeaaXJ+CF5+1mAc=;
	b=OfTA8Fa+mYdMjgndcCqXjvmUNK+4qPKkXXNo2NDOl8wBxkZfu7hZe8JmCiIdbdmwyH65OS
	txfA+dfqNvO8LCJ87zJZTSKi5tmzbv1qStyHjShcY93Mg5/LoAi/IUn4kOuho8kwE9CqBl
	j6nEPepdBki671gNT+7kPb7w8yeYshY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-uoPwyWlxNXyPqbTzKgdjdg-1; Tue, 11 Mar 2025 10:06:36 -0400
X-MC-Unique: uoPwyWlxNXyPqbTzKgdjdg-1
X-Mimecast-MFC-AGG-ID: uoPwyWlxNXyPqbTzKgdjdg_1741701995
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff6af1e264so14730105a91.3
        for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 07:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701995; x=1742306795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OPOZ7he65BOXlfA9oSho8t0fS/rmeaaXJ+CF5+1mAc=;
        b=Q55Wx9TMW3W0ps13Qs4AcUnwryqdK/T56NORHlnNtsKIl+p/IYNuBhYWIlcx2gF0XU
         UxazzbUGDaWgfvTVkByC8LVDeYkh9P/G+jRawpdiDWo9/mWCea/jRkBKBK8ude85utgN
         qHfLk9QXpTxRrbS1Qute54B5VuXtKTrE77hbk6V7dGuM/Z4zVxtB8J20qp1YSG0bVaMK
         5G21a84KjP8fywBnut+THyOBaP1XC3fQedjEMuR3KI56ylg5HFU0XyogZWSdu7Gl+C3v
         P7aXF9pUnHDhMc/xHblyMofFefRlqsijLKE3tHcbJ51fgL2tEBklLHGVbkEwgwuCuTNm
         YPlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Bkzt/5RINszgY9pE40fPwijNsAZmIM1eYwGlcBnRvu9SYsH1RX7xnOEvUy6bC/TUPA1PXvLv@vger.kernel.org
X-Gm-Message-State: AOJu0YwJicSlllNybI8mhkbayg+/aVBtH1spcgy3xoEYWdEXiHPHjbj8
	zBU1khBZNXw0Qhq4sPtE/EaiWYu9Uct5WpicE4vvD5oZUKg2eUcOd2AereNTlNj4yvr0mmGWmRl
	AdY48DuMFuaoCb/2lUJUivoruIELtkbHoCqv9hNEG/55hQ0ahYAKGeOI=
X-Gm-Gg: ASbGncv4Z77W04IXJu+kOjzSc5JBkTgKv/kCN+fngqACgp+hJvYC25aMqcFQEhcgym0
	H5uCy/jVL1f+MiJybdbBRApdZ3audRNy5BRiNNTKjRy/tLN3X/mTVUXQA6v+DMdIy/Q7dXGqKWy
	O66VBx/xoaufwxCQGCr9Tc87/UfHs58exVy0vXlLLubFLa0+7PrarTpoqSTBmEXjMzy/AGpvq2Y
	F2XrnWy37NJzUsalZuGdJFc9qJB1mugB5BYj4ErO5D9NlSdAN+2Vp5JLnqyE7HLZvckSlF3+qDA
	esMU8+BaUwCBX1ciN8wd9qUEwyZC7E7bkKG7YeengZ2acy/kypfiFtUe
X-Received: by 2002:a05:6a20:160c:b0:1f5:8c86:5e2f with SMTP id adf61e73a8af0-1f58c8660a5mr7186308637.37.1741701994894;
        Tue, 11 Mar 2025 07:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOUM0EgF5JQvrEivKy6KbPfAQKra7zwYiLgOcmGGJhXJkcLBoKcLzljd22x+SxHMoK67xzLg==
X-Received: by 2002:a05:6a20:160c:b0:1f5:8c86:5e2f with SMTP id adf61e73a8af0-1f58c8660a5mr7186270637.37.1741701994572;
        Tue, 11 Mar 2025 07:06:34 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b322e537sm8111916b3a.38.2025.03.11.07.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:06:34 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:06:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 6/6] f2fs/009: detect and repair nlink corruption
Message-ID: <20250311140629.acdx54w4t3pitl22@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250311080430.3696582-1-chao@kernel.org>
 <20250311080430.3696582-6-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311080430.3696582-6-chao@kernel.org>

On Tue, Mar 11, 2025 at 04:04:30PM +0800, Chao Yu wrote:
> This is a regression test to check whether fsck can handle corrupted
> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> and expects fsck.f2fs can detect such corruption and do the repair.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - check socket command
> - add _cleanup to kill & wait background thread
> - add commit title in _fixed_by_git_commit line
> - clean up codes
>  tests/f2fs/009     | 145 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/009.out |   2 +
>  2 files changed, 147 insertions(+)
>  create mode 100755 tests/f2fs/009
>  create mode 100644 tests/f2fs/009.out
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> new file mode 100755
> index 00000000..4f8b2079
> --- /dev/null
> +++ b/tests/f2fs/009
> @@ -0,0 +1,145 @@
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
> +_require_command "$F2FS_FSCK_PROG" fsck.f2fs
> +
> +_fixed_by_git_commit f2fs-tools 958cd6e "fsck.f2fs: support to repair corrupted i_links"

_fixed_by_git_commit f2fs-tools 958cd6e \
	"fsck.f2fs: support to repair corrupted i_links"

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

	cd /
	rm -r -f $tmp.*

I don't have more review points on this test case now, f2fs list might give it
more reviewing :)

Thanks,
Zorro

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
> +		mkdir $filename
> +		ino=`stat -c '%i' $filename`
> +		nlink=1
> +	elif [ $i == 2 ]; then
> +		mknod $filename c 9 0
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 3 ]; then
> +		mknod $filename b 8 0
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 4 ]; then
> +		mkfifo $filename
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 5 ]; then
> +		socket -s $filename >> $seqres.full 2>&1 &
> +		pid=$!
> +		sleep 2
> +		ino=`stat -c '%i' $filename`
> +		kill $pid >> $seqres.full 2>&1
> +		nlink=0
> +	elif [ $i == 6 ]; then
> +		ln -s $SCRATCH_MNT/empty $filename
> +		ino=`stat -c '%i' $filename`
> +		nlink=0
> +	elif [ $i == 7 ]; then
> +		# orphan inode
> +		touch $filename
> +		ino=`stat -c '%i' $filename`
> +		$F2FS_IO_PROG write 1 0 1 zero atomic_commit $filename 5000 >> $seqres.full 2>&1 &
> +		stat $filename >> $seqres.full
> +		rm $filename
> +		$F2FS_IO_PROG shutdown 1 $SCRATCH_MNT/ >> $seqres.full
> +		sleep 6
> +		nlink=1
> +	elif [ $i == 8 ]; then
> +		# hardlink on file
> +		touch $filename
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 9 ]; then
> +		# hardlink on charactor
> +		mknod $filename c 9 0
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 10 ]; then
> +		# hardlink on blockdev
> +		mknod $filename b 8 0
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 11 ]; then
> +		# hardlink on pipe
> +		mkfifo $filename
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 12 ]; then
> +		# hardlink on socket
> +		socket -s $filename >> $seqres.full 2>&1 &
> +		pid=$!
> +		sleep 2
> +		ino=`stat -c '%i' $filename`
> +		kill $pid >> $seqres.full 2>&1
> +		ln $filename $hardlink
> +		nlink=0
> +	elif [ $i == 13 ]; then
> +		# hardlink on symlink
> +		ln -s $SCRATCH_MNT/empty $filename
> +		ino=`stat -c '%i' $filename`
> +		ln $filename $hardlink
> +		nlink=0
> +	fi
> +
> +	if [ $i != 7 ]; then
> +		stat $SCRATCH_MNT/* >> $seqres.full
> +	fi
> +	echo "ino:"$ino >> $seqres.full
> +	echo "nlink:"$nlink >> $seqres.full
> +
> +	_scratch_unmount
> +
> +	$F2FS_INJECT_PROG --node --mb i_links --nid $ino --val $nlink $SCRATCH_DEV \
> +		>> $seqres.full || _fail "fail to inject"
> +
> +	_check_scratch_fs >> $seqres.full 2>&1 && _fail "can't find corruption"
> +	_repair_scratch_fs >> $seqres.full
> +	_check_scratch_fs >> $seqres.full 2>&1 || _fail "fsck can't fix corruption"
> +
> +	_scratch_mount
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

