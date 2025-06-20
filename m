Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582629C355
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441132; cv=none; b=JB+8wu3sntkarJ9Ub3ZfUi+31SajotG8BqnpzPb5R46hmlkFyytacJBpGkfE73u69aWh0DxNTmzxAZ5w2siziJU9N0uexGyHcxOMedtQogDdNd1AMJFYBXHIspUxZ3R0KVywTcgTLoDpm0g0v4yHIEP5qCawz2un9kbL+y9x7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441132; c=relaxed/simple;
	bh=lqEhx3Tq9ef6EiQT7yhsgJN26gh6j2b8+Vw+neK46lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dky8wmdEKMCG28F3w9djM+MqgM1MAbK4V4hNz44RPilgE+zUiYGB4arnmVvlC1jsfAD7riPMYYoXr0SesKGMP29OXCzL+h3tk9uZlQEuM9PTeLzHp/n+ZbjZAnd6D9f0vuSiBG+aAkaTPfy8gDrAepRpf/Gb+PaJUee0XbYT08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2cH1JzZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2cH1JzZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750441129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JD47MP/D35rJlJK+W0fohHkbJdlRqA+G8YCEoRCkt9E=;
	b=H2cH1JzZD5o1FvEvLe80mdStud80P0o/v0MlmTO8tZlmIX6c5HVCy4b3yGd58nQElDK/qF
	Pv2EoOHth+vhE+7y9/BXecLum7AEd5TPgsFiT1Iu/fowCVgsg1iXLT/yQAkiRfBhZvCida
	QC4/A4ZgjNBYIDo29QFeqSUAs5uvB/I=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-dPcjH3OVPjC_IctvOVYbdw-1; Fri, 20 Jun 2025 13:38:46 -0400
X-MC-Unique: dPcjH3OVPjC_IctvOVYbdw-1
X-Mimecast-MFC-AGG-ID: dPcjH3OVPjC_IctvOVYbdw_1750441125
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7398d70abbfso2859506b3a.2
        for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 10:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441125; x=1751045925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JD47MP/D35rJlJK+W0fohHkbJdlRqA+G8YCEoRCkt9E=;
        b=hdLQd2+tCEEMDX2Dib9XL9LCPlwqwz7h0Zfxw8bRuP1e3GrSEDs/Gq5JpQVXJ7zn3v
         m6skn1RZNvwaPWyTBzkyvHgdl94nbujVAN2Aq9AU8F3uQ/4u/5eIEEB4A3rN6UQL2lyo
         uUJ9xIimpZtJpGAm0+nGdZfOrM5Lj/ezL4Iir0n84HbzPxp/kD6Hqe/Zr0MGUC1UBm3t
         Gxob7uNQxm7ssP8x8oLANiDif9tqRshSfQfFW+eBgHcYacZghtwLLbycq9a1Yp0FrMDA
         7blrqAvOMDvEah21U0cMG4aeezXcG5hwo9DVo4XoVGO+Xu4N4Atu2SQfETZB4xed/ZuN
         64ww==
X-Gm-Message-State: AOJu0YyG2bIQB+a4dqGTsSTxIZgQoBbfwD888QI+jjal5BPpIqOKqoAQ
	wXmi3RlflE84L8zjKeN/EKnDt2i4LJ+/R4mttAXzCu8ihH4+N9ieHrq8QMd+JyDBQCfEoFgCj6v
	80uLdeHObF5ubQ9rE8VQN4kWKuoxwti4+r59abZ0Mw0/erxIQLEDvbbE7i2c=
X-Gm-Gg: ASbGncvOH9ew+/TGoegZFaKacdliXOP/oeNhryir5LEK/G0uyfzMi/6ZFYkoK3bitR2
	wYOROlREAuyVm4VrpQ6RbeWLsH3zrFrUvgTtse3bR+1/MUBtR1kPh3wfw/Mdn7Mex5sFejn7gNt
	ZpT/J0e4fiNJzkelnBnJH4lxHZpEh8x/MJgiHJ/fdwQb/pfd3vKlWMzrlYZBvDiizBuhY51eExI
	+B5+XGC2KRyj/5tJi1Y87nga1g8G04WYzUEmaz2g5+6/U2UadSpeATXn4bswv21QPHzVildxTnR
	7+1ZgdjWlNqa+eSylwfucqUdbdtT6Qexsfxl9Aqlpw3q9CjOxrsOVdX3/x1DSKs=
