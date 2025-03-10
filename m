Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF541DE8AA
	for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638341; cv=none; b=KixgWTt3UxE21n34USJtNQd2oaaDDa7cJwizPle6V9/OG2BYbBaN90ysUSScMTnIyq8MMPE6WSSsfZM/CibR/u3DqbQHCqaZIPEtjCtIyyDcydqb3zgFoj+4h18DbpB14nZuZUrEUgtfFDp857pB+sw9Zsxq6Mwsv+Dt0MVIkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638341; c=relaxed/simple;
	bh=at6VCHpIgKSzb5VmnHhaEd3Qi3lq2txlyekY3x9q66Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrGmMNYuNTnNzu03NiwVpxJ+mDDdwcr/uDHJMG2N8haccDqcW7qxYDsEansTgdGh4jHUU3b09n8tjI6gAVbOi4NPUU3RYv0yQ/jgYahqEjOGYuKQmfcVFtWX19jigsvSBGKDSVPIjrGmI76xp6XdPEQ5VWesJmJHGrnoLdzjnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvbWkGG/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvbWkGG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741638338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DzXTnrCrylALmiqhMAxlKqzEAqMAoi54ub7ST5/3JnI=;
	b=GvbWkGG/9ZErBzv0WqcITqtFXumC/K3k9vm93s6LFwG5jig6SYkwFh71ir8P5dWDPjSHm+
	zC8t6Y42Sk0/sb7RnwGM0DKlJFy2gjIRoSe/emtbipn3dFybI/aOwDYgBIhjSZXkrhdc8Q
	U2CwVf+RGmDZA3QWioVaozDzje4o5vU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-DMq8aLzRNvaxUUJLFFjgxw-1; Mon, 10 Mar 2025 16:25:37 -0400
X-MC-Unique: DMq8aLzRNvaxUUJLFFjgxw-1
X-Mimecast-MFC-AGG-ID: DMq8aLzRNvaxUUJLFFjgxw_1741638336
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-225505d1ca5so33372775ad.2
        for <fstests@vger.kernel.org>; Mon, 10 Mar 2025 13:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638336; x=1742243136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzXTnrCrylALmiqhMAxlKqzEAqMAoi54ub7ST5/3JnI=;
        b=CzRjDs+TiTPMpKiQtB3OKdjiPf9NNnu6mo7i2wvhExatHVRF981GFnwQsW2rNukcZe
         rvHkqEjSidO3HZctyC6zFSFG6iiCoI68rh2hDK0RKCxqDOZQ70evkO6/kSZbryzA1CS7
         opfKWwrh4F4rG4uMJPELtFOJloncApRzJ21nCZgLYTKWvG1fIfsfDbrXbMTEijGaF0Mo
         0zYLTEWMPgy6fyJV4u4jPU/BK+bpeiACszX54oowLiG5g4rjFP7EUZ35GWxcxmFZNJYS
         QU49PfNmI784BmEWrbKXhHCQR3c+AfyXF29YwL66z3NRTp69q8H9EhDeGhTGetQ3CyX/
         WT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx0O+tn0BxQRaNalm2GW60SUwDpnycrssfhauLBpN0FX3JFhpubtLrE1/yctiMiVdJT2/Cv7hQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLdTGkyrrwIRbFJmxzHKxWj8SmQXFTqfINSIVtLQ3MoyiDRlN
	Yqj7Gertuob+RgyC1L9cyr1evty5HuRUwovCoQKoPrsMW3PoQM5xFOt1sqKVgo8KnUfpt18z+R4
	YwckSsZeCKzufonb3XTz2i5WkI66J5RIA1r0Nvp7lKr3rNEvjF0+/hTs=
X-Gm-Gg: ASbGncu5wICmGn+dVvraXNEIQUj+FR3HXIKxjZLQJOc+ptFyT6Oi4XvtWHdiKgSWKzT
	hjqOWYfxEn0S+zggn7L/SCy9qALeFdz56vSigE0xsFOke8emUDC2OXM1XJWfTONh/cJJPYBRY+j
	pTv9PB99N9Et4eL0VfpBErYv0sKMYgzD/ejOInd4R9RJdOaopTHnEP/agbCbSqkrMGbyjPyod/J
	6mauiCrtwQtqm2fCTSOlgiPxVoovgJ5tU+xo5IHvWChf9pd5I8QSICqSBITplrbdY5ZjTVvg8fw
	8wna++jjM54XAq+/M7Ni2ChdtSQWyPVSgfdEVm1hPaAmutdX/daW3NgK
