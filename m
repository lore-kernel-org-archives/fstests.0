Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAAA12C7FD
	for <fstests@vger.kernel.org>; Thu, 28 Nov 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825839; cv=none; b=PUpzo/8XNtx6Rm/nGSChjRPxI1mC/W9FSQQ5QjVksYE8Pvv6mXtLOA2H7/oc/fvrZjkabhbpwZxLF5lltJocHX+rO8nmVOjeO50tfd9UFe8zpQ+R8a73eJblddiqRZufh2L3z/lSj9hd40yzJH56EJ90C+grf2MwPtRvlyPCIdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825839; c=relaxed/simple;
	bh=n12ow44lAhdzVwbinu9sZUxhMtOzVoooRBaYpIhnPlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt9iiW2JHQaSvKYFRLuUookl+SN8VpKHTzCO+EJxXf1AgCI+4QCsSF4PE70Owlp8k+bwxtzn6uG66s1seE5WVvGU6c/KkW5IXhafMqAQ0cbJrZXZof8iDO/zlNModWV7FpACHOUmGM0RTmUF4eemTjNAPGsqq433/SVZ10utaZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=M5bBp7Q7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="M5bBp7Q7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724d8422f37so1019332b3a.2
        for <fstests@vger.kernel.org>; Thu, 28 Nov 2024 12:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732825836; x=1733430636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeqR/EGgcmggqo0Vk/FFbAdn8P5erKXJ4ShxgvlxqnQ=;
        b=M5bBp7Q7QdQfTpEO4am06nsZKAlRC/8wuSvkuWVWtumWQYKJkRIa7pJTtWCtfqV4B2
         R1Tcxs7vCEMFMnbsTLKy8YDGKhi0/rnVjxqJ1pGdMDAMQvwObwpXXBJK6HpDDQ4KnzEO
         itRcifXZ0y4fKv5oz+HaDJ4EUZk5Y/CjcEqn/m0LrqyoaNn0Kymw9nqODEyqTTWoZVZZ
         sDtys3zUdP/r5ntKc1oiwSn4ip4wOKgZWEd/pQwPaEkFFDVQSUoA1ZLsSt7EPhGDBUPR
         dLRPDVpTqDU0c+c8xopYgyk/7KAMvoEhW7dTaD0faOW7MhxaUN+6N4a5IDElJEL5FJ9v
         76Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732825836; x=1733430636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeqR/EGgcmggqo0Vk/FFbAdn8P5erKXJ4ShxgvlxqnQ=;
        b=jTnknMXEH3bLioMRSW9N8D1zRKML5Dqxn4r0q8exsZBRlnM5Sk/Ozgzo8HwoVQyw/Z
         N1UACQV1TThvtTy1J/YyLH2NrRK6GPWiCRt0Xrxksn0w55HSFjgnl07uxDVfbxmxBAKD
         wJ/DqRX6JOwp2Bb+XbChgksWcwDtKPu5JZXqMQZY5QVe0i2ZuJvbymSc+2Uxwq5KiKec
         nw07B9+3fH3DJixCK8cX5YbtONKhiLbquRYHnuvtBQ0C3i8HZTvZXTjpFyvGdGLT4ELs
         6mCE5jFNnOExCSID7GCAhN7gpVrr2LL4TUu7VDLiH6iO6iCSAM17446sIZCftuuPfei6
         ILnQ==
X-Gm-Message-State: AOJu0Yyo6iSyKEY+Tx36j4OyLmJZxurlb/OPap7fh1cffRrqHrzcSFOr
	7/LSiVh+57CtyFsVV6I8XWQOyTWRHzY916uYwgRg/iIN0mgaoZJklqqCTUT9FhgM8rvLnILhKcd
	r
X-Gm-Gg: ASbGncsxyl7pP8SZ0W43p3fOKaznIml6Att81JlyvqN593uS/6T7LLQwCeAY62Ckva6
	x02U+UhMDiQE0q0wCTzr+/kuSazrcUpUoCT6DN5heEZZt69/EbsXrvnhLYi3zOtDhryWAllsHvw
	Rm/Py/csUQXZOjyHD8SqO8KegEpU4kzn82vHJ8oENmu/b3MRG3LM4hzO/rghXMa5HtsFP910Ph7
	JlDl6U0OSHiwccHxTZJNe6bOqaNZpgxnfRWe1pNVY68VaTBHH73mly8+87HO/AYXrylVPADn9UN
	3670AWr+SJeRCceV+Swedq0s4w==
X-Google-Smtp-Source: AGHT+IHf0lh3Zz9vS1fG6JvnEgHP58GxgDTAEaTNsbygD81Rtr0PcONJWpLLt8vh3mtJrKR4EmGqtg==
X-Received: by 2002:a17:902:c945:b0:20c:f0dd:c408 with SMTP id d9443c01a7336-2150109b04bmr76782725ad.20.1732825835934;
        Thu, 28 Nov 2024 12:30:35 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219d0909sm17589955ad.278.2024.11.28.12.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 12:30:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tGl9j-00000004F9K-2ms9;
	Fri, 29 Nov 2024 07:30:31 +1100
Date: Fri, 29 Nov 2024 07:30:31 +1100
From: Dave Chinner <david@fromorbit.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/028: kill lingering processes when test is
 interrupted
Message-ID: <Z0jS5zmObJTEWYTY@dread.disaster.area>
References: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a257c21d2efe2706bac1f2fac8f7faff1d0423f.1732796051.git.fdmanana@suse.com>

On Thu, Nov 28, 2024 at 12:14:56PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we interrupt the test after it spawned the fsstress and balance
> processes (while it's sleeping for 30 seconds * $TIME_FACTOR), we don't
> kill them and they stay around for a long time, making it impossible to
> unmount the scratch filesystem (failing with -EBUSY).
> 
> Fix this by adding a _cleanup function that kills the processes and
> waits for them to exit.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/028 | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

IIRC there are several btrfs tests that run fsstress that need
similar fixes. I fixed this problem for fsstress across the entire
fstests code base in this patch I recently sent:

https://lore.kernel.org/fstests/20241127045403.3665299-3-david@fromorbit.com/

Avoiding needing to repeated rebase that work by having people
randomly fixing one-off instances like this is why I'd like those
large "fix everything" patches reviewed and merged sooner rather
than later...

Regardless,

> diff --git a/tests/btrfs/028 b/tests/btrfs/028
> index f64fc831..4ef83423 100755
> --- a/tests/btrfs/028
> +++ b/tests/btrfs/028
> @@ -13,6 +13,19 @@
>  . ./common/preamble
>  _begin_fstest auto qgroup balance
>  
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f $tmp.*
> +	if [ ! -z "$balance_pid" ]; then

"! -z <var>" is the same as "-n <var>"

> +		_btrfs_kill_stress_balance_pid $balance_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}

This really wants the balance_pid and fsstress_pid variables to be
unset after they are killed in normal execution so we don't try to
kill and wait for them a second time on exit.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
