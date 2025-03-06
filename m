Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB01FC0FB
	for <fstests@vger.kernel.org>; Thu,  6 Mar 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259119; cv=none; b=b3ZkwiW0gGOoCw3j+GbkGCvNB6XldsirQpB499wAVVwMCfodsQD6j227X8YQS7EffATogvi9rlPia4tVw6TtpI3CwfJk5bq5YImmDsfXSFl7bHeFCSfgN4a6cjF2BUsfm1Vli6xOaX3u8hOjVEmcGw/7DLBOtEopDjLlAAfv+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259119; c=relaxed/simple;
	bh=/cC1lJMApoxWxOO8D3Ns81ZSoC0WPT8kJ7nL/eKLAjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qkj06rLb3pCOmhMcgiRsVSM3gVogNxo6J8qqdu/SJATucm6Q2aOEy3PyeYFtZDuszHqeVz2l/yl5ajBNHq9XWkLov6NuL6vqXWpBtS9lpXS1UBFxPK/S16lj9ZHcbshdf8KsY8HOo1Tj4qvAH3HvzOkctBCipS37PaP/ZV/kQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FKoUsUJX; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FKoUsUJX"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff04f36fd2so891348a91.1
        for <fstests@vger.kernel.org>; Thu, 06 Mar 2025 03:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741259117; x=1741863917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r77KB5e0ggp3XHtWYDI70Cvwmi5isFHBBlKG4vQODgM=;
        b=FKoUsUJX4BCe1qNZffaqf1zdQT3n23DtCQUJI2/++MGt3FgxnGSAWlgthGcWsbHy7D
         xjcf1Q7AxwR/6g969wZAoJwcBr9MtfB6ymgK15oXSUtiWkMAEJr8YYeP1JSMFpozrDKZ
         rmPkIcKiAzITaOzYxCFTExHidWHHHX0W8pmvgYsvSkdAwg3rWgkJC2cZNJskt+uV4pJR
         54GRt+lWWtOc5NdjsY6yPSzujMgh5ohIzuPankkah4i1FZQ2i+XNUJDWgTfkxTOurjsN
         SpdJyzX1mX2nSCp2AZdDybnUNTViCGSTrXtVPTi5nJ99sWUBdzZwnhdKH99BoPqEjHS0
         IPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259117; x=1741863917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r77KB5e0ggp3XHtWYDI70Cvwmi5isFHBBlKG4vQODgM=;
        b=ptX9eGjzy/75i1nzJCRtBDtbHiI+rubhttuB7TYMKecVH55K0+8PG/7J0107CraRQY
         FoOFfsqAHyHxSab74wBnwdP9uZTZkCiODHu7Z7tI7GkKIqe070ld9JLmxBgnJU/GSjF6
         ZFQjS9DlLCiy2KZpM+0yTDsyQftq1+2Z0mm3PzpUCj+OPo2LEcTaoFIThDh1LlgnvcbT
         EM5RDlUZRvdDJWWzCEPf0HVL5axOONY/+KvNFHM+TPqhvwj/N6qEdAr4pdoFb59b/3AA
         XNNqIS7rkzEJl+oeSc0tAwRc3jhesTK2TNRoDFa3eOSS8axqivMrGzC89L1r9LX8ALeM
         km5A==
X-Gm-Message-State: AOJu0YyU3vCbJBuOrFLemShpIAKe3Sabx2WaH5/kdPz6FD7b+V6AyvEY
	YjY/ztlBw3M+1ZvmsJuhF1JI7y0dOhaE28pz89W3BsQyvnlSdg0nc6gXP2knaZPg+b43jBt7lgl
	m
X-Gm-Gg: ASbGnctfk3piA4yartjSnCaEzT3IGAxDGDuV0bPFQKrYQNmIYwLQyx+UnS6KCqPaupX
	wTt935DyXfB9lUwrCM2PPuvfrtCHPb8GXVMNNaWq/XNUntfieGaINjSyzSchJIzkUDA+o8umNF+
	UgZJLZ3Vg2plS+F0NSwqPCf0fdto8nhq/xjxL6Y2hC7eYPTXGswUmwmfiM/6z9DQDUrZdeFxci/
	iiFbKYvo0QqcNr1aZYVJW2LoEfhcmUVL+chN4M0ooTh754LaVm9RvgmAOZIw1c/Cq/f1a/J+3tL
	I+spU9l2hKNYdOgCoy1zdr7UN5qYzO1bU9hX5nW5R1XfGGrTvt5PFNx6qIGro5gioSJUNsh/1ym
	eKHKXuxp/ACI3YiZ5Lv0B
