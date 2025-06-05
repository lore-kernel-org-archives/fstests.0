Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1482777E4
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145583; cv=none; b=przl197RzSKgyYWWeL5F2tWC8GOy9STOKssEK0nV+sc8VycBAUP+TOYGFsB9snp8qJFgVkaMQLSDhrUqEmpn0y24a4pnsTxeWS01QRmKmb4n/5U4cMNdF+81iH5Lji9PgMs5bDR3S1FluziNtjhWdZVxfNiSDDpofU6rPC8dMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145583; c=relaxed/simple;
	bh=NWl6Qxphb3BjwURBYpg1h/YO2AB21RDOxh6sTj6TVjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/ETXkp+NP93tcboT8sp0RtVZGCtWR35Jl7fDLds+m4m2n1mIszp9jIOkfkujx8vjvdLqsE7KjnYSAk0CyuIFKhnhR8UKTSEhUjuBz4FfOC76AdIrJFW/O6BmSOrrC1K5oEVT5MN+6XNHtI9496eyuZru5QqFuRvSOuY3wfmMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9oOEqkv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9oOEqkv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749145580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iPrdVG6+0PsOEdiXujTCu1pdQDdZmy8ZPdPIbt39iBU=;
	b=N9oOEqkviQQzQjbVQKec9GCU/E36wSn3oMS/gQcmEz/kILoexeSclULsX+sJjsKP+c/Ctw
	meLs8lph4kctA8JAExd+wQx0ekhMlFHvU+24axY3PCeSAGoRLlP2s9G9j0YvV8yzD/X8fg
	1NcXIVECCUT4BJB+I+IdzAGzwH5GQbE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-TrSA-BU3OQCtyv_Ew6cSIA-1; Thu, 05 Jun 2025 13:46:18 -0400
X-MC-Unique: TrSA-BU3OQCtyv_Ew6cSIA-1
X-Mimecast-MFC-AGG-ID: TrSA-BU3OQCtyv_Ew6cSIA_1749145577
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74620e98ec8so1184114b3a.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 10:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145577; x=1749750377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPrdVG6+0PsOEdiXujTCu1pdQDdZmy8ZPdPIbt39iBU=;
        b=hiXgeddodhHn0QL1C8dKtuKcbbznf65z6IsMGajjZ1xxcLdm9bV8TTi2VDFNeW7YS8
         fR+CGK0oGLVfcgEe56hrQI1ZR0/dnsttNWpRNlHVGsvmUF03JogcDqsCNXZuq/bTzLH7
         yflU2LR0soQ0TrxF9+xLhy6i14QkQlDZGR0568WIvJi8vkceV0aJfxCn/kbCvScMMLqu
         inF2Imc0BU8Hg/rgMx+EkVtibPwiPJvSOSZKrM9V/6BZ9V1weXqvLBcoQyvHeltkd83r
         Jec0DC9AyhcuDtuBR/BFLE5KBdAeeEKYlJZsvJ7GksGGFO5akoRu9ChiZiXFk/p9AZuQ
         t/HA==
X-Forwarded-Encrypted: i=1; AJvYcCV2GFM9vI/M7bCEomvLL1gJQWjke/3vkxPNBLVeNG/rFPy8gxFimfaEO86ogf19A4cfLXhw8qJx@vger.kernel.org
X-Gm-Message-State: AOJu0YxOj6cMZBKjj4yHSb1s65iZ1//KyS3gqeoVejRnWwaOGpzkj95I
	h3enhz9V+EAXbLeBpLNMQkfRJALkgkawBTndHRcY7D+kGRvKgvTdEG+HRx+jpyrCP7+GkA6VV/C
	hpcifEFBe2goFTnQYaTc/3OtoJ1VXWblYxPNjstrOABn2BD3F55Qw6hUr728=
