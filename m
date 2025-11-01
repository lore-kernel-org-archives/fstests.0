Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581E22045B7
	for <fstests@vger.kernel.org>; Sat,  1 Nov 2025 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761997246; cv=none; b=fwKJPg5CXx8tEzObRRN1m7OEseXm2UYz8Sc5rWcKB6s5bAoepZfaAeuq7v/u2nEXg87EKNBbWk7Mq0TwWybYdMV8W7DP3/Ky34okCWXHd5YhGORF8vRJ4ABo48ObV5xCJ3+Ilsu6BNystbxOBUtKjNJeR2fMfMCbMs0R8sKRY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761997246; c=relaxed/simple;
	bh=y+k67zjTU/BwGrXsR9x/XrzQbn0jcbBc7oUs3b0v4Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlcEI3UwyUhDjW3PSsonR9KNO5o3gtiZIAWIUhTW0dt1y5/xRRXqsdrfF8nSeCxtCKDfW87k8rOInAIypowy5lf/G94dGbeExJygRVfcwdoyrKaHGQ1yf1E0/euUcOvvEFUgpIYKxL6D3x6cMXW9YYAh5aWD1CUxCHYeY+ufYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnPV5sDu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMGEYVSn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PnPV5sDu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMGEYVSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761997244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gRPzHhBnGQKZg8AlnPA2nk5Y2FBH4BbPy+XMSkasbro=;
	b=PnPV5sDuHis8cO168RNmQYazmHrEjCZ6uUc14Wfze02euskxejl60w9zPaEZJDY8Dp4QE9
	T3fStS/HZ4fB33EInUK0pZVDaCBdFjdgOsFpPdCZMXG4/G/qP5VmGu7akVqH0N4K1v71ea
	C+Qeaakpf3G9m81TTk+C87kOeisU9Y0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-Res-IFwYOLKt4M43wQEM1w-1; Sat, 01 Nov 2025 07:40:42 -0400
X-MC-Unique: Res-IFwYOLKt4M43wQEM1w-1
X-Mimecast-MFC-AGG-ID: Res-IFwYOLKt4M43wQEM1w_1761997242
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da21394adso3493814a91.1
        for <fstests@vger.kernel.org>; Sat, 01 Nov 2025 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761997242; x=1762602042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRPzHhBnGQKZg8AlnPA2nk5Y2FBH4BbPy+XMSkasbro=;
        b=MMGEYVSncED2rKliX1AFXddkKLipeuSIxA3m1znMzrMNXMPmafOJSufR02QdH+wTJP
         c4Sf+r67dKXHThg3cHcBaibGXtG7vKH9XpV0Eu3BEHunFETImbcFc4LRl2kkSFzeidLQ
         zllr19G/wcB9Nu4OgDFpGu+fRdBkRLahvLZxknfUC0upCqbMlJobwyeyXkMWtDRAKw2r
         kt5E3kDbTAdVOreLXiOQjRWAzV6u7smMJNF7zewzL7p+8FtrI7jtoQlTXtw3erNsdOzs
         uL1Q0OXbArh/fEvSBk/eXH0bJidCJq/f5TaAmW298m3PEy6/Qt5HUTozLTlVut8/QBSZ
         F2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761997242; x=1762602042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRPzHhBnGQKZg8AlnPA2nk5Y2FBH4BbPy+XMSkasbro=;
        b=IyDN2DlSm3GeNFDB5M1Z4QVes0Wcyky8zQRzqG7wVVLJ5AxXA5I9QuV36FYxp/Km0G
         y7LAO0ZpVmldL7G4e8N+Q4hshRljWQDImL3VM0xk7a1J54uRmIM23Qq2vRh0xkQiPwU9
         LtI9eaJmhvcrhb2UZguDf170ljs5Kmf7l2vgAhTX+rVXyR+v43NGeobshVzi2BqYwV+o
         R21rw3Yp648e5vF5JtHorU6rX07hS1LupTEdtOSCixejGyoAm56bDfwvW0SXP41aD9Uo
         RCnsCnHZGDaAi41Btp/JJSvEGJO2ZWtXyZ/mJ8oELGV6UKnqesGDbGXUlBA0qF4hBMSy
         uWvA==
