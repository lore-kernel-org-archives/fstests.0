Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C41A705C
	for <fstests@vger.kernel.org>; Fri, 25 Jul 2025 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753450684; cv=none; b=d0Ow8siSNth51AqCt7+kG5t2V8eTfbx4bda0/fYJ7uigXSV8993EyJw6shPT8MpH9z8h0yuoziixnGwGPJknYXUvN63Pyk2FG+75fgXi3sQk4W96p7u1fFdbrJgtGBBIq7O28b9l1Y2Ay78ROxB5Xy/jJ+11uYMSt0Fl7Md0dvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753450684; c=relaxed/simple;
	bh=/R/f1VnIiQ17ztgf2ziByjM8+xJu435UaKItLzM7cII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODO/5nOHIBgmBQDNb8uhudFBtdT6OxqPVwVgymUOO496f2luirZu1ZgQ8c0J7G+NnwxXOkePOf/cm+KLlVZj51rGRRSSfOY2IaCvzFNYDZio2voE5FGhdR8N5uDkklfwfT+7eHng0OJWXwcGEz5NDrFeIfZ0bePr/OdIkbyW0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoFfbe6n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoFfbe6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753450681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a5JYyCeQr8lwVf5tBXRGsE5gJohtZrePfxB1grTkhOo=;
	b=YoFfbe6npcx0DNf5b31QoISQ0l88qI1sXHsSnTrnI4yytS/pzvmwhDjEFGdPHN4yOfqSXu
	v/MmDxztWzFuDm+1foVZ2kFP3soEEaQEH1XADjGGgCeQ7D281QSXwNo2HEYSs4/fmWcctA
	f9NaNa5MJUWacGcrcNzs8kklWrXOYDc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-1QJS7u6TNUKYaZw37a_yAw-1; Fri, 25 Jul 2025 09:38:00 -0400
X-MC-Unique: 1QJS7u6TNUKYaZw37a_yAw-1
X-Mimecast-MFC-AGG-ID: 1QJS7u6TNUKYaZw37a_yAw_1753450679
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso3802690b3a.3
        for <fstests@vger.kernel.org>; Fri, 25 Jul 2025 06:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753450679; x=1754055479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5JYyCeQr8lwVf5tBXRGsE5gJohtZrePfxB1grTkhOo=;
        b=JkbHyRgjqaZ8jaahSGEPi/5hehru6X9eOOaHEvOFeBGaYYCrcUFOa9Ysu4ddKEv+4G
         JE95MCF3pJx7DN2BGy/KqL9Ex9gW1nDY2RIGSuKCTqylNU94FeEUCmKX2954rFjMlsLH
         1yJq2u/Jrjv5QJbT2FXsP9nEUKYC2YZVEAClo4QV8Aew5gX4vq3iwLUT2huLU0beYHEn
         OflypLqLYlPxVFsEJqFUZlu4eV/G/1yi+l/JoWIw3ntkJ1XhrHNt1ShKDI/QjmhbsJOX
         yNeVqIPpS6IlsqXuJ4nxFP0qfkIbNNC8IwekvIfc1r47qaey/eP9RYfmAOB7IPotjOyI
         lIUg==
X-Forwarded-Encrypted: i=1; AJvYcCV/SVNnTIDJFWGODDk5iFlAxfcm5AdWsRUQUNrLhXmIfB01WoBrm8s/ZW9zhOAhdElt93JSiSYR@vger.kernel.org
X-Gm-Message-State: AOJu0YxICe8vgw9YHnI5X+GJFEW7ZQrN3A5eevteZ7M0mULMBgkqbWEM
	FG1/cCz6SA48gWhleZ7aav96+vb84+WMqFS3H5rIA0BEyxx0EldFB9HJJ0e99/QgnBzTYkegrVP
	euFhHR6jR6q4MZOgpoLBZXgGSdao7hfVoKqKTGQK58tsKSONXNdOwuisB54M=
X-Gm-Gg: ASbGncvo4SqIiQRWwGP0mh4xLs88QGGPtvYrlrPcpf63t1ehoJUJDkxy/kOLYM9qTVu
	e+shxlZESDQGD8adpVOIP1X7C3daYgnBWzg3gP8yhf/bl3FKVMSxz3k6t/J90lMs0IXnfUgeh/a
	Iq5zzK+6E23Q3TlySR/cKuOvnB9GXntTKhZc+kxWg4DqyEReoD2NWjhoqfE4u2qpy9Lj9iox2KI
	hROTeXa13vNdfeHdzYP9FPGz8JnUVMHZ+bcybEL9y860+C1udpar0p7CSM8S+pdlemkgnnqXpfj
	JptOayHMoyOqoH1iS8QIcLmKndiX03x6jwSGDzFHNbBeQ70AJYvbdOU6WZ1w84gYdjRBw8Oqpps
	2eaBg
X-Received: by 2002:a05:6a00:ac8:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-763356295afmr3509977b3a.3.1753450679082;
        Fri, 25 Jul 2025 06:37:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdHJeyZQMYS18pi3cqnEtsPUEq8U8ViXrYZKdQs1WvIp0JMwrzaSIEKBUAi6M8oxr7MuJIww==
X-Received: by 2002:a05:6a00:ac8:b0:730:95a6:3761 with SMTP id d2e1a72fcca58-763356295afmr3509933b3a.3.1753450678717;
        Fri, 25 Jul 2025 06:37:58 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b04b501fsm3708366b3a.92.2025.07.25.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:37:58 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:37:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, Yuezhang.Mo@sony.com, fstests@vger.kernel.org
Subject: Re: [PATCH] Revert "generic/730: add _require_scratch_shutdown"
Message-ID: <20250725133753.f7vwtkvtxql4owl2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250724072514.3313006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724072514.3313006-1-hch@lst.de>

On Thu, Jul 24, 2025 at 09:25:14AM +0200, Christoph Hellwig wrote:
> This reverts commit 68c9ac2ad74ba31c02275fcbb11d1cf90f0435b1.
> 
> The test does not actually use the xfs_io shutdown functionality,
> and it does not use the scatch device.  Adding this checks causes
> it to fail for setups that do not use SCRATCH_DEV at all.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/730 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> index 6b5d319675f7..6251980e33e1 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730
> @@ -29,7 +29,6 @@ _require_scsi_debug
>  size=$(_small_fs_size_mb 256)
>  SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`
>  test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
> -SCRATCH_DEV=$SCSI_DEBUG_DEV _require_scratch_shutdown

About why this case need "shutdown":
  https://lore.kernel.org/fstests/PUZPR04MB63169A8C1008035BB2D104568166A@PUZPR04MB6316.apcprd04.prod.outlook.com/

So looks like we'd better to notrun if shutdown isn't supported by fs on
SCSI_DEBUG_DEV. But if think "_require_scratch_shutdown" is a problem, maybe
we can avoid using _scratch_ things, use a local function to check shutdown
on SCSI_DEBUG_DEV manually, and notrun if it's not supported?


BTW, can I ask why do you need to test with TEST_DEV only :) Although
SCRATCH_DEV is optional (README says), I think nearly all testers test
with SCRATCH_DEV.

Thanks,
Zorro


>  echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
>  
>  run_check _mkfs_dev $SCSI_DEBUG_DEV
> -- 
> 2.47.2
> 
> 

