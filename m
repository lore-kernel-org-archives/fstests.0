Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9821638F
	for <fstests@vger.kernel.org>; Tue,  4 Feb 2025 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690376; cv=none; b=o87ds6sPOnGMAXOXtv9LPHLTwhZEXHTn5HXVXlEe9KBtYxm5MW0JEkTSkEMAT7iUec8MHxd6O2odw7HcEUv1R+oHZi84EL0OM5Ur72trOJEmm13FTN2GF0/62wEqKFYJ8pmbjNPnX4DjlppIKIhWLYY6HkQi/lbFFORqI7P023Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690376; c=relaxed/simple;
	bh=gwUl6Dx+OTeOaqXejWlWOqUci8QZk8CC7rbjTNhwE/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQm1zvL4tS7zrVpCK5sKqJpKaiVZBj7w/K+h2HIY8yNO2Kl+dDJ8oWwX73vL3pewGRCzhblSzNNNpppZn9jh8e0DlxJxL2aqcZkDEjYdNtke60ZVmr67aidNAPWsLzKFWcYIF557VTeVBPavu+6N9QK2yyfL9ScXK5sHYJKU0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7DY2qus; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7DY2qus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738690374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnZO3fVfK3cThBm35Pln6hDZOo04GuJWQRhz+n5uKng=;
	b=V7DY2qusWaJS8PEkwGylOmHcmlaLuT0eaDvkgwJZoF1bywbmzpRLaYJvelOszwBFOsDN9z
	lp+rChRDQHglXHB/Lb78iB0g9+gYyfgZ9mlugdCmluhluxFogge3O0gPvAseJzSDLs3MyR
	fmMt5wVEaxaB6Ydl350Vl4l8V+AMpcU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-6AxeOdGJN_6XBQs6F4zSdQ-1; Tue, 04 Feb 2025 12:32:51 -0500
X-MC-Unique: 6AxeOdGJN_6XBQs6F4zSdQ-1
X-Mimecast-MFC-AGG-ID: 6AxeOdGJN_6XBQs6F4zSdQ
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f9c02f54f2so2025804a91.3
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 09:32:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738690371; x=1739295171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnZO3fVfK3cThBm35Pln6hDZOo04GuJWQRhz+n5uKng=;
        b=FlsT9gJw0pP95UAJ1F9m4WDVlHFk50ze1LO/mTyA2v0OB63aMRsVh/dMPj4DeRm7hl
         XN3nXu8EyDAiamORYK9K4TMP54vFHIIdLhKJemfHmsi6JEiA8udPZtTi4/XcPaLy/y2s
         6u4/kp7Vk6n/0hI8DheQkR99dst63oC55x4c9fFFSyWny/X60jduMWySiVuuAiY6VI9Y
         McualntWLbRIPkvN2VZ4qku8KLH+XGSe1hHxaqodAqzu+Srn4dZCGiIic6yHPCPlF9Fw
         zEGHTpiJ0ByFP5AYGit3yCpRpxJAx25Ab2phXVrTZD60e6Ir5jdCt6YM15QL8E5zrR0G
         dFhA==
X-Forwarded-Encrypted: i=1; AJvYcCVADjFlUd4GhOP99meqx3ggJWpoMR8V7yGSw2QjSBl6QBrNjaVRLupC5ZKlV5uPJj/S8Mv0zQth@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6X1rWCgCXL8vcFqWuObJmdYFCuT4LTgWj1DJFodHyFyFyL4de
	WEjq3Zwru4UAFy21BeZJJFpz4w5lm9d2HqLeu8TPQd2c/OvOlcY25pSw8Sfds5p9wfGB4HyLS6/
	IoDyVPCkod3q44/ScQ4iwLuO34sr7ltlLg9Z4/NItAVwJRXeouvNMpks=
X-Gm-Gg: ASbGncuwOIvMOQ/53SqiRqNBnBbHSl22x2uvcJzD/f7d8S5IEIw3HUTxpcqq2UMOtCv
	9OHZZ/bYilyFh5heQHtP/y3WlFF/yBU6vpL4yfGxx8ZmPE43kWvJHHdEe/HmGQyKq+flFl/h0Vk
	GZNOtinA6Qsfm15IPhVCZLb4flAVSClkENldkCPqXooIafF0SqV7uu2rbioxhu5HV7hOh1rDkJ6
	tQ5BdmZI6ODmElF4qOQHIGAN9vHYyWmwW0Ne6TRjvF/s4/neS/RKsgDPf89XVyxLVVI2D2xqM72
	UW7MWi9GT+rQ8ONMEbpGAvtC2iJy+rHniJonjxJ9XZDJbQ==
X-Received: by 2002:a05:6a00:ad8a:b0:727:3ccc:25b0 with SMTP id d2e1a72fcca58-72fd0c658admr38478416b3a.16.1738690370767;
        Tue, 04 Feb 2025 09:32:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCzZH42S/jQvpLJIx9uzIu9QeGfV3gZWWhl2PSZ9fFuduv71dtQM1L5ZF6n+Hsf6gun5DmOQ==
X-Received: by 2002:a05:6a00:ad8a:b0:727:3ccc:25b0 with SMTP id d2e1a72fcca58-72fd0c658admr38478380b3a.16.1738690370470;
        Tue, 04 Feb 2025 09:32:50 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ce9f4sm11155837b3a.146.2025.02.04.09.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:32:50 -0800 (PST)
Date: Wed, 5 Feb 2025 01:32:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common: fix a spelling error in _require_zoned_device
Message-ID: <20250204173246.dv7ecpi2hlvhtcp6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250204134612.2017269-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204134612.2017269-1-hch@lst.de>

On Tue, Feb 04, 2025 at 02:46:12PM +0100, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 4658e3b8be74..6840bb1dfa10 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2473,7 +2473,7 @@ _require_zoned_device()
>  
>  	local type=`_zone_type ${target}`
>  	if [ "${type}" = "none" ]; then
> -		_notrun "this test require zoned block device"
> +		_notrun "this test requires a zoned block device"

Sure :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  	fi
>  }
>  
> -- 
> 2.45.2
> 

