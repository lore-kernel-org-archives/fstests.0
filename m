Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79122C2368
	for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768759530; cv=none; b=i1JahB0faiPZi4etafkY0Fh189506wBWdiOg810z7q2oAPOqsbSyD+C6cMKkKtCedBcTbyg+clT31KF8XHf2Wtg2Jj8wCoVPffcUHVPqxhUHp9gv885pISk1iDbTWXT/CMiPNGIHGAJoS/x2OD4DnURJqf/PPHBycWc1mU7DKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768759530; c=relaxed/simple;
	bh=EBopMWp3Nu+B1DwCwjkUZBZPU5R58050Bh9WTkE2Jvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN2/BxlhmEV+gHKbHEwxkHBc0W5bPiPWyFLILLgYO1p3Iw9ZCY0leyGkepX79Wliibk4ATw8rEOtGVEM+fOMGGXV8ahb5WBWZid/U0AfAYzbglvNxo+ZxWm3XeS2Ueo89hcqFSqUr51tMD7HiXGISEs/y3gjFSqWhRWtirQ9vHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBsGZHWG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q1f6rTjs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBsGZHWG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q1f6rTjs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768759527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7GTIcWu2ZHoot7uN0uZ+bnOWWdj0iWA6yylYTcRdXwU=;
	b=EBsGZHWGKZ1LsTIJSwkZDIvChMAb4E+IfXi+PCdVtzZY8TSKqLk35Yw6HGa4YUW4Ragmmx
	DwLmlaLBUqSweX/V7uevd5SdEox11sdD48ax3/okEc1oHjNN8ShKtk6trvXBqn3DkKt6Cv
	6gfE7trBZaDGUpyjvN5G5TdyyNSAq4w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-SJ-pPx4eNqivzoAAM6La0w-1; Sun, 18 Jan 2026 13:05:26 -0500
X-MC-Unique: SJ-pPx4eNqivzoAAM6La0w-1
X-Mimecast-MFC-AGG-ID: SJ-pPx4eNqivzoAAM6La0w_1768759526
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c37b8dc4fso6756805a91.2
        for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 10:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768759525; x=1769364325; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GTIcWu2ZHoot7uN0uZ+bnOWWdj0iWA6yylYTcRdXwU=;
        b=q1f6rTjsFDgqgifOi9+xYaacb6XBGgqXkQ3n55HgfyPKULlheeIsBrqYHZ2txHymvY
         yvA/VPxqYt2aeqdFZjwdmAp58mAwwUNIANUyF4gCAVMSXvjLh9Tz1NdbS+5dHGPzexA5
         bESxX4GxXoHbl5dazodi5H2IKnnTaHQFNR1PwA9biB3xSXGwhkWgNs06SwTKpvGVDZvQ
         nWYXs35CmzVysvkV1XSdaZ/r3palFXQcXkhNovhhLjEUtefTxan0ADPPdmyrlizNGP83
         5yvLr17+nif7wSg0baUp58eB0IJbLdqTV9nGoa8WzpDXYbzv5yxl+LTM3UhbD5hUknSm
         8fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759525; x=1769364325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GTIcWu2ZHoot7uN0uZ+bnOWWdj0iWA6yylYTcRdXwU=;
        b=bKAfmY/Bq+st2Wg3f0nU5pqyrNbULIg+1ot6no+SdzNHHF8amq6n6pf2fXXWeS+DoW
         s9Glsko99JiXqmbnqgyk+3We9CYUI7yvYXGy1f/tbMmmq/L2FfHmruFNm8gqF4Ce3AON
         ddtAFot0hALA7pSj56WAmgds16Nrh1s9Bd/+3CXutEzViCndiUYkqcaGWYiYGHtD9PuA
         h+4YO6BjTFH0oYNTgkhDxalibw9qQicZE+OSK4zRHYY/hsEPROOHt/uGFMhC8NtJnpIe
         7GRNqcuHDPfmo/vwdWg6SWhNmaSzbp7VjSOHGlYHcZQmrjIKFSal4eofwKNEH/PNivQY
         0lQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYpxCQg+dxWYRnZ0kQCOLFjiMan4sMpEAUN+LvoEtooRxn/wQkN1aJCQiWRz0L7AKRJe7ivzY+@vger.kernel.org
