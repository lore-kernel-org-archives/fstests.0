Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D7156C5F
	for <fstests@vger.kernel.org>; Sun,  1 Dec 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733055057; cv=none; b=hwO09auIAX5auxKpIgQWyJMomwSfHO/84Uc5S6VLVQqU8xC5Bel2NMLoNQiX6jzzMtlpUze0VmR0aKVQN44Dc5wAeTzMLgZAG80MU1GAKR4QQ47s+BvKpMgQu8ZGI+fWlkY/jpu29afTvhsvEL8Ojp0E9jo2tNT/FrVun0vTjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733055057; c=relaxed/simple;
	bh=4uOXDaJiaDXvmNA+WoWyoPf+SiWAteNLBPhvuMlVAQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA7liiOdNFBJXXI9IVf5lUzZFf5HnfGo0cDCyDQuV2oglsXpGYoEI7QVakF3nIr/1D975z8A4bStFcQ8HW1zOetMPFbsefH0mU1p8UY+R1SdoZE54Pg03DSzq6LFHhNRwzs3o6C3KyVcvcWT87ambsazNoqiKF3zjN2pBdqzKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9R1BOVj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9R1BOVj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733055053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5Wyd3DsRcG0qw26ejRRUhyVp1g4ADtchigsKHINtNY=;
	b=K9R1BOVjJbSnjSmzA0VN+NEkaV8EFfzdypRpltzIx+fjuEfoXGXx8jQxp9qkU6Cc0ATXWg
	TSJjpNtmHoJNj7SBwf975pYg4gJeX4sOineX8UZKXACqXof76qHxzQtzPBoFpeaFDp0NAw
	F+qL45Wrxndgsutl7hG+OkouwOgVOVQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-dgUGB5pcNoOQOJcKhSLsow-1; Sun, 01 Dec 2024 07:10:52 -0500
X-MC-Unique: dgUGB5pcNoOQOJcKhSLsow-1
X-Mimecast-MFC-AGG-ID: dgUGB5pcNoOQOJcKhSLsow
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-211fd7cfc4eso28908905ad.1
        for <fstests@vger.kernel.org>; Sun, 01 Dec 2024 04:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733055051; x=1733659851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5Wyd3DsRcG0qw26ejRRUhyVp1g4ADtchigsKHINtNY=;
        b=a5Q78/kp/iEu2C/St+H5bjVgce8wgODxxuu3WWQku1kbDCZtJt3J+0R18Yz2Csb0sC
         UGMoLehXzRi/mmjhT5wgvJ8oV4Fofz21CjRPJyxL+AKGDz/rufDmOdcYuKb2zTsv9AjS
         zM62AQyzDvqEL2HpWWbgZSKlitGy8bd9ZQlbqCzvhHaoesCScyPtcSR+qJxya74cf23q
         63P4w3vj+Q4KwKxVObcVvQN+BvRS4fKuHKrZGQBwOp5k/bPIjD1XQ2Vw6OpBgby3L6lU
         3amcl623dex12ERlHul7SinZId0vWSZAPO5+H+xUgolb43JslmHadh4OzlwZsC083Aq8
         R5CA==
X-Gm-Message-State: AOJu0YytIOhZSgt7MzrCUY2oYsAZJgUlI4wMKgKe6jX/WhOo7Wey2Dt1
	Fy7W/aml9OKKDxKQe473jOIDfyLHSc6uWh58cLmmGCjiiHrNqv7F2rDA8O42rHzBHeSVNXD2Mu5
	fDlAq+LI/RiXdOKtRof7pdImmEfjprCaREctfHskbEk8Jg3jyrZ7JCVQ=
