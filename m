Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF38287A
	for <fstests@vger.kernel.org>; Wed,  8 May 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179807; cv=none; b=bPkTW9FPy2YGpfGpopyxugPGps5jkwtWjAV5A0hcg0tnG61vukEhpyG53M0iqpGauhZoks+E7d/GpCTxf1ehxb5lnGdKB3k83P+fcGLXhF114spcb2FE/iDiYROI1Sdkf4NMNqzByeS23o8KCcE1lHJSpIQeUc1Pkp1G0AYCDUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179807; c=relaxed/simple;
	bh=naAfvqHy2oM+bZosbdgUcG7nb7Oq/L3oxOdpZx+IWXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4umMXzof6Qk+lEJ+y8prkFdHw1bUw/BzWvp5MF++BI93LEfx1jyGrXK+7boP16NHT2tJrpLc8uq6h2UI7QZilrokndkDFr5gAiHJfiiKiRNXJqSda89FDYdtYtAs4+FHUwZnEGSV2jv2smQ+e2Y853BOu4BPcs1kTQ/eAHRZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=aot9Nsos; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="aot9Nsos"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VZJ2y0Pwqz9sRn;
	Wed,  8 May 2024 16:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1715179802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eDFatsvhLCKLfyKo4C3IGzfeA7t/sOERraPTqUcvMjc=;
	b=aot9Nsosl1PwNVIe47c1juItxLW2BdlvbGDKrwhxulXpxuK4tSE14rWMpXFwG1VgdGX0v0
	a6ciwiWr/0LfEDcpl0BpTCK5fONLMvmbWW3b7mrdeaics/dShhFyYkXT4QZI1wgbUcqThA
	oBmW6vxYQlmONaUGAQ28IgTX2qAXQA/eyDJSVw0vKWKcfQUY+PgVro9gPGEH1vJriR8HOz
	MzQWDP9+VdeciIG/zh+ldlQonBSuXe/0siIBvlNTshhC72nbM9Lo5aq61sfXKrBuOpB8ZN
	RMKaiJHPqTejY8puI+gJzLTEeAVt4AIe5S6JSbDKPSza2Qq9He5nIpcxiK8E+g==
Date: Wed, 8 May 2024 14:49:54 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/3] xfs/161: adapt the test case for 64k FS blocksize
Message-ID: <20240508144954.qogsczhxl5xwqxz3@quentin>
References: <20240506150119.184097-1-kernel@pankajraghav.com>
 <20240506150119.184097-2-kernel@pankajraghav.com>
 <20240507222323.GC2049409@frogsfrogsfrogs>
 <20240508105852.nfjtlp53v24xb3tw@quentin>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508105852.nfjtlp53v24xb3tw@quentin>

> 
> diff --git a/tests/xfs/161 b/tests/xfs/161
> index 486fa6ca..074acddc 100755
> --- a/tests/xfs/161
> +++ b/tests/xfs/161
> @@ -38,15 +38,21 @@ _qmount_option "usrquota"
>  _scratch_xfs_db -c 'version' -c 'sb 0' -c 'p' >> $seqres.full
>  _scratch_mount >> $seqres.full
>  
> +
> +pgsize=`$here/src/feature -s`
Stale pgsize variable.

> +file_blksz=$(_get_file_block_size "$SCRATCH_MNT")
> +# Write more than one block to exceed the soft block quota limit.
> +blksz=$(( 2 * $file_blksz))
> +
>  # Force the block counters for uid 1 and 2 above zero
> -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/a >> $seqres.full
> -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/b >> $seqres.full
> +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/a >> $seqres.full
> +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/b >> $seqres.full
>  sync
>  chown 1 $SCRATCH_MNT/a
>  chown 2 $SCRATCH_MNT/b
>  
>  # Set quota limits on uid 1 before upgrading
> -$XFS_QUOTA_PROG -x -c 'limit -u bsoft=12k bhard=1m 1' $SCRATCH_MNT
> +$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$file_blksz"' bhard=1m 1' $SCRATCH_MNT
>  
>  # Make sure the grace period is at /some/ point in the future.  We have to
>  # use bc because not all bashes can handle integer comparisons with 64-bit
> @@ -71,7 +77,7 @@ _scratch_mount
>  
>  # Set a very generous grace period and quota limits on uid 2 after upgrading
>  $XFS_QUOTA_PROG -x -c 'timer -u -b -d 2147483647' $SCRATCH_MNT
> -$XFS_QUOTA_PROG -x -c 'limit -u bsoft=10000 bhard=150000 2' $SCRATCH_MNT
> +$XFS_QUOTA_PROG -x -c 'limit -u bsoft='"$file_blksz"' bhard=150000 2' $SCRATCH_MNT
>  
>  # Query the grace periods to see if they got set properly after the upgrade.
>  repquota -upn $SCRATCH_MNT > $tmp.repquota
> 
> > 
> > --D
> > 
> > >  # Force the block counters for uid 1 and 2 above zero
> > > -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/a >> $seqres.full
> > > -_pwrite_byte 0x61 0 64k $SCRATCH_MNT/b >> $seqres.full
> > > +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/a >> $seqres.full
> > > +_pwrite_byte 0x61 0 $blksz $SCRATCH_MNT/b >> $seqres.full
> > >  sync
> > >  chown 1 $SCRATCH_MNT/a
> > >  chown 2 $SCRATCH_MNT/b
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> Pankaj Raghav
