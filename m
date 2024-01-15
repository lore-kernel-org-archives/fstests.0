Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800991B7FD
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 23:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="L14CSRm2"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28e0786edb3so2791586a91.2
        for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 15:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1705361903; x=1705966703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gIxV+15hS18mozTWlcKqZtDsDzJXr7KrpP4OI8JIqu0=;
        b=L14CSRm2qJr1JUHW5XBUjN57xoFtCsy7cnehf+cz80gcRKRITC4a8yvsM/v4EBjrhs
         iJKwNfVc2YTD1UiP99z05UdrmOBBDOV/b1K9MmvD/i9chq0QTN0z+aXeB+pr7/su2DDr
         9BAh/qjv7FCkQ/xpsmBl3gQ/EAmjlnkaaGBqkFEyEwuc8DGJfuZaJeik+AlqudeeMj2T
         QvC6+Jepy79i5+/dhfWuSWO4EkRFUwlpFPi4H/HS/EJMNGf+OwOu9o1PnY227dakuZEL
         jxLPVmVsrRaLwnvOr4tF2+fo1tTJ3UmPxQ3v5eoCr/YMH5OJFqbRM73F4LtAE0/hFTVN
         mWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705361903; x=1705966703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIxV+15hS18mozTWlcKqZtDsDzJXr7KrpP4OI8JIqu0=;
        b=Bj+XnnTrisTZtrf2bcEy5FAiAqy/z+5Rak9bJ4J72xuXPgT4cxaqipvG4uXZ92RjKS
         DdfIwkWgJ6XzlSi8iWXyvYtoBgWyGCYstFe92j/p6P0oS13KgO8W8juuCAoMdsUVBhh4
         8kfM8AmUswDC0T8L6LZpnpbN/lAgBXxYhR54bLvy3p1TmRIzU7lGUXBdF1AaMEiTszt7
         nIkjxd2gnvF/feUz1ZitSm9DcM8e2ATpmUVj6Y2Y+WIZcaxsdbpVPPw61X7yun64mDE9
         sFeXSDK0MQz4qm8CE/iATnsKdzTyPnMXjgPEhsoOhvs/5mwbL4MOVzaN5IObSMTuCv4V
         J2RA==
X-Gm-Message-State: AOJu0YzJCmB4qnEg4F4wSxQzOYXpMym7fvosySMartfegs7VmMYotjY8
	nu2o51nsyCNdTDqxWcFSrlEHmzsR8Kbunl6oL2NzqAjyVrk=
X-Google-Smtp-Source: AGHT+IFfATVwwpTyrcUJ3XrVC3loibO+dDjwuiXXaHzlaiCuzz8Jtpvyhf1nSO5AR6tCX93VOQaIAQ==
X-Received: by 2002:a17:90a:a782:b0:28b:fe06:5dfc with SMTP id f2-20020a17090aa78200b0028bfe065dfcmr4168769pjq.29.1705361902707;
        Mon, 15 Jan 2024 15:38:22 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id db11-20020a17090ad64b00b00286da7407f2sm12796366pjb.7.2024.01.15.15.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 15:38:22 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rPWX5-00Atz9-0J;
	Tue, 16 Jan 2024 10:38:19 +1100
Date: Tue, 16 Jan 2024 10:38:19 +1100
From: Dave Chinner <david@fromorbit.com>
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/193: Ensure user in expected group
Message-ID: <ZaXB6wYpoqjeGHKg@dread.disaster.area>
References: <20240115212402.21888-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115212402.21888-1-richard@nod.at>

On Mon, Jan 15, 2024 at 10:24:02PM +0100, Richard Weinberger wrote:
> The test assumes that the $qa_user is member of the group
> $qa_user. While this is automatically the case on systems
> with USERGROUPS_ENAB set in /etc/login.defs, not all
> enable this option. Most notably SUSE Linux.
> 
> So make sure this case is noticed and reported instead of
> failing the test and let the test guy puzzle.

> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  common/rc         | 11 +++++++++++
>  tests/generic/193 |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index a9e0ba7e..5c6671a3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2484,6 +2484,17 @@ _require_user()
>  	[ "$?" == "0" ] || _notrun "$qa_user cannot execute commands."
>  }
>  
> +# check if a user is member of a specifc group
> +#
> +_require_user_in_group()
> +{
> +	local user="$1"
> +	local group="$2"
> +
> +	id -n -G $user | grep -w -q $group
> +	[ "$?" == "0" ] || _notrun "$user not in group $group."
> +}

Just do this check in _require_user(). The user needs to be set up
correctly for all tests - if the user and group is not set up
correctly, don't run any of the tests that require that user.

This means we don't have to play whack-a-mole with "user has no
group" every time someone assumes that a user is created with a
group by default.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
