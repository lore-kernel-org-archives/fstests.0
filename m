Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DF3198E9B
	for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163807; cv=none; b=tXI9tiVyOkvWT+MXz0mET6xgFHrPwhp6Xa3bMIP+gJRyjLr321QsaOD8fgBqzkMOtaesKsOwIz+26q4hyrGUr4Ex7mcEziJ9xgB6zdTW7FsqlWueVPKQeBOx9dLAY2sqdzWqNem1q+Vm8jwAKlRlM8pc+EMBGZ1jY9eiCCIYxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163807; c=relaxed/simple;
	bh=YDod+df5AiIWuWs6Cmu2qKvbtpNdZm/Pu1iwQ3NStw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2uEw2FWSxh6w4pBpwlmpUj9CocxAWKH91tUnsu6gxSqx4NSrY7WOTBpWY8bV8yf7/Dn6Kw3HCkf641d+by8xym6NwEgB5Ej3m6olYMgBrnrxG8Sx0LURUibUzwF2Donm02wllPruY9VkJAIGVtEJLrVGlGCtDrQsa0V+TzAcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDvegG0o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDvegG0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGjmNd9ec8sbRwoFSLfESS0FlftMKib6skkfiBxe07s=;
	b=ZDvegG0otLnnzXhyidl+ov+Yw6XcCCyi1/l/wTeb3pnDs39dffrvdtoXOdjA7USX1Z6Z2v
	hQleBjSrpwQ/X8PUHnpGoW+vlmrX7kHZHGFdq671lbS6a8wNpQUdHQIz8avx2SHJK+MlPa
	d6jrk5bMAL4xmzp8r6l/qoGgghuZEW0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-JLAZ00ADPmO6gpxSZYzQOQ-1; Thu, 10 Jul 2025 12:10:03 -0400
X-MC-Unique: JLAZ00ADPmO6gpxSZYzQOQ-1
X-Mimecast-MFC-AGG-ID: JLAZ00ADPmO6gpxSZYzQOQ_1752163803
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-747ddba7c90so1041138b3a.0
        for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 09:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163802; x=1752768602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGjmNd9ec8sbRwoFSLfESS0FlftMKib6skkfiBxe07s=;
        b=sQxRcC6BSxjCYUNXc7G1eBS7t/1CTvbl1xrdDa2HJPbeOgXYc5pnb4O5UjVifVqtIP
         TR2dPJS8+gimWN4dz1pKSfe1+G89CJTUQJDI1KJBT0jkW6XK826Qpr/Cutsw5uyxjD2y
         avYgT8o+8KHQnVcGNmmAK7iROAYmcKVqvnraEgPHmN3tFTrTluEvp1GpIzDja+CZdj/Y
         8DuXp7HB9gxNSDNNYtSxQKaEMLO9YOGM5mU8DMpE1B6Ml2z8+e1ywPXJNTAcyM2Z6AJU
         0/iXitk03yJ+avFyrpp2skj+nAMwLgZkjtsc+81zw3dPs4Aet8CbkBb8KQx2d48gFPFL
         jhTg==
X-Gm-Message-State: AOJu0Yzdqzkp80IWr9K7ZTJq0ImQRMKEfROd8fIA+Hwz7rwnPdntm70f
	9SnmpG0O4DLtjmiFa8qUSBbLrITWpytygM8vbt2LaNkPzevHvzKkfG7SHYc6elIb6B6QqRniS5W
	g4FNTex6TKsVrEN1FEVV3qmqDTKA60Xje/lUYrxKByyUZC7Pky5HqRwPD4Tz/NQ/eXHclrFNXU+
	3ewlkPikDcArzD+lZyGP0H3s+cFAIK8Q6HLDSKhTo=
X-Gm-Gg: ASbGncusaBvywxhQ2u/XTtwKy1gOX+zF6BGqflT07LeAoLEFZwof4YAjqyS0+eMs0Je
	Gs7+J/SbPhvp/S6IdLnehPXpUyvVZxpkBe9xHriEKZ68cVXAYAh6Sy+hPXlXWrNgVdh4BNU8ENn
	Z3pdVIYVoi/PLBKtpogXD6dG0nMJYfbS6KB4gIX1KFInuLlKK2owoA0zUuOGY7IcxQ+I6biH10V
	deXyTres4sCf1nKVyu0TQPX4WSU/jnBDm/1Hvikq+lK0QWwLLq/3zCyKYQqvrqVXY3xA7aZIYxN
	PNCsZ4h9cob1dkRIMkoWGcnxjmcz7M8VfqlzvtjkyqJcTHMSQTJGiUhZqcrwutI=
X-Received: by 2002:a05:6a20:9188:b0:22d:fd6:95a4 with SMTP id adf61e73a8af0-22fb8ae6bafmr7341775637.12.1752163802127;
        Thu, 10 Jul 2025 09:10:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1m8LE7GTQhgpGO01JfsKu0cDoA8fJPphpzaqlYBM6tKooTC36JmDSLFmaA21NxgPueq8Ibg==
X-Received: by 2002:a05:6a20:9188:b0:22d:fd6:95a4 with SMTP id adf61e73a8af0-22fb8ae6bafmr7341736637.12.1752163801652;
        Thu, 10 Jul 2025 09:10:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e14e9bsm2603065b3a.49.2025.07.10.09.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:10:01 -0700 (PDT)
Date: Fri, 11 Jul 2025 00:09:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: Re: [PATCH 1/2] common/rc: remove useless _pgrep funcion
Message-ID: <20250710160957.umewloigewyxilbn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250622203947.797199-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622203947.797199-1-zlang@kernel.org>

On Mon, Jun 23, 2025 at 04:39:46AM +0800, Zorro Lang wrote:
> The _pgrep() function isn't used anymore, remove it.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---

Ping.

Could anyone help to give my 2 small patches a reviewing :)

Thanks,
Zorro

>  common/rc | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index fbab26b25..a27f87a0b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -36,16 +36,6 @@ _pkill()
>  	pkill "$@"
>  }
>  
> -# Find only the test processes started by this test
> -_pgrep()
> -{
> -	if [ "$FSTESTS_ISOL" = "setsid" ]; then
> -		pgrep --session 0 "$@"
> -	else
> -		pgrep "$@"
> -	fi
> -}
> -
>  # Common execution handling for fsstress invocation.
>  #
>  # We need per-test fsstress binaries because of the way fsstress forks and
> -- 
> 2.47.1
> 
> 