X-Forwarded-Encrypted: i=1; AJvYcCXlkRqU5htLsEXPvsCFGe8aJsgcNuP80m9Hd8t/Wrogz3+T1aJstzKX3lPTXahFzIghwV8RLfnb@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSoHmh/ikPxxKLX0TZJ3WswrOiD7FE91EDZMNvkuLncygTo/H
	N4ZWxr4cwQEhiYm1uZPQu2L8zXKnZ1rnhCVB+IoXkKGMm0xBaD78cm/3CtcZMJWLWAIeyc9jPlY
	nOqObwmB6G2RjSRwSZzQNYGnWs34NESs/4UdHTbskcTy5IcE8OIdTueNkF9Q=
X-Gm-Gg: ASbGnctOMcRUPkwA3dXnOIe0/K4giPt1x9aPtVjMQSCNXUseiVjhprYrsJ9TBAN7z9q
	1QZEfYwNj0U8c4Ef5VBYNsCWyAtskiWWH4uvdc8DjoRcnby47+QOcQx8Mu9vlH4oS3pg2ciRPFg
	3tq6Lp4SLwrSdxjY8og5bQ06To95peK3on+xJrj6FNVbxTtJGB0nGSl+O8JhqS/Uxg377neHAEF
	pWLClghu4wvbknOhSk6FDlLwxZB8jXUAcvXxScAphqTChFHiEigx2nXu/5yqhW4O3Oa3tSdgEZY
	qmyhQ8nuHGw3336oNdvqIJzHrbwtFh150CxyG4pPJ0tuJEs9Nbo5WykHCwYMP0nwIhhhAvo30Fk
	N+wpwscaxuJA6b1x7wVV0PQ7DX58Fzo9mo0ugZyw=
X-Received: by 2002:a17:90b:17c2:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-34082fdaa04mr7826977a91.13.1761997241725;
        Sat, 01 Nov 2025 04:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGqKIGEb6+Us34rq8MtYPffmKqhLlbsN8qhKbPlV8qfPWJA9jiCJfThCl3/qBYWgtcgB4n4A==
X-Received: by 2002:a17:90b:17c2:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-34082fdaa04mr7826963a91.13.1761997241239;
        Sat, 01 Nov 2025 04:40:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bf265180sm4910840a12.33.2025.11.01.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:40:40 -0700 (PDT)
Date: Sat, 1 Nov 2025 19:40:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] f2fs: add commit id to _fixed_by_kernel_commit for
 f2fs/02[1-2]
Message-ID: <20251101114035.zk6vy5z7mrxmtnys@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251020023108.327728-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020023108.327728-1-chao@kernel.org>

On Mon, Oct 20, 2025 at 10:31:07AM +0800, Chao Yu wrote:
> The bugs related to f2fs/02[1-2] regression testcases have been fixed
> by below commits:
> 
> - 930a9a6ee8e7 ("f2fs: fix to avoid NULL pointer dereference in
> f2fs_check_quota_consistency()")
> 
> - c18ecd99e0c7 ("f2fs: fix to do sanity check on node footer for non
> inode dnode")
> 
> Let's add commit id to _fixed_by_kernel_commit in f2fs/02[1-2].
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/021 | 2 +-
>  tests/f2fs/022 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/f2fs/021 b/tests/f2fs/021
> index 96fc97c4..0cacb138 100755
> --- a/tests/f2fs/021
> +++ b/tests/f2fs/021
> @@ -10,7 +10,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick mount quota remount
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 930a9a6ee8e7 \
>  	"f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()"
>  
>  _require_scratch
> diff --git a/tests/f2fs/022 b/tests/f2fs/022
> index 48a8386b..f6d77c96 100755
> --- a/tests/f2fs/022
> +++ b/tests/f2fs/022
> @@ -15,7 +15,7 @@ _begin_fstest auto quick rw
>  
>  . ./common/attr
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit c18ecd99e0c7 \
>  	"f2fs: fix to do sanity check on node footer for non inode dnode"
>  
>  _require_scratch_nocheck
> -- 
> 2.49.0
> 

