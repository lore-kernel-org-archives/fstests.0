Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A812E610E
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442014; cv=none; b=dFMYVHAFZjlcGnqXEDn2mAMCRYH5HCvDw+/j5M99oBuaGDFVA8jGocTxERi3F/sXYSdT3w3cm+sBWQnhG992xYNAq10oBGGI0l34svY8S83rfdh84scJ++o4pHqoskzc/agYqYNyhFz/ekApHR2WSX0X0XEEu0zKyDfOcXMdxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442014; c=relaxed/simple;
	bh=P4GssuY/lJRwBeU/r8xgj2f0Jz2JM6g82ZiHyvgA6mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE5guxvbd9MVUZm4Fk2R0J+TGmK4j3xTjspf74k9ayjUcdyH0bo//5D9NhzCzMFNGELTo4lYezylHy0DUqdTmR6pUpAT3f0UqlbVb/tAe3kCslGzjNw1dDb/dxIWxLh/Pmj3vETePv/sQ/TLo1Y4eP2BDu1npwlK3WRbREPGR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUykt67A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUykt67A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750442011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MmVr62zHeiFyZ5PIOfEG/VEY8NtaiLO4PmPOTd/TeYQ=;
	b=TUykt67AnT/LrGoq9L5w0fFbpwveYJiRjDJ43JCCxvsHfuQoeVoz18kbfK00KJVWmOCXMX
	fwfUPeyaIVgHjwAo7utacHePLXJzgiLhNUPfgK5RmbZmKseRb6wGH+Y9DF23f2ZGBzVn+l
	aHejxWHG6wVvSBXG1rl2HzoBFj8oDRo=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-VQcJBdWuOdCQXbjo13ZFpg-1; Fri, 20 Jun 2025 13:53:29 -0400
X-MC-Unique: VQcJBdWuOdCQXbjo13ZFpg-1
X-Mimecast-MFC-AGG-ID: VQcJBdWuOdCQXbjo13ZFpg_1750442009
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b2eea1c2e97so1655369a12.2
        for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 10:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750442009; x=1751046809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmVr62zHeiFyZ5PIOfEG/VEY8NtaiLO4PmPOTd/TeYQ=;
        b=r0mp/Tnv5X9DxG5k7hcaC72kveOEaLc+0+pG0cCMko8DNyewQ4CZCieqIzxn9iTi/j
         v5V6TjGLkUDO14j40X7OlAxYtvjqDhztPz3FW5Aa0T9g7V0b+nwoVLJp6naWurUDzyrA
         wpN3OTN2fKHv+h8ce/jRT3w7o0HnVa27r7uGnCUrUhnoInNri+7ZKUhHN4fzbMzbEJNZ
         GrSb8Hux1VRQLeW2twefcjj5rswB+GY27AO1D1+pZVkLYRjh+tcCEfSVhd/TV69m4LmH
         LwGRhw/Njil4ChszGo9y0PhHjqfCOCr6oVvgHPvVWepmca4eN1CI1QZCxKAZigf4o8vG
         6FvA==
X-Gm-Message-State: AOJu0YwlOakbhjf9tqWZ0tHSLabyaonqMbLAXzmtFU9S0FqDFiz9+1X/
	vOrL8ZH7UOZ/RxwGqIe++exgQfZHvuyKUg0IIac9GbKPy3ys2j0xufrWSH51d2acRF9bQjaGUXl
	xloutQ5QR2pmfh6jLa68Cixn0NA95op4jCjA0KjHuRMHmlcGQ5+qQDnuuUuY=
X-Gm-Gg: ASbGncsu42Y2n7MfvdbJYcYyjjJ4DmIequUOvvRIhVgig0DDEqMHDcTQktunF8Rm5W4
	kk6VicB5nIm7qytVWejEWjA8zTBeXv3WuSaZdfIL9ZXkpSiN3JH7beuc9yguWoOjeIngYr6OBsf
	NzTNWIHu75D0oAT64O/aUiratetDBno/jdGcNu3yPXqZQ2ggWECEHDF3sXQuhvNnpgWcrfpk6hy
	yCwShWQNx0Pu3GCJ0QKIG9/HBpUhSM4ArGVfHrIZ2zcopaCYq3lKZiaRW9OYb4XiUrLmNe+ecMa
	yXgR+7JHihfP+sC/lfdhB2EvHcT1eZdWTkXGFBg6rl3QCn5KAT044MbbJm+GIpE=
