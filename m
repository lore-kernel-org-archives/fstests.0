Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D8382
	for <fstests@vger.kernel.org>; Sat, 28 Dec 2024 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735360183; cv=none; b=MgQq9szy5N9fJ50uq2hPGUTLA/M6+SMsRkYreTPEitoygzwogXXSBCkBbsC+4w38Oenk5V89r3GEig0GLSWk9BRRFV3c05vH2Z+P4KjpFyY2RnUJBA8W+fdFDVC4Np/U1XnMMCI2dBgpRXChMCvl/XuB0nsiqtxLx+W5f17NQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735360183; c=relaxed/simple;
	bh=gro4dNNWPQ5gYJECg7R07YgLJPSbRf6YQLgKpGRTQVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkLMycJ1shD/ys/sDu3wIpirJoJCI5N5YREnECE+3ESBUuupOvHHuSBSiVC3dpgeD8ePdchhRgGiP3L3TUdbfsCLtpGNh1rrR96o7xmdE22LgubPeU2eIW5hisY+TdNjNUxOhPn2um/vy/RFtw1sZBkTr2ZH9k7Y9wDM6UF703M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecO6lEnm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecO6lEnm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735360180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7EfW69f1VbR875uQRLJFk3Xl8wJJasMX4yD9gMIjf4E=;
	b=ecO6lEnmj2T6cRObbK5Ev1Hiqgb/cAlfwHjGOtM5bmiQHodxbLFCE1QgKO4+SjqFx1Pxs4
	mhs2rZvBZVMe6AHJH9SomQ2Jn4GMpdGWRHpQzgL4w3ixKNakjU8YD7U1jj+sP2kLRYbEX+
	iNIWr2oTURrUojRXHX0E9iDrZO3NsyY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-fjJ9ahTGNmyTutVHcHNULA-1; Fri, 27 Dec 2024 23:29:37 -0500
X-MC-Unique: fjJ9ahTGNmyTutVHcHNULA-1
X-Mimecast-MFC-AGG-ID: fjJ9ahTGNmyTutVHcHNULA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef8c7ef51dso9728769a91.1
        for <fstests@vger.kernel.org>; Fri, 27 Dec 2024 20:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735360177; x=1735964977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EfW69f1VbR875uQRLJFk3Xl8wJJasMX4yD9gMIjf4E=;
        b=i71eegk9e2hVtt4HgeuVuPgUtWgqBAuIy4ddql9dfzJmbmlKQ/P3GOM7IEEdJFOS3i
         xAkr14eW9Ah4PN8isnpb4sTG18ercDpg1g2ZYqqJoRSBLUUzQGXp7W/XmvkmLrwmPuWT
         dfnyMG7FfddcmIAI24hs6LZsLAZ34RAr8mFgUbXO38FlRJR5T2b11Wan3RxmoCJAnQ/J
         O5gpI56aPX5FL+R8t7Q/cx4Gs3dGRcM/x/Af0BTn8vCwevipnqJIkQ28dA/GvF5JsZg+
         F7u16LNc1iJciH1K0X5H91IC3pCHC9RsRIcdUw0mWFVhIoacVvPf1U53Qy3D9tGkUGYS
         zX4w==
X-Forwarded-Encrypted: i=1; AJvYcCV5pQT7LcwliuucMBxqLl+vIZSTb2pVlQWR+amyBl6mJFPwb64SIhFkvo2/ieVKTjeolSYTrWy3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxex8MhhX3u97v4ga4m/GtwiQdPEoU5nkGLMIFoqKBMo1T8L6b5
	96KXyfQXQjOxzh4tb74xVA4kTeX493c5BG+6XLdLFxeraQjTVzbrTgJT9ckmKHAK1ca6WsJyRJm
	opvQvvXOjLCDfSNCqGeyFaJO0sfX5o8neAXc6Pr7Hg28nHU5EOYo3RfU=
X-Gm-Gg: ASbGncuFi2LiGNF3VIuZ/qcnXoiAppHVXTPDx/WJL6wxZ2hnXzdYhoh6QRbwcN98dwU
	LONmOx4X3n48THWVzZ+WqxQpkqUw76ultyi2zsphicMvpbs5VjdAlDJkCTW2T3lgamEYIIVW/dJ
	n0njRjIFJiCFbkFm6hCh7eWNLKn5QDuwJbNvJHEEXaOnKdP4OmJjQ03EmvTyLRC6CK+pTJoc9+H
	K6YXUYE7TeNpUNRGNyREEtEpgZ+1oPq9K/smmvSwTzfi65N+4uaqkOJM0y639enuURZCv4UnY+e
	trOVy8tR5k5R/hn67b0tKQ==
X-Received: by 2002:a17:90b:2b83:b0:2ef:9dbc:38d1 with SMTP id 98e67ed59e1d1-2f4435ad5e6mr45177911a91.5.1735360176841;
        Fri, 27 Dec 2024 20:29:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1MdxnWOsnF/Nx/tbnW5WGIG+UHcQ1Kyol/UUxYMSG87cGahqG+KdcewPaFgaSIsQRZPlBig==
X-Received: by 2002:a17:90b:2b83:b0:2ef:9dbc:38d1 with SMTP id 98e67ed59e1d1-2f4435ad5e6mr45177896a91.5.1735360176557;
        Fri, 27 Dec 2024 20:29:36 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f7356sm143127715ad.193.2024.12.27.20.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 20:29:36 -0800 (PST)
Date: Sat, 28 Dec 2024 12:29:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 1/2] common/rc: support f2fs in _mkfs_dev()
Message-ID: <20241228042932.jvevyhdxmp6sasjx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241226133631.9486-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226133631.9486-1-chao@kernel.org>

On Thu, Dec 26, 2024 at 09:36:30PM +0800, Chao Yu wrote:
> Then, f2fs/* testcases can use this wrapped common helper instead of
> raw codes.
> 
> Suggested-by: Zorro Lang <zlang@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v4:
> - no updates
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 7b5bc0b4..ecac2de8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -833,6 +833,9 @@ _try_mkfs_dev()
>      ext2|ext3|ext4)
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $*
>  	;;
> +    f2fs)
> +	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $*
> +	;;

Oh, that's fine to me if you don't want to use mkfs.f2fs directly.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>      xfs)
>  	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $*
>  	;;
> -- 
> 2.40.1
> 

