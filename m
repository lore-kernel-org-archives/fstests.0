Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927B1FBC8D
	for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395419; cv=none; b=NKUo3UX0mOhAhJpUwMDNq3t8/UhihslcP8su6kCmhXlr5HY8WRx/xWxnpWE+EAj0pzKDVwbqk70XP/BnuWCGpKR7eIaqAI8imyKYg9Ar3qLqikspE+HbM+12e2PJq9AP8jMuvAH/4L9avvcDK6teV59ML9jJNkKrcaY7BOo5DW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395419; c=relaxed/simple;
	bh=Hy2r0elVz1dNaH6kTrp/cVsXskL5R2B2kHanuTCM4kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJfE5SC+GBpYa59g9YxtggpxZt50u9heKrx7tD8nFqQWKJah3uDX05b9zlqhKhnX0jESYEW5SbstSbeLodg+qOmYzfvC5O4/06icn53CJnjvKEs7eS46FsDZUwqzXJOhkFdDD4FqxEXoqhhD4T5G7pJAA3A2JdV8vjPQCairktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=T5vgbcPP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="T5vgbcPP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f4af4f9ddso1898215ad.1
        for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 13:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739395417; x=1740000217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DnWJ9ncHwe6ht8H8YTq86uwEtd3hGCr8wLzk0vFKje4=;
        b=T5vgbcPPmcNEygj7xxbAWZJ+tYuxFaYlP68nzftNISpR4yunrRg88SQq+m1iSy/nC0
         5DiLtsVehx7wf7e7NSdzUjVBRKq9vABcaib41ctk9SNs+fN6fIOGeGLs5GxqSmoqEFnb
         uEy71h1vGgOFlJoo3dh/ZVi6Tr7EgUEt+Hp/ga+494935OWDnxbRzm/g+reeSIZVQBox
         df2mmJrs9KX9Pb6im7LBYKbxw5CDxxAHLKOJCfk8L1P4683Om000dUkQtpeDNxLsgCJT
         mNUvfj237aGbgMV2jsAZHxQCW1mzigTWFxsKb8hjRKz3+PIMXHWtaIhf6XkxMtzs6Gn+
         xXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739395417; x=1740000217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnWJ9ncHwe6ht8H8YTq86uwEtd3hGCr8wLzk0vFKje4=;
        b=THUbO6SKQs6bDzRuOqkYIgr8U8AwPDacYOUdDJBeP5xCcFq5nERZb/zr4lPgwqGMHg
         njTazuziwV5CyQVPkVW1JtH3QNixMxe2w1jnsdAxBLm1xX+XAEtuEF+pdalKXxxJ2w3y
         P9Ya+Zk/tqLdJmQHSm5TCCe3zsdOKJbnNdwCRR4BtmyCUyhVVhFcdk0tIYKLzEhU7aUp
         bYVV3AgktyTAgoTXmMfQKFlDePGB/Zx3JH73rr7VPRUnuuVZe7cyLQbfIhbMsQT8Uy6l
         jllQw+xI62+eAwQT6eY/EDExx55vb+lCw3wXngs9TKXzDr+wuW3bYwT+Ni/6PMBYV8Hm
         HPkA==
X-Gm-Message-State: AOJu0Yy/u65/QRB8pEOM1Q0mKmU8ZI6Y7q7TKpSUGSXx4w74PpJl2hkG
	ENGwNoB7cKxsffAVPqbmfe1HksRmv9ghseEc/yOYNi8I/Sm+2IGVd1ykPIkfSkLsDcGpkTK2PjX
	g
X-Gm-Gg: ASbGncurIsWXm+uU8vjVPsba/M5jsaPpnBaSBJB/kiK/GfDhrBd5VutPDr8G6SXKUUL
	Xao3dI2BmsNvRQAZlRtqruhJU+rHiJVkmUQYPXC1ngp1r2vuzjo4H+N3jyxwv16GmFg4g923vad
	yPkH9kq/ARI/8IiuQ0zlYtXKETZbrQbIk2apk9o1UGXdyuwKJZQ0pCgIuHQqP73IHkuR8e3HaC4
	nerzKfmk3VNSBmX6hCtMr8UrFKomdAcrhE3DTRpfexwmQ36+tj9O46Zw6y8dxnPk6P/0KMc+ztk
	nC8QqF9B4D14W+ye1VvJAm+qX0nsGA/f5zP+IaJDx3hlF6KC6DKfFV/pqdODGBWtVaQ=
X-Google-Smtp-Source: AGHT+IEYqdmFI/8uZqwemYkPrJk0UIjGmcrIHb9Mpfb2ciK6bkr9nytSyUNC0C4qGkZnmqnJZ6k5rw==
X-Received: by 2002:a17:902:ef11:b0:21f:5cd8:c52 with SMTP id d9443c01a7336-220d213e655mr13788095ad.53.1739395416777;
        Wed, 12 Feb 2025 13:23:36 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5363848sm118065ad.55.2025.02.12.13.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:23:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tiKCi-00000000RUB-3uBx;
	Thu, 13 Feb 2025 08:23:32 +1100
Date: Thu, 13 Feb 2025 08:23:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v1 2/3] common/xfs: Add a new helper function to check v5
 XFS
Message-ID: <Z60RVLPGwpucOgRx@dread.disaster.area>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <61a7e3f25621548ec3ef795a3cd0724e32afb647.1739363803.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61a7e3f25621548ec3ef795a3cd0724e32afb647.1739363803.git.nirjhar.roy.lists@gmail.com>

On Wed, Feb 12, 2025 at 12:39:57PM +0000, Nirjhar Roy (IBM) wrote:
> This commit adds a new helper to function to check that we can
> create a V5 XFS filesystem in the scratch device
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  common/xfs | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/common/xfs b/common/xfs
> index 0417a40a..cc0a62e4 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -468,6 +468,19 @@ _require_scratch_xfs_crc()
>  	_scratch_unmount
>  }
>  
> +# this test requires the xfs kernel support crc feature on scratch device
> +#
> +_require_scratch_xfs_v5()
> +{
> +	_require_scratch_xfs_crc
> +	_scratch_mkfs_xfs -m crc=1 > $seqres.full 2>&1 ||
> +		_notrun "v5 filesystem isn't supported by the kernel"

This is testing mkfs.xfs, not the kernel.

We already have a helper for that: _scratch_mkfs_xfs_supported()

> +	_try_scratch_mount >/dev/null 2>&1
> +	ret="$?"
> +	_scratch_unmount
> +	[[ "$ret" != "0" ]] && _notrun "couldn't mount a V5 xfs filesystem"
> +}

This doesn't actually check that the mounted filesystem is a v5
format filesystem. That's what _require_scratch_xfs_crc() does.

Hence I don't see what this adds over _require_scratch_xfs_crc(),
which does the right thing on any mkfs.xfs released in the past
decade (i.e. when we changed mkfs.xfs to create v5 filesystems by
default). 

What test environment doesn't _require_scratch_xfs_crc() work for?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
