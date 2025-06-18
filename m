Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45D93085B0
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270420; cv=none; b=a/ZMJ7cQNEho7DQS/XS2VoDfls43WnFxFqSJqOQ8m23SuUFu0rWNHETvy6TeEBrGw1u7czev7uHcoqdqrgrEmhNAyXGddttrAg/t3mFwaWj3tKS4mKMaXbtglhClsJ2Ui+TPnZeBpgnNnA5LlLaokR6dNDVSAXo0/XLk91EammU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270420; c=relaxed/simple;
	bh=6BJJDm/oATUxH19ZzgYWdB5L2G31btaks5q9oMRrhQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryE5w5Ec/Y3G42wTX8zxBel/W2YfavGtX1gmSfkGJGkFAnBQ8QGKIt5/6GXDtCd/zsGk7uyB8iq3Geneu6N1+4eHo8mfUs8hvIzMMzxOeBo4cQj9KfYWpnW5u5Pcy70hIjRl/GcKxOakquvt9Uv+5YkkaBTOKF8mRxGf0UR3Rxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F441csGi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F441csGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750270417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+0I0gZCEoq+8B1Ew5xwWmKe5kE4PTPDaeCojL2le2k=;
	b=F441csGio2xVYHclYcHw2Bj88cNOdG2kFgZQI5fH7tYjfTuWs5iJcjHEub2PpEVmcRq+wX
	Fbr9JY4jTlGcRLbwJ41DyKgVEjCiPDpp5Y/x1R0G/iKf5NRs7O9IBLZ98RiB8WPOWSK9/N
	lhCFb+vqkA3iL/aITdJzQyRV5215+ZM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-bwioiRDlN6SJOkM5ilPdJg-1; Wed, 18 Jun 2025 14:13:30 -0400
X-MC-Unique: bwioiRDlN6SJOkM5ilPdJg-1
X-Mimecast-MFC-AGG-ID: bwioiRDlN6SJOkM5ilPdJg_1750270408
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235dd77d11fso2305ad.0
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 11:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750270407; x=1750875207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+0I0gZCEoq+8B1Ew5xwWmKe5kE4PTPDaeCojL2le2k=;
        b=snG6p2Bsv63qxtjOaAsDIHQdJ6vblTiZ5Kcc+WLYHcTE5clGlo3xg5vvlwbqZsPjPF
         onWbvIjRqyqGAMBgEuBCaTzCyZCpNF2Elkt4/0kTj/ynh9zYUQN1Yzp4h/ETPd5qGKqT
         QVcoohIXHPwSoam9kj1DM3oiVicAWb4ONAiNIogLG8yvzA+mUHLSDmpasjBmxxdD9m1A
         jnQx1iDkwsyOONvkKNuc6Uqk42w+6+TmAF+tpVYDz+6d9vVEesAPSX6F/Ip92eP+Wkce
         1tpR6FyT7MOO/9owo3YP0BgSAelQZ6C9SNVXB0FsUOsdHdy/kxXiW944VRm/F9iXPc/K
         A2fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMSTB0kpHRMnM6je9YbbwkQhbI5aUk6iNK/VDo0Yhv+EwsJzx2IfkCCEDn+wa0n7MPA12uXGlD@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdWDYySzxmhg3Xbj9Qf+Kuu7rtaxIje3V6sTNDIlkuUqt36d6
	bVnWF5NE7hiy0P79q/IN61wy8cxrlOmGtM+nHJuY1bS5CpYQaRdOT+fbPvny3mqZDlb1v/J0Uf5
	Hy/CBEuWuRNHjSaFM6cMsKzlu1Q+Iv5kfHZ3laiWkzywQdLIQgY6QLMq95n0=
X-Gm-Gg: ASbGncuTetmt2bot1BU7/EmQJU7+xrc6jpngI2j7E22mQtK79OiNTfjnxEa/hNoOCQi
	GLO1JyYGm6Kxf3o5YLc7wRPvB0t3nLnNmXC/nc0wruiwA4ibLvIncs8KFlc15bguHwnW/gVitYS
	1W0059RVvV7ZrilgPwCSfgLrL9pCa44MH/n7RDUF//WN84TcvlRRLl70fhTNNzS/x5lvB+PXVSc
	qun3vM4SNPrPncI5ZSCe6zsFLRglxtCeWeY9iSQUk4KwiDdGleBdjQ1ic00lbbZA5gDIYJtuNYa
	gUvkZHOlSj87IuCcjEhzCyDRzPXRCPHnzEn9Z8Und6F5GYGgcClofhb2vknYWQw=