X-Gm-Gg: ASbGncsP2Pkie/9VWx7F5/Ottn7aFWXMelSRAW4Rf+a3gYkMoJNxbuQ4zzUdZXbheOf
	8TA84cV4600YmWaZJ/7cX5wrU95Q7WKG0GZytDwZ9kg4h2/83COipAJ98/FHVJkGibSptjasWWp
	mgTRaj9Zuaj+obiRluF/i0T0l+nx2bI5CvMqWIul1gUDczeg6R0+43V4aWvNMP2+626l1gSyxWQ
	neKf1BvYCyEs7rKXMls95xysNlzVfH/BABuiPIO+w7+txBiXCVRB0EzY7wHLS1o/RErONpvWwY3
	LVOtsWXpl9kKacw=
X-Received: by 2002:a17:902:e88c:b0:215:8dc2:1a7b with SMTP id d9443c01a7336-2158dc21c46mr8162555ad.31.1733055051115;
        Sun, 01 Dec 2024 04:10:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsI6Su3n5/mPQ3XdxD07+AfkQZcnm7dmqD9dEeCx00OsLU7hgv//jpqNUbkbW/6N5a6zRJdA==
X-Received: by 2002:a17:902:e88c:b0:215:8dc2:1a7b with SMTP id d9443c01a7336-2158dc21c46mr8162295ad.31.1733055050770;
        Sun, 01 Dec 2024 04:10:50 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219673b9sm58535865ad.149.2024.12.01.04.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 04:10:49 -0800 (PST)
Date: Sun, 1 Dec 2024 20:10:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 30/40] fstests: don't use directory stacks
Message-ID: <20241201121046.qdgyjhuaovupjadw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
 <20241127045403.3665299-31-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127045403.3665299-31-david@fromorbit.com>

On Wed, Nov 27, 2024 at 03:52:00PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Using bash directory stacking (pushd, popd, etc) seems to be
> somewhat unreliable. I've been seeing occasional random failures
> from both pushd and popd commands that cause the test to fail, and
> there does not appear to be any reason for the failures occurring.
> 
> Rather than wasting time chasing ghosts, just get rid of the
> directory stacking altogether.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tests/generic/099 |  8 +++-----
>  tests/generic/109 |  5 +----
>  tests/generic/135 | 24 +++++++++++-------------
>  tests/generic/707 |  7 ++++---
>  4 files changed, 19 insertions(+), 25 deletions(-)
> 
> diff --git a/tests/generic/099 b/tests/generic/099
> index c7d5932b6..980fd38f3 100755
> --- a/tests/generic/099
> +++ b/tests/generic/099
> @@ -253,15 +253,13 @@ echo ""
>  echo "=== Recursive change ACL ==="
>  rm -fr root
>  mkdir root
> -pushd root >/dev/null
>  # create an arbitrary little tree
> -for i in 1 2 3 4 5 6 7 8 9 0
> -do
> +( cd root ; for i in 1 2 3 4 5 6 7 8 9 0; do
>  	mkdir -p a/$i
>  	mkdir -p b/c$i/$i
>  	touch a/$i/mumble
> -done
> -popd >/dev/null
> +done )
> +
>  chown -R 12345:54321 root
>  echo "Change #1..."
>  _runas -u 12345 -g 54321 -- chacl -r u::rwx,g::-w-,o::--x root
> diff --git a/tests/generic/109 b/tests/generic/109
> index 2b0b438cf..894e07167 100755
> --- a/tests/generic/109
> +++ b/tests/generic/109
> @@ -54,10 +54,7 @@ _scratch_mount >> $seqres.full 2>&1
>  # Test different directory sizes to test various directory formats
>  for f in 1 2 3 4 5 8 12 18 27 40 60 90 135 202 303 454 681 1020 1530 2295; do
>  	mkdir $SCRATCH_MNT/dir$f
> -	pushd $SCRATCH_MNT/dir$f >/dev/null
> -	filldir $f
> -	renamedir
> -	popd >/dev/null
> +	( cd $SCRATCH_MNT/dir$f ; filldir $f ; renamedir )
>  done
>  
>  status=0
> diff --git a/tests/generic/135 b/tests/generic/135
> index 30c52af72..cb9407fdf 100755
> --- a/tests/generic/135
> +++ b/tests/generic/135
> @@ -21,30 +21,28 @@ _scratch_mount
>  cd $SCRATCH_MNT
   ^^^^^^^^^^^^^^^

