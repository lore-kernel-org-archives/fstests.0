Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3DB1B28D
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 04:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709008119; cv=none; b=d/riGIKCCwKMzysnF5USd5+mUs+EowJyTGG7Or1HLqyN9cfLHtEAzrsYU1KOEoYmCUCxsMkeTRm9rqcXYLzqA1QappReVDwmHmLxXf82CDHHyLJb//HeINSjzXl5DJ3HoncW5zi5jGPv12Kk+Vn/9Y60A7NjCczpm+BPpdScbAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709008119; c=relaxed/simple;
	bh=3cg/MjJAV8rejg55H/2nCxPE719hq9lT8aJnFP2wthM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJ7Sjj0vImBmlgxdU+zTafOY/Ov6d5VaP+vwsplckN6E2Msri9+k9bUSD1AyPpqh4TKSvMTCUyjVt3+hO2WD90nIiPEyUVTFzSyegrK63muq4k/zM00Hg8pl7F9OQRuWZdqB7ScB3wnsMTBxoyV37PgwiB2/jDHZ7vR70tIy+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5yopfjp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5yopfjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709008116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n27fA5JcdPwsR5o8IRM4smQtVIbRrKZHJ809a2eXsFA=;
	b=e5yopfjpYFZ86QMf4LHpIz6lARQ28rC8TD5Gm3ijY+WzS8dUOO8b0weW0JcsQgO5aTx/qI
	PDPk/KSl2GllVfqj2j/2+jaDTumE8VNTCs652J6jNVkhG+PsuUy0DzC7ofuViZGvo3435C
	vwqdm8yktu9bx4A7Tgeb1bbieKNXnPE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-Syj3C8s5PuKWLqqWilq5ZA-1; Mon, 26 Feb 2024 23:28:33 -0500
X-MC-Unique: Syj3C8s5PuKWLqqWilq5ZA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d4a87da75dso42370515ad.1
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 20:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709008112; x=1709612912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n27fA5JcdPwsR5o8IRM4smQtVIbRrKZHJ809a2eXsFA=;
        b=rqL2GQzRenPErhzRPJqXEuigVDqkV5vGHYZjXABVcREs/yJ4WYJ19XxGoGqla0XJPd
         xrUPYPN9SEsyhUqTkOpJyh0YmI1xpPcMP/8afsTZcJQIwP+DMWduyVOeoI5a0n7DJd+J
         KqAigmObgmjwgy6nwRBWlmtZfKvJD5jsCv4LKjMlk8oEynP86CdiTZ+LauV9/rlhdJx1
         BX1XVJO/veny2uhUDIPucV2muN8dZTilaf4i28eri/S6V+ukEYsCv3R8FPWhEYafE5Vk
         ow9xQGvnE5DHJYAL/aSSmngdHM8q6uXmifK1Xf/7yn+tCWx3pwbUKoCv/f5mhB4djk5v
         uvPg==
X-Forwarded-Encrypted: i=1; AJvYcCWW7S3nPbWMk3IqyqWQ9OTkJ1DM5ji5JhlRAo5LCgB4wCmxKYYXF9WZWr3BdHMkWQC5tmSg8qeCHqyryGh4L4GlGvWepO9zzA==
X-Gm-Message-State: AOJu0YxHUEL6FSaYP3s4oMXW8XEtotVahzEGRgPsNyyf6JP+PkvuQHI9
	ntOlL2VhHkKCPDNH0/z7FEADg7Xv62C8Mku5drE6C8vimHSPFnoZO9mTMTLd8tEbYjbZm/eoftb
	yULGOMey5QPW5WnaDTxCS34qC+tvTjWfTUL40aS7Hc+IpsZpQANeEsnw=
X-Received: by 2002:a17:902:cec8:b0:1d7:4353:aba5 with SMTP id d8-20020a170902cec800b001d74353aba5mr10285637plg.58.1709008112420;
        Mon, 26 Feb 2024 20:28:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE3IjGec5q46Sse2FcWfKJwxUeQ03hyJqmYNnMV3TDTPXL7DpATP/5Xyb0Pz6u0OG8r2KN+w==
X-Received: by 2002:a17:902:cec8:b0:1d7:4353:aba5 with SMTP id d8-20020a170902cec800b001d74353aba5mr10285631plg.58.1709008112107;
        Mon, 26 Feb 2024 20:28:32 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ix14-20020a170902f80e00b001dc23e877c1sm482609plb.265.2024.02.26.20.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 20:28:31 -0800 (PST)
Date: Tue, 27 Feb 2024 12:28:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 4/8] generic/491: increase test timeout
Message-ID: <20240227042828.7jx4bvzw2bdcak3c@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <170899915207.896550.7285890351450610430.stgit@frogsfrogsfrogs>
 <170899915276.896550.7065004814140508980.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170899915276.896550.7065004814140508980.stgit@frogsfrogsfrogs>

On Mon, Feb 26, 2024 at 06:01:34PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Bump the read timeout in this test to a few seconds just in case it
> actually takes the IO system more than a second to retrieve the data
> (e.g. cloud storage network lag).
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/491 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/tests/generic/491 b/tests/generic/491
> index 797b08d506..5a586c122a 100755
> --- a/tests/generic/491
> +++ b/tests/generic/491
> @@ -44,7 +44,7 @@ xfs_freeze -f $SCRATCH_MNT
>  
>  # Read file while filesystem is frozen should succeed
>  # without blocking
> -$TIMEOUT_PROG -s KILL 1s cat $testfile
> +$TIMEOUT_PROG -s KILL 5s cat $testfile
>  
>  xfs_freeze -u $SCRATCH_MNT
>  
> 