X-Received: by 2002:a17:903:19e3:b0:234:eb6:a35b with SMTP id d9443c01a7336-2366b3e365cmr307134205ad.44.1750270407458;
        Wed, 18 Jun 2025 11:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQb9r1o0enRKqYWd/jZnW4wLDAgBWgFlyMjLo9hFHIoxQ8aoB6OtLIDp3MCL+scJl/SBRbvA==
X-Received: by 2002:a17:903:19e3:b0:234:eb6:a35b with SMTP id d9443c01a7336-2366b3e365cmr307133865ad.44.1750270407095;
        Wed, 18 Jun 2025 11:13:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7832asm103634705ad.140.2025.06.18.11.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 11:13:26 -0700 (PDT)
Date: Thu, 19 Jun 2025 02:13:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: Catherine Hoang <catherine.hoang@oracle.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, djwong@kernel.org,
	john.g.garry@oracle.com, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com
Subject: Re: [PATCH v5 3/3] xfs: more multi-block atomic writes tests
Message-ID: <20250618181321.kcbeam5yhhnvlxpd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250616215213.36260-1-catherine.hoang@oracle.com>
 <20250616215213.36260-4-catherine.hoang@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616215213.36260-4-catherine.hoang@oracle.com>

On Mon, Jun 16, 2025 at 02:52:13PM -0700, Catherine Hoang wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Add xfs specific tests for realtime volumes and error recovery.
> 
> The first test validates multi-block atomic writes on a realtime file. We
> perform basic atomic writes operations within the advertised sizes and ensure
> that atomic writes will fail outside of these bounds. The hardware used in this
> test is not required to support atomic writes.
> 
> The second test verifies that a large atomic write can complete after a crash.
> The error is injected while attempting to free an extent. We ensure that this
> error occurs by first creating a heavily fragmented filesystem. After recovery,
> we check that the write completes successfully.
> 
> The third test verifies that a large atomic write on a reflinked file can
> complete after a crash. We start with two files that share the same data and
> inject an error while attempting to perform a write on one of the files. After
> recovery, we verify that these files now contain different data, indicating
> that the write has succeeded.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> ---

Similar review points as patch 2/3, but as cases in this patch are xfs only, so
_require_block_device might not be necessary.

Thanks,
Zorro

