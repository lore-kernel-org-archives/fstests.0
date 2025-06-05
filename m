Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D9E26AD0
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141042; cv=none; b=WKhcCluK8EBUIYTMgrb1ov22yzE6vZyruXfqhmuR5jzqAu+X/G7+ZPtSuXrenihEPbvq1ZnCIOE5X8szHFziZvNiiEUnZ/w3iYv+XDNN3v8SpDDadhLvXAQ1dLyEqrMniXvqwXiKd7BmfAshcvzlH1q+7uuxRAtqYc8d6+RFBeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141042; c=relaxed/simple;
	bh=oXYYDzTPGNs+ypmcj1eS5D+KOVWsyqBy1Q0BqMjYayk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR99ROGLb6x0aLhxiuyPwNyiSJKlllPiEMVGG/kupN6syJw8vlnHrNZkbYUjXfnqLlT+p490pSelmjHaRggVYN+qacyX60atu+u00c28+K70L4ngdFuwCKhV1XAS2odYcf3l/K17361c6rJ6ADoA2ONTXhv2pf9BEdLyCSSk44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbPHXwta; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbPHXwta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749141039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L12XX5ma/UkaofRsTldbekTX43EjtYhEhxzfoIm0/dw=;
	b=PbPHXwtacnYGRyZtaK+m4sbZE39ZRr7zHEn5trrR/vNEsCl7AHVXoLpHQfWgqbokCHxsvd
	W20KID0wUVSeKXpNbixRZDFuavTguBu21/0CbDpdMujt9l2vIndRAsNo53eHZ5HWqjU8nc
	Bo7BsdSyhbFvAH7i3L9v/pLOOfCXcGE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-PhedGFAnPCuUl4kMZUvy9w-1; Thu, 05 Jun 2025 12:30:38 -0400
X-MC-Unique: PhedGFAnPCuUl4kMZUvy9w-1
X-Mimecast-MFC-AGG-ID: PhedGFAnPCuUl4kMZUvy9w_1749141037
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235e7550f7bso12081515ad.3
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 09:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749141037; x=1749745837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L12XX5ma/UkaofRsTldbekTX43EjtYhEhxzfoIm0/dw=;
        b=EEIh6LifJxdND3rbzmirLFbcCeql2rdXUvrxNKXngFoHt0zmZiJsLo3MMZFgb4x0E7
         dh1SoJgd47Rs6t9ss6fR603aCa/dRIUtwg8z/r98WSb8F83OWZRXrcAI2GS78BSAS6a4
         gOPB3zFETMNbu2FWf0/zawPcT6PHp2w6f3K/dcX1ml+AmMdbKahlC5CQZzopOepYu6hR
         amLtn7lfS4th1oNJtB4oGBcQidPqNfOybBU0kumhD3LsWdtayeZ/DrhyCfcRjxr+ExNj
         Y9hv3CLt6hXmGi0OPRBITp7ykZbM24ae1IvOg04O53d6/upWMHKZCKTbleMYCXTEpH1J
         8Yqg==
X-Gm-Message-State: AOJu0YwycGqArC0b48SNRtfm/THhepZJP0YTAEkxG0ZPJdHkaYAHQzyB
	OtgMpoAbH1IOKOopHubkhBEAn+SeAMj8l7jsV3vcKpAbiczRV5eilFC20xq5GEUN7LPVo348yYk
	h+n37pGBX17kTOl1dKkKwxU2EoB5VY2RtexV1AT159KLAHwvXXuO4TplpmIw=
X-Gm-Gg: ASbGncsnLu2w2gEmq7hUhQRKVzGDPX/2TFBxc7brQIk2J15y4vY2Xha+nRQ0PcKEF7e
	hxE8yPo0ruoJELzN1uJa3kc2EdNX6sn12FaHJgcr4kh0t3tR5rzDaAZdOj4viQ3nFmXxjszcVze
	j5H3d6PsfS8R6jBvpKKkxmt+H4sbNzxxrvFwI263HO6inMJHuHvacG2lIH61hQypp2s+/S4ga4l
	Oc22CFf129tp00A83xpQGaoUbKq9jr7Yuhr6Vxuj9ECbySr5/KTdbyYHaFoyUexrVCXVttRAR5j
	+dhmJYQnzmwoXyWyyfygHdH1tNco3kQSYsYUKoFtShlkWym1gaKz
