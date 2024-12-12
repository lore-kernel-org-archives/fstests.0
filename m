Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779418643
	for <fstests@vger.kernel.org>; Thu, 12 Dec 2024 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733970668; cv=none; b=i+0pL6rbFb8TZGxPO+k5ixURJulckNSq/iCupKpK1NmSUAjaDsKyM0k3rZzTxNM4fHvwB7rUL+iuXdH1p3+lGxfPo5bFNAtryi6LOZXZLWZxUztQCl+RHa7w5Of7/ut3S7uepskjLEQt9xt/YTz7TPqr26SXi5lizBontwFIVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733970668; c=relaxed/simple;
	bh=L1BVMb1C/FS7GoiWz8CxjSZNukhHSQUput/cvQVf64E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/9qnxuq/B4l1GVw90YyKIk7zflK8XiFsPGMMuBk+5wbcAadxyoNwUMIJVrW5OjhCYXxhj+Cp7ppXV/d/auRUq/gVS5E2xV/fybxHgHrSWHX5JesrjC48HsJ9KUrFvySSs0NdBSAuGRH8n/QLfwh+INxDatUkFS9CDGxipHrP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=wW44TnBP; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="wW44TnBP"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fbd9be84bdso156501a12.1
        for <fstests@vger.kernel.org>; Wed, 11 Dec 2024 18:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1733970666; x=1734575466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYXR2B2j1+gf6sNrF7M5invgEFBbpf0YZ82gTY7L5us=;
        b=wW44TnBPdIyKNNiV8WCYJDltsQzu6u2INdlWsl/su2Bb07ihN85gkjFUE4PrrHqYr2
         8MsToJiRH/uIuzx6kisVq7CbZXGlMdtZNQmONNnenv6vhOgmal+rPReXyom8QvePbHqA
         5rScRe/DIm7icvfMXjJqHSUCd2JDW7oosUwMmgCNFXsHHgiOPyWcarnXVGzx+xEEVpy7
         N8EDrZj+888AkRAqtFxqo+kOOB1STuTyeB64O+lP7VPtp/q9RG/+cvtr1apRTfjP2PGO
         sjpo1QvzAzAE7OVFc2dv4BpiGAO6aF3P86+pHuavY4Zl8A48sCF/7DvDDWEULS2ur+xK
         /XBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733970666; x=1734575466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYXR2B2j1+gf6sNrF7M5invgEFBbpf0YZ82gTY7L5us=;
        b=NEeTBFkV3HHOJILPVbguBQM5FR6AYKWLzJkzGrXSnP08ZK/YaEZ/iwLFV7SIM8xiAl
         aZVOkszvR2GUdL6MW92NyVcr+2SJrqUZ9zZ9uelO6x3whtKj2hLbt7ZpenXKmdp2qFXK
         /J3cX5kEyeOqdqdEwIBfrv41aQooIojUj22huBKoJcK98f9B++Hv65gFxf8/9vJtfQAy
         /uzkdGS6e19rGcfxC5WVARYunX16ACUwZGjcR5orWP6SppI48/G0A0n9J0go7lyx9lYF
         p+Dd5MSkTbmA2w3cT3JegG6RGUhsclRVcaZUU63/ENY30olYB0UAG5FGeUR8tE6BVaHR
         4v8w==
X-Gm-Message-State: AOJu0YzDm2ZUiBt4Zt0s9La/wOXsvxATbi1E25Nn/VlEk5o81bIhHoNo
	OFw1zuXkOtv2gXPN9eeLyxLlzG8O9lEPiDMhHcZjUISudwNaVSo8KLyrgnhm5uA=