>  tests/xfs/1216     | 68 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1216.out |  9 ++++++
>  tests/xfs/1217     | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1217.out |  3 ++
>  tests/xfs/1218     | 60 +++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1218.out | 15 ++++++++++
>  6 files changed, 226 insertions(+)
>  create mode 100755 tests/xfs/1216
>  create mode 100644 tests/xfs/1216.out
>  create mode 100755 tests/xfs/1217
>  create mode 100644 tests/xfs/1217.out
>  create mode 100755 tests/xfs/1218
>  create mode 100644 tests/xfs/1218.out
> 
> diff --git a/tests/xfs/1216 b/tests/xfs/1216
> new file mode 100755
> index 00000000..694e3a98
> --- /dev/null
> +++ b/tests/xfs/1216
> @@ -0,0 +1,68 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1216
> +#
> +# Validate multi-fsblock realtime file atomic write support with or without hw
> +# support
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw atomicwrites
> +
> +. ./common/atomicwrites
> +
> +_require_realtime
> +_require_scratch
> +_require_atomic_write_test_commands
> +_require_scratch_write_atomic_multi_fsblock
> +
> +echo "scratch device atomic write properties" >> $seqres.full
> +$XFS_IO_PROG -c "statx -r -m $STATX_WRITE_ATOMIC" $SCRATCH_RTDEV >> $seqres.full
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +echo "filesystem atomic write properties" >> $seqres.full
> +$XFS_IO_PROG -c "statx -r -m $STATX_WRITE_ATOMIC" $testfile >> $seqres.full
> +
> +sector_size=$(blockdev --getss $SCRATCH_RTDEV)
> +min_awu=$(_get_atomic_write_unit_min $testfile)
> +max_awu=$(_get_atomic_write_unit_max $testfile)
> +
> +$XFS_IO_PROG -f -c "falloc 0 $((max_awu * 2))" -c fsync $testfile
> +
> +# try outside the advertised sizes
> +echo "two EINVAL for unsupported sizes"
> +min_i=$((min_awu / 2))
> +_simple_atomic_write $min_i $min_i $testfile -d
> +max_i=$((max_awu * 2))
> +_simple_atomic_write $max_i $max_i $testfile -d
> +
> +# try all of the advertised sizes
> +for ((i = min_awu; i <= max_awu; i *= 2)); do
> +	$XFS_IO_PROG -f -c "falloc 0 $((max_awu * 2))" -c fsync $testfile
> +	_test_atomic_file_writes $i $testfile
> +	_simple_atomic_write $i $i $testfile -d
> +done
> +
> +# does not support buffered io
> +echo "one EOPNOTSUPP for buffered atomic"
> +_simple_atomic_write 0 $min_awu $testfile
> +
> +# does not support unaligned directio
> +echo "one EINVAL for unaligned directio"
> +if [ $sector_size -lt $min_awu ]; then
> +	_simple_atomic_write $sector_size $min_awu $testfile -d
> +else
> +	# not supported, so fake the output
> +	echo "pwrite: Invalid argument"
> +fi
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/1216.out b/tests/xfs/1216.out
> new file mode 100644
> index 00000000..51546082
> --- /dev/null
> +++ b/tests/xfs/1216.out
> @@ -0,0 +1,9 @@
> +QA output created by 1216
> +two EINVAL for unsupported sizes
> +pwrite: Invalid argument
> +pwrite: Invalid argument
> +one EOPNOTSUPP for buffered atomic
> +pwrite: Operation not supported
> +one EINVAL for unaligned directio
> +pwrite: Invalid argument
> +Silence is golden
> diff --git a/tests/xfs/1217 b/tests/xfs/1217
> new file mode 100755
> index 00000000..f3f59ae4
> --- /dev/null
> +++ b/tests/xfs/1217
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1217
> +#
> +# Check that software atomic writes can complete an operation after a crash.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw atomicwrites
> +
> +. ./common/atomicwrites
> +. ./common/inject
> +. ./common/filter
> +
> +_require_scratch
> +_require_atomic_write_test_commands
> +_require_scratch_write_atomic_multi_fsblock
> +_require_xfs_io_error_injection "free_extent"
> +_require_test_program "punch-alternating"
> +
> +echo "scratch device atomic write properties" >> $seqres.full
> +$XFS_IO_PROG -c "statx -r -m $STATX_WRITE_ATOMIC" $SCRATCH_RTDEV >> $seqres.full
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +echo "filesystem atomic write properties" >> $seqres.full
> +$XFS_IO_PROG -c "statx -r -m $STATX_WRITE_ATOMIC" $testfile >> $seqres.full
> +
> +bsize=$(_get_file_block_size $SCRATCH_MNT)
> +max_awu=$(_get_atomic_write_unit_max $testfile)
> +
> +test $max_awu -gt $((bsize * 2)) || \
> +	_notrun "max atomic write $max_awu less than 2 fsblocks $bsize"
> +
> +# Create a fragmented file to force a software fallback
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((max_awu * 2))" $testfile >> $seqres.full
> +$XFS_IO_PROG -f -c "pwrite -S 0x58 0 $((max_awu * 2))" $testfile.check >> $seqres.full
> +$here/src/punch-alternating $testfile
> +$here/src/punch-alternating $testfile.check
> +$XFS_IO_PROG -c "pwrite -S 0xcd 0 $max_awu" $testfile.check >> $seqres.full
> +$XFS_IO_PROG -c syncfs $SCRATCH_MNT
> +
> +# inject an error to force crash recovery on the second block
> +_scratch_inject_error "free_extent"
> +_simple_atomic_write 0 $max_awu $testfile -d >> $seqres.full
> +
> +# make sure we're shut down
> +touch $SCRATCH_MNT/barf 2>&1 | _filter_scratch
> +
> +# check that recovery worked
> +_scratch_cycle_mount
> +
> +test -e $SCRATCH_MNT/barf && \
> +	echo "saw $SCRATCH_MNT/barf that should not exist"
> +
> +if ! cmp -s $testfile $testfile.check; then
> +	echo "crash recovery did not work"
> +	md5sum $testfile
> +	md5sum $testfile.check
> +
> +	od -tx1 -Ad -c $testfile >> $seqres.full
> +	od -tx1 -Ad -c $testfile.check >> $seqres.full
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/xfs/1217.out b/tests/xfs/1217.out
> new file mode 100644
> index 00000000..6e5b22be
> --- /dev/null
> +++ b/tests/xfs/1217.out
> @@ -0,0 +1,3 @@
> +QA output created by 1217
> +pwrite: Input/output error
> +touch: cannot touch 'SCRATCH_MNT/barf': Input/output error
> diff --git a/tests/xfs/1218 b/tests/xfs/1218
> new file mode 100755
> index 00000000..799519b1
> --- /dev/null
> +++ b/tests/xfs/1218
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1218
> +#
> +# hardware large atomic writes error inject test
> +#
> +. ./common/preamble
> +_begin_fstest auto rw quick atomicwrites
> +
> +. ./common/filter
> +. ./common/inject
> +. ./common/atomicwrites
> +
> +_require_scratch_write_atomic
> +_require_scratch_write_atomic_multi_fsblock
> +_require_xfs_io_command pwrite -A
> +_require_xfs_io_error_injection "bmap_finish_one"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +echo "Create files"
> +file1=$SCRATCH_MNT/file1
> +touch $file1
> +
> +max_awu=$(_get_atomic_write_unit_max $file1)
> +test $max_awu -ge 4096 || _notrun "cannot perform 4k atomic writes"
> +
> +file2=$SCRATCH_MNT/file2
> +_pwrite_byte 0x66 0 64k $SCRATCH_MNT/file1 >> $seqres.full
> +cp --reflink=always $file1 $file2
> +
> +echo "Check files"
> +md5sum $SCRATCH_MNT/file1 | _filter_scratch
> +md5sum $SCRATCH_MNT/file2 | _filter_scratch
> +
> +echo "Inject error"
> +_scratch_inject_error "bmap_finish_one"
> +
> +echo "Atomic write to a reflinked file"
> +$XFS_IO_PROG -dc "pwrite -A -D -V1 -S 0x67 0 4096" $file1
> +
> +echo "FS should be shut down, touch will fail"
> +touch $SCRATCH_MNT/badfs 2>&1 | _filter_scratch
> +
> +echo "Remount to replay log"
> +_scratch_remount_dump_log >> $seqres.full
> +
> +echo "Check files"
> +md5sum $SCRATCH_MNT/file1 | _filter_scratch
> +md5sum $SCRATCH_MNT/file2 | _filter_scratch
> +
> +echo "FS should be online, touch should succeed"
> +touch $SCRATCH_MNT/goodfs 2>&1 | _filter_scratch
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/1218.out b/tests/xfs/1218.out
> new file mode 100644
> index 00000000..02800213
> --- /dev/null
> +++ b/tests/xfs/1218.out
> @@ -0,0 +1,15 @@
> +QA output created by 1218
> +Create files
> +Check files
> +77e3a730e3c75274c9ce310d7e39f938  SCRATCH_MNT/file1
> +77e3a730e3c75274c9ce310d7e39f938  SCRATCH_MNT/file2
> +Inject error
> +Atomic write to a reflinked file
> +pwrite: Input/output error
> +FS should be shut down, touch will fail
> +touch: cannot touch 'SCRATCH_MNT/badfs': Input/output error
> +Remount to replay log
> +Check files
> +0df1f61ed02a7e9bee2b8b7665066ddc  SCRATCH_MNT/file1
> +77e3a730e3c75274c9ce310d7e39f938  SCRATCH_MNT/file2
> +FS should be online, touch should succeed
> -- 
> 2.34.1
> 
> 