X-Received: by 2002:a05:6a20:3d85:b0:215:e60b:3bd3 with SMTP id adf61e73a8af0-22026efe3f9mr7315808637.29.1750441125094;
        Fri, 20 Jun 2025 10:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwH5975YRUAMegPcfvcHN9wY4KebcZODQS2JViA9DaMRD9UKcgm5r8yqrteNswGViEEnJNQA==
X-Received: by 2002:a05:6a20:3d85:b0:215:e60b:3bd3 with SMTP id adf61e73a8af0-22026efe3f9mr7315774637.29.1750441124730;
        Fri, 20 Jun 2025 10:38:44 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f12587fbsm2111744a12.62.2025.06.20.10.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:38:44 -0700 (PDT)
Date: Sat, 21 Jun 2025 01:38:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, l@damenly.org, gfs2@lists.linux.dev
Subject: Re: [PATCH] common/quota: adjust _qmount_option for gfs2
Message-ID: <20250620173839.q735lweoglone5cp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603041009.59811-1-glass.su@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603041009.59811-1-glass.su@suse.com>

On Tue, Jun 03, 2025 at 12:10:09PM +0800, Su Yue wrote:
> gfs2 supports mount options 'quota=[off/account/quiet/on]' but
> 'usrquota' and 'grpquota' are unsupported.
> So in _qmount_option, transform $OPTS to 'quota=on' first.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
>  common/quota | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/common/quota b/common/quota
> index a51386b1dd24..4b8052e07dde 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -283,6 +283,12 @@ _qmount_option()
>  {
>  	OPTS=$1
>  
> +	if [[ "$FSTYP" == gfs2 ]]; then
> +		OPTS=`echo $OPTS \
> +		| sed   -e 's/usrquota/quota=on/g' \
> +			-e 's/grpquota/quota=on/g'`
> +	fi

There's not response from gfs list. I'm not familiar with gfs2, so I have to
ask some questions about your patch...

From the manual of gfs2:
  quota=[off/account/on]
  Turns quotas on or off for a filesystem. Setting the quotas to be in the "account" state causes the per UID/GID usage statistics to be correctly maintained by the filesystem, limit and warn values are ignored. The default value is "off".

Looks like there's only one mount option "quota=..." for gfs2. And I didn't
find a description about project quota, so
1. What will gfs2 do if there's a "prjquota" or "pquota"?
2. Do you need to replace "noquota" with "quota=off"?
3. And "quota" to "quota=on" ?
4. Have you tried your patch on gfs2, can all quota related generic cases pass/notrun
   on gfs2?

BTW, in this function you can see:
        # ext4 doesn't _do_ "-o pquota/prjquota" because reasons
        # Switch it to "quota" to enable mkfs-time pquota
        if [[ "$FSTYP" == ext[234] ]]; then
                OPTS=`echo $OPTS \
                | sed   -e 's/\bpquota/quota/g' \
                        -e 's/prjquota/quota/g'`
        # ocfs2 doesn't support "-o projquota"
        elif [[ "$FSTYP" == ocfs2 ]]; then
                OPTS=`echo $OPTS | sed -e 's/prjquota//g'`
        fi

please move your gfs2 specific codes here ^^, and give it enough comments.

> +
>  	# Replace any user defined quota options
>  	# with the quota option that we want.
>  	# Simplest to do this rather than delete existing ones first because
> @@ -300,6 +306,7 @@ _qmount_option()
>  		-e 's/\bpquota/QUOTA/g'    \
>  		-e 's/prjquota/QUOTA/g'    \
>  		-e 's/noquota/QUOTA/g'     \
> +		-e 's/quota=[^, ]*/QUOTA/g' \

I think you might need a word boundary, e.g. "\bquota=..."

Thanks,
Zorro

>  		-e 's/quota/QUOTA/g'       \
>  		-e 's/uqnoenforce/QUOTA/g' \
>  		-e 's/gqnoenforce/QUOTA/g' \
> -- 
> 2.48.1
> 
> 

