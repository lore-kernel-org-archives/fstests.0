Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERioc30X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A2182
	for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 06:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700146332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tHFYvMb37Bnn7ajIbO3XnSzzu5Gh8KJZFj0sm6WsBY4=;
	b=ERioc30XuX0unx5f0l8wv0qDNAfkeW20HuATCf8knOjOJVVmVmHeCRhCGCd+yg49YSQrZT
	9qHkrSbFC3g9K7WXAf1MN+dDWGV5Df2kHedS5CPoNQnvWGtLXKC1UAeXMFBO7WfY7FN2JL
	w1CG6mQKh19Mw2SfXuTdSO23sXkJWzM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-c5jyO2RSOU-IPoEyiHLoFw-1; Thu, 16 Nov 2023 09:52:10 -0500
X-MC-Unique: c5jyO2RSOU-IPoEyiHLoFw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c415e09b2cso938554b3a.2
        for <fstests@vger.kernel.org>; Thu, 16 Nov 2023 06:52:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146329; x=1700751129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHFYvMb37Bnn7ajIbO3XnSzzu5Gh8KJZFj0sm6WsBY4=;
        b=ZoAYPL/c+UdJtFQRtazYet9NxIsQxSBTkJGIZOhDUihmWj3afIyiypBWpRxNDj+5Wb
         MzM6IrZBxYvSvBAWlnPlJ1hgzRTiFAaXeagyf8LlLyVcG0A7S2tPjGAurOCJD6xXAQrc
         iM+Q3CTktTYxdeX4rt1LLilWKn8s6PcMuRf3/kgv40frHp8WbBKw+3snssVz3FwR3Cqn
         YAvvhi5PuKH3bB8oVBDoPYMVZNDBb1adivr5zprn3D6ObNpbXgDiFQdlB0wCl6uoVoby
         xn9nqJEdWamz0ORrLLP05bKTpeirmSuAgt3Htg5wx2BXJfp0ZW9AMc5jKaPc36+mPq0g
         mcpQ==
X-Gm-Message-State: AOJu0YyryJLcNQYiOK9bLc0SMVY5hYcpHVDX1FkRI8qJg7ttF22krL7I
	U8jlyxl0FQuUZUeJQLfwLA1VZ343bVbBaRlMPC5WDS8xYUQu80O8ig/zhOYfJbFavH2kPL2vBBW
	Uqzq3jfMb+IXwmN3gM8zvUSXk2eEA
X-Received: by 2002:a05:6a20:9385:b0:187:4a56:99f3 with SMTP id x5-20020a056a20938500b001874a5699f3mr7716016pzh.20.1700146329218;
        Thu, 16 Nov 2023 06:52:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGumdrKJ4XYbZNF4t3MJXjwOIHMbrhBxNlzb8M4zEDqsYHHwx/88QTFJu0RFZZmFUK+iMrJmg==
X-Received: by 2002:a05:6a20:9385:b0:187:4a56:99f3 with SMTP id x5-20020a056a20938500b001874a5699f3mr7716008pzh.20.1700146328921;
        Thu, 16 Nov 2023 06:52:08 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i18-20020aa787d2000000b006cac1688153sm1586348pfo.69.2023.11.16.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:52:08 -0800 (PST)
Date: Thu, 16 Nov 2023 22:52:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs/263: Remove mkfs.xfs data section argument
Message-ID: <20231116145205.bffcvjpubufvl33c@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231116073315.3748-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116073315.3748-1-xuyang2018.jy@fujitsu.com>

On Thu, Nov 16, 2023 at 02:33:15AM -0500, Yang Xu wrote:
> On machine with using raid, this case will trigger
> the following error:
> ==== NO CRC ====
> +mkfs.xfs: small data volume, ignoring data volume stripe unit 512 and stripe width 512
> == Options: rw ==
> == Options: usrquota,rw ==
> 
> mkfs.xfs generates this error since xfsprogs commit 42371fb36
> ("mkfs: ignore data blockdev stripe geometry for small filesystems").
> It disables automatic detection of stripe unit and width if the
> data device is less than 1GB.
> 
> But, since xfstests commit baaa392c("xfs/263: don't hardcode inode numbers in output"),
> we don't care the inode number. So let's remove this data section size argument
> instead of increasing this size to 1G, then we can solve this false
> positive.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/263 | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/263 b/tests/xfs/263
> index fadd6280..bce4e13f 100755
> --- a/tests/xfs/263
> +++ b/tests/xfs/263
> @@ -72,12 +72,11 @@ function test_all_state()
>  }
>  
>  echo "==== NO CRC ===="
> -# Control size to control inode numbers
> -_scratch_mkfs_xfs "-m crc=0 -n ftype=0 -d size=512m" >> $seqres.full
> +_scratch_mkfs_xfs "-m crc=0 -n ftype=0" >> $seqres.full
>  test_all_state
>  
>  echo "==== CRC ===="
> -_scratch_mkfs_xfs "-m crc=1 -d size=512m" >>$seqres.full
> +_scratch_mkfs_xfs "-m crc=1" >>$seqres.full
>  test_all_state
>  
>  status=0
> -- 
> 2.39.1
> 
> 

