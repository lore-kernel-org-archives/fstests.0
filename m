Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2B1E1E05
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944836; cv=none; b=ruB7BgxC7BxUoEuzZL1QzXuOlWZ1TqRbP0EMPRebEIXlo49at4GuMW7YbDWZCfbiSudOvs/ZJOOLwWrb1JOt7iPTExw80Tg8wpnB5Pce7HUOCxnYXO/NrblxPi1hKQ9AzUshxEFUuytTkNAHezZGT5awdm73zDwgRyOu3MRDSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944836; c=relaxed/simple;
	bh=Y9aYbw3uoMV1SC4X/SSkU8CvywSpynyzFOLN+R3eLB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5MDOJTrKNfbJWci1uuzm+0RVHpwLnmd6T1Sh5/T9xLnlcE6wkXkp0tWCJ3TQQBWdwUbUzOS53+gfikjfcGR9+i+mgDvvMaYLT1bw06970rIIANUyaScy5drd4cQtSQ1fc4D8DH3s8F1GghsJlv0wTMudFK6OIUyoFDLH61TK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=qjAaSAiR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="qjAaSAiR"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2255003f4c6so120204905ad.0
        for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 16:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742944834; x=1743549634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xN1R4jttMHrmK3BdJr5+xjDCnhrufGspgu+PHeQu2dQ=;
        b=qjAaSAiRSSwlE8YGPbKOJlOMra46d7HioA2OOU962sFxS2JCAIhlPzwgpaGJR8Um7Y
         Fs3XZ416IlSQzTbupxsdVG5b+6L8wy5Wq164edBUTSbSRKSHpbbwOb/NaAyU7vEaWRr4
         fa+zrlf2WBiwD+iquc+t6Qrzf5zRmyiXets2XRp4nOIVC4iMRZw7vaGH6Z+tgh28KPwL
         3Wgu0FHmygKYAD2aQeIJpHC/znWEQwHMcRCheckuM7Z1Vo5juqAQA7nYhJVTZDr87uxA
         L8C7cfrXqygbRZS6z1nyRVFl8g0uS99pMbaY2B8Y1Ug26G/DuzENQpdi0ecWbzyKrhjq
         qUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742944834; x=1743549634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN1R4jttMHrmK3BdJr5+xjDCnhrufGspgu+PHeQu2dQ=;
        b=oSrBECMAx+wjxroWVCW06S1l6FzvGLzrSkOVvXGY83llrqJsjRoqKNjkKGifGUQCCL
         9iIByGMjGhVIA5PMtnzApccSUcpfONwM77UTEVF90ghmLje2sMo0/Y+UIGPYMyGn99Y+
         6dd+Bgh6/K8hNwNK1AfATBQ6DMgYlja4xp4WtLffcGrCRL8VbdKsBc3o3BIX/ue7Zy57
         NK/G4U5LrRUvHAniiO3NSZQGHzpXxRPcPa7xBjd82g6Jo7goyNGBYCWERMxHcqrS2tRQ
         4Hc/p+F8COIAawsGUxagU9YZQiMUEOQ1Ce01ZzfI+mfXPG9JdPJKbvcw8//qXossFxuU
         vl9w==
X-Forwarded-Encrypted: i=1; AJvYcCXEe8B7HuRkF9/a8blUPqKACpECpiRQYA59na6PVN3Bqp4qeFdv4vymRXQC8OLGlDRTMeNYsznG@vger.kernel.org
X-Gm-Message-State: AOJu0YzovDN9jRzIyQeqRRCLG+IeR9J1BjCquXibZhFW0Za3+6PWpwMJ
	Zt7uZfyW8otaT7i6Mlg/7kO9WrowCNNdzrubg+GuB+/caInP6/jeKAF1sWMmdYDJuRIf+qQco0+
	dKzk=
