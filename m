Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F2EAD0
	for <fstests@vger.kernel.org>; Wed,  5 Feb 2025 00:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738715828; cv=none; b=pgFbwtrvSClfppPSRKe4doSirlJX6lpEXPQWn5RJukXZ6DnM7pz6A3kw1kayD86Ozckkn0QP6UTxvD29osJKC7vH1pzyTd4+t/rWUUx/FAlqu2u7vrEl/msMu0/egRIJ4knB4tonaz7AV9Tmedb99yDJSVIIOwKwkCVJVdZ5Y9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738715828; c=relaxed/simple;
	bh=WbgrX6reo4859QCILu/fyJEynNDQB3xCeU/jslB5X98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db5HshVMDpIysN8qyLWzSnI5Ik7dwOziwA5h2o0Z2oWqezqVrzCDLXuIAgQokYP+2IwHIngF2FN+GvNvPWP9HIB6sjYsKsd9tQtlXRIuYKrlhhlAyhQB6SW8uiMfjY0vilqH5VCtrCNk/AeTzI2FqJh/HnKWOADgC9+Pv2vtXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=fGFQTQ7I; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="fGFQTQ7I"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2164b662090so121059245ad.1
        for <fstests@vger.kernel.org>; Tue, 04 Feb 2025 16:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738715825; x=1739320625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCOBfzpFTeNSK9rnRpzmFIzU5EiYDyWt4jjPVrCth4I=;
        b=fGFQTQ7I5Mib6B1ufmh4mBezrb4yS8vgcuuk96bZXUBF/swXuPThrB22ksN1Ys/50I
         MSnr4dIRobvszcWCP8ZuXUCGRCTnZ4oLEyo7OvR41PhB5Ywd1ZbYVzkK+3NkxkbqjLPZ
         H8+LXtOGe1sB98DBDBrvoz1wt3YKstMMFORsQalUhD9Upgou5wEqjm3b1rnWeBXdwoKV
         dNUwkVG9MfNiYfYyfhGNWu7/MqtutA1VhyOzajC+Lalkh5Y5sInrp2QFyw2wvXtiKG+8
         FZxIKL+OabkPVww0z9D4jHBe9JBhh4cLVu9ChMZzcY6PvxuursfeVgB2FZywBk9Uixqm
         RLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738715825; x=1739320625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCOBfzpFTeNSK9rnRpzmFIzU5EiYDyWt4jjPVrCth4I=;
        b=I1fwCR6nW8XQIVYiTPAmMfB7tiaMOszmjoXSN/RYBNqUvkhiR2lhbc1YlmBD8yD5/z
         d3f/x6HTMo8z0mYd9a5Wa/McrIFp9D2zqkWn/WpGAmY3g/KIFcy3UK0wVf0oSPpfNmkr
         j3Xyi25D9EqY/+oCHWoCDn8fSFKPdDX1we88Cc/Bwl9IkCTA4ocgNEvW0zGkVtUjINdc
         q0tI0IETSEKJTiUVFQ9ZJvqpT9fY+9Zm3LfKwi/eTJwkPg3Hr9IJEPWyQkHyWs0k1JWO
         Uppilh/CUhiX+twq4BGFFFDAt6vhaoTzQP0QKlB+FEiNqg0K/VUg1kYXQtGUUgdu9PmJ
         LBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc2fnFna/MRrYUL4QVzlzY9wRWyDjzidIgAbNXIz4Et64oWJLbsv2Wreg/Y3DLHFJa1qAPFozv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrv3dcW0lYU8ik5MTjl/bZtLdlqOQPf+bdqWIxL6ETk8rU3sXN
	qs79Vwh6hQY7uwbHtGQpjUbuOZEMXXw+kiLTwbUVTJoih4kBcQdqiqjsTRM5iXI=
X-Gm-Gg: ASbGncuCsNdRLR23sn4TCLcUknVKdaqOpmtB0It4CVafMNDZa5lSYbIg5Mcnx53Jgv6
	KlZokbCqVx2u3l0ikrM+MYku7MYrok8J8ni46b4qIWhxMUEuR+6rV8wTpWXIXd06XWndUF8QQEB
	t5zgpNEuPzCIg5y0xiF/I7hg+8qDIoKq1GabI74tMK3+njEyqMxEysIAXRc6TYpxbI4T/U/72q/
	NKPiw8L9l3vy5JwTxDP9aOS3B6Nvp3EPbgwzo2SqYJScdrrruMFOYSXKkTsTVlXSHPp+oNczC8d
	/UQtd7tvgFdRihdU/x7kkskeI+RBk/yX2+WXGYjRRHm7jI62Rc/C85wc
