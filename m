Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333011B21AD
	for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396830; cv=none; b=EDLc815TWBoSIFBWey3LNkGHbldUibdb75vQK/IRegZk52KKZpCm/xmCIQwx+V1vuAxu2viBCWbwy1tv1V5vxmJbXilVtkEvsTj4OMvId5nSAikqGMYD7B6UIDe/Ru4EBRpfLwN6jVQtg6BvLb5kKQunXV4qKzHbh8yJf3F8SDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396830; c=relaxed/simple;
	bh=Lnq4FTvbanMJRWO9UU2Sh2ynk+Qtj7WbE2EyQGFzh1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z76kXus3W8I8RfyFp5Ryir5LoG64Q6H0LvEoEnPU5WB3dPmfzN2pwYxogQkHN8YS6kJOFcW+xjZssA1boy1+4qMyjivAImIJNfkOhSNdlG+1xmlZjbncD3VFJiF5aTF6lsNorVYTZhjiq3LUabI790ovmAPTDUnZtTgwiBCPwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pGLy+gkJ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pGLy+gkJ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f6a47d617so2332905ad.2
        for <fstests@vger.kernel.org>; Wed, 12 Feb 2025 13:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739396828; x=1740001628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gWgH6BRH4uvfdvHvSNKEFUnHAT9O3jpVoaM4yCHjsD8=;
        b=pGLy+gkJFeRS2FAYEdguWi+vIRuxJiZ3CMyiVGUGQWRToFyeiHI8IyIZ/Tkr98NWm5
         Sy5POiZhB4kS96WXqeX3hWrCv/pUBTSDeV8XW7pgp66W/jQ/ZjptoWiYJ7+GW+vLuHVv
         /Auke5v+98+6I/f8Waya5yhyd6Qwg+BpFfbYuCDwqSk2hYuDbC1XHMgVE3m7vmGQlUR3
         +y1sNCQmZiO99toHXHg+w9TiSmHPSRucPPsnOng0RhHtcSlU2nOKZGPaM10PLdTomzEr
         2AXqCxc0WbKaag+prVlnoZxVlgnGKuhrW5+OvEOq6/ogyE0qnXqpTbZIkt8XxFZHgtzZ
         lovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739396828; x=1740001628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWgH6BRH4uvfdvHvSNKEFUnHAT9O3jpVoaM4yCHjsD8=;
        b=cL4unAz9yzli1n7A88UP8GmPtE4aF/ERBVqMpTFE74ZG9S4E+S34Pw8t6dpHvfIFaq
         tTSXfQkqJdm6vXLQO0misti8BhdOCcxYqmXZ2oGmIh9ZehDKi6h/HUMdypAJ220aNCMg
         qW6+ZNh2Z2npTzYd7e34f+j33QdKykUtiICOmVY2hbc7hSE/JKY0z/opP0tx/KW3XhE/
         Ot3PW3vnEgRZoVOtv9QsKrmvNJ8w1dalffrSqpez+pkIzSYqgeVuLcj+IT0z7WxqaaYy
         ncn0uVJ8Cma4tNvJc8wCjkLJuFaaHbkUn4FY593+OVOLi6nYKSu+8SVOCclDqFcRD0ty
         /fxA==
X-Gm-Message-State: AOJu0YwQ1+fOik5chfGKP6Ow1lAR78LA/Cf4BOR5mQRVywJUEGhd4/6q
	0WQRDByEV6m1vjOiqdFR/+aYWFd5j6C2FzSfMewKjgYKF46jLwZ2XiAtjRBpeZjjrMDTcQTaj4R
	6
X-Gm-Gg: ASbGncsXsUyDNm0goB5WhuUxgUUYpsYOsitUahvemeY1hM5xgC1InjFM0j44wDz4gCs
	qoD9gkZ8TYL9G4DmfCrXG7bhOSolPxUKwZwjQ18ZIl3EwqZ7PAyLN0gW+P9TZyAz1aB0/A+OQly
	VJrO2hZgJ5bOvpkzhNrCt04bt5SScl/wjFhQQzQHP8lBqyMb/eFd1ukX+AFBr4bEAqHQt1iTI+0
	45qLoyn2s+AnSs1w0blzjkbg72YvSXDP/J/0Qh8wCT779UIivnQuHicDhiar3aTCXgjImAzUxEw
	8LqjumcVafmr3K85tmAl4UkJatLG3rL+IvFbq0dyDuXRW6uUyVPQZQyP
X-Google-Smtp-Source: AGHT+IFvEo1sLDGK43eislHv14UxDSjw3KRGdmZi4jemDh6x9pT6qVEWn8GmLa/4wvn4h+SozAZ8GA==
X-Received: by 2002:a17:902:e5cc:b0:21f:3e2d:7d58 with SMTP id d9443c01a7336-220bbad65b4mr69397715ad.13.1739396828519;
        Wed, 12 Feb 2025 13:47:08 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c8d1sm177145ad.113.2025.02.12.13.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 13:47:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tiKZV-00000000Rxy-2gAy;
	Thu, 13 Feb 2025 08:47:05 +1100
Date: Thu, 13 Feb 2025 08:47:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v1 3/3] xfs: Add a testcase to check remount with noattr2
 on a v5 xfs
Message-ID: <Z60W2U8raqzRKYdy@dread.disaster.area>
References: <cover.1739363803.git.nirjhar.roy.lists@gmail.com>
 <de61a54dcf5f7240d971150cb51faf0038d3d835.1739363803.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de61a54dcf5f7240d971150cb51faf0038d3d835.1739363803.git.nirjhar.roy.lists@gmail.com>

On Wed, Feb 12, 2025 at 12:39:58PM +0000, Nirjhar Roy (IBM) wrote:
> This testcase reproduces the following bug:
> Bug:
> mount -o remount,noattr2 <device> <mount_point> succeeds
> unexpectedly on a v5 xfs when CONFIG_XFS_SUPPORT_V4 is set.

AFAICT, this is expected behaviour. Remount intentionally ignores
options that cannot be changed.

> Ideally the above mount command should always fail with a v5 xfs
> filesystem irrespective of whether CONFIG_XFS_SUPPORT_V4 is set
> or not.

No, we cannot fail remount when invalid options are passed to the
kernel by the mount command for historical reasons. i.e. the mount
command has historically passed invalid options to the kernel on
remount, but expects the kernel to apply just the new options that
they understand and ignore the rest without error.

i.e. to keep compatibility with older userspace, we cannot fail a
remount because userspace passed an option the kernel does not
understand or cannot change.

Hence, in this case, XFS emits a deprecation warning for the noattr2
mount option on remount (because it is understood), then ignores
because it it isn't a valid option that remount can change.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
