Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E12101B3
	for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743428919; cv=none; b=finor7cCWMp/cI1ydTGANOhVe4Hzv2yzozCkHkXWfMRk0EGlgayReY4BkZOGr20lGlYKi3ekYVAG2y0oHl5c3iK3cMKVTLdXesOJ9jZbBn8QS6ClGRuvAGCr7Ieqw8yxg8/Ih7lofLh2M90UYo6NZWfGxlt77bDK0vzriyP+Qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743428919; c=relaxed/simple;
	bh=hfHXqtCM9g3kme35ZkfKhWwanTOeUWoZHrNcFTF+P50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpQCxBXqp13/UGj1uU5njsxKFF5uQbEmEuvSGlRFn6cWph8/3p/p4fPhNgziswcEG2LXF0QCJVvH/mXcw93mNTJGKWO1o/2DRNvFgckbkL+c2cUmJXuJhE+tPaU7m7sUrdDRydnT5A+oVptRERPKCPz50ujxoGIi9zsuymykiXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6rixDrM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6rixDrM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743428916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V6YWlaHb/+sQxHYU09XE2mXXZQH2Pq2JQG12aswrcG4=;
	b=i6rixDrMYr4vTc38IznC7dbHf7un6hm2XYe0sq5IKbVTbyJ5yoDSt781LsH+3AizYyczgh
	2/fQI5jyY3aRJExdCqGpotjFWSdXPifGSMV5/hB2S1lki84OU/K3ncPNRMFuMm7wWM6GzY
	o3ZWvEkC2ehgLXjVkCLcDnmsz6VFRpY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-CBMlQS-8NvO8yI40mkZrzw-1; Mon, 31 Mar 2025 09:48:33 -0400
X-MC-Unique: CBMlQS-8NvO8yI40mkZrzw-1
X-Mimecast-MFC-AGG-ID: CBMlQS-8NvO8yI40mkZrzw_1743428913
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so4811015a91.3
        for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 06:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743428913; x=1744033713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6YWlaHb/+sQxHYU09XE2mXXZQH2Pq2JQG12aswrcG4=;
        b=j5pk+HY2udLTWiylScgLuXL26pw2fooVpoELjX1UmAMhQxuIaQLAOBwyqrqm6CqsBW
         errsGHNYbp7XhyLpwo5Kx0nz2TCbOGYWJSfQslxjozv+AiWjqT5A41Nd9SY5clq3Ij+B
         ZOIWZcj999G73YBET5wYXFvp+24/ZxlnQbvleFKXUPwlb3nGMXndXB/Po9xzz0tpjkgX
         xy3eir8RflYwbxmjb/DVLR1Gk3oXTX6EUDuCievVrhoQ0C3sW/8+SyP2mfnYoUXYTGD1
         BtrjS6m1W9p8dLlWx4S5GUsbWIB3WWKpEF9W6C4NErSasFtJ+Cd9fv7LEEixJwt3WLTM
         aX5w==
X-Gm-Message-State: AOJu0Ywl8DWFC6SgcbIZeCZj9pwF4njtiYBj14JE3rutxrWMaTSWxSX7
	jsWW+2Wkb+gWg6fqr1rc3pKaKtyIdpCZkc97gXBK6/D23ZMfo81UcUwlgqqFc+aTa8wJsSFQz+O
	YlupTCLU47qL0hkwFJrzYaoNEGpacpDULyXTcYN7P3hzPaXoCRvZfNgk=
X-Gm-Gg: ASbGncu3rUbbjow8OvIvIFXa4pKIRy0979nDLHeU48/Jj1/kG2RZH7WmtdkkW1GMVbU
	Ak6xq/5BJd2ZBhuV2VpjHKP2aAN8LPd1HVmcj/zEUa0bMsqqsnUnk14JOSQvhXSwVH88senEaS0
	E/wiMSKvOWDsXpVSPQ/VqnqN1aP+qJwNleW4kHY6o9oW9XPi8n5b24xZyT3sdJFXgoHycXWvzew
	p20NMi60RjlxYX1z5WXSqSv+k84CSn5YtnPak+gPrWQELioXLPNM6mLBkC8I3tRgdn0F7/TYNXX
	fJSlHL8ViHdBjqPHQxtaSU7NtxZX5vj/KaXmUsfzQaMYocYaw6PrBPhJ
X-Received: by 2002:a17:90b:2e4e:b0:2ff:618c:a1e9 with SMTP id 98e67ed59e1d1-30532153717mr11908699a91.23.1743428912862;
        Mon, 31 Mar 2025 06:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQKSNhk8NiYd8Hn1ZwyKJ6CjBpwAC/RgBvb3iPW3KMEFIllNvo17+flUhvAe5tyvFxT0OTlQ==
X-Received: by 2002:a17:90b:2e4e:b0:2ff:618c:a1e9 with SMTP id 98e67ed59e1d1-30532153717mr11908676a91.23.1743428912537;
        Mon, 31 Mar 2025 06:48:32 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b6cfbsm9518248a91.47.2025.03.31.06.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:48:31 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:48:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH v4 1/5] fstests: common/rc: set_fs_sysfs_attr: redirect
 errors to stdout
Message-ID: <20250331134828.atadwmenvglahjrk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
 <cb5e54259bcd2bd6cd310ffa2411a79370698f61.1740721626.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5e54259bcd2bd6cd310ffa2411a79370698f61.1740721626.git.anand.jain@oracle.com>

On Fri, Feb 28, 2025 at 01:55:19PM +0800, Anand Jain wrote:
> Redirect sysfs write errors to stdout as a preparatory patch to enable
> testing of expected sysfs write failures. Also, log the executed
> sysfs write command and its failure if any to seqres.full for better
> debugging and traceability.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index c7d7dbb8e93b..59af83a01e3a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5181,7 +5181,8 @@ _set_fs_sysfs_attr()
>  
>  	local dname=$(_fs_sysfs_dname $dev)
>  
> -	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
> +	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
> +	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full

Actually I doubt the $seqres might be not defined before calling _set_fs_sysfs_attr.
For example, we call _set_fs_sysfs_attr in ./check as

 _test_mount -> _prepare_for_eio_shutdown -> _xfs_prepare_for_eio_shutdown -> _set_fs_sysfs_attr

The _test_mount is called before $seqres is defined. At that time, the $seqres.full
will be ".full" if the FSTYP=xfs

Anyway, we can fix this problem in another patch, this
patch is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  }
>  
>  # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
> -- 
> 2.47.0
> 
> 

