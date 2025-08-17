Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B522068B
	for <fstests@vger.kernel.org>; Sun, 17 Aug 2025 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755420202; cv=none; b=DKssmWxBdmaScAuWXHfn1GMQhhw4Em8oPf0v/cFt7S1Y1/DVE92kYluRYxCgxXeJd0K+0NCTPd6c05nGkKqSoX0d88nleT66OR8fD3Ay+9xYCgmpgQmbc7T/gA1OHE/ExNYVX3GKAqbIEnW5Wjmm8nTSEJfeEztm6WklodGdi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755420202; c=relaxed/simple;
	bh=DqZWB0lltSj1U2F7ndykkiIRB65hhUDWTC9fkGUmwGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObD4iCWDdWWpk9WbrJV3ok//a2i5BTIKfgyMxJABUZFcpdRGeNvpLm2ieA/8jIPJaQ/yY+HiyhzoIBMOpwsPzFiUgW5HWA9EBov6gGDVzFwnKnXAX2/ylCiENN/xM/L6mwvhqqyqjp/LTKqCGfNw8HDLy9Hj3mZ+G10fO7LpwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=glD3vMf9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="glD3vMf9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755420200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq4YXS+xac1WFQmsLw/7/5+gnl0xUJ4PHyPQ6ACSu3g=;
	b=glD3vMf9fyrnhqh584Maso2fooBdvSvFWVICygP7os6SpxGF6eftP7iIdNCUa+R5W4X1Mj
	0ZjSDLBOfkON3pDv1AqtuSJtJgK3wWXu9wO2qNqvtBsxfXK68CqeON2ejLJP/hf5uTxmoF
	N8nUq/HlwyZEAK1iFHXCJpi88vJwrVs=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-ALOGQlGCN5Wa_b9fSTPTCw-1; Sun, 17 Aug 2025 04:43:18 -0400
X-MC-Unique: ALOGQlGCN5Wa_b9fSTPTCw-1
X-Mimecast-MFC-AGG-ID: ALOGQlGCN5Wa_b9fSTPTCw_1755420197
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4738634fc6so1136548a12.1
        for <fstests@vger.kernel.org>; Sun, 17 Aug 2025 01:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755420197; x=1756024997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rq4YXS+xac1WFQmsLw/7/5+gnl0xUJ4PHyPQ6ACSu3g=;
        b=mjwIkV9aNHuYnHkbqvnHvYv+AmQNW6hz9BBFe/IM71NULrOseu0KeAq0Ovl8C3+Ibp
         WkLZT87wGRhlxZo6SrWA3oPAkjUXFb/+TvCYrSGmfDVQG75ZgF+dcZxdLvTNhp/gUX9I
         inX/P5SjM7VZ+vMCh85PhMfFe++KiilKtPKG4HWKbd9EFRcsmqjO1/4wM1z/OLGHYPN+
         3SOIWOt0cBzZ7l3Y/bkZcLx9brKSijYEWtWPKmAQ/45FfCFGc8vCe8Di3kDLW7Aw/vXe
         raz5bMNgGOm0F9sRdACQWoGEN6T2IUaS5BHW+w8GTZOCX7+vQJuzJTCePnASdzClJevg
         WepQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEKtIaMbYeeum6PnFJZgYAZm2uAwOKgMXoLAQgywS4km+bdBpfpvEP9Y7HkikrIA31d46sqqhS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3A1XdlbBgIIONsFaWm4QGa9Z7suYaWimzzn+2lgz2GLKBNESo
	ZDzGAmfxm00K+rXdPN7luOLpMV3YKw0hYZys7jhDFcdzUVfqAWFQFbGtaM/s4HH0p/4qGXeu+ze
	gwDigifBM2Zgjf46NMCQe9ZCznHXNIcLHHbQ/wVBQd6MomkP7M/Cq26SvP8w=
X-Gm-Gg: ASbGncvQDUr+K2tjVYEpA9wHTkPSSWxtLTs/ePO7pMmOUzn1yjjcpzcXw2H4Wdl3nuw
	kf/MnH3ZWH7HOhMJBKE52B32mugPxEdYxWxfCF3svh+cIzxCeu+7OCLf8d/5K6OpvRoKYzkJatx
	q745lV9v3HjHY5W4BELBnGkYypibGuuL7GlGq8g3L1MwZnRPQdSfTM+qgmBcLprP0u2xBBRWweV
	dXyzNc+yJaU3aO8JWfpqsy8bzXyasa0tl+zzxxZ6racrDZLHsmMJbBDp4576Enj2X67JMPZEmaM
	j6f9OgdT1bs0R07T4dhmdFIR75KhM9eUvUTQs5QCKovEz6lg1u43Ejcmk+1isVp/mCj58RTk6Ix
	qyYxC
X-Received: by 2002:a17:902:d2ce:b0:235:eb8d:7fff with SMTP id d9443c01a7336-2446d8b1f83mr105604755ad.28.1755420196958;
        Sun, 17 Aug 2025 01:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeaLv3g8gcs36btGxPw09l7seNqjMeEa5e2kr7eFsSqwAraKtWBfVi3Ptpl9SpasTZy3uA9Q==
X-Received: by 2002:a17:902:d2ce:b0:235:eb8d:7fff with SMTP id d9443c01a7336-2446d8b1f83mr105604595ad.28.1755420196618;
        Sun, 17 Aug 2025 01:43:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54fb54sm50570015ad.134.2025.08.17.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 01:43:16 -0700 (PDT)
Date: Sun, 17 Aug 2025 16:43:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Daniel Lee <chullee@google.com>
Subject: Re: [PATCH v2] f2fs/012: adapt lookup_mode=x mount option
Message-ID: <20250817084311.txrzrcgqnm7g7spj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250816072909.2844349-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816072909.2844349-1-chao@kernel.org>

On Sat, Aug 16, 2025 at 03:29:09PM +0800, Chao Yu wrote:
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
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daniel Lee <chullee@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - ignore error from _try_scratch_mount "-o lookup_mode=auto"

This version looks good to me, thanks for fixing it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/012 | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/f2fs/012 b/tests/f2fs/012
> index b3df9a8f..7438d9ce 100755
> --- a/tests/f2fs/012
> +++ b/tests/f2fs/012
> @@ -22,6 +22,15 @@ _require_scratch_nocheck
>  _require_command "$F2FS_IO_PROG" f2fs_io
>  _require_command "$F2FS_INJECT_PROG" inject.f2fs
>  
> +#check whether f2fs supports "lookup_mode=x" mount option
> +mntopt=""
> +_scratch_mkfs -O casefold -C utf8 >> $seqres.full
> +_try_scratch_mount "-o lookup_mode=auto" >> $seqres.full 2>&1
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
> 2.49.0
> 

