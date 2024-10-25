Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9994C83
	for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828944; cv=none; b=NehqsOCciL6GjRNYQFO1CmkdrI9fveMhiLtoPcRcVVyOov15Ozi+9gxZZeUTuxOm5/+pLwH9joQq8oylsCjrk8TgUN3p2kMpiJqknnfleb+j+2wl1itsNxo23B6OnV44BkECotqZaitfVivp5NIxbDtGg0E1PCP9NIfmfFv0mqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828944; c=relaxed/simple;
	bh=uNNyFrU//jI+27NE8Rk5aStStQyfnxZRXxKDA7EQ2qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EixxgQpRs+fneanIGeeEO1qqO3DMA2JoWppUC3JwjSy3LUmbXkTSmDMCgUJ8cH1/82R7ojEGmP+PYJH1rimLaCRcrg8lW6Bw291W/eP3SbDRMQKcmvcMoFr3D4QAHYd8yeMeXtiQSY4g5sQ4ayscHqtywSeYdTAUp2WYTLHM4Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0vOjJuU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0vOjJuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729828941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FHQVs/xjpuXyoCEGljLr+hwlf/k6mw4k4tJGGtnlURw=;
	b=X0vOjJuUlVVt6W5TSkp+lUOMyvEKN53i9V9TSlXw86DSloCNcrlBQWgCY4Kz3kGg9zqad6
	jz7eqYM4lm7bKtTI6Vf1wekytZfW0mHBstQeDyLLNUMo621UtqW1DPdMH2C4CVPcUE/3qZ
	iBbhl5YX0OTrvPVXNNqGLAz0P7ozLIg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-BgemT6jPPXWuvtSxgYiasQ-1; Fri, 25 Oct 2024 00:02:19 -0400
X-MC-Unique: BgemT6jPPXWuvtSxgYiasQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20e5df3e834so15171275ad.0
        for <fstests@vger.kernel.org>; Thu, 24 Oct 2024 21:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729828938; x=1730433738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHQVs/xjpuXyoCEGljLr+hwlf/k6mw4k4tJGGtnlURw=;
        b=kr6B/nrbQGyv8mA++KEHQG4EFLaY9WX1G8GX7oUsiFwbOIdY8/WUr098PrN/ilp8TF
         ky0+MIOs6oL08O+lT5NOr41IHdwa+x4Jg8cMUeZSneiPHO8CB372Hy0nqfWZyu1d+pKy
         zvkuvkFKVgD465guF8xA5dPWYSfsRU8QCVi+p2ixei36WL0cT0L0YhMQn9F98QH8lFvi
         Oc8WjdxD/EnU5wI7k+tbSBUNxlJzOdLWb5zsYK6Cj20dqpi+vlcco/bFyqWFoc/iVUl5
         6L5qWWmQWoUKD6TQBefoqtRkLy+STQSVoR3hNrqjmOsKgH/bZ65byADbX/K8YG2tWWQ6
         EIew==
X-Gm-Message-State: AOJu0YxmV7YxUsV+cdJsrk5xu2U2QrA8IrmI4w84jwGjET606RUir+jz
	ObRZPE1oBfx3regKF+JFaqQkP6bFvXKDSVfqhU1BYqAljF7ZxBnukSP8TFhsYap4xs5ahvwTSYo
	k2vG2gFesjqMphFNYnv3zrMjXhy0lTMMqQmoGx48YvHQygGlFbcEJdCw=
X-Received: by 2002:a17:903:22c1:b0:20b:920e:8fd3 with SMTP id d9443c01a7336-20fa9e9ae97mr113660775ad.35.1729828937986;
        Thu, 24 Oct 2024 21:02:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8xAUx67xoCM2Ay2c5aVQ1YjGOROU3Bjt+t0ZV9mja9aLgaL5EB65gkb5GqNaMvUX5anNfXQ==
X-Received: by 2002:a17:903:22c1:b0:20b:920e:8fd3 with SMTP id d9443c01a7336-20fa9e9ae97mr113660605ad.35.1729828937661;
        Thu, 24 Oct 2024 21:02:17 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0864d7sm1829005ad.303.2024.10.24.21.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 21:02:17 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:02:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs/004: add missing _fixed_by_kernel_commit line
Message-ID: <20241025040213.k77l4lticz5bafiq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241012011419.4066147-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012011419.4066147-1-chao@kernel.org>

On Sat, Oct 12, 2024 at 09:14:19AM +0800, Chao Yu wrote:
> The bug related to this regression testcase has been fixed by commit
> b2c160f4f3cf ("f2fs: atomic: fix to forbid dio in atomic_file"), let's
> add missing _fixed_by_kernel_commit line for this testcase.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/004 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/f2fs/004 b/tests/f2fs/004
> index dd1ed5c1..e08cee11 100755
> --- a/tests/f2fs/004
> +++ b/tests/f2fs/004
> @@ -25,6 +25,9 @@ _cleanup()
>  	rm -r -f $tmp.*
>  }
>  
> +_fixed_by_kernel_commit b2c160f4f3cf \
> +	"f2fs: atomic: fix to forbid dio in atomic_file"

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
>  _require_scratch
>  _require_odirect
>  _scratch_mkfs >> $seqres.full
> -- 
> 2.40.1
> 

