Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA5284689
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760718129; cv=none; b=SM8OulnqUr2kmhScVjBf2wItKYnYXNlLhy+62yN2s+q8bZ3WBNKGzl1q6KYKElq4EYY/4t948SBq2ZsNaSc13Ycr4bNwc0dZMg9iwFa0+M/09GeccPy5InHi/FYx7cdZiFIF+D/6erfEntQgCR8H4s8zVHyfgrglDeJIEpd2WQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760718129; c=relaxed/simple;
	bh=77VNMQIij6En9pojgWuquSiCSwDDmBoJYUEceB5OrXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp5XagxknupRJsHeZIkfpu5j6IPayfeOL2geQTxaxbafAUg/i52vklRtgrQ+NKW5YwuMiKOg2k4yGGAReIHhuTb23apsDGbVwxt8kDdRZiJAecKxXXFTjYCOfb9Bpin7FjaHSpEcT4pSRS0C45w7pMl/4nx+xn4JMLuS/fYPWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZppL3P30; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZppL3P30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760718125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7YTcK3VR0j6mGW9Mh46yN8tByhSaOAS1LNU95/rjcUo=;
	b=ZppL3P30Q6lMh2hTK8gXjGwKTO6Cg3CU68mDdX0+qPc3FZosE3BUCCXp4J/9nRG6hd6rs6
	iog2Ay/uU73Pfd/+8XY4rDPms8pVN8ry5Z2E2rnQegaFoJJR7HVuaVWVLy1zDFQdqz04FO
	Vf2rnYJ8mF+HbHJbsgO8EmvhwIE8Tp8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-t4jHrle2PTWu3ovidZtBkA-1; Fri, 17 Oct 2025 12:22:03 -0400
X-MC-Unique: t4jHrle2PTWu3ovidZtBkA-1
X-Mimecast-MFC-AGG-ID: t4jHrle2PTWu3ovidZtBkA_1760718122
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b6325a95e44so2078453a12.0
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 09:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760718122; x=1761322922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YTcK3VR0j6mGW9Mh46yN8tByhSaOAS1LNU95/rjcUo=;
        b=Bi9v0ylDncfTLjNxeqGCy5LygoTzKxKEFZFtK+HUG9wz8/f+3/r6C0Gts76xyWFSD8
         3wxF5I5i7g3Ef7WfK3J0PnVHngf51R8Ksgqr7bPKL3pr6rXD+Hmswgm9WaddbDK6UwIo
         8jYCllQAxid7KvnZvd9eVMSPoba163o0IJupcvWo3W3AT1xdyMoZc1u4G+uDU5SEM6dS
         cwyTQpFr/JmiKrRJNq+8wjHSMZLoYLa62kzVf6478pN8//VBzWQxFRYzFdqtN6Ijzu3R
         8l2NirypjoZZmb/NycekhVWTKHqhftmvb+4pLc6Zz7YkkvlGHqXkREjMzcY0+GKxcHV5
         F3LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrSFLY5z3WewON/ouR9P0GYGxTqAK3fvctoYBudujTJ3+cD9v6j21Dl8dzIEQXM6lDuPyrC/+Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxat+jwL2Hc+xiTcSIYBzOElkkQVTvAhbKkp1B4MxHy71kcmwyU
	cZ/0PhRLiFk8E4Ivpsr/HUsRiy5vlZaNVzspHTFPEoZBl8ee9rJHsrdBEcfXULFecYkjJ5SElk4
	5toELnFZb79uelJZD0F8n5kabQWeX54jBNa0HjzhtXyEp39IKesra00iU0SQ=
X-Gm-Gg: ASbGnctfFwvO2/cSISyBm2NKUZsYZwLIQwfiXlVOprnLXQO/PdYUpW8j+mTv4+BDIS+
	m9dnDMLeOFZYiCtNSVW5XejLco6+ts3eu4nAfqGe5+4P9G1W62CmAnjCMDQVAmGx2IuEKEcgUtf
	YHUjhX1yWAuEjay+UdvDCVAeCq/b96r7G+AhJS1+WYfBDQmekc2VO956m1xGBL8jGKAKvJtQ9z/
	ZVe7Go/RLUo8uHQnSNlcweCqCCAZRJg7pCZR3AXT1i8hZAH6H44CWorg7k06CJmZlwgGkpXRg9h
	hrfDCZAsM70GrzecW5zu8KtsvgE1dxSQXs3jZe9x9OZSQ9srIjs+F86LLkgZ1ZoH09Htt2MKWfM
	8yb9WNS4GlcE1LwO2h+aAAJS8ypsRl1tKaCK6sv4=