X-Google-Smtp-Source: AGHT+IHLl2sUdwWfRhvjJPLdL1l9KWFuzRi4uxxrs/x5vjEmGEiSeyQVmsrd74ysA7cjk/Dfllqt2A==
X-Received: by 2002:a17:90a:d64e:b0:2ee:8e75:4aeb with SMTP id 98e67ed59e1d1-2ff497534c7mr12703892a91.17.1741259117378;
        Thu, 06 Mar 2025 03:05:17 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f976sm9479735ad.156.2025.03.06.03.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:05:16 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tq92P-00000009Zkd-19eC;
	Thu, 06 Mar 2025 22:05:13 +1100
Date: Thu, 6 Mar 2025 22:05:13 +1100
From: Dave Chinner <david@fromorbit.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] check: disable HAVE_PRIVATENS by default
Message-ID: <Z8mBacJNAj6gVd7N@dread.disaster.area>
References: <20250306094924.1353269-1-zlang@kernel.org>
 <20250306094924.1353269-2-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306094924.1353269-2-zlang@kernel.org>

On Thu, Mar 06, 2025 at 05:49:23PM +0800, Zorro Lang wrote:
> Currently we have 3 ways to run a test case in _run_seq():
> 
>   if [ -n "${HAVE_PRIVATENS}" ]; then
>       ./tools/run_privatens "./$seq"
>       ...
>   elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
>       systemd-run --quiet --unit "${unit}" --scope \
>              ./tools/run_setsid "./$seq" &
>       ...
>   else
>       ./tools/run_setsid "./$seq" &
>       ...
>   fi
> 
> The "privatens" way brings in some regressions. We need more time
> to develop and test this way, it's not time let it to be the
> first default choice, so isolate the HAVE_PRIVATENS initialization
> by a TRY_PRIVATENS parameter, and disable it by default.
> 
> Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
> old ways. This patch can be removed after "privatens" way is stable.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  check | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/check b/check
> index ea92b0d62..cb2f19d08 100755
> --- a/check
> +++ b/check
> @@ -674,10 +674,13 @@ _stash_test_status() {
>  	esac
>  }
>  
> -# Can we run in a private pid/mount namespace?
> -HAVE_PRIVATENS=
> -./tools/run_privatens bash -c "exit 77"
> -test $? -eq 77 && HAVE_PRIVATENS=yes
> +# Don't try "privatens" by default, it's experimental for now.
> +if [ "$TRY_PRIVATENS" = "yes" ];then
> +	# Can we run in a private pid/mount namespace?
> +	HAVE_PRIVATENS=
> +	./tools/run_privatens bash -c "exit 77"
> +	test $? -eq 77 && HAVE_PRIVATENS=yes
> +fi

Works for me - I have basically the same patch in my check-parallel
stack because this breaks check-parallel mount namespacing for
reasons I don't yet understand.

Creating a new mount namespace for each test that is run appears
to turn the private mount namespace that each check instance is
executed in back into a globally shared mount namespace inside
each individual test mount namespace.

i.e. when check uses private namespaces I can see all the mounts
from inside each test namespace from the init namespace and every
test can see every mount that every other test runs again.

That is the problem I originally used mount namespaces in
check-parallel to avoid.

I have no idea if this is how mount namespace nesting is actually
supposed to work (seems completely broken to me!), but the only
solution I've found that works so far is to turn off HAVE_PRIVATENS
in check as it is redundant when it is run from check-parallel.

FWIW, given that check-parallel now runs in it's own private PID
namespace with it's own /proc and /tmp, the original problem of
needing to "confine pkill to only the child processes of this test
instance" has gone away entirely. i.e. check-parallel does not need check to
to restrict pkill to children of the current test being run anymore.

Hence I think we can probably remove the new process isolation
shenanigans and revert the _pkill wrappers to plain pkill calls
again as the private PID namespacing the check-parallel does means
pkill does the right thing for both check and check-parallel now.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
