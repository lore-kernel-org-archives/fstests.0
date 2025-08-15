Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE92FD7AB
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 15:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273258; cv=none; b=KfPhkrbUUSCTyeOpuHn/2834wZaffUGOibahHqT8omgqcAOr6m5gG8RyZyCqwmd6v+ZMyD4RsY3RCDF0eQwttJU5wNdXVrQhvR/VtI8Az/tjP2OHxys8nWMlXSQkFNcHdg81ygYVl28i3MiuS19zRbKH83s+R4f62QzgD1a5cxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273258; c=relaxed/simple;
	bh=NY8B1Z9FddZAzaCt8GE9tuaN9ny8asX0WuzemETSTRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyzGZ+pXSsfTYN5u9G08kfzSCih/HCymmf+5rJNlv9EEKvACNTr+Fg0PLGmg5LzQkOp32jWwLxOS97Fh1BvGeUM689XyJWUmBJZJ+JcLH1O2Q3aGXj6FAwn9CV+zoxXhlQyyLtjJDDzSG4wOSZtxFdinKARAfwQkEMbVkknGBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LKuikM8C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKuikM8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755273255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NRaMgkMEgLgN4mQUMby7xLO7l22leF6759j8hvQ68v0=;
	b=LKuikM8CH8dZ3g92fKiz9XFu73NHsLVGsg3RDiD8Yig5Q1L0NU72E9s3GNip2CDXQJc8dO
	Sdpumf/OsJSoQ0ee6Sg0hLgbGxk1GOdjOteUa/pY9AgGs3QBE+vTJHwL+grQS06LLuG4a5
	vfelkHaVmLZR4QbJ9jamwp4TN4dLlyE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-LaW-xP-3ORSD-wOr8S5tCw-1; Fri, 15 Aug 2025 11:54:14 -0400
X-MC-Unique: LaW-xP-3ORSD-wOr8S5tCw-1
X-Mimecast-MFC-AGG-ID: LaW-xP-3ORSD-wOr8S5tCw_1755273253
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e1ff27cfaso2706603b3a.1
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 08:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755273253; x=1755878053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRaMgkMEgLgN4mQUMby7xLO7l22leF6759j8hvQ68v0=;
        b=JaZl0sXUnUFeE8aEoSqXyYOh7bysfu5n8d/Ypaz0CB8oKNefeZZbL3aY2hBVSyhfli
         wQaxLG1fGehCFwdpRagxAdEKNXY6kKUJRgLJKSUS2WOPP016mGlXgY4pfocJLlUrV07r
         Q31z48eKYM55n9bJA8yxCYNZfU+Y3m00LNM923fWEdNRJ6PJuGQdaadqyWC3W6OO6yPF
         yO+m5OkCq9SgkDjgHOuH9qZvPIvtMDkd32OHkPT/ltYC1AS9LkZhbd9d05DcsEXTwm9F
         dq0mjTSTBMRsm3PAKqpnYGfzXJZw4XRqPHN1FIOljP5rJY+DXYcqq/hMlrwN+rkepFFm
         VDBw==
X-Forwarded-Encrypted: i=1; AJvYcCUQdM1XirI2SMU8IJ/gdPZK/jT+u9ovKnncKO67kzdDoW05kplzyZoEF2ei5q1wgS6PDtxeinI3@vger.kernel.org
X-Gm-Message-State: AOJu0YybDdG1EXYG/SE4vw1/2QE9vMwQO6UActcwPW9OsSCt0pdh6Pmy
	fw89TL781fTx8qWH52TJ2+n+lDEOKyX0UZz4/9GfFVYh2m2F8EX7b5VwxNL1HKL5V/NjsLFLmLS
	P2meh2B7vm7j9gn4wLLc+B8RBnAoGK/sBLrJ2noOEngCNPkC82tTevFGXWrI=
X-Gm-Gg: ASbGncsZ7+hfZqNIRW97ys3wPfscXmOtSu2h8qfaVwgqFmKydVuYEDEN12KqjCZW9o6
	yUAicEwHsssaZhYaYFAzg4+4fQpVOuqBHWYdOeugaZ3NjLsoDrH+Noi9Bxx3gtRbOZyy/b9ONSG
	nmDxo+aHlI8+rGs9HNPDYR9F8BmpI9demNq5zKufGeujK26VSJPTukblAOTKO9Wd7HLbwh9iBEb
	IM5nlNT5k0TYeZYXVGGvkfq8YCvWHcipJCGwKqvJ/CcqPbzMp8BOT3K8HdD8e4glDQyoLh1DC9l
	l7J3nN+EdJ27GpQOuBSYppiTw0ketlTQPqAjCXo5FCnWEtXX+avgpVK9g8wYT8tZLARQvKEeCFb
	yLvid
