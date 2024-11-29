Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52233C5
	for <fstests@vger.kernel.org>; Fri, 29 Nov 2024 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732851280; cv=none; b=E/L7o+dx4etI5eNMP+VgIYlLAyO4E2QhydDxmG7i051M5hauU70No7s/2yKXG1RA5LIpI+7rv+ESaXdDq5osoUTnp+zwmK9PwKQ41PvEtgsFIHeYVacQtpyxzPEMkO52fzgbF9nsTsF4z4bikRi9T6rRnBoU69RlCDnqwmiYOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732851280; c=relaxed/simple;
	bh=b07I9fIkkl7CeSEZv1R+QFp5uyWYdtH5PAa2I7mPplQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icrr7JeWFLOI3H13aFIG4IxyyeriFl0ZVZMe4qUQykzhmqBKSuXZSJmVsU5kpnlkrR61jrR1fRfkuAyBFrNY+ityKnUWAFD5grHSrQY7pe4WmxIA/QZj0ODkuvlxaQHpWenXO8Ue2ku3XX7BPQqJE6YjhEZVNEoUnFsYi/+f/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4E2+B7N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4E2+B7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732851277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hwFiIeKgrPXiBfl6+vpO+U1J2jSnelqnp959N8eo+0=;
	b=A4E2+B7N4bo1OGGpfxwMnhjWiEi0nmStDRqJYI88/ZfCjUvEMPsSVP9foZHhFMwgfvWBnx
	W2hAXZ0RY1ft1hQX87Z81/B1Tis27K2XDVsaN90G1CSDBVRW0SBWrA8C2QVD0ikzBN1KnU
	FQDAb+7/AydlkPn9TPiuC65BcSlY+AI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-joa0rcZSPhmf8VYxpEMG_g-1; Thu, 28 Nov 2024 22:34:35 -0500
X-MC-Unique: joa0rcZSPhmf8VYxpEMG_g-1
X-Mimecast-MFC-AGG-ID: joa0rcZSPhmf8VYxpEMG_g
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7251c893b4cso1746842b3a.3
        for <fstests@vger.kernel.org>; Thu, 28 Nov 2024 19:34:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732851274; x=1733456074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hwFiIeKgrPXiBfl6+vpO+U1J2jSnelqnp959N8eo+0=;
        b=wweyqEg5tRdTyyKapMR48Ou/XA4+xsD9oTWzjks+XlcVe8gyIRPSDxPe3gmlxY5qDE
         tt1VINpS73MR1BMNSqu+zaRwy41lXJ4HVK6IhuEFDc1LKLadajcJdkMf78KJPukpY51H
         zw+knBdHWccQbmNbOoAxmf5CoORBucPaltZBmpDmcD+oBKIZcK22389pJvFV/REap1r5
         E7aWn10mWWgt2VkQ1kPVwGYVh8/lZoYTIqtg7KRV4PlWxFiBYrudctgYItv4a1YmrXaA
         2YMYuxdwpR85i0dl+ktsZoiZe9tE7mSixI8Q1TcKEOB8rTzVPj1/BR3ek6sgLI7PdU44
         zOVw==
X-Gm-Message-State: AOJu0YwBBY2VlhTh5oyFU2adY4aEkLm79OEqfGytDRqrRYgtdYTu5OCV
	0V0H+MFFZTAIemBySL6uzx3J2M3Yd4Ypy49URPm8U9iOLVgKmvF2o4Q2n/HDlPNQDRKhhsNRKnJ
	abEjnJNxo5Wyao2rePnCy21HgLJWZEKjbBTv75D827dRPS7cg9S+F3o5YKrVLmiA+Aw==