X-Received: by 2002:a05:6a21:6d98:b0:216:5fa9:55ad with SMTP id adf61e73a8af0-22026e9d0f1mr5517348637.39.1750442008688;
        Fri, 20 Jun 2025 10:53:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEStXPkBhSplwryrT8owmYybNJQqkhlLLia/kHBX2zM7mompliT7DCOU8lHLZHnqtfAevqMsw==
X-Received: by 2002:a05:6a21:6d98:b0:216:5fa9:55ad with SMTP id adf61e73a8af0-22026e9d0f1mr5517328637.39.1750442008367;
        Fri, 20 Jun 2025 10:53:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a621cafsm2600290b3a.101.2025.06.20.10.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:53:27 -0700 (PDT)
Date: Sat, 21 Jun 2025 01:53:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Leah Rumancik <leah.rumancik@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] common/rc: add repair fsck flag -f for ext4
Message-ID: <20250620175324.tyx4s4dxdslv7hqx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250530192712.2643365-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530192712.2643365-1-leah.rumancik@gmail.com>

On Fri, May 30, 2025 at 12:27:11PM -0700, Leah Rumancik wrote:
> There is a descrepancy between the fsck flags for ext4 during
> filesystem repair and filesystem checking which causes occasional test
> failures. In particular, _check_generic_filesystems uses -f for force
> checking, but _repair_scratch_fs does not. In some tests, such as
> generic/441, we sometimes exit fsck repair early with the filesystem
> being deemed "clean" but then _check_generic_filesystems finds issues
> during the forced full check. Bringing these flags in sync fixes the
> flakes.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---

CC ext4 list to get more review points.

>  common/rc | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index daf62c92..042f6c36 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1496,19 +1496,24 @@ _repair_scratch_fs()
>  	_check_scratch_fs
>  	;;
>      *)
>  	local dev=$SCRATCH_DEV
>  	local fstyp=$FSTYP
> +	local fsopts=
>  	if [ $FSTYP = "overlay" -a -n "$OVL_BASE_SCRATCH_DEV" ]; then
>  		_repair_overlay_scratch_fs
>  		# Fall through to repair base fs
>  		dev=$OVL_BASE_SCRATCH_DEV
>  		fstyp=$OVL_BASE_FSTYP
>  		_unmount $OVL_BASE_SCRATCH_MNT
>  	fi
> +	if [ $FSTYP = "ext4" ]; then

What if ext2 and ext3?

> +		fsopts="-f"
> +	fi
> +
>  	# Let's hope fsck -y suffices...
> -	fsck -t $fstyp -y $dev 2>&1
> +	fsck -t $fstyp -y ${fsopts} $dev 2>&1
>  	local res=$?
>  	case $res in
>  	$FSCK_OK|$FSCK_NONDESTRUCT|$FSCK_REBOOT)
>  		res=0
>  		;;
> @@ -1548,12 +1553,16 @@ _repair_test_fs()
>  	yes | $BTRFS_UTIL_PROG check --repair --force "$TEST_DEV" >> \
>  								$tmp.repair 2>&1
>  		res=$?
>  		;;
>  	*)
> +		local fsopts=
> +		if [ $FSTYP = "ext4" ]; then
> +			fsopts="-f"
> +		fi
>  		# Let's hope fsck -y suffices...
> -		fsck -t $FSTYP -y $TEST_DEV >$tmp.repair 2>&1
> +		fsck -t $FSTYP -y ${fsopts} $TEST_DEV >$tmp.repair 2>&1
>  		res=$?
>  		if test "$res" -lt 4 ; then
>  			res=0
>  		fi
>  		;;
> -- 
> 2.49.0.1204.g71687c7c1d-goog
> 
> 

