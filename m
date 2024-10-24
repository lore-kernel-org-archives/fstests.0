Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CEF1E32D0
	for <fstests@vger.kernel.org>; Thu, 24 Oct 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776303; cv=none; b=e45/6W4QcQB9LWwc7DqilbZVpLgYPhk3TksUKVPT7NSAHj2Zh2q1GZ12BWLfOX5vMeQTy8TEhxzDUZ/v1NtWS2PnObh0igMaMR8Z0zETTEq9fUpfB59niP2FrHecgYWRLalY9a1iqsBEWLA7jSlcyCNuM5knJV0VO/U6b3PKDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776303; c=relaxed/simple;
	bh=sCPp8eNkui5TGNkGrJxN0F/c58rwd7lkBJs+tCntlQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQN2bkbslCOIh8pD6zTts7q3P03/94xpsOkZl2TqDb/hAmRKNqCc3EMj6a2mVb7Hj3TDX1yRGk2psu4KYLyUqQewp7u7gM3wGovLKJIQrTPhK5Q/EXpvSSbBanKREBjfgkw6b+OvVuQnR+oTxPVNec8lmIoi+rrznIb8OCZt0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0u2f0HU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0u2f0HU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729776300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LV+oh1RkjuJCTI87bth73hem1xdoRNhxaUyaCPHSaOE=;
	b=h0u2f0HUkmZj8J4qDl+erDfLCYipzcfUNdgNSE6ae8SZgAHcrdNjTyrC2OwseMg9FIngyR
	yC01AwgVu6u5OvhHsmJ7YgCfzGClDa5KBKbEF/kv9WPnyI79yZrInhzgKPtKEVa2VvuHPO
	xuakqg2XAzuNjDTrPaHnXqsT0QNix7c=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Z2jkI0D3M8W9uGK_I55vKA-1; Thu, 24 Oct 2024 09:24:56 -0400
X-MC-Unique: Z2jkI0D3M8W9uGK_I55vKA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71e49ae1172so979025b3a.2
        for <fstests@vger.kernel.org>; Thu, 24 Oct 2024 06:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729776293; x=1730381093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV+oh1RkjuJCTI87bth73hem1xdoRNhxaUyaCPHSaOE=;
        b=tvqBKqUtd4HyJZoFqDgYHeEr8ikD4zX9osl3Flxr2N2AY0fKa0jCbU1tXPC5u+Nqeo
         Ja6V8cebsaUV0EKnFEV5g9Ug2Ec554uIWA9iksCCJuIM+G0K+9v+P2IRU+fYH4QBQbTX
         PaAAoYtRotQENdpCXS5AokK2aqYn7z5yCHP4WbIZjz1s8OW42hkp3qHT5kz/Jd4Xo2Yn
         +ajiwwRqKvm3tVivfhf2y2ICQu8nrYpKVJROrO6EgCYFmKt6doPG+ifX/21WBrKygoSf
         9RXqWUJ91YYLL43/j6JQATicwRKchtekktyzxJbJkb02c+pWNam8yb+DR0waYaaWzezW
         GSPg==
X-Forwarded-Encrypted: i=1; AJvYcCXJQMd6G4JHy72IvJlwtupZJbmSZvHS8GtQEPIiLuJV3PxfIlPRYOhatWk7EX+zr6EVVQqAQlDU@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqPAWMhNkydF7VTfaZiPvGVj36Ek8m0YY5zhS2a4KNVv7aMgN
	7QZ0pph7+619KcwTAH2CqthoAj8rGvxQa/23Qu9eUMc/LcpyaezzkwSNfbVYXBeEalbsVgBsb4q
	tH+Y7ESAEv/eRjt5ZNA/eSQhkWND3SeomRhYKq3UlXwyhWe+IujCfTEc=
X-Received: by 2002:a05:6a00:1995:b0:71e:6046:87c2 with SMTP id d2e1a72fcca58-72045fa867emr2321578b3a.26.1729776293596;
        Thu, 24 Oct 2024 06:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaEabVORN+hZYi8D+0zykQc3dA+B8iN1SxPjM6E0B/i4J8uOChVFt1q02hrMCsdVmx93i2gQ==
X-Received: by 2002:a05:6a00:1995:b0:71e:6046:87c2 with SMTP id d2e1a72fcca58-72045fa867emr2321543b3a.26.1729776293103;
        Thu, 24 Oct 2024 06:24:53 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab1dc6bsm8546749a12.23.2024.10.24.06.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:24:52 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:24:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, zlang@kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: remove the post-EOF prealloc tests from the auto
 and quick groups
