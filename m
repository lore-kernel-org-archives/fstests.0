Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49753374CC
	for <fstests@vger.kernel.org>; Sun, 28 Jul 2024 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722178461; cv=none; b=MA8pIdzUf6FILk798moGHJAs7ufpq2dexA2q52O55+WY9Z0Ebms6n2nLVLweJLXJ88ZCiZ8DN2Ehe/6T3gyGMVP0TBIPB92nO5/h7kc4V0AWFWNi6chGtqXvndibkE9E6qI13uVwEMhstxqScXmYiCE22asLGjrzcWtfJQYHfTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722178461; c=relaxed/simple;
	bh=SJNolGQqVD0BolHWbLdTZKRWgbqvMQ2HSvj8tlCkMTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4W/sQ4EgI+16LAYI9/e3pC9vijGFnq/6HRFaTntS3h91drGKxgMS4DiiDu82gLnueUuxs4olHEAtQb1zaBIOO78jGl6yREXneo8cC3pf3IYVWA64yZzkVQ/QFAjQaK1Lxy/VCJrGNtDuVuMH8UQwn7BH3ud5PGItMiJzw0Q0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifXQbRtS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifXQbRtS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722178459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pqy1ISPnQUGctFt4KkkdUUuShdvIuxpHe5p1UfyNBrQ=;
	b=ifXQbRtSF5a20KPYDUCn79uAHP7LotXzOK03BgNFgiQuapgzluJI5Vgf1VCvkaiV1I63Rh
	ecwbvmgrNvoOLqDhfXtm4t5Wo49OMVx2WwIGOLZ8y+H6CZFKVULexnL/HiqmIBqUpXiobX
	blAdx1kBL2HiR4AbVWJ2N0zLZCsQn2k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-wbnsVHn6NV6Ihj7NstHaVA-1; Sun, 28 Jul 2024 10:54:14 -0400
X-MC-Unique: wbnsVHn6NV6Ihj7NstHaVA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fc5acc1b96so25867925ad.3
        for <fstests@vger.kernel.org>; Sun, 28 Jul 2024 07:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722178453; x=1722783253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqy1ISPnQUGctFt4KkkdUUuShdvIuxpHe5p1UfyNBrQ=;
        b=NWYHmc3nVLark75h+X9dtvrtfMcusa9CVc7t4il6dNkGvVITn851W/6UlC7/dEgz6l
         YZE/0mNkh7ZEd+juGS/rVSCz4+1c/Zf4PSxqZBUvlq6jS86+NE7FXl/7bGyfI7svB89e
         fqOJgd93qqAw8GtIVcl7yXcgWXNWS//jjgIrv+vPcxeO0kXPFoc05Nah66U1LV8/ZTar
         lEuzZ91X9ZpSg5Zl3Lr6MqUp2lRJwXGq5FTFKmN83JO5pwynl4XnxxjfOQdlmzCSlypW
         frUuTAPnZ2MOTFDypyiYLvpAIG3K+H0/LR+g66NcFEDMe4BIVWUR8B4vjP4++EIR/JRH
         +7HA==
X-Forwarded-Encrypted: i=1; AJvYcCVMLoahFJbGU7dKLisKwTauKMb2+p49U+ooGcGbVq/v9FkK6LMLMVc/pt4QUKc4lheEcxyD3oWFnGgtmnsnlcnIi0HTnQeRwQ==
X-Gm-Message-State: AOJu0Yx+Xgg45zA9o5bxOu/hbypNS9CnIEXQz1Bzh86cQBAX++UrWMZc
	/u2jpFa0WveqgJPLFkOCGO0WX/o3DJpH5AAZy243EpF2rD+6LzZqDqPwQ4cIdsfTmRr8qIoQFCn
	0MHtvDG81FQdHIHLS3Iautspre1R661BLwVfREwCtRfV4J6fgqffd5cFWeOor9j5T5g==
X-Received: by 2002:a17:902:c40e:b0:1fd:69e0:a8e5 with SMTP id d9443c01a7336-1ff048d4cb2mr60208485ad.41.1722178453165;
        Sun, 28 Jul 2024 07:54:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFIYQNYVR/K/P3Y/5W6ri+AJmsXa1xIaawdbOysCmQOkONfRN5lFRrLm/8JxvIrX4spdDOBQ==
X-Received: by 2002:a17:902:c40e:b0:1fd:69e0:a8e5 with SMTP id d9443c01a7336-1ff048d4cb2mr60208245ad.41.1722178452723;
        Sun, 28 Jul 2024 07:54:12 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8c1a8sm66231025ad.2.2024.07.28.07.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 07:54:12 -0700 (PDT)
Date: Sun, 28 Jul 2024 22:54:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/4] common: _notrun if _scratch_mkfs_xfs failed
Message-ID: <20240728145408.mu2hmmqmzxb2amrd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240723000042.240981-1-hch@lst.de>
 <20240723000042.240981-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723000042.240981-3-hch@lst.de>

On Mon, Jul 22, 2024 at 05:00:33PM -0700, Christoph Hellwig wrote:
> If we fail to create a file system with specific passed in options, that
> that these options conflict with other options $MKFS_OPTIONS. Don't
> fail the test case for that, but instead _norun it and display the options
> that caused it to fail.
> 
> Add a lower-level _try_scratch_mkfs_xfs helper for those places that want
> to check the return value.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

[snip]

> diff --git a/tests/xfs/178 b/tests/xfs/178
> index e7d1cb0e0..0cc0e3f5b 100755
> --- a/tests/xfs/178
> +++ b/tests/xfs/178
> @@ -52,7 +52,6 @@ _dd_repair_check()
>  _require_scratch
>  _scratch_xfs_force_no_metadir
   ^^^^^

I tried to merge this patch, as it's a xfs particular change, and xfs folks acked
it and would like to give it a try.

But this line blocks the merging process. I can't find "_scratch_xfs_force_no_metadir"
in xfs/178, and even the whole xfstests. Could you help to rebase this patchset on
offical xfstests for-next branch, then send it again? This patch is too big, It's hard
for me to merge it manually ( I'm glad to know if there's an easy way to deal with this
conflict manually :)

Thanks,
Zorro

>  _scratch_mkfs_xfs | _filter_mkfs 2>$tmp.mkfs
> -test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed!"
>  
>  # By executing the followint tmp file, will get on the mkfs options stored in
>  # variables
> @@ -61,7 +60,7 @@ test "${PIPESTATUS[0]}" -eq 0 || _fail "mkfs failed!"
>  # if the default agcount is too small, bump it up and re-mkfs before testing
>  if [ $agcount -lt 8 ]; then
>  	agcount=8
> -	_scratch_mkfs_xfs -dagcount=$agcount >/dev/null 2>&1 \
> +	_try_scratch_mkfs_xfs -dagcount=$agcount >/dev/null 2>&1 \
>  	        || _notrun "Test requires at least 8 AGs."
>  fi
>  
> @@ -69,8 +68,7 @@ _dd_repair_check $SCRATCH_DEV $sectsz
>  
>  # smaller AGCOUNT
>  let "agcount=$agcount-2"
> -_scratch_mkfs_xfs -dagcount=$agcount >/dev/null 2>&1 \
> -        || _fail "mkfs failed!"
> +_scratch_mkfs_xfs -dagcount=$agcount >/dev/null 2>&1
>  
>  _dd_repair_check $SCRATCH_DEV $sectsz
>  

[snip]