X-Received: by 2002:a05:6a00:2344:b0:76b:cc37:d4c5 with SMTP id d2e1a72fcca58-76e43830aebmr4116954b3a.5.1755273253373;
        Fri, 15 Aug 2025 08:54:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVyz6fnoqKB51muPU4YuSBCAeUdAuoOcJyxwicsXPL6yhVmU/S9648a/DV3cU8AIDA8Bd9Uw==
X-Received: by 2002:a05:6a00:2344:b0:76b:cc37:d4c5 with SMTP id d2e1a72fcca58-76e43830aebmr4116930b3a.5.1755273252964;
        Fri, 15 Aug 2025 08:54:12 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45292dc1sm1394626b3a.50.2025.08.15.08.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:54:12 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:54:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Daniel Lee <chullee@google.com>
Subject: Re: [PATCH] f2fs/012: adapt lookup_mode=x mount option
Message-ID: <20250815155408.ja527chpfrjtcuau@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250808065803.17298-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808065803.17298-1-chao@kernel.org>

On Fri, Aug 08, 2025 at 02:58:03PM +0800, Chao Yu wrote:
> w/ below change [1], f2fs will enable lookup_mode=perf by default, it
> will change f2fs dirent lookup method from linear based lookup to hash
> based lookup.
> 
> So that, f2fs will ignore sb.s_encoding_flags by default, which is not
> compatible w/ f2fs/012 testcase, in where it will control lookup method
> by configuring this flag w/ fsck.f2fs.
> 
> To avoid failure of f2fs/012, let's check whether f2fs has supported
> "lookup_mode=auto" mount option, mount w/ the option if it can,
> otherwise, don't.
> 
> [1] https://lore.kernel.org/linux-f2fs-devel/20250805065228.1473089-1-chullee@google.com
> 
> Cc: Daniel Lee <chullee@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

With this patch, I always get below error:

f2fs/012 2s ... - output mismatch (see /root/git/xfstests/results//f2fs/012.out.bad)
    --- tests/f2fs/012.out      2025-07-21 13:33:12.379585206 +0800
    +++ /root/git/xfstests/results//f2fs/012.out.bad    2025-08-15 23:51:54.156835560 +0800
    @@ -1,2 +1,4 @@
     QA output created by 012
    +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/sda6, missing codepage or helper program, or other error.
    +       dmesg(1) may have more information after failed mount system call.
     Silence is golden
    ...
    (Run 'diff -u /root/git/xfstests/tests/f2fs/012.out /root/git/xfstests/results//f2fs/012.out.bad'  to see the entire diff)

Then test passed without this patch:

f2fs/012 2s ...  3s
Ran: f2fs/012
Passed all 1 tests


>  tests/f2fs/012 | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/f2fs/012 b/tests/f2fs/012
> index b3df9a8f..15fc8f0c 100755
> --- a/tests/f2fs/012
> +++ b/tests/f2fs/012
> @@ -22,6 +22,15 @@ _require_scratch_nocheck
>  _require_command "$F2FS_IO_PROG" f2fs_io
>  _require_command "$F2FS_INJECT_PROG" inject.f2fs
>  
> +#check whether f2fs supports "lookup_mode=x" mount option
> +mntopt=""
> +_scratch_mkfs -O casefold -C utf8 >> $seqres.full
> +_try_scratch_mount "-o lookup_mode=auto"
> +if [ $? == 0 ]; then
> +	mntopt="-o lookup_mode=auto"
> +	_scratch_unmount
> +fi
> +
>  check_lookup()
>  {
>  	local nolinear_lookup=$1
> @@ -30,7 +39,7 @@ check_lookup()
>  	local redheart=$dir/$'\u2764\ufe0f'
>  
>  	_scratch_mkfs -O casefold -C utf8 >> $seqres.full
> -	_scratch_mount
> +	_scratch_mount $mntopt
>  
>  	mkdir $dir
>  	$F2FS_IO_PROG setflags casefold $dir >> $seqres.full
> @@ -52,7 +61,7 @@ check_lookup()
>  
>  	$F2FS_INJECT_PROG --dent --mb d_hash --nid $ino --val 0x9a2ea068 $SCRATCH_DEV >> $seqres.full
>  
> -	_scratch_mount
> +	_scratch_mount $mntopt
>  	if [ $nolinear_lookup == "1" ]; then
>  		[ -f $redheart ] && _fail "red heart file should not exist"
>  	else
> -- 
> 2.40.1
> 

