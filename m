Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAC54F8C
	for <fstests@vger.kernel.org>; Mon,  5 May 2025 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425693; cv=none; b=YWMVl6MsW5+2XH+i6WgYkwGoH2QMpGKn2Tpse5+hZX31glXdUa41giezsiw5GFj54vB1z/HfvgLhv4W7aza7bv0qWBsweZGTG70inwdcuRaYkbntTnU1XNfjTS8liQEA9XKb2jqx1nYSMicBpaX9/kDGKyOtmH4sGEjV0rk51zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425693; c=relaxed/simple;
	bh=iLDzLfBmGWMKA7w5suQGCgh3NzOwoseT8sErFXnxehg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=fXeT1+8jo9NSCReU5rrMC8LwACYXUkO8p1/2fGRFKLTz6GolOZz3dMu27ca1uoH4krXK9QDAqmcHSAabrrQJCPPnnYDA89rO8BTKzgtm3RpoHgx7ZAm+QUWtpb7xo14AddsZ+HpHF3NHz8UZdrzWu/fVXixDQHpPIymXLbKkFiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjpNqulc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjpNqulc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227914acd20so39500515ad.1
        for <fstests@vger.kernel.org>; Sun, 04 May 2025 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746425691; x=1747030491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aR8NnignHndeAf7NKRYYv7nYgxr+bbPWib+y0XLT/UA=;
        b=IjpNqulc47abwu69QgG0iH2mysxBDyM9Jd5U+DD8oYP3XfBHPIH/KShF1LBGQVZ/Eh
         Rv3ghQOVmp06WCaPkJBhoQOhPhuxlnPBE4jYxer63Y54+2mjg4doqvhVBbSwFAKcJGxb
         +Nw9U6uRpJAhBSgKOHQcMBxjYmn5VUMPADK29pAsvGQgw7jb3NiGz119wfZrjqC8qWXj
         QRY/JLOAFwZnvzIY07IqnlU6KQbv0mMAtKi2V/8VXbfTWZsdOdWwFla2jsIIkwRK3w43
         jyvI0hUNjCqQBWz46ZAJ+7D3N2zxW3/IsGClIcLFisnwQM/9+YdC50bdB7ZyaOH8HXam
         rOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746425691; x=1747030491;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aR8NnignHndeAf7NKRYYv7nYgxr+bbPWib+y0XLT/UA=;
        b=we300xV/7zmCikbGeeB8kCFLQpbKqX2tzJgIo5ECTK3+qfDL9z0R9uMAIqZj6Oo/G9
         FR8L6xV1gmFwhWGPITPYpHK73Xg452JBbCOUm3+dJLHTYAZkgATWEPt94zjwkyFtG2Ct
         +H1QbfIcrsVBzqkRF8xRybwr07ouXCU5K1lo3oxyZq7nNv9SlHucCUyLd4hiJba17/wz
         XOEQ2hmgMZCmXTIZPjUpWtT+ukHORyju4J8MwbTVwzuaaHcS353aCzZFsV5O068uSFJR
         RnjZHJuR+o3k7naWiWhJz4QvBLGstFPkLicbfIyMdECOVDuHB3uVQNxSuVLk2Ic8Kx9d
         UNdA==
X-Forwarded-Encrypted: i=1; AJvYcCUG5wAy5TZGq6hro8uwaKZIGIEU0LhXqQygt8itxn2G1QmR9rr8eCQSYn3D9MQjdMoU704nDZ0a@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi53jxe1OLAl6qc/6X0lK24wF6o+b8lsiWFicEE5ozH2zdoZlZ
	lEb3Yuz3i6R1PLRQkpZ6CCQGsIejPRwlE7h0NAYa68pngrE+P41Y
