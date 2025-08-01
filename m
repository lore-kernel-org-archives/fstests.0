Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9DC347DD
	for <fstests@vger.kernel.org>; Fri,  1 Aug 2025 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754075481; cv=none; b=BkMQy15NKDJkChedj2w49ZBc032ZBDBXd2tnI/kSVOXIYJkStFDbA/4FRRrgPQQ8t5CH5T1Lx9JLeJLw6ZL/0bpOEDrUE9lrqHljSZDD03V0DVOrnjzHp+KaDBpYMdlNWjHdOPsVc36NWTvQYgqKciD64qi0uGefdi+Qb8wzF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754075481; c=relaxed/simple;
	bh=Zmz/8sMI93Dbgn9Gexqbfd+JWIgWpHOOkKmz6AIGCSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSAI5HgH+Tk4UzCCFSmJseA/s0Q1iQO6BO8jOgSEZP3rLxYA4bRgQ8L8Q+25ErwMfwG2+Hw4uuHvdRyQP0TUPlUSgH0xumlcSltqrVUhl4iLb/QO6YSyQ/Vio0MEsmZUPmNfB71BFqqRRD92TRXKoyCGXhggIvANA0zyYYjmWXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGdljUD9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGdljUD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754075477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sEffyHy0ilVpWoM8ux901pwrU4aBmgABF4pcRC5LKPg=;
	b=BGdljUD95dJ7VYDcfMzYDr/6T8rVUXTOht1w1yddV2NKzMMXDczwjfdEO5t9owM3b/vNCU
	RKP+frcE2Ql0ehVy02J2Qln0xDpv5+KEfRag+NvbNIDrvZv9t+ijfRH8iGJhK4ZSlW6lfZ
	Bv/SglJKzOtAZBpYAsAWV1P3VKbjt2A=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-DmX65aHsPaG7Ceu8k8FqeQ-1; Fri, 01 Aug 2025 15:11:16 -0400
X-MC-Unique: DmX65aHsPaG7Ceu8k8FqeQ-1
X-Mimecast-MFC-AGG-ID: DmX65aHsPaG7Ceu8k8FqeQ_1754075475
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bc9259f63so1460529b3a.3
        for <fstests@vger.kernel.org>; Fri, 01 Aug 2025 12:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754075475; x=1754680275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEffyHy0ilVpWoM8ux901pwrU4aBmgABF4pcRC5LKPg=;
        b=bH+0SsTmooLt6EbCjl845XuWd0NPnh0dgtIs76TnwiNs6hc87rToKNw6nG3sjRPSxR
         XV/VYJHm6ZwkWdL2YtTtnX/n3IjPqO4YWbM42o3HA99g3DGW1q7tXVSPHW5w/Bi58Ice
         SP5/i7VJJPPmzOclKdTN5wVuyBuhLnIkpWQZAmxH7pwEuqibu5jFhpRnriWXNzHx9J//
         Rg862vJXeiGtPhnivb3MJfKfiBE/23++1vsNaJtP3qKSTMdTmXclKLHyHk0RJQGNMF0t
         JbDclYF/IKD50ktRftleY+aNVM6m0HCoch1pN29iRj+GWX5gomp/TiNflMP6njyQTpl9
         e25A==
X-Gm-Message-State: AOJu0YwUhL9Ar0JHzQ2Hba9iwazqzKhOUbpMpIdRuhdzO4hzgPDqYww9
	F3ZDDgQXxuodjuvDpAMdOGENzf0IRHzatX0bh0Qs/nYskyMaZ0VAHTrPV8D7zXCv4X5YYi8XtkG
	B+7XbawZlOPb27hP7eLZka+vZ+OA7jyV7jJjoUwTYF1zZ0Er2v1CyUCUHJS0=
X-Gm-Gg: ASbGncv4xEp1qTo5pElsofc2ua5BEYqVBmH//eaXZ9KtV9vUnRFHBrgRbeWpQavpOuI
	Sp46i9ZJDfAegD3162xegnjI9qxewCbbY1hzHzEpzwCd/mdk8RONAjOYyv31+PuNIfaSO3yYrvg
	TNVoYzIKIVbKH+jsK4Kyk2ZLgqAI7+nofd4A1vxsMg4ZWcxk1WrMLLLMTDU877tTiCuVikxlXk6
	MuTQ8N7oKkhMLvidTEe45Sw6QcL0MAGF4DfAzIdtEUe56I8lP0NjO3WEr0yA67kpcU+wngSJQi6
	huZbPZosNx8xLZcg8OOVf1p4PgTbK1gjj4jOzqdur6aDwYJLvU4buGnmqi0k6bC9U/XITesKy1J
	YNKyf
X-Received: by 2002:a05:6a20:3ca2:b0:222:1802:2dd7 with SMTP id adf61e73a8af0-23df8fa4fd7mr1317399637.13.1754075475086;
        Fri, 01 Aug 2025 12:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6Zo/YOtK1QkMgSjdtvlYNyXe3Mj689hVIHHznN72x5y7jJlm+/5gpBzT3A7lyvGfKPeXduA==
X-Received: by 2002:a05:6a20:3ca2:b0:222:1802:2dd7 with SMTP id adf61e73a8af0-23df8fa4fd7mr1317360637.13.1754075474654;
        Fri, 01 Aug 2025 12:11:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bdd2725c9sm2439595b3a.6.2025.08.01.12.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 12:11:14 -0700 (PDT)
Date: Sat, 2 Aug 2025 03:11:10 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/189: fix remount barrier test failure
Message-ID: <20250801191110.oj7tl4knhn3wfsff@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250730172826.122130-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730172826.122130-1-ailiop@suse.com>

On Wed, Jul 30, 2025 at 07:28:26PM +0200, Anthony Iliopoulos wrote:
> _test_remount_barrier() is skipped on kernels newer than v4.19 where the
> barrier options have been removed, and this is detected by matching the
> mount command output for a "bad option" error.
> 
> Recent util-linux commit 9da5644e414c ("libmount: report kernel message
> from new API"), which was introduced in v2.41 release changed that error
> message from the old hardcoded one:
> 
>   mount: /mnt/scratch: mount point not mounted or bad option.
> 
> to the newer, and more specific coming from the kernel:
> 
>   mount: /mnt/scratch: fsconfig() failed: xfs: Unknown parameter 'barrier'.
> 
> Update the test to account for that change so that the unsupported
> options can be properly detected again and for this part of the test to
> be skipped successfully.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  tests/xfs/189 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/189 b/tests/xfs/189
> index d32adf0840a6..1770023760fd 100755
> --- a/tests/xfs/189
> +++ b/tests/xfs/189
> @@ -180,7 +180,7 @@ _test_remount_barrier()
>  
>  	# If the kernel doesn't recognize 'barrier' as a mount option then
>  	# just fake the output.  The barrier option was removed in 4.19.
> -	if grep -q "bad option" $tmp.barriermount; then
> +	if grep -E -q "(bad option|Unknown parameter)" $tmp.barriermount; then

Although this test case might be dropped in one day, but your patch still
makes sense before we remove it :) So

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  		cat << ENDL
>  SCRATCH_DEV on SCRATCH_MNT type xfs (rw)
>  SCRATCH_DEV on SCRATCH_MNT type xfs (rw,nobarrier)
> -- 
> 2.50.1
> 
> 