X-Gm-Gg: ASbGncuFuQLXhLrXVwCMlaLVAkt3lvK40oq/rNQFqNIF0Ub0kkrx21U0CU3oXWgeXyf
	6aPpmYF6OOlomEnsxrapW6mGfcViKc2ZResRJJ4tdZs25CBZlxdvP6mMHWiD7Tc5BevlbVN6dY2
	8SrzQMrZ3xFsx/FXI9rvt0pqdk5U0C0mO53amIMf/G1YSnGUYS1+cuFHoMOMjN7E9XjdZEstVS7
	cLJ2AyEOFK+SXfEw3nXSNijXps3kH1hSbGs48vmXWGOHRxlqRN7Yht7vp+jT1gl0MXixvUX2d21
	6vQWXT3xo+zcLAJCrGf/eKTR0VkIsDbPSOIFMEsGrG9H9xdbAltx
X-Received: by 2002:a05:6a20:12cb:b0:1f3:20be:c18a with SMTP id adf61e73a8af0-21ee25987demr122582637.10.1749145577215;
        Thu, 05 Jun 2025 10:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFimSDjURIa5JqVkJZKGmXb2QwBIKm/vIISZyhWkS+AvWtKgRYIUfw9WXpJVOzV3RfmnK0zlA==
X-Received: by 2002:a05:6a20:12cb:b0:1f3:20be:c18a with SMTP id adf61e73a8af0-21ee25987demr122553637.10.1749145576851;
        Thu, 05 Jun 2025 10:46:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2efe6caae1sm5789454a12.29.2025.06.05.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:46:16 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:46:12 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 6/6] generic/699: fix failure with MOUNT_OPTIONS
Message-ID: <20250605174612.zugwd6lwkuqqfstv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-7-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603100745.2022891-7-amir73il@gmail.com>

On Tue, Jun 03, 2025 at 12:07:45PM +0200, Amir Goldstein wrote:
> generic/699 uses overalyfs helper _overlay_mount_dirs, which is meant to
> be used by overlayfs tests, where MOUNT_OPTIONS refer to overalyfs mount
> options.
> 
> Using this helper from a generic test when FSTYP is not overlay is
> causing undesired results. For example, when MOUNT_OPTIONS is defined
> and includes a mount option not supported by overalyfs (e.g. 'acl'),
> the test is notrun because of:
> 
> mount: /vdc/ovl-merge: fsconfig() failed: overlay: Unknown parameter 'acl'.
> 
> There is no other generic test that includes the common/overlay helpers
> and uses them, so remove this practice from generic/699 as well.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/699 | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/generic/699 b/tests/generic/699
> index 620a40aa..2a6f857d 100755
> --- a/tests/generic/699
> +++ b/tests/generic/699
> @@ -8,7 +8,6 @@
>  # mounts specifically.
>  #
>  . ./common/preamble
> -. ./common/overlay
>  _begin_fstest auto quick perms attr idmapped mount
>  
>  # Override the default cleanup function.
> @@ -96,20 +95,24 @@ reset_ownership()
>  	stat -c '%u:%g' $path
>  }
>  
> +setup_overlayfs()
> +{
> +	mkdir -p $upper $work $merge
> +	_mount -t overlay -o lowerdir=$lower,upperdir=$upper,workdir=$work \
> +		overlay $merge $*
> +}
> +
>  # Prepare overlayfs with metacopy turned off.
>  setup_overlayfs_idmapped_lower_metacopy_off()
>  {
> -	mkdir -p $upper $work $merge
> -	_overlay_mount_dirs $lower $upper $work \
> -			    overlay $merge -ometacopy=off || \
> -			    _notrun "overlayfs doesn't support idmappped layers"
> +	setup_overlayfs -ometacopy=off || \
> +	    _notrun "overlayfs doesn't support idmappped layers"
>  }
>  
>  # Prepare overlayfs with metacopy turned on.
>  setup_overlayfs_idmapped_lower_metacopy_on()
>  {
> -	mkdir -p $upper $work $merge
> -	_overlay_mount_dirs $lower $upper $work overlay $merge -ometacopy=on
> +	setup_overlayfs -ometacopy=on
>  }
>  
>  reset_overlayfs()
> -- 
> 2.34.1
> 