X-Google-Smtp-Source: AGHT+IGbzMoBUcU/wDNhF8zFHmw9a+LbIFtR+G86aGKWDMm9zz/rR2pps/AKce1FPj1hH1c38HK5UQ==
X-Received: by 2002:a17:903:28d:b0:21f:14e8:e87 with SMTP id d9443c01a7336-21f17e0c237mr12002795ad.26.1738715825498;
        Tue, 04 Feb 2025 16:37:05 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796d6sm10685771a12.55.2025.02.04.16.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 16:37:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfTPY-0000000EjIc-1u4f;
	Wed, 05 Feb 2025 11:37:00 +1100
Date: Wed, 5 Feb 2025 11:37:00 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/34] check: run tests in a private pid/mount namespace
Message-ID: <Z6KyrG6jatCgmUiD@dread.disaster.area>
References: <173870406063.546134.14070590745847431026.stgit@frogsfrogsfrogs>
 <173870406337.546134.5825194290554919668.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173870406337.546134.5825194290554919668.stgit@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 01:26:13PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> As mentioned in the previous patch, trying to isolate processes from
> separate test instances through the use of distinct Unix process
> sessions is annoying due to the many complications with signal handling.
> 
> Instead, we could just use nsexec to run the test program with a private
> pid namespace so that each test instance can only see its own processes;
> and private mount namespace so that tests writing to /tmp cannot clobber
> other tests or the stuff running on the main system.
> 
> However, it's not guaranteed that a particular kernel has pid and mount
> namespaces enabled.  Mount (2.4.19) and pid (2.6.24) namespaces have
> been around for a long time, but there's no hard requirement for the
> latter to be enabled in the kernel.  Therefore, this bugfix slips
> namespace support in alongside the session id thing.
> 
> Declaring CONFIG_PID_NS=n a deprecated configuration and removing
> support should be a separate conversation, not something that I have to
> do in a bug fix to get mainline QA back up.
> 
> Cc: <fstests@vger.kernel.org> # v2024.12.08
> Fixes: 8973af00ec212f ("fstests: cleanup fsstress process management")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  check               |   34 +++++++++++++++++++++++-----------
>  common/rc           |   12 ++++++++++--
>  src/nsexec.c        |   18 +++++++++++++++---
>  tests/generic/504   |   15 +++++++++++++--
>  tools/run_seq_pidns |   28 ++++++++++++++++++++++++++++
>  5 files changed, 89 insertions(+), 18 deletions(-)
>  create mode 100755 tools/run_seq_pidns

Same question as for session ids - is this all really necessary (or
desired) if check-parallel executes check in it's own private PID
namespace?

If so, then the code is fine apart from the same nit about
tools/run_seq_pidns - call it run_pidns because this helper will
also be used by check-parallel to run check in it's own private
mount and PID namespaces...

> diff --git a/tests/generic/504 b/tests/generic/504
> index 271c040e7b842a..96f18a0bbc7ba2 100755
> --- a/tests/generic/504
> +++ b/tests/generic/504
> @@ -18,7 +18,7 @@ _cleanup()
>  {
>  	exec {test_fd}<&-
>  	cd /
> -	rm -f $tmp.*
> +	rm -r -f $tmp.*
>  }
>  
>  # Import common functions.
> @@ -35,13 +35,24 @@ echo inode $tf_inode >> $seqres.full
>  
>  # Create new fd by exec
>  exec {test_fd}> $testfile
> -# flock locks the fd then exits, we should see the lock info even the owner is dead
> +# flock locks the fd then exits, we should see the lock info even the owner is
> +# dead.  If we're using pid namespace isolation we have to move /proc so that
> +# we can access the /proc/locks from the init_pid_ns.
> +if [ "$FSTESTS_ISOL" = "privatens" ]; then
> +	move_proc="$tmp.procdir"
> +	mkdir -p "$move_proc"
> +	mount --move /proc "$move_proc"
> +fi
>  flock -x $test_fd
>  cat /proc/locks >> $seqres.full
>  
>  # Checking
>  grep -q ":$tf_inode " /proc/locks || echo "lock info not found"
>  
> +if [ -n "$move_proc" ]; then
> +	mount --move "$move_proc" /proc
> +fi
> +
>  # success, all done
>  status=0
>  echo "Silence is golden"

Urk. That explains the failure I've noticed but not had time to
debug from check-parallel when using a private pidns. Do you know
why /proc/locks in the overlaid mount does not show the locks taken
from within that namespace? Is that a bug in the namespace/lock
code?

Regardless, the code looks ok so with the helper renamed:

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