Message-ID: <20241024132448.uoms7lvnaanoysfi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241023103930.432190-1-hch@lst.de>
 <20241023172351.GG21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023172351.GG21853@frogsfrogsfrogs>

On Wed, Oct 23, 2024 at 10:23:51AM -0700, Darrick J. Wong wrote:
> On Wed, Oct 23, 2024 at 12:39:30PM +0200, Christoph Hellwig wrote:
> > These fail for various non-default configs like DAX, alwayscow and
> > small block sizes.
> 
> Shouldn't we selectively _notrun these tests for configurations where
> speculative/delayed allocations don't work?
> 
> I had started on a helper to try to detect the situations where the
> tests cannot ever pass, but never quite finished it:
> 
> diff --git a/common/xfs b/common/xfs
> index 557017c716e32c..5cb2c102e2c04f 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -2238,3 +2238,34 @@ _scratch_xfs_scrubbed() {
>  
>  	$XFS_SCRUBBED_PROG "${scrubbed_args[@]}" "$@" $SCRATCH_MNT
>  }
> +
> +# Will this filesystem create speculative post-EOF preallocations for a file?
> +_require_speculative_prealloc()
> +{
> +	local file="$1"
> +	local tries
> +	local overage
> +
> +	# Now that we have background garbage collection processes that can be
> +	# triggered by low space/quota conditions, it's possible that we won't
> +	# succeed in creating a speculative preallocation on the first try.
> +	for ((tries = 0; tries < 5; tries++)); do
> +		rm -f $file
> +
> +		# a few file extending open-write-close cycles should be enough
> +		# to trigger the fs to retain preallocation. write 256k in 32k
> +		# intervals to be sure
> +		for i in $(seq 0 32768 262144); do
> +			$XFS_IO_PROG -f -c "pwrite $i 32k" $file >> $seqres.full
> +
> +			# Do we have more blocks allocated than what we've
> +			# written so far?
> +			overage="$(stat -c '%b * %B - %s' $file | bc)"
> +			test "$overage" -gt 0 && return 0
> +		done
> +	done
> +
> +	_notrun "Warning: No speculative preallocation for $file after " \
> +			"$tries iterations." \
> +			"Check use of the allocsize= mount option."
> +}

Before we remove these cases from auto group, if above function can help these
test cases to be stable passed as expected. I'm glad to consider it at first :)

Thanks,
Zorro

> 
> --D
> 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  tests/xfs/629 | 2 +-
> >  tests/xfs/630 | 2 +-
> >  tests/xfs/631 | 2 +-
> >  tests/xfs/632 | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tests/xfs/629 b/tests/xfs/629
> > index 58beedc03a8b..e2f5af085b5f 100755
> > --- a/tests/xfs/629
> > +++ b/tests/xfs/629
> > @@ -8,7 +8,7 @@
> >  #
> >  
> >  . ./common/preamble
> > -_begin_fstest auto quick prealloc rw
> > +_begin_fstest prealloc rw
> >  
> >  . ./common/filter
> >  
> > diff --git a/tests/xfs/630 b/tests/xfs/630
> > index 939d8a4ac37f..df7ca60111d6 100755
> > --- a/tests/xfs/630
> > +++ b/tests/xfs/630
> > @@ -8,7 +8,7 @@
> >  #
> >  
> >  . ./common/preamble
> > -_begin_fstest auto quick prealloc rw
> > +_begin_fstest prealloc rw
> >  
> >  . ./common/filter
> >  
> > diff --git a/tests/xfs/631 b/tests/xfs/631
> > index 55a74297918a..1e50bc033f7c 100755
> > --- a/tests/xfs/631
> > +++ b/tests/xfs/631
> > @@ -8,7 +8,7 @@
> >  #
> >  
> >  . ./common/preamble
> > -_begin_fstest auto quick prealloc rw
> > +_begin_fstest prealloc rw
> >  
> >  . ./common/filter
> >  
> > diff --git a/tests/xfs/632 b/tests/xfs/632
> > index 61041d45a706..3b1c61fdc129 100755
> > --- a/tests/xfs/632
> > +++ b/tests/xfs/632
> > @@ -9,7 +9,7 @@
> >  #
> >  
> >  . ./common/preamble
> > -_begin_fstest auto prealloc rw
> > +_begin_fstest prealloc rw
> >  
> >  . ./common/filter
> >  
> > -- 
> > 2.45.2
> > 
> > 
> 