X-Gm-Gg: ASbGncvnfSGrwfhWQ04mo8DMvq87vPs3PsibmCmKuXnlvaoG5nViXC3ta8Pqqdd6YEP
	AvIMLpQQte+2YKdYfug3I9VSlTcU0qwfE8Gyh7WoLeX9OoUKfh0MtIkku2BY7t9+rI3lRqblo/X
	I0HH9RIjb9eMvjiASvOWm8xoT01ADv2VZeLmzJFtLEbEnjRQi+C1i/j5YPi72F1Kxr5xvH7OZKX
	ZI0JdAASGVwazUUhxpIkZbWqQCpwOMPJMhXZdueNlIQlrZ23AtK/RLfjLJGYDxWgABl0mU5CSAr
	127F+fYbah4X3yua0DhjewpeRWfTMdxl6r3GIpiFYAWubOq9CA1Ye+nnlpaUpX1KmJFe0CserL9
	DgdzMoOEttQ==
X-Google-Smtp-Source: AGHT+IFPvwqH3aFp6ptKNymYWn0hEgv6uWOBsU8mhsLRdoc8XyQn/nxx7iSZSiHI8TChl/8J59OZdA==
X-Received: by 2002:a17:902:e541:b0:223:7006:4db2 with SMTP id d9443c01a7336-22780dbb924mr272665915ad.31.1742944833515;
        Tue, 25 Mar 2025 16:20:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f50c80sm96377285ad.104.2025.03.25.16.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 16:20:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1txDZO-00000000ImA-0XSx;
	Wed, 26 Mar 2025 10:20:30 +1100
Date: Wed, 26 Mar 2025 10:20:30 +1100
From: Dave Chinner <david@fromorbit.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 6/6] f2fs/009: detect and repair nlink corruption
Message-ID: <Z-M6PkLZI2LIOlXY@dread.disaster.area>
References: <20250325125824.3367060-1-chao@kernel.org>
 <20250325125824.3367060-6-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325125824.3367060-6-chao@kernel.org>

On Tue, Mar 25, 2025 at 08:58:24PM +0800, Chao Yu wrote:
> This is a regression test to check whether fsck can handle corrupted
> nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> and expects fsck.f2fs can detect such corruption and do the repair.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v5:
> - clean up codes suggested by Dave.
>  tests/f2fs/009     | 141 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/009.out |   2 +
>  2 files changed, 143 insertions(+)
>  create mode 100755 tests/f2fs/009
>  create mode 100644 tests/f2fs/009.out
> 
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> new file mode 100755
> index 00000000..864fdcfb
> --- /dev/null
> +++ b/tests/f2fs/009
> @@ -0,0 +1,141 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/009
> +#
> +# This is a regression test to check whether fsck can handle corrupted
> +# nlinks correctly, it uses inject.f2fs to inject nlinks w/ wrong value,
> +# and expects fsck.f2fs can detect such corruption and do the repair.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +if [ ! -x "$(type -P socket)" ]; then
> +	_notrun "Couldn't find socket"
> +fi

Perhaps something like:

_require_command $(type -P socket) socket

would be more consistent with all the other code that checks for
installed utilities that a test requires?

> +_require_scratch
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +_fixed_by_git_commit f2fs-tools 958cd6e \
> +	"fsck.f2fs: support to repair corrupted i_links"
> +
> +filename=$SCRATCH_MNT/foo
> +hardlink=$SCRATCH_MNT/bar
> +
> +_cleanup()
> +{
> +	if [ -n "$pid" ]; then
> +		kill $pid &> /dev/null
> +		wait
> +	fi
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +_inject_and_check()

Single leading "_" is reserved for fstests functions, not for local
test functions.

Just call this one "inject_and_test", because that is what it does,
and call this one:

> +inject_and_check()
> +{
> +	local nlink=$1
> +	local create_hardlink=$2
> +	local ino=$3
> +
> +	if [ -z $ino ]; then
> +		ino=`stat -c '%i' $filename`
> +	fi
> +
> +	if [ $create_hardlink == 1 ]; then
> +		ln $filename $hardlink
> +	fi
> +
> +	_inject_and_check $nlink $ino
> +}

something like check_links()

Otherwise this is a good improvement.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