X-Gm-Gg: ASbGncuE2BeAluAsgiP/GTgHjGz/G7Mmi1pMucVfD6j71bcSMql6WHfgdXO+vfzSzvm
	7gC0ogVibwOkNhNxEJjLxTGwgvP8u4VFt+YBpINWErHnGrxFqpZ37SAeM6tCbJ/zLSDLkA7WhH8
	47qMNdQml0Pft4g14aO913F1SGbQ3TvPbjmvBJITVXqNUAmjY8r/eEmcFGikiVdpH/81R2O/5Wk
	z4NKsWX5+QEMXargyClKhvS8PxHrSbv0vmE5Tet0k7+jEAe/PW47axt8ZjsH+Edt9T6elykEhDB
	QTG2kIp7VcKvkZdoSjojv43cgrCaBg==
X-Google-Smtp-Source: AGHT+IFmE6fIbUK6tb9WC2d5dwwoPe/m0dx75q5uvLxSBOmGEh+xNmpX1coZJV5HjHsKqkJ3yyKawQ==
X-Received: by 2002:a05:6a20:6a25:b0:1e1:bdae:e045 with SMTP id adf61e73a8af0-1e1ceaed5f0mr2296464637.23.1733970666099;
        Wed, 11 Dec 2024 18:31:06 -0800 (PST)
Received: from dread.disaster.area (pa49-195-9-235.pa.nsw.optusnet.com.au. [49.195.9.235])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ef484c1fsm5955828b3a.75.2024.12.11.18.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 18:31:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tLYyk-00000009dWd-3KfF;
	Thu, 12 Dec 2024 13:31:02 +1100
Date: Thu, 12 Dec 2024 13:31:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	dchinner@redhat.com, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: fix argument passing to _run_fsstress and
 _run_fsstress_bg
Message-ID: <Z1pK5j6A5aJJdilC@dread.disaster.area>
References: <51ccb57553e069946bec983ded52a75640d4fef5.1733851879.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ccb57553e069946bec983ded52a75640d4fef5.1733851879.git.fdmanana@suse.com>

On Tue, Dec 10, 2024 at 05:32:54PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit 8973af00ec21 ("fstests: cleanup fsstress process management")
> test cases btrfs/007 and btrfs/284 started to fail. For example:
> 
>   $ ./check btrfs/007
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc1-btrfs-next-181+ #1 SMP PREEMPT_DYNAMIC Tue Dec  3 13:03:23 WET 2024
>   MKFS_OPTIONS  -- /dev/sdc
>   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>   btrfs/007 1s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad)
>       --- tests/btrfs/007.out	2020-06-10 19:29:03.810518987 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad	2024-12-10 16:09:56.345937619 +0000
>       @@ -1,3 +1,4 @@
>        QA output created by 007
>        *** test send / receive
>       -*** done
>       +failed: '2097152000 200'
>       +(see /home/fdmanana/git/hub/xfstests/results//btrfs/007.full for details)
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/007.out /home/fdmanana/git/hub/xfstests/results//btrfs/007.out.bad'  to see the entire diff)
>   Ran: btrfs/007
> 
> The problem comes from _run_fsstress and _run_fsstress_bg using $*, which
> splits the string argument for the -x command used by btrfs/007, so that
> fsstress gets the argument for -x as simply:
> 
>    "btrfs"
> 
> Instead of:
> 
>    "btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base"
> 
> Fix this by using "$@" instead of $*.
> 
> Fixes: 8973af00ec21 ("fstests: cleanup fsstress process management")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 1b2e4508..f4fff59b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -78,13 +78,13 @@ _kill_fsstress()
>  _run_fsstress_bg()
>  {
>  	cp -f $FSSTRESS_PROG $_FSSTRESS_PROG
> -	$_FSSTRESS_PROG $FSSTRESS_AVOID $* >> $seqres.full 2>&1 &
> +	$_FSSTRESS_PROG $FSSTRESS_AVOID "$@" >> $seqres.full 2>&1 &
>  	_FSSTRESS_PID=$!
>  }
>  
>  _run_fsstress()
>  {
> -	_run_fsstress_bg $*
> +	_run_fsstress_bg "$@"
>  	_wait_for_fsstress
>  	return $?
>  }

Looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
