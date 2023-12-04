Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVJkRQ26"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC1CA0
	for <fstests@vger.kernel.org>; Mon,  4 Dec 2023 06:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701699647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QSRfffTh70uOtHz89+FqUKxyLtH8J0xi8EdpaDIFibw=;
	b=NVJkRQ26iODm3rdnl5GMk4drWPqrYashK2VNFnzLpWdgMnVGig8tkGM8PewiMy9VFxvk9F
	pqv7Wgg2rrkLHvMh6MyB+WLNH5J/yXYVvUPilq03XzrtokAkXU9X1LJR96gWhcWDIxQ1c5
	a+43DnJ4YXwcS/RjQHwWqRciGNoPxsw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-PE5ren_QNDKvRfm3buq36g-1; Mon, 04 Dec 2023 09:20:45 -0500
X-MC-Unique: PE5ren_QNDKvRfm3buq36g-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d08383e566so18458185ad.2
        for <fstests@vger.kernel.org>; Mon, 04 Dec 2023 06:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699644; x=1702304444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSRfffTh70uOtHz89+FqUKxyLtH8J0xi8EdpaDIFibw=;
        b=KcOBhi34YT6IngSMMr9uUn7h9rcTrAuaBgsES77PckzXLl5CAPGicBS6JxxZUPWMax
         Ys0NzoN3MWVJPz7g+YJCFkcGTtaMP2DkCUT177cc2DG7AsZD4YlH2jp3rV98TB97W5YW
         U4opEoWmCUaLducFxOl0Nie0q79wk+FP8vAnHJDzSabWojI4L4HkX/U21wWYvdVEuQ20
         hrpfmLI+6k73FjbyWX50qMeAWxeTEi5knc9yHP4s2FZwqlpYzNW0/CB4F+GO1/ET8395
         Do2wG9B1Q07A0iwubnuyj+acR6+lU1Gf+TPfsn1lvzPDvOBGjzRO4xwL801axWCxYLI7
         sW5Q==
X-Gm-Message-State: AOJu0YwOi4clwjd+w/SQhTCBEAZsiafo0ZHztLQdq4WWdVrLK43fZQcp
	V/2z+gfBq8Dg+1YmJH1ylHqJoFJpT/EJCKfkz9W64qmHXKSaImp8Eb0Puqdz94OvDbrW8T+KLqZ
	4EG52qD2HezzPFkAt2OuCntW2az7tVXU=
X-Received: by 2002:a17:903:1205:b0:1cf:cf43:303a with SMTP id l5-20020a170903120500b001cfcf43303amr4289756plh.64.1701699644585;
        Mon, 04 Dec 2023 06:20:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfhX1xCnkf62UEh4BqMeXkise86j8tG19GFOTI1qMqfFI5wrRg4quaA+CBTuCkACi1sxox6w==
X-Received: by 2002:a17:903:1205:b0:1cf:cf43:303a with SMTP id l5-20020a170903120500b001cfcf43303amr4289744plh.64.1701699644243;
        Mon, 04 Dec 2023 06:20:44 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n13-20020a170902e54d00b001d09be1bcf9sm2294188plf.80.2023.12.04.06.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:20:43 -0800 (PST)
Date: Mon, 4 Dec 2023 22:20:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fsstress: unify verbose output format
Message-ID: <20231204142040.f2apcfbtl6ke4fx3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231123085843.1152470-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123085843.1152470-1-ruansy.fnst@fujitsu.com>

On Thu, Nov 23, 2023 at 04:58:43PM +0800, Shiyang Ruan wrote:
> Wrap offset, length within '[]' and remove meanless 't' in
> do_fallocate().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---

The fix for the meanless 't' is good to me. And I don't have objections
for other output format changes.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  ltp/fsstress.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index abe287425..9778fce82 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -3810,7 +3810,7 @@ do_fallocate(opnum_t opno, long r, int mode)
>  	mode |= FALLOC_FL_KEEP_SIZE & random();
>  	e = fallocate(fd, mode, (loff_t)off, (loff_t)len) < 0 ? errno : 0;
>  	if (v)
> -		printf("%d/%lld: fallocate(%s) %s %st %lld %lld %d\n",
> +		printf("%d/%lld: fallocate(%s) %s%s [%lld,%lld] %d\n",
>  		       procid, opno, translate_falloc_flags(mode),
>  		       f.path, st, (long long)off, (long long)len, e);
>  	free_pathname(&f);
> @@ -3932,7 +3932,7 @@ fiemap_f(opnum_t opno, long r)
>  
>  	e = ioctl(fd, FS_IOC_FIEMAP, (unsigned long)fiemap);
>  	if (v)
> -		printf("%d/%lld: ioctl(FIEMAP) %s%s %lld %lld (%s) %d\n",
> +		printf("%d/%lld: ioctl(FIEMAP) %s%s [%lld,%lld,%s] %d\n",
>  		       procid, opno, f.path, st, (long long)fiemap->fm_start,
>  		       (long long) fiemap->fm_length,
>  		       translate_fiemap_flags(fiemap->fm_flags), e);
> @@ -4866,7 +4866,7 @@ resvsp_f(opnum_t opno, long r)
>  	fl.l_len = (off64_t)(random() % (1024 * 1024));
>  	e = xfsctl(f.path, fd, XFS_IOC_RESVSP64, &fl) < 0 ? errno : 0;
>  	if (v)
> -		printf("%d/%lld: xfsctl(XFS_IOC_RESVSP64) %s%s %lld %lld %d\n",
> +		printf("%d/%lld: xfsctl(XFS_IOC_RESVSP64) %s%s [%lld,%lld] %d\n",
>  		       procid, opno, f.path, st,
>  			(long long)off, (long long)fl.l_len, e);
>  	free_pathname(&f);
> @@ -5334,7 +5334,7 @@ unresvsp_f(opnum_t opno, long r)
>  	fl.l_len = (off64_t)(random() % (1 << 20));
>  	e = xfsctl(f.path, fd, XFS_IOC_UNRESVSP64, &fl) < 0 ? errno : 0;
>  	if (v)
> -		printf("%d/%lld: xfsctl(XFS_IOC_UNRESVSP64) %s%s %lld %lld %d\n",
> +		printf("%d/%lld: xfsctl(XFS_IOC_UNRESVSP64) %s%s [%lld,%lld] %d\n",
>  		       procid, opno, f.path, st,
>  			(long long)off, (long long)fl.l_len, e);
>  	free_pathname(&f);
> -- 
> 2.42.1
> 
> 

