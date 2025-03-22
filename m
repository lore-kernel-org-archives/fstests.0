Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767A22E3FF
	for <fstests@vger.kernel.org>; Sat, 22 Mar 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742655666; cv=none; b=IYvD5UmThdrb8INgml8uRFUqBuXvfD7paqWgdjG/7+dEHdFwZpWCEaZeGU9hsvnBVLDLjDokkgBpNDhA/KeKpvQTZxlKsrX/Q2ieJuKsKW88LHmVhUrvQCTXBOS5cJh4my4wwqVlt6fVNi5EyxV9ywX7p2V9CpwjACzyAdqojus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742655666; c=relaxed/simple;
	bh=vM909MV1xRIxsji7GkE0M2VaUres9qPw8Yj5ppl7xpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDDTIpG4uNI3Qlz+oK4PcQqxr4sOPoss+J5L7G+HmLbY0Usa9VX4T6xhsa/z93mvfcwDI656ExGoyFKS5PKU/1Ko5CnHTWsG7CBCZcEX++mHyKUksLyL8dq03QsVLKkZbWBnw2vdWivVeloH+0SDpJH+Cmn3ktC9dJIImA7WTGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjEkIxFs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjEkIxFs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742655663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QbEnZcYniNzHNoFgfqOJwSZI+W0C/5rQjUnSrB+X1hA=;
	b=QjEkIxFskNMnYxd3g2epzaPDhn7bE9ejJEyah++2diDhYlUlljYr18+2P464ejTIDdm6BX
	VSr5WE5ydWU7//XW0/Pqo/k8tOch3pSMU2QDlUHIPNfbrbQM/Cbqbt+slybUloCXILiQS8
	TZcbl8uxpRC4svEfCUdct2+sWcrfUus=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-Pdblu6JiOnqXy7QI8uNR0g-1; Sat, 22 Mar 2025 11:00:59 -0400
X-MC-Unique: Pdblu6JiOnqXy7QI8uNR0g-1
X-Mimecast-MFC-AGG-ID: Pdblu6JiOnqXy7QI8uNR0g_1742655658
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff6943febeso3985026a91.0
        for <fstests@vger.kernel.org>; Sat, 22 Mar 2025 08:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742655658; x=1743260458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbEnZcYniNzHNoFgfqOJwSZI+W0C/5rQjUnSrB+X1hA=;
        b=RW4of9EFoSzcTZW0bt3Mp0bK5VeRY4MFzqygc1xstYlJKHCI0XDxYti0j6gJb+1VOi
         TnXESviBmHdDo2ZeY0Ddv29YKTXCvMK6PiJ7QIzUKxkuZhrmmDQS6XHxJf+82hEe88bT
         Ct5oeTkPlQtXGoaeSh56+LqHv+rfudoZFfumT0nfha/SIOhzcCDrN5xXhUonB90uTm6J
         XpHAbwXveF5E2YP2uUvNWHC514uNBpi9ViWSoubjWYJu66PLhNzYG9YdSO3L4xS4/qMd
         p0aX3TGfHQIUVqgcAysRQe+fJgUtcE6rh8ZKCXCvuA1hCc1f7SoHscodxwWRM1pB9906
         FdTQ==
X-Gm-Message-State: AOJu0YwrSbm28TQmcvgzaM1QLKNm6bhnGsh13jlF8s/mVH+zcF5gWkzR
	t+T9ol30t/Z3wVZkODbaXma6TBwvx835l3qH9t2ner4krcJs960/HQXqcdehrguadgxb3Sz75VM
	WgpM6UJe1vRvK76p+551wReJvyhx0Bx+wtlHgq1ZAe61eKMRO+uP298o=
X-Gm-Gg: ASbGnctf4nGxx63mMtgKfDQ4+64uIDfG6N6bmm7m++g1hRbEKP/ulrn0gKDbwa4OdBg
	ShfGGnC+xlImf5U/HTTsuntIomiZG4FjEnINCWKLoOAWrmIKvcSUQb3WJPNPLQVYzHxS9OtYIO8
	6xZTsJmGZu4/LJFsCeCurlEqC3MZSQbspSgVNk6rVD6MNPpjaWFNk+WNMOYKeUBMgUkzSb7VEg3
	y3gV4ulqZaRZ2S+n6NOCTZ6Wquuu5lDXaGkMIbY3E7FcRhGvR5jUY5cNfFdSsaZaAUlvkzNYn2j
	46DZfK20KybLFwkimJOYnbec5szHpLl2nxT4M0YR5c+Ms+KA9zEaGgE9