X-Gm-Gg: ASbGncuUusaeJjFRbDaAeBfX6lCPTGnGkGoc/vSPXoywfBw24w3mI1DSsMObDAypM3R
	aBnlKVGlZx6QpGtmFK3sQugdFZ1dANuT4/cOiORiANH5HPbVX9QZHMerfPmacGDtLnWO5NJA8/7
	ZsMzQ9eRcMGJm3Po34wccGuBrqzreo/Db5Cvhb9oVQ1bSkbkENNQR4j6aZ988jJU6Yezvhc09p1
	1IFHX/UCVGyYSkrLedAp8d3VdJYHlim0uzyD018FDT8O8nt5WcNAzHdi6K3Ki4ks0tk2xwQqAgl
	Qa2NDx3L+PJnuNReT4IXSL0Ku0ROVtvSEFDZJnanw4WOY8WPXlmoXqV6ayRHGta5tyngUX0pHmD
	ouZaNMG7HnI3bx80bfw==
X-Google-Smtp-Source: AGHT+IHFES8nx/50Z8AI5z+R/OZShubXELXu5TW36MNHjqOLQEmr2a3EoaeIp7X1TES10KnthtvpiQ==
X-Received: by 2002:a17:902:c401:b0:21f:98fc:8414 with SMTP id d9443c01a7336-22e0865ecc8mr200790655ad.26.1746425691218;
        Sun, 04 May 2025 23:14:51 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fca324a9bsm2147682a12.0.2025.05.04.23.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 23:14:50 -0700 (PDT)
Message-ID: <a910d25a3d456a48dcf3d3259a2f8012b11b0110.camel@gmail.com>
Subject: Re: [PATCH 02/28] _scratch_mkfs_sized: obey USE_EXTERNAL for XFS
 filesystems
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Mon, 05 May 2025 11:44:47 +0530
In-Reply-To: <20250417031208.1852171-3-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-3-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.como>
> 
> _scratch_mkfs_sized is failing on my check-parallel setup because it
> has an RTDEV defined but USE_EXTERNAL is not set.  Hence
> _scratch_mkfs_sized sees the RTDEV, adds a size parameter for it,
> then passes that to _try_scratch_mkfs_xfs() which looks at
> USE_EXTERNAL and so doesn't add a RTDEV to the filesystem.
Okay so the function flow is like:
_try_scratch_mkfs_xfs() --> _scratch_mkfs_xfs_opts --
>  _scratch_xfs_options() --> _scratch_options mkfs -->
_scratch_xfs_options()
In _scratch_xfs_options() we have

   [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ] && \
	SCRATCH_OPTIONS="$SCRATCH_OPTIONS
${rt_opt}rtdev=$SCRATCH_RTDEV"

_scratch_mkfs_xfs_opts() adds $mkfs_opts which already holds "rt_ops="-
r size=$fssize" but _scratch_xfs_options() doesn't add "-r rtdev=<realt
ime_device>" because USE_EXTERNAL is not set and hence the error. This
makes sense. We should fill up rt_ops only when USE_EXTERNAL is set.This looks good to me. 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> 
> The result is that _scratch_mkfs_sized -always- fails with this sort
> of error:
> 
> .....
> ** mkfs failed with extra mkfs options added to "-m rmapbt=1 -i exchange=1 " by test 300 **
> ** attempting to mkfs using only test 300 options: -d size=536870912 -r size=536870912 -b size=4096 **
> size specified for non-existent rt subvolume
> Usage: mkfs.xfs
> .....
> 
> Make the XFS code in _scratch_mkfs_sized look at USE_EXTERNAL like
> the ext4 code does.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 9bed6dad9..12a05cb96 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1264,7 +1264,7 @@ _try_scratch_mkfs_sized()
>  	xfs)
>  		local rt_ops
>  
> -		if [ -b "$SCRATCH_RTDEV" ]; then
> +		if [ "$USE_EXTERNAL" = yes -a -b "$SCRATCH_RTDEV" ]; then
>  			local rtdevsize=`blockdev --getsize64 $SCRATCH_RTDEV`
>  			if [ "$fssize" -gt "$rtdevsize" ]; then
>  				_notrun "Scratch rt device too small"