X-Gm-Gg: ASbGnctGaj4wxcJtalvgwQWGd43ThWR2nyexiJ6eYEc1x3H9dhuyRv+QfOHPH4jmSEV
	yxfnEa9K2B6RjPuFFUiZ8ePMZqSfT9OPlJoZCfmqbHaMqLgWQF/RatPa3oZ3AkpB5wCiceEaknF
	S5PGe1DD6gbgcFHlopM/DjtVNOkc5QSfz1+hLmLHvCIKWbaTAnnDd/Kdhi27WP+H6MP0LWib74T
	t1smJe2TwuYXO6GF1o6DM1jm/9PxIv1/0THNN9gM+nV+wGs46N+3TUL5V0EwFcz+oyK5sjxWP4u
	mzwhnD0uRnnVz10=
X-Received: by 2002:a17:902:ea12:b0:20b:b40b:3454 with SMTP id d9443c01a7336-21500fe71f9mr111011415ad.0.1732851274459;
        Thu, 28 Nov 2024 19:34:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV6NTBJQ8fhyNbPU4JHKIWGwwWhzg/D0jJtDWpcOgTF803SX9cf4k4MKPSQyKQ1+lBXfkeDw==
X-Received: by 2002:a17:902:ea12:b0:20b:b40b:3454 with SMTP id d9443c01a7336-21500fe71f9mr111011215ad.0.1732851274047;
        Thu, 28 Nov 2024 19:34:34 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219b1403sm21249505ad.242.2024.11.28.19.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 19:34:33 -0800 (PST)
Date: Fri, 29 Nov 2024 11:34:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 25/40] fstests: scale some tests for high CPU count sanity
Message-ID: <20241129033429.w3mh6pbn5jq23sng@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-26-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127045403.3665299-26-david@fromorbit.com>

