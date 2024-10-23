Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BB4C3D0
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729657402; cv=none; b=WTEuFUgwoF6w99bKXmMOsY0WYU4ggw0R7tYDZrq7Xey3PnKqpKLTrCruFJ+Afoko1hVvnwa9kwXK4kSeQZbqlS4L++s1h6x7rfISAbSt1rExJdOIzu7ibF2oQ3Kgz+Eck7vFah6ceVVmjQFRp/HW/x8/jVCo3wJKbwRdABd7+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729657402; c=relaxed/simple;
	bh=L7+k1i8489tEGmKRN1ucBqp+4YMw4Bn0UzMNOhDXvDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOICe3ttbEMWdqdzEtOlS+MPk8dj6X2y5p9tSmnwWTH3umO1wOEqHMPbu38LU8PZMPuY3YiYyMVMi0+6E4TFoFYtS0aoJMQ038kPZgUBuD2pbHF6PdnoktpAORToLimNgbL3WruIue4CLNbovpBSpvCvESasJWIsdqfHgRtMAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcttSHgI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcttSHgI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729657399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OAkL5yCM6y7BDQ8CUK/gyfO8rGWWndsll5pUTO1Bpes=;
	b=QcttSHgIWLsqL0Vy/RhGI+22SEoaxc9/BUYKlPbFBdvCOk1JCiQxXAIkVwjXqsAWCgkIoq
	sUtjG2vT148QMzU3QLARwwlrPdyJPiflsw+/LdKlUSTS8I0RqSkDc9RpZmnTni6GopmPk7
	HS//4QsqoW16gL2WDX5xozTqxeblO5U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-fPw4k9c1Nvq5Xtc7d9Wn4g-1; Wed, 23 Oct 2024 00:23:17 -0400
X-MC-Unique: fPw4k9c1Nvq5Xtc7d9Wn4g-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-20b6144cc2aso4806645ad.0
        for <fstests@vger.kernel.org>; Tue, 22 Oct 2024 21:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729657396; x=1730262196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAkL5yCM6y7BDQ8CUK/gyfO8rGWWndsll5pUTO1Bpes=;
        b=hw2YaODypFfSgLg4Dz9b8/UTuWtOsRaLXe/ivaGLqkg41Vq/qceBWVVziNZRGhK+F1
         Hw7jE89isgk/osu5rHOHwdxHQUFGc4ooEPxVEfvl6XOqR+K7z7Tfhr/iMntDoEne5zO1
         9FBApd8NpWf+SuSrlPKyefwZWhkbFRIxLaIJ9RZYwiiKQM9LBxvTXDDwub5+g8NUP1rO
         nwj2dyF/lv3OhiVC0ypKNZVZO1ZmqcYkMELX6IIvX8c98n5l+MahRZNDvevNqLeGPpI7
         5mhl3ImX2Ql+0Scew3NedHZ4MzCJx4OKa6/CCou61Y3VzCq9SlcvROSGi5CQWL9eDiSu
         B5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUe/V35Hgm2Y4wJ7QyCjwdHDr4BrpoyV68k2ISiFcGcvLbkZmjdyA0oISC8voOwxJ3I6+DiYG62@vger.kernel.org
X-Gm-Message-State: AOJu0YwaO5/ayKJc/USeW3qsQAtC2L7uMwC9sGr8HXwdNM+xQG7sylKZ
	6Us0Sv7KoiCPTSpFDnWmlnq6NlByW4cgbY8PmxI7QaprGDDJL9nbLm/sI4alLpcXpy+GD5UA4C5
	7eBbdTonVf3tyxA0ezPzlRJPwbO62T6VOeL556jYTbmB6mWosiiRk1Sc0uhBhSiScVg==
X-Received: by 2002:a17:903:244a:b0:205:8763:6c2d with SMTP id d9443c01a7336-20fa9ea22f1mr23794665ad.9.1729657395808;
        Tue, 22 Oct 2024 21:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELkvnuc5PEhORNlgKURJl356pveYdM9/yfbKLimVQqNTxshnMQsUlXSHpgff8BM9YUmtbQeg==
X-Received: by 2002:a17:903:244a:b0:205:8763:6c2d with SMTP id d9443c01a7336-20fa9ea22f1mr23794445ad.9.1729657395390;
        Tue, 22 Oct 2024 21:23:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bcc3csm49931555ad.158.2024.10.22.21.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 21:23:15 -0700 (PDT)
Date: Wed, 23 Oct 2024 12:23:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs/161: adapt the test case for LBS filesystem
Message-ID: <20241023042311.apfuq73crvlblxoe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <172912045589.2583984.11028192955246574508.stgit@frogsfrogsfrogs>
 <172912045624.2583984.16971966548333767345.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172912045624.2583984.16971966548333767345.stgit@frogsfrogsfrogs>

On Wed, Oct 16, 2024 at 04:15:32PM -0700, Darrick J. Wong wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> This test fails for >= 64k filesystem block size on a 4k PAGE_SIZE
> system(see LBS efforts[1]). Adapt the blksz so that we create more than
> one block for the testcase.
> 
> Cap the blksz to be at least 64k to retain the same behaviour as before
> for smaller filesystem blocksizes.
> 
> [1] LBS effort: https://lore.kernel.org/lkml/20230915183848.1018717-1-kernel@pankajraghav.com/
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/161 |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/tests/xfs/161 b/tests/xfs/161
> index 002ee7d800dcf1..948121c0569484 100755
> --- a/tests/xfs/161
> +++ b/tests/xfs/161
> @@ -37,7 +37,11 @@ _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
>  _scratch_mount >> $seqres.full
>  
>  
> -blksz=$(_get_file_block_size "$SCRATCH_MNT")
> +min_blksz=65536
> +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
> +blksz=$(( 2 * $file_blksz))
> +
> +blksz=$(( blksz > min_blksz ? blksz : min_blksz ))

Just to be curious, is there any machine with pagesize bigger than 65536 :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  # Write more than one block to exceed the soft block quota limit via
>  # xfs_quota.
>  filesz=$(( 2 * $blksz))
> 