X-Received: by 2002:a17:902:f602:b0:234:d7c5:a0f6 with SMTP id d9443c01a7336-23601d4ed01mr216225ad.31.1749141036975;
        Thu, 05 Jun 2025 09:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnt68u95749X80LDtx+XH9djrLQpxwmELcFErgZKaQ0qOXdRdzUH8UJYVv5Idd6yTk5GqTHg==
X-Received: by 2002:a17:902:f602:b0:234:d7c5:a0f6 with SMTP id d9443c01a7336-23601d4ed01mr215185ad.31.1749141036266;
        Thu, 05 Jun 2025 09:30:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd949bsm121673255ad.91.2025.06.05.09.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:30:35 -0700 (PDT)
Date: Fri, 6 Jun 2025 00:30:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/094: fix test ignoring failures
Message-ID: <20250605163032.kroyvzlhwjcdfgir@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <7425c940548e19ab996b8458717dd3c3c3c55630.1748518250.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7425c940548e19ab996b8458717dd3c3c3c55630.1748518250.git.fdmanana@suse.com>

On Thu, May 29, 2025 at 12:33:13PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The test is ignoring failures completely:
> 
> 1) If mounting the scratch device fails it redirects both stdout and
>    stderr to /dev/null, so it gets unnoticed and the test runs against
>    a different fs than expected (in my test environment $SCRATCH_MNT
>    points to a directory in an ext4 fs for example but I want to test
>    btrfs);

Yeah, I really don't recommend redirecting all outputs of _scratch_mkfs
to /dev/null. Some old cases might still do that.

> 
> 2) We are redirecting the stdout and stderr of fiemap-tester to the
>    $seqres.full file, so if it fails it gets completely unnoticed and
>    the test succeeds.

I'm surprised that this test case neither check the test output nor
check the return value of src/fiemap-tester.

> 
> For the first issue fix this by not even using the scratch filesystem and
> use instead the test filesystem, since the test creates a 2M file which
> is small enough.
> 
> For the second issue simply don't redirect the stdout and stderr, so that
> if the test program fails it causes a mismatch with the golden output,
> making the test fail.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

This change makes sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/094 | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/generic/094 b/tests/generic/094
> index c82efced..6ae417c3 100755
> --- a/tests/generic/094
> +++ b/tests/generic/094
> @@ -9,18 +9,22 @@
>  . ./common/preamble
>  _begin_fstest auto quick prealloc fiemap
>  
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $tmp.*
> +	rm -f $fiemapfile
> +}
> +
>  # Import common functions.
>  . ./common/filter
>  
> -_require_scratch
> +_require_test
>  _require_odirect
>  _require_xfs_io_command "fiemap"
>  _require_xfs_io_command "falloc"
>  
> -_scratch_mkfs > /dev/null 2>&1
> -_scratch_mount > /dev/null 2>&1
> -
> -fiemapfile=$SCRATCH_MNT/$seq.fiemap
> +fiemapfile=$TEST_DIR/$seq.fiemap
>  
>  _require_test_program "fiemap-tester"
>  
> @@ -29,12 +33,10 @@ seed=`date +%s`
>  echo "using seed $seed" >> $seqres.full
>  
>  echo "fiemap run with sync"
> -$here/src/fiemap-tester -q -S -s $seed -r 200 $fiemapfile 2>&1 | \
> -	tee -a $seqres.full
> +$here/src/fiemap-tester -q -S -s $seed -r 200 $fiemapfile
>  
>  echo "fiemap run without sync"
> -$here/src/fiemap-tester -q -s $seed -r 200 $fiemapfile 2>&1 | \
> -	tee -a $seqres.full
> +$here/src/fiemap-tester -q -s $seed -r 200 $fiemapfile
>  
>  status=0
>  exit
> -- 
> 2.47.2
> 
> 

