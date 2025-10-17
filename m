Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8AC330B02
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717215; cv=none; b=GyWJExmz0WnDGmfNMINBHr4ogc5C4Ms13Q5oHvkubuLCVImlFtUb/mlQgFbUgNfaYSFyqim8vGpm3stxwHZzQuNBznRYBHw5WdmjHfuH3KVUTCKHej74q/ScogJhnyKMPhTVKPYwci4SFlr7b9mFuEQewwHE7A5aQHMk4Pqu2xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717215; c=relaxed/simple;
	bh=Su6VhEt/BR3BroimPGmGzceuUCOFePjUtELmvhVyLKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpIq06y2DD5V9B1CNwYcRvbtCExLPd8T9c60I4HohxvXQ6Zn0PNA0pA7cmmJkyORY/iLqBLmyLf23QhUYYdHW0Hy4cEi1ovBHWvwqX/bSUtSMmG2I0ze03TAl3+sBz3div7ZXLuyT+FHVUaIxSsH2qV7XPt5+U46IgxZVWG+e/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOQ7/xpl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOQ7/xpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760717213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wsx3pbSsK+HcNrWvvqpREgf7UisqA0u83Z6j3J2/2fo=;
	b=AOQ7/xplaC7KbopgUuhTLcWAYSf6soGcnzRK8XdTPiEvKY7osVlONvOzqyu7OcKXQa3iTQ
	oMpyUj7Gm3pG69xUxKiGhonneGa6u6augI4+bDOTZ3JqHMLokTI6MdTdWSiGb9ZCRGZYf4
	sOQ84u8QJwIssAPQw+dp4C5fHNVIVhc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-T5KOp6ZgOu6fu_kv-jQDgg-1; Fri, 17 Oct 2025 12:06:49 -0400
X-MC-Unique: T5KOp6ZgOu6fu_kv-jQDgg-1
X-Mimecast-MFC-AGG-ID: T5KOp6ZgOu6fu_kv-jQDgg_1760717209
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780fb254938so1918938b3a.0
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 09:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717209; x=1761322009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsx3pbSsK+HcNrWvvqpREgf7UisqA0u83Z6j3J2/2fo=;
        b=SyDlf/O9t+D3OhSMkdmBRzjkYFS6sP5A5TaWt+QG+t6oWHGyaEYlX1Wx9VsWIB9Krd
         xv8hwNuyNRR/uf0vEQFu2LORX7TE9XHJ462A4XXAWfS8QSCCvtneQmniDneGl8/cgenr
         c0RE14nFKKc9lcA8Ky/Z0WemiX19b88/uT0X2Ic3+GKpB4r6ah7pfXJwTHEyCW7r7OnX
         4z6OYGrOSFSCB4PWDRkfadGvYX77J59G0C/59P2rXpYQr9kL/8pzgsesy1QbMrObIGJm
         Z0GzuLgqcB5jkq41nRsvH12TwjVB+RlYWzlAe0jV+uGTxusv45hwZe2KcTr7jRj8vnkQ
         WYxw==
X-Forwarded-Encrypted: i=1; AJvYcCVsf1ucPEjcv5+ujM07H00GudCuE5Rz2Nsw12GbM1HIsrhCbIPPlsrT61j96O7DkgUFsj7Mz6UO@vger.kernel.org
X-Gm-Message-State: AOJu0YyObytin0zt8G9SNXXXVTBuO6Z5gSAyDVsQS/6eaiTOHFS/6KNn
	KO3o7SLndizJpOCY9GtLp8aVudmYJ8aUxGVCT4OHUa9iTHM1HbEtxLpDZcHMrch8Y+Yw2c3+Lpr
	2FcMpvJnr5Bmy1UaWHI0OFgiCx46dgN0p+sobMPVLAhHLPebWiFY5b7Cq2po=
X-Gm-Gg: ASbGncuJPL3/Hy9n5T5Rs4Dun6gfIROWxcgWBfKysAn+509PUxqbKn7VI/2OhZK6v+b
	6d1MvkPxthA8qhs94F545SsieafibXKT9D/niviaHcoHWLz2LcKWD2rOJtu23fcPhva24LZtDJb
	0Fk7I3Q8P0Tx9jRUXxB4GtDJ4y7dX846KEdpsV84cWgNuzBkcM0tL6aX8/nwGAl3wF7aVcQ2RnO
	KyuAT0tLJXgbAR/fs73tLT9oPTmBc9kGxkYMuRKXudhaiOBI8jZK6aeeBBYc4+cfSCdFvSLdtdi
	r1MbZh6a6tG3sf8F/CdtFHTWVuIVea+ZzPV7+GOUsag36INZiYMBmyavJXnkPCICd22DEmcie5y
	NfWCI1FHb8LzU+6f9tCfnBvwFR9d3rlqpOnyDbho=
X-Received: by 2002:a05:6a00:4288:b0:7a2:2100:1d4b with SMTP id d2e1a72fcca58-7a221001d8cmr5574786b3a.14.1760717208324;
        Fri, 17 Oct 2025 09:06:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpQE+T4KzspXGTUsgyFZ0qbznilbaZBiVlGM3fc3NnYCVdgbimJgFPcqAumz//tVwiJ/2djw==
X-Received: by 2002:a05:6a00:4288:b0:7a2:2100:1d4b with SMTP id d2e1a72fcca58-7a221001d8cmr5574751b3a.14.1760717207862;
        Fri, 17 Oct 2025 09:06:47 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb11ca0sm26297274b3a.32.2025.10.17.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:06:46 -0700 (PDT)
Date: Sat, 18 Oct 2025 00:06:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/3] common/config: source common/f2fs in
 _source_specific_fs()
Message-ID: <20251017160642.yre5hcy6ogogaeix@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251009085043.16910-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009085043.16910-1-chao@kernel.org>

On Thu, Oct 09, 2025 at 04:50:41PM +0800, Chao Yu wrote:
> Let's source common/f2fs in _source_specific_fs() instead of in each
> testcase.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Make sense to me, thanks for fixing it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/config  | 1 +
>  tests/f2fs/002 | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index 22b52432..1420e35d 100644
> --- a/common/config
> +++ b/common/config
> @@ -509,6 +509,7 @@ _source_specific_fs()
>  		;;
>  	f2fs)
>  		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
> +		. ./common/f2fs
>  		;;
>  	nfs)
>  		. ./common/nfs
> diff --git a/tests/f2fs/002 b/tests/f2fs/002
> index 74146217..d2f6e413 100755
> --- a/tests/f2fs/002
> +++ b/tests/f2fs/002
> @@ -43,7 +43,6 @@
>  _begin_fstest auto quick rw encrypt compress fiemap
>  
>  . ./common/filter
> -. ./common/f2fs
>  . ./common/encrypt
>  
>  # Prerequisites to create a file that is both encrypted and LZ4-compressed
> -- 
> 2.40.1
> 