X-Received: by 2002:a05:6a20:4323:b0:263:57a:bb46 with SMTP id adf61e73a8af0-334a78940c0mr6204486637.13.1760718122391;
        Fri, 17 Oct 2025 09:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECpvd72xcq56k2PNT+BlO1IjTFbRSih8k3yBJEhp4jcO5r40I0PnCo9OnJxSzIZVhITaAaJw==
X-Received: by 2002:a05:6a20:4323:b0:263:57a:bb46 with SMTP id adf61e73a8af0-334a78940c0mr6204443637.13.1760718121805;
        Fri, 17 Oct 2025 09:22:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0604cfsm26579868b3a.9.2025.10.17.09.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:22:01 -0700 (PDT)
Date: Sat, 18 Oct 2025 00:21:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/3] common/rc: move _check_f2fs_filesystem() to
 common/f2fs
Message-ID: <20251017162156.rsytol3rx4gx4czl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251009085043.16910-1-chao@kernel.org>
 <20251009085043.16910-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009085043.16910-2-chao@kernel.org>

On Thu, Oct 09, 2025 at 04:50:42PM +0800, Chao Yu wrote:
> _check_f2fs_filesystem() is f2fs specific, it's better to move it to
> common/f2fs.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Looks good to me. With the patch 1/3, this change should work for f2fs too.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/f2fs | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  common/rc   | 44 --------------------------------------------
>  2 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/common/f2fs b/common/f2fs
> index 1b39d8ce..4d0d688b 100644
> --- a/common/f2fs
> +++ b/common/f2fs
> @@ -25,3 +25,47 @@ _require_scratch_f2fs_compression()
>  		_scratch_unmount
>  	fi
>  }
> +
> +_check_f2fs_filesystem()
> +{
> +    local device=$1
> +
> +    # If type is set, we're mounted
> +    local type=`_fs_type $device`
> +    local ok=1
> +
> +    if [ "$type" = "f2fs" ]
> +    then
> +        # mounted ...
> +        local mountpoint=`_umount_or_remount_ro $device`
> +    fi
> +
> +    $F2FS_FSCK_PROG --dry-run $device >$tmp.fsck.f2fs 2>&1
> +    if [ $? -ne 0 ];then
> +        _log_err "_check_f2fs_filesystem: filesystem on $device is inconsistent"
> +        echo "*** fsck.f2fs output ***" >>$seqres.full
> +        cat $tmp.fsck.f2fs              >>$seqres.full
> +        echo "*** end fsck.f2fs output" >>$seqres.full
> +
> +    ok=0
> +    fi
> +    rm -f $tmp.fsck.f2fs
> +
> +    if [ $ok -eq 0 ]
> +    then
> +        echo "*** mount output ***"		>>$seqres.full
> +        _mount					>>$seqres.full
> +        echo "*** end mount output"		>>$seqres.full
> +    elif [ "$type" = "f2fs" ]
> +    then
> +	# was mounted ...
> +	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
> +	ok=$?
> +    fi
> +
> +    if [ $ok -eq 0 ]; then
> +	return 1
> +    fi
> +
> +    return 0
> +}
> diff --git a/common/rc b/common/rc
> index 1ec84263..4d121a1b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3566,50 +3566,6 @@ _check_generic_filesystem()
>      return 0
>  }
>  
> -_check_f2fs_filesystem()
> -{
> -    local device=$1
> -
> -    # If type is set, we're mounted
> -    local type=`_fs_type $device`
> -    local ok=1
> -
> -    if [ "$type" = "f2fs" ]
> -    then
> -        # mounted ...
> -        local mountpoint=`_umount_or_remount_ro $device`
> -    fi
> -
> -    $F2FS_FSCK_PROG --dry-run $device >$tmp.fsck.f2fs 2>&1
> -    if [ $? -ne 0 ];then
> -        _log_err "_check_f2fs_filesystem: filesystem on $device is inconsistent"
> -        echo "*** fsck.f2fs output ***" >>$seqres.full
> -        cat $tmp.fsck.f2fs              >>$seqres.full
> -        echo "*** end fsck.f2fs output" >>$seqres.full
> -
> -    ok=0
> -    fi
> -    rm -f $tmp.fsck.f2fs
> -
> -    if [ $ok -eq 0 ]
> -    then
> -        echo "*** mount output ***"		>>$seqres.full
> -        _mount					>>$seqres.full
> -        echo "*** end mount output"		>>$seqres.full
> -    elif [ "$type" = "f2fs" ]
> -    then
> -	# was mounted ...
> -	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
> -	ok=$?
> -    fi
> -
> -    if [ $ok -eq 0 ]; then
> -	return 1
> -    fi
> -
> -    return 0
> -}
> -
>  # Filter the knowen errors the UDF Verifier reports.
>  _udf_test_known_error_filter()
>  {
> -- 
> 2.40.1
> 

