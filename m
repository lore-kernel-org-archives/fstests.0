Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A3C28CF79
	for <fstests@vger.kernel.org>; Fri,  1 Aug 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074405; cv=none; b=elUggpuigTf3J01AYVe2lKgmo+zKpig5zha6XPnzvBD5yWLWfUXZTh/4st3CX7NIjRRIKSsxUFO6QmDAumI/hp9jC5nDJPv5jQJzLmAn81QbitB8MPfdaO6vbTIFBnOlHKdNzWZ4qvNCVeOpAdaB3/BOB29HTCwuWCkeheiFdkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074405; c=relaxed/simple;
	bh=BlOWmP6b0ngQyzTUDyYd5gM8MDYZNPL8SItlOoTrUlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbauqUksyjVl5KfpprKUL8FIAG0lTRcTOGIbOLdtXqTQd/Ak2WGWMd2D0yWGK185537gPcyYaY512LTD5DAvnENnSRQo3/olTlGOQQLcNxhyRFPOppqsLtC7qQ4Udb6MJvxyZSOErjyq70x5SeXNs4ioom9De5krahIcfW80OmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChintfTR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChintfTR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754074402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7y/JAVOPDtnhJGGllW7ByUv7onWM1J6uxLUWmUw+0qw=;
	b=ChintfTRyIY4B+1qghde/4i1PHCfeSW7oVE3VrYSVj9Qko4k9rGgjFv2BNzmp7+6r9MXPN
	jejX0mUSofCszBjHbCoDEBrDcTUqU2JnBI4oYJLd+n1MX16ZvZ7PGKH0Edlvu3CyWYGuTP
	QVqrpeDysTcUGTJbnAvf/vP2UP2JVkM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-N7kgeo--MSSOfpx0cr9EgQ-1; Fri, 01 Aug 2025 14:53:21 -0400
X-MC-Unique: N7kgeo--MSSOfpx0cr9EgQ-1
X-Mimecast-MFC-AGG-ID: N7kgeo--MSSOfpx0cr9EgQ_1754074400
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23824a9bc29so21038345ad.3
        for <fstests@vger.kernel.org>; Fri, 01 Aug 2025 11:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754074400; x=1754679200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7y/JAVOPDtnhJGGllW7ByUv7onWM1J6uxLUWmUw+0qw=;
        b=D4he1aAsaGAK186LYjwnGp4JLK1ccPyMZuv+hVv1qp7Km2osaxfUOruJ21XYueQAA/
         6sNaCxbhMho1hRoGndfe9FwYLChkkIsf4rpIO9ML/frmZVAIWGAkjE382HcWs4xZVWzQ
         Z0BIHkS6ygAwrPjk8HID9cKlSNQMKCPnWBiPYT4NXFPzqYBt/Nyqow0ugNGVIZo5xMYl
         zVdDXCa/RMNQX621B40U6sqNpXPfgX6iMZ20TQbYUoII9o27OQWCPcJkCXFUxCJX2cmu
         VuA1WqT4/pbyz2m8xl2p80WVAQDBrtEaaPBEo9e9nyWLekIKrv/uAsCbRNkw5kL8NC4i
         c7aw==
X-Gm-Message-State: AOJu0Yz4kLNjO9pN0oIKS1cTuvFKB8YTT/Cm+M70l2yXod1IFlfdMpIu
	9D6ZmQW+l9iFi6KCC/cnfBfXW1BqOO3Fvf+/t4eImtgd3FcBJHleCIUpw2qFgqke1U+TxcuwHe9
	4qF7l3778Sy7QTNgxHHDY/55onDo83WJ8qrqrKhNC3drPXzuHeL2OD+wabkcFx1YQetE=