Below "_scratch_cycle_mount" fails, due to above line. I'll remove it.

Thanks,
Zorro

>  
>  # create file with async I/O
> -$XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x12 0 4k' async_file > /dev/null
> +$XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x12 0 4k' $SCRATCH_MNT/async_file > /dev/null
>  
>  # create file with sync I/O
> -$XFS_IO_PROG -f -s -c 'pwrite -b 4k -S 0x34 0 4k' sync_file > /dev/null
> +$XFS_IO_PROG -f -s -c 'pwrite -b 4k -S 0x34 0 4k' $SCRATCH_MNT/sync_file > /dev/null
>  
>  # create file with direct I/O
> -$XFS_IO_PROG -f -d -c 'pwrite -b 4k -S 0x56 0 4k' direct_file > /dev/null
> +$XFS_IO_PROG -f -d -c 'pwrite -b 4k -S 0x56 0 4k' $SCRATCH_MNT/direct_file > /dev/null
>  
>  # create file, truncate and then dirty again
> -$XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x78 0 4k' trunc_file > /dev/null
> -$XFS_IO_PROG -f -c 'truncate 2k' trunc_file > /dev/null
> -$XFS_IO_PROG -c 'pwrite 1k 0 1k' trunc_file > /dev/null
> +$XFS_IO_PROG -f -c 'pwrite -b 4k -S 0x78 0 4k' $SCRATCH_MNT/trunc_file > /dev/null
> +$XFS_IO_PROG -f -c 'truncate 2k' $SCRATCH_MNT/trunc_file > /dev/null
> +$XFS_IO_PROG -c 'pwrite 1k 0 1k' $SCRATCH_MNT/trunc_file > /dev/null
>  
> -pushd / > /dev/null
>  _scratch_cycle_mount
> -popd > /dev/null
>  
>  # check file size and contents
> -od -Ad -x async_file
> -od -Ad -x sync_file
> -od -Ad -x direct_file
> -od -Ad -x trunc_file
> +od -Ad -x $SCRATCH_MNT/async_file
> +od -Ad -x $SCRATCH_MNT/sync_file
> +od -Ad -x $SCRATCH_MNT/direct_file
> +od -Ad -x $SCRATCH_MNT/trunc_file
>  
> -rm -f async_file sync_file direct_file trunc_file
> +rm -f $SCRATCH_MNT/*
>  
>  status=0
>  exit 
> diff --git a/tests/generic/707 b/tests/generic/707
> index fd02eacf9..3d8fac4bd 100755
> --- a/tests/generic/707
> +++ b/tests/generic/707
> @@ -42,7 +42,7 @@ create_files()
>  	# We use slightly longer file name to make directory grow faster and
>  	# hopefully convert between various types
>  	for (( i = 0; i < $files; i++ )); do
> -		touch somewhatlongerfilename$i
> +		echo -n > somewhatlongerfilename$i
>  	done
>  }
>  
> @@ -50,12 +50,13 @@ for (( i = 0; i <= $moves; i++ )); do
>  	mkdir $SCRATCH_MNT/dir$i
>  done
>  
> +start_dir=$PWD
>  for (( l = 0; l < $loops; l++ )); do
>  	mkdir $SCRATCH_MNT/dir0/dir
> -	pushd $SCRATCH_MNT/dir0/dir &>/dev/null
> +	cd $SCRATCH_MNT/dir0/dir
>  	create_files &
>  	BGPID=$!
> -	popd &>/dev/null
> +	cd $start_dir
>  	for (( i = 0; i < $moves; i++ )); do
>  		mv $SCRATCH_MNT/dir$i/dir $SCRATCH_MNT/dir$((i+1))/dir
>  	done
> -- 
> 2.45.2
> 
> 