On Wed, Nov 27, 2024 at 03:51:55PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Several tests use lots of processes to stress the filesystem. many
> of them haven't really considered what this means for running the
> test on high CPU machines (e.g. >32p) and the potential contention
> and performance issues this might trigger.
> 
> Some of these tests simply need to increase the size of the journal.
> Some need to run on filesystems with high inherent concurrency (e.g.
> larger AG count). Some need more efficient/faster file creation. And
> so on.
> 
> This commit is a collection of those sorts of changes to improve
> runtimes on high CPU count machines.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  src/aio-dio-regress/aio-last-ref-held-by-io.c | 5 ++++-
>  tests/generic/251                             | 5 ++++-
>  tests/generic/323                             | 7 +++++--
>  tests/generic/530                             | 2 +-
>  tests/generic/531                             | 8 +++++++-
>  tests/xfs/013                                 | 4 ++--
>  tests/xfs/076                                 | 6 +++---
>  tests/xfs/176                                 | 6 +++---
>  tests/xfs/297                                 | 4 +++-
>  tests/xfs/501                                 | 2 +-
>  tests/xfs/502                                 | 2 +-
>  11 files changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/src/aio-dio-regress/aio-last-ref-held-by-io.c b/src/aio-dio-regress/aio-last-ref-held-by-io.c
> index a70f2a9b7..7106e30a9 100644
> --- a/src/aio-dio-regress/aio-last-ref-held-by-io.c
> +++ b/src/aio-dio-regress/aio-last-ref-held-by-io.c
> @@ -85,11 +85,14 @@ aio_test_thread(void *data)
>  	/*
>  	 * Problems have been easier to trigger when spreading the
>  	 * workload over the available CPUs.
> +	 *
> +	 * If CPU hotplug is active, this can randomly fail so dump the error
> +	 * to stderror so it can be filtered out easily by the caller.
>  	 */
>  	CPU_ZERO(&cpuset);
>  	CPU_SET(mycpu, &cpuset);
>  	if (sched_setaffinity(mytid, sizeof(cpuset), &cpuset)) {
> -		printf("FAILED to set thread %d to run on cpu %ld\n",
> +		fprintf(stderr, "FAILED to set thread %d to run on cpu %ld\n",
>  		       mytid, mycpu);
>  	}
>  
> diff --git a/tests/generic/251 b/tests/generic/251
> index b432fb119..98986469e 100755
> --- a/tests/generic/251
> +++ b/tests/generic/251
> @@ -175,9 +175,12 @@ nproc=20
>  # Copy $here to the scratch fs and make coipes of the replica.  The fstests
>  # output (and hence $seqres.full) could be in $here, so we need to snapshot
>  # $here before computing file checksums.
> +#
> +# $here/* as the files to copy so we avoid any .git directory that might be
> +# much, much larger than the rest of the fstests source tree we are copying.
>  content=$SCRATCH_MNT/orig
>  mkdir -p $content
> -cp -axT $here/ $content/
> +cp -ax $here/* $content/

Hi Dave,

Darrick sent a patch to review this line:
https://lore.kernel.org/fstests/173258395238.4031902.16373799205312238046.stgit@frogsfrogsfrogs/T/#u

Please help to review, if you don't need this change anymore, I'll fix this
conflict (by removing your above change on g/251) when I merge this patch.

Thanks,
Zorro

>  
>  mkdir -p $tmp
>  
> diff --git a/tests/generic/323 b/tests/generic/323
> index 457253fee..2dde04d06 100755
> --- a/tests/generic/323
> +++ b/tests/generic/323
> @@ -23,12 +23,15 @@ _require_aiodio aio-last-ref-held-by-io
>  testfile=$TEST_DIR/aio-testfile
>  $XFS_IO_PROG -ftc "pwrite 0 10m" $testfile | _filter_xfs_io
>  
> -$AIO_TEST 0 100 $testfile
> +# This can emit cpu affinity setting failures that aren't considered test
> +# failures but cause golden image failures. Redirect the test output to
> +# $seqres.full so that it is captured but doesn't directly cause test failures.
> +$AIO_TEST 0 100 $testfile 2>> $seqres.full
>  if [ $? -ne 0 ]; then
>  	exit $status
>  fi
>  
> -$AIO_TEST 1 100 $testfile
> +$AIO_TEST 1 100 $testfile 2>> $seqres.full
>  if [ $? -ne 0 ]; then
>  	exit $status
>  fi
> diff --git a/tests/generic/530 b/tests/generic/530
> index 2e47c3e0c..18256b870 100755
> --- a/tests/generic/530
> +++ b/tests/generic/530
> @@ -22,7 +22,7 @@ _require_scratch_shutdown
>  _require_metadata_journaling
>  _require_test_program "t_open_tmpfiles"
>  
> -_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
>  _scratch_mount
>  
>  # Set ULIMIT_NOFILE to min(file-max / 2, 50000 files per LOAD_FACTOR)
> diff --git a/tests/generic/531 b/tests/generic/531
> index 0e3564fd4..ed6c3f911 100755
> --- a/tests/generic/531
> +++ b/tests/generic/531
> @@ -21,7 +21,13 @@ _require_scratch
>  _require_xfs_io_command "-T"
>  _require_test_program "t_open_tmpfiles"
>  
> -_scratch_mkfs >> $seqres.full 2>&1
> +# On high CPU count machines, this runs a -lot- of create and unlink
> +# concurrency. Set the filesytsem up to handle this.
> +if [ $FSTYP = "xfs" ]; then
> +	_scratch_mkfs "-d agcount=32" >> $seqres.full 2>&1
> +else
> +	_scratch_mkfs >> $seqres.full 2>&1
> +fi
>  _scratch_mount
>  
>  # Try to load up all the CPUs, two threads per CPU.
> diff --git a/tests/xfs/013 b/tests/xfs/013
> index fd3d8c64c..5a92ef084 100755
> --- a/tests/xfs/013
> +++ b/tests/xfs/013
> @@ -28,7 +28,7 @@ _create()
>  	mkdir -p $dir
>  	for i in $(seq 0 $count)
>  	do
> -		touch $dir/$i 2>&1 | filter_enospc
> +		echo -n > $dir/$i 2>&1 | filter_enospc
>  	done
>  }
>  
> @@ -42,7 +42,7 @@ _rand_replace()
>  	do
>  		file=$((RANDOM % count))
>  		rm -f $dir/$file
> -		touch $dir/$file 2>&1 | filter_enospc
> +		echo -n > $dir/$file 2>&1 | filter_enospc
>  	done
>  }
>  
> diff --git a/tests/xfs/076 b/tests/xfs/076
> index 840617ccb..e315a067c 100755
> --- a/tests/xfs/076
> +++ b/tests/xfs/076
> @@ -47,10 +47,10 @@ _alloc_inodes()
>  	dir=$1
>  
>  	i=0
> -	while [ true ]; do
> -		touch $dir/$i 2>> $seqres.full || break
> +	( while [ true ]; do
> +		echo -n > $dir/$i || break
>  		i=$((i + 1))
> -	done
> +	done ) >> $seqres.full 2>&1
>  }
>  
>  
> diff --git a/tests/xfs/176 b/tests/xfs/176
> index 8e5951ec1..1aa8cde38 100755
> --- a/tests/xfs/176
> +++ b/tests/xfs/176
> @@ -68,10 +68,10 @@ _alloc_inodes()
>  	dir=$1
>  
>  	i=0
> -	while [ true ]; do
> -		echo -n > $dir/$i >> $seqres.full 2>&1 || break
> +	( while [ true ]; do
> +		echo -n > $dir/$i || break
>  		i=$((i + 1))
> -	done
> +	done ) >> $seqres.full 2>&1
>  }
>  
>  # Find a sparse inode cluster after logend_agno/logend_agino.
> diff --git a/tests/xfs/297 b/tests/xfs/297
> index f9cd2ff12..af6af601a 100755
> --- a/tests/xfs/297
> +++ b/tests/xfs/297
> @@ -34,7 +34,9 @@ _scratch_mount
>  STRESS_DIR="$SCRATCH_MNT/testdir"
>  mkdir -p $STRESS_DIR
>  
> -_run_fsstress_bg -d $STRESS_DIR -n 1000 -p 1000 $FSSTRESS_AVOID
> +# turn off sync as this can lead to near deadlock conditions due to every
> +# fsstress process lockstepping against freeze on large CPU count machines
> +_run_fsstress_bg -d $STRESS_DIR -f sync=0 -n 1000 -p 1000 $FSSTRESS_AVOID
>  
>  # Freeze/unfreeze file system randomly
>  echo "Start freeze/unfreeze randomly" | tee -a $seqres.full
> diff --git a/tests/xfs/501 b/tests/xfs/501
> index 1da4cbf92..678c51b52 100755
> --- a/tests/xfs/501
> +++ b/tests/xfs/501
> @@ -33,7 +33,7 @@ _require_xfs_sysfs debug/log_recovery_delay
>  _require_scratch
>  _require_test_program "t_open_tmpfiles"
>  
> -_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mkfs "-l size=256m" >> $seqres.full 2>&1
>  _scratch_mount
>  
>  # Set ULIMIT_NOFILE to min(file-max / 2, 30000 files per LOAD_FACTOR)
> diff --git a/tests/xfs/502 b/tests/xfs/502
> index 52b8e95a2..10b0017f6 100755
> --- a/tests/xfs/502
> +++ b/tests/xfs/502
> @@ -23,7 +23,7 @@ _require_xfs_io_error_injection "iunlink_fallback"
>  _require_scratch
>  _require_test_program "t_open_tmpfiles"
>  
> -_scratch_mkfs | _filter_mkfs 2> $tmp.mkfs > /dev/null
> +_scratch_mkfs "-l size=256m" | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  cat $tmp.mkfs >> $seqres.full
>  . $tmp.mkfs
>  
> -- 
> 2.45.2
> 
> 