X-Gm-Gg: ASbGncuVrPoQjAlKWIZg8vWXS0Y8lnvePK0zVi5lg5RrXzxs85cKPJoVHNj8h3O+nuU
	HEppBJ+Tgspf2BsAL5LnQCOGWBbWqqEkEnjrXCuaafT4WDm89UdqobBUFoImT/R1dy0iiaX670m
	A/3H9Yr1Mi1+2LT+8yJtUonUTLCj6ZM7EbmNVsR7dP3sf5vMTZ+HaggBsSZbaA983KX11GNS3sz
	5kSL9l2gj55mnUDp8wzn+trtSDJvQMwir1NdyLSMEg4+vHMSQ/MmN3JIo9/tGL8oBTy6lqNgYqI
	5dGKVOeO5GbmP4ieNtnrYfkdXve3Y3mpgh5pfVPTSFz1Mnom6im0RWxabW+E0G0mD70r9t58/QR
	S/JKR
X-Received: by 2002:a17:903:110c:b0:235:f078:4746 with SMTP id d9443c01a7336-24247030c77mr6836025ad.42.1754074399981;
        Fri, 01 Aug 2025 11:53:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFR71sgbrUQpth4ns+7RmhQm8UWtY4FP90VahQPpWRdU7WkyumbSH8U8cF7K5bIFI1cVFlHg==
X-Received: by 2002:a17:903:110c:b0:235:f078:4746 with SMTP id d9443c01a7336-24247030c77mr6835775ad.42.1754074399596;
        Fri, 01 Aug 2025 11:53:19 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a1csm50075115ad.78.2025.08.01.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:53:19 -0700 (PDT)
Date: Sat, 2 Aug 2025 02:53:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/7] common: fix _require_xfs_io_command pwrite -A for
 various blocksizes
Message-ID: <20250801185315.2d2mfehoqybtiizb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <175381957865.3020742.6707679007956321815.stgit@frogsfrogsfrogs>
 <175381958029.3020742.354788781592227856.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175381958029.3020742.354788781592227856.stgit@frogsfrogsfrogs>

On Tue, Jul 29, 2025 at 01:10:04PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In this predicate, we should test an atomic write of the minimum
> supported size, not just 4k.  This fixes a problem where none of the
> atomic write tests actually run on a 32k-fsblock xfs because you can't
> do a sub-fsblock atomic write.
> 
> Cc: <fstests@vger.kernel.org> # v2025.04.13
> Fixes: d90ee3b6496346 ("generic: add a test for atomic writes")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/rc |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/common/rc b/common/rc
> index 96578d152dafb9..177e7748f4bb89 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3027,16 +3027,24 @@ _require_xfs_io_command()
>  	"pwrite")
>  		# -N (RWF_NOWAIT) only works with direct vectored I/O writes
>  		local pwrite_opts=" "
> +		local write_size="4k"
>  		if [ "$param" == "-N" ]; then
>  			opts+=" -d"
> -			pwrite_opts+="-V 1 -b 4k"
> +			pwrite_opts+="-V 1 -b $write_size"
>  		fi
>  		if [ "$param" == "-A" ]; then
>  			opts+=" -d"
> -			pwrite_opts+="-V 1 -b 4k"
> +			# try to write the minimum supported atomic write size
> +			write_size="$($XFS_IO_PROG -f -c "statx -r -m $STATX_WRITE_ATOMIC" $testfile 2>/dev/null | \
> +				grep atomic_write_unit_min | \
> +				grep -o '[0-9]\+')"
> +			if [ -z "$write_size" ] || [ "$write_size" = "0" ]; then
> +				write_size="0 --not-supported"
                                              ^^^^^^^^^^^^^^^

What is this "--not-supported" for? If write_size="0 --not-supported", will we get...


> +			fi
> +			pwrite_opts+="-V 1 -b $write_size"
>  		fi
>  		testio=`$XFS_IO_PROG -f $opts -c \
> -		        "pwrite $pwrite_opts $param 0 4k" $testfile 2>&1`
> +		        "pwrite $pwrite_opts $param 0 $write_size" $testfile 2>&1`

"pwrite -V 1 -b  0 --not-supported 0 0 --not-supported" at here?

Thanks,
Zorro

>  		param_checked="$pwrite_opts $param"
>  		;;
>  	"scrub"|"repair")
> 