X-Gm-Message-State: AOJu0YzndJzsAW0MlqJaXqUG3X5THeAxOU9xFJ34zIo2/GNzUI9TKmeZ
	Ku3JdLNKGA0dOeN+xQrqVnjr2vKyarNGNe6LPhbkmbUAFdFtrUJ9XugtPeBJ5mEZ4XX5zsjGMuZ
	JW8lhNpEckDsKsPnWXseG6FPOLcww/bCqpA+MKQrt93blCWjUDTWNHuqFrN4=
X-Gm-Gg: AY/fxX70UlEvpxdB+rCKrVO9qF+w/X+s7ATAzQ/vKvuIq4WAhXpmOWZcrpnWZDW8k4r
	4SHl2oV8xzHMAOKnEkkHJacQWc4tIvyQdC+tlcXjYoza35gnpiPQNS9W5n3DiuAgJQotz9JeVtS
	NyHyHfS0iXntnjxfDcVVYNBqbpwiw8/u/lRZFuAbSP1G5cg6Re/dmAfwv7elAAwJ1jdWFU+a6QT
	fSAIpH7SiP6FIwaOeZtblEwXHxNBIUwKzSt3Q+Ev+IDrdrH//yl6FHGkY/a3XFBaVoR9wI6oHeg
	j1JDqNTo8+Y7injkhydcBIKAOm5/rlOtNzEI0W5hZd46q9kYI3d2uPJ+urPBFx0H32Wlv+rJmtW
	37m5A0GLzijY1/asCcdkG1EsqAvxiAFeNrUVje4udB3Bsjhg90w==
X-Received: by 2002:a05:6a21:328c:b0:38b:e88e:ad1f with SMTP id adf61e73a8af0-38e00d5d087mr8300941637.47.1768759525532;
        Sun, 18 Jan 2026 10:05:25 -0800 (PST)
X-Received: by 2002:a05:6a21:328c:b0:38b:e88e:ad1f with SMTP id adf61e73a8af0-38e00d5d087mr8300922637.47.1768759525007;
        Sun, 18 Jan 2026 10:05:25 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf354b16sm7027939a12.30.2026.01.18.10.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:05:24 -0800 (PST)
Date: Mon, 19 Jan 2026 02:05:19 +0800
From: Zorro Lang <zlang@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com, fstests@vger.kernel.org, zlang@kernel.org,
	Slava.Dubeyko@ibm.com
Subject: Re: [PATCH] xfstests: hfs/hfsplus don't support metadata journaling
Message-ID: <20260118180519.xdddwoke2tey6ogt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260106233555.2345163-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106233555.2345163-1-slava@dubeyko.com>

On Tue, Jan 06, 2026 at 03:35:56PM -0800, Viacheslav Dubeyko wrote:
> HFS file system doesn't support metadata journaling.
> This patch marks HFS file system as not supporting
> metadata journaling in _has_metadata_journaling()
> of common/rc.
> 
> Technically speaking, HFS+ is journaling file system.
> However, current Linux kernel implementation doesn't
> support even journal replay. This patch marks HFS+ file
> system as not supporting metadata journaling in
> _has_metadata_journaling() of common/rc. If journaling
> support functionality in HFS+ will be implemented,
> then HFS+ could be deleted from _has_metadata_journaling()
> in the future.
> 
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> ---

Good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index c3cdc220..82491935 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4267,7 +4267,7 @@ _has_metadata_journaling()
>  	fi
>  
>  	case "$FSTYP" in
> -	ext2|vfat|msdos|udf|exfat|tmpfs)
> +	ext2|vfat|msdos|udf|exfat|tmpfs|hfs|hfsplus)
>  		echo "$FSTYP does not support metadata journaling"
>  		return 1
>  		;;
> -- 
> 2.43.0
> 
> 

