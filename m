Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014652E3381
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864842; cv=none; b=JokHEwv2usX6f6Dlh2CWyRaIeJRRYyiiOuBn1BrCpQO4vGycMPbWyVJOKOP6PzY2aTyreu7L0ANpRvvicQOtWJZr5ImV+aXFA58NXXaEWoeNP6DqnoD2/PHv7a41+bhYkCu75mLgMcBnRRVsSAnyLFd41e3c1QAcjR7mVvsCF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864842; c=relaxed/simple;
	bh=/NDHJqBtfFzrpMc4Hs9rWXVw6vsRkqQKc+jANVRqwJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuCSJcpWkyaBMIRG2i1S+QGNWwB51coJVmf96J1NJh4oiysw6huvCdKaEUDnPm5DfnQIO+wMIjcV2zOs/u1yvi+XIi2sLRT2Anw+Cx3bOGGISoiZoz1WxN1yJIXOS7ZU2NEqczVKz+nFPe8fer42/i6fLaSpByjfw8+RnFQRV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJMQmxVJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJMQmxVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742864832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ca6tvFaMuFWGnHVvQslx3xHF4LqShHWEylSbrbBNjpo=;
	b=eJMQmxVJDis+IDUNDkmJYt6/tzvZ7jwm5hTB+pzsYq0KYQIW3JETBeKJOUoGJXWMnm10Qb
	gnE/CFTDk/HfjUeGKJtSSZirSaVNN6UfZJ36bczBqNwgZSWs+72MGGYuDtOZyMEzuKgvQn
	VmXNtFiPvvOyRqTrVOQABTLvD6TWldY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-2HHALCopOG2ns1dMWtU07A-1; Mon, 24 Mar 2025 21:07:08 -0400
X-MC-Unique: 2HHALCopOG2ns1dMWtU07A-1
X-Mimecast-MFC-AGG-ID: 2HHALCopOG2ns1dMWtU07A_1742864826
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224364f2492so74586845ad.3
        for <fstests@vger.kernel.org>; Mon, 24 Mar 2025 18:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742864826; x=1743469626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca6tvFaMuFWGnHVvQslx3xHF4LqShHWEylSbrbBNjpo=;
        b=SvkPi2g930lRZOiNtxvh1ATVfudkrg7fYHIDaWhws4jaev6AkQFCF7R6zCO04khvAD
         84FetfovJEpo6TATSfo67lz6K6cr8H4FW6dAPtjn2mmDqIHtA+f7pQSx6O7xE6XZl5j+
         Tmlsu8uLG1fOjgX/kJ8NsYYqwMyt3tT9eGM/Xf5NbRSmLKHsjw4wSHOtQM1RwNMu6w3F
         0+2EoCtYouNykxA7K372A1LphmYuykWYKqtHBXBA7PHutE0eKfvu4LXTMBtsbTXSmltl
         nS6IpDnMSqp2aRE+sSWgT8GbfOdx7LQkSNjTTA6Q5h5FMJng+EIhOu1+BxiKcYP1bShp
         Kzaw==
X-Forwarded-Encrypted: i=1; AJvYcCVLxeP0qU5M2nCpVJ6PQF3P0YhajkyqLRr0bv+qpKjB8dyBe/bx2OZldKaj631LYAMOd1BETTK6@vger.kernel.org
X-Gm-Message-State: AOJu0YxcupHq2ewzz+pYlvuf7rNWjn4mC6fwAO9tbCUyxBlqdTkTHvaj
	5zMsO3e7y3gEJNb38uDwxTxHNrB8pLCUVX2zCpLAm34EmtZtX+2bBRXj/xChaa9E0CeCbprjURL
	+yRJq5TO57yqF9dePNye73B23xtax4IOQawUlYqYhC7E9V4M0FU+z5yNeAPU8rhqftg==
X-Gm-Gg: ASbGnctrjRlSjaTWiZ3NBLxzJOEshT7p+pkoX48CBZtLycZQfTU+JgfJ7fmo/8scBLY
	1u1CnhRym1S0diKjMeFtGIIMDlu8iJIvxUlS+z56VuV9VkVpq2LUeWz6RBPZFno7CE9zGYTo4Kl
	N1TrAeqXnaY7WF2dwYfxrx0Oq45FoAi5KOn3XXEOGhRrn6vrs/KEBtVe+G3Praf8ITk3ViyMLka
	jhziNhKrD4kTn+0Hrxe8QPh2I8MFu2qmSm9DIe7iZKXMR+MNFGaiMSek7DBNX1WwAiN4PEElZlb
	U39ocxLGDozGrx13e89DG9058jX0eECSgQSDi8gV/MOf7BsOK7p5XBZK
X-Received: by 2002:a17:902:ce01:b0:223:faf5:c82 with SMTP id d9443c01a7336-22780c7e05fmr198384875ad.8.1742864825671;
        Mon, 24 Mar 2025 18:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3hRhwT80J0wl1cy+2s5UnRQlGubHQzmqd3tsaRVrCRoluLAqgLLpBnorMQkQc7zCzTbTfbg==
X-Received: by 2002:a17:902:ce01:b0:223:faf5:c82 with SMTP id d9443c01a7336-22780c7e05fmr198384655ad.8.1742864825167;
        Mon, 24 Mar 2025 18:07:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da9dbsm77893365ad.179.2025.03.24.18.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 18:07:04 -0700 (PDT)
Date: Tue, 25 Mar 2025 09:07:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 6/6] f2fs/009: detect and repair nlink corruption
Message-ID: <20250325010701.pe3u2qryvjwl6dpf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

Hi Chao,

Which package provides this "socket" command? I tried to search it in Fedora, but
got nothing:

  # yum search */socket
  Updating and loading repositories:
   Fedora - Rawhide - Developmental packages for the next Fedora release                                              100% |  19.1 KiB/s |  23.6 KiB |  00m01s
   Fedora - Rawhide - Developmental packages for the next Fedora release                                              100% | 694.7 KiB/s |   6.9 MiB |  00m10s
  Repositories loaded.
  No matches found.

If it's a program by yourself, we might can put it in xfstests/src/socket.c?

Thanks,
Zorro

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