X-Received: by 2002:a17:902:f54b:b0:224:c47:cbd with SMTP id d9443c01a7336-22592d95bfdmr14756645ad.0.1741638336397;
        Mon, 10 Mar 2025 13:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdhRPF/9qQyxk/8HridFguvWf2Vlm1zX/sntLmxPfLxK0eP3fSpNj3YgskzB5IGUBoax66Kw==
X-Received: by 2002:a17:902:f54b:b0:224:c47:cbd with SMTP id d9443c01a7336-22592d95bfdmr14756455ad.0.1741638336054;
        Mon, 10 Mar 2025 13:25:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f7cbsm82898005ad.140.2025.03.10.13.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:25:35 -0700 (PDT)
Date: Tue, 11 Mar 2025 04:25:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 4/4] f2fs/009: detect and repair nlink corruption
Message-ID: <20250310202531.kpbloh4c6lopyvw7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250310115621.3441518-1-chao@kernel.org>
 <20250310115621.3441518-4-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310115621.3441518-4-chao@kernel.org>

On Mon, Mar 10, 2025 at 07:56:21PM +0800, Chao Yu wrote:
> This is a regression test to check whether fsck can handle corrupted
> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> and expects fsck.f2fs can detect such corruption and do the repair.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - make _scratch_mkfs() to format f2fs image forcely
> - adjust _check_scratch_fs() to allow specified parameter of f2fs
> - add _fixed_by_git_commit
> - add _require_command inject.f2fs
> - simply return value handling
>  common/rc          |   9 ++-
>  tests/f2fs/009     | 133 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/009.out |   2 +
>  3 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100755 tests/f2fs/009
>  create mode 100644 tests/f2fs/009.out
> 
> diff --git a/common/rc b/common/rc
> index bf24da4e..e156f3af 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -993,7 +993,7 @@ _scratch_mkfs()
>  		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
>  		;;
>  	f2fs)
> -		mkfs_cmd="$MKFS_F2FS_PROG"
> +		mkfs_cmd="$MKFS_F2FS_PROG -f"
>  		mkfs_filter="cat"
>  		;;
>  	ocfs2)
> @@ -3682,6 +3682,13 @@ _check_scratch_fs()
>      ubifs)
>  	# there is no fsck program for ubifs yet
>  	;;
> +    f2fs)
> +        if [ "$FSCK_OPTIONS" == "--dry-run" ]; then
> +            fsck -t $FSTYP $device -- $FSCK_OPTIONS >> $seqres.full 2>&1
> +        else
> +            _check_generic_filesystem $device
> +        fi
> +        ;;
>      *)
>  	_check_generic_filesystem $device
>  	;;
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> new file mode 100755
> index 00000000..d14df968
> --- /dev/null
> +++ b/tests/f2fs/009
> @@ -0,0 +1,133 @@
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
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +_fixed_by_git_commit f2fs-tools 958cd6e
                                           ^^^^^^^^
                                           commit subject?

> +
> +filename=$SCRATCH_MNT/foo
> +hardlink=$SCRATCH_MNT/bar
> +
> +for ((i=0;i<14;i++)) do
> +	echo "round: " $i >> $seqres.full
> +
> +	_scratch_mkfs "-f" >> $seqres.full

As you've add "-f" in _scratch_mkfs, so this "-f" can be removed.

> +	_scratch_mount >> $seqres.full
                          ^^^^^^
                          I think it's useless

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
                ^^^^^^

Where's the "socket" command from? I think it's not always installed on any
Linux system. fstests never use this command in any test case. If you
need this command, you might need to check that, and _notrun if it's
not installed.

> +		pid=$!

As you have background processes in this test case, you need to make sure
these processes are killed properly in _cleanup, especially if the test
is killed suddently, refer to generic/019.

Thanks,
Zorro

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
> +	export FSCK_OPTIONS="--dry-run"
> +	_check_scratch_fs >>$seqres.full 2>&1 && _fail "can't find corruption"
> +	_repair_scratch_fs >> $seqres.full
> +	_check_scratch_fs
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