X-Received: by 2002:a17:90b:1c82:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-301d42c585dmr18854443a91.8.1742655657880;
        Sat, 22 Mar 2025 08:00:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElL7bt3velPPnZFKVKH6XHvWvRuh8sAjZc620qhVFQ8x+hlGKxuMM7M4undR2VflifW9erPA==
X-Received: by 2002:a17:90b:1c82:b0:2fb:fe21:4841 with SMTP id 98e67ed59e1d1-301d42c585dmr18854397a91.8.1742655657401;
        Sat, 22 Mar 2025 08:00:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f3efbabsm4265051a91.0.2025.03.22.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 08:00:57 -0700 (PDT)
Date: Sat, 22 Mar 2025 23:00:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, hch@lst.de, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/4] xfs/818: fix some design issues
Message-ID: <20250322150053.l7tlptpqeiv6pg5m@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <174259233946.743619.993544237516250761.stgit@frogsfrogsfrogs>
 <174259234036.743619.7066882477727740142.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174259234036.743619.7066882477727740142.stgit@frogsfrogsfrogs>

On Fri, Mar 21, 2025 at 02:28:26PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> While QA'ing zoned filesystem support, I discovered some design errors
> in this test:
> 
> 1) Since we're test formatting a sparse file on an xfs filesystem,
> there's no need to play games with optimal device size; we can create
> a totally sparse file that's the same size as SCRATCH_DEV.
> 
> 2) mkfs.xfs cannot create realtime files, so if it fails with that,
> there's no need to continue the test.
> 
> 3) If mkfs -p fails for none of the proscribed reasons, it should exit
> the test.  The final cat $tmp.mkfs will take care of tweaking the golden
> output to register the test failure for further investigation.
> 
> Cc: <fstests@vger.kernel.org> # v2025.03.09
> Fixes: 6d39dc34e61e11 ("xfs: test filesystem creation with xfs_protofile")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Make sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/818 |   19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/tests/xfs/818 b/tests/xfs/818
> index aeb462353df7e9..bc809390b9e340 100755
> --- a/tests/xfs/818
> +++ b/tests/xfs/818
> @@ -75,9 +75,8 @@ _run_fsstress -n 1000 -d $SCRATCH_MNT/newfiles
>  make_stat $SCRATCH_MNT before
>  make_md5 $SCRATCH_MNT before
>  
> -kb_needed=$(du -k -s $SCRATCH_MNT | awk '{print $1}')
> -img_size=$((kb_needed * 2))
> -test "$img_size" -lt $((300 * 1024)) && img_size=$((300 * 1024))
> +scratch_sectors="$(blockdev --getsz $SCRATCH_DEV)"
> +img_size=$((scratch_sectors * 512 / 1024))
>  
>  echo "Clone image with protofile"
>  $XFS_PROTOFILE_PROG $SCRATCH_MNT > $testfiles/protofile
> @@ -99,7 +98,21 @@ if ! _try_mkfs_dev -p $testfiles/protofile $testfiles/image &> $tmp.mkfs; then
>  	if grep -q 'No space left on device' $tmp.mkfs; then
>  		_notrun "not enough space in filesystem"
>  	fi
> +
> +	# mkfs cannot create realtime files.
> +	#
> +	# If zoned=1 is in MKFS_OPTIONS, mkfs will create an internal realtime
> +	# volume with rtinherit=1 and fail, so we need to _notrun that case.
> +	#
> +	# If zoned=1 is /not/ in MKFS_OPTIONS, we didn't pass a realtime device
> +	# to mkfs so it will not create realtime files.  The format should work
> +	# just fine.
> +	if grep -q 'creating realtime files from proto file not supported' $tmp.mkfs; then
> +		_notrun "mkfs cannot create realtime files"
> +	fi
> +
>  	cat $tmp.mkfs
> +	exit
>  fi
>  
>  _mount $testfiles/image $testfiles/mount
> 

