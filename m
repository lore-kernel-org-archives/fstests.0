Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxCl7tsx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CABD6E
	for <fstests@vger.kernel.org>; Fri, 17 Nov 2023 06:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700232721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b7j5sBfV13vA8wMQsCDmP3uVuHgN6BsD8DUHr4xS7M0=;
	b=fxCl7tsx6N8Jz5YMyrK7YTCLWDbYobZTQ2KN+1n3/1UlQCsRHxFTDeMOm4I98qCfUsGPRZ
	7cOO6E/sQu4GqGxCbl1u5yxKBL1Ddvx87qJimzwvhTfzCr6kFCRArGcyNra2BwgnVw7LVI
	riyMcJC+9H07WvcOHs20WORakT9WJA8=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-iUsc5ULpMaCk7PGF5bg05A-1; Fri, 17 Nov 2023 09:52:00 -0500
X-MC-Unique: iUsc5ULpMaCk7PGF5bg05A-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d656fd896dso1957840a34.3
        for <fstests@vger.kernel.org>; Fri, 17 Nov 2023 06:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700232719; x=1700837519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7j5sBfV13vA8wMQsCDmP3uVuHgN6BsD8DUHr4xS7M0=;
        b=CRm6VYjbJujPcDsU+4c3RZaCwwGDkMkv0gJIFozHbykZO5/EkRx28T6aCLkntDJ4ez
         HSbaGSlIJmvL9VwR08XDb5CaKtIBi9x2bIrxLAkFV8qJo5AQ2vCv2P6Fo9CVtswH1JUE
         ITw6bdvCORXlNnkebYz9o2BWIys9/6SY/rIk5L5X+MtA4zrUY+aWS2i7MYxc/dliJl1x
         zaPF66RGYvXwb//2z83i+jYjATKyNU70TjQTrYAqSsIuS0FokIt4RRijr7dcL4ceeBxh
         O1cCAk41p9vROYoKpyZuIgj9vRKRbLZ6o7HZExXgxn9GJei/zKWw2EcQThDUdiVO4FVG
         IRJg==
X-Gm-Message-State: AOJu0YyFN0PLls/+KLqErR915khW/r/ZWgHErRZT+tAeCljImcXFzbpk
	zMsSMi6+GmZmsK5IxOcS4RKBGtVzDUu5NMMI+ojHexLJGZ6YqQTGebQ47a+4ehdhBy+EpUHVOxq
	OeS4QUfptdRbtr1bycO7c23XXMRcLWog=
X-Received: by 2002:a9d:5d05:0:b0:6c4:c3ac:a9dc with SMTP id b5-20020a9d5d05000000b006c4c3aca9dcmr12810489oti.21.1700232719197;
        Fri, 17 Nov 2023 06:51:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6cGRYQ0FlUxGklr/fWv+6yUJ3QN2pjQRGps73vnFR9FF6Dp7NF9rcvy6LLMWnjqRYXg3Big==
X-Received: by 2002:a9d:5d05:0:b0:6c4:c3ac:a9dc with SMTP id b5-20020a9d5d05000000b006c4c3aca9dcmr12810477oti.21.1700232718911;
        Fri, 17 Nov 2023 06:51:58 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bs184-20020a6328c1000000b005bd11296584sm1524602pgb.53.2023.11.17.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 06:51:58 -0800 (PST)
Date: Fri, 17 Nov 2023 22:51:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/726,727: add missing _require_scratch_reflink
Message-ID: <20231117145155.t7vvq3ksdrhyo5ff@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231108152428.432995-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108152428.432995-1-hch@lst.de>

On Wed, Nov 08, 2023 at 04:24:28PM +0100, Christoph Hellwig wrote:
> These two tests require reflink functionality, add the correct
> statement to ensure that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/726 | 2 ++
>  tests/generic/727 | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tests/generic/726 b/tests/generic/726
> index f0d8df2e..77afe10c 100755
> --- a/tests/generic/726
> +++ b/tests/generic/726
> @@ -19,6 +19,7 @@ _begin_fstest auto fiexchange swapext quick
>  
>  # Import common functions.
>  . ./common/filter
> +. ./common/reflink
>  
>  # real QA test starts here
>  
> @@ -28,6 +29,7 @@ _require_user
>  _require_xfs_io_command swapext '-v vfs -a'
>  _require_xfs_io_command startupdate
>  _require_scratch
> +_require_scratch_reflink

Does the "startupdate" actually need reflink feature?

>  
>  _scratch_mkfs >> $seqres.full
>  _scratch_mount
> diff --git a/tests/generic/727 b/tests/generic/727
> index 2cda49ea..1f9eebc5 100755
> --- a/tests/generic/727
> +++ b/tests/generic/727
> @@ -20,6 +20,7 @@ _begin_fstest auto fiexchange swapext quick
>  # Import common functions.
>  . ./common/filter
>  . ./common/attr
> +. ./common/reflink
>  
>  # real QA test starts here
>  
> @@ -31,6 +32,7 @@ _require_command "$SETCAP_PROG" setcap
>  _require_xfs_io_command swapext '-v vfs -a'
>  _require_xfs_io_command startupdate
>  _require_scratch
> +_require_scratch_reflink
>  _require_attrs security
>  
>  _scratch_mkfs >> $seqres.full
> -- 
> 2.39.2
> 
> 

