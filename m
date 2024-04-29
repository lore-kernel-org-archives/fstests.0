Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630962C69C
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398272; cv=none; b=nYe4J4mLWLwwAJnwUrJ8CU6JTPTQxudTfjdCVlDLY6XiPowEKukV/e8z7lFx2Nu3fzCk5dzRsK/N02P8IRcqkH9iEMtkAcNyRtX3qSllj4/ou9JTkJre3ATpYWASCqNSKCdRgPCNsWgrfP5M6JAaeqvOik2ejQ9fXisPxUqDvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398272; c=relaxed/simple;
	bh=Nv0lX6ap2XtpfJyH+agV7zfdkNEqT8GwGkgopVxrX38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHXXlNuqnyc/F+KD4Uc/n/kVFUVDcRhBYKOQqiOUs6oeltPbORkA4hKwsnJX5AqGAVWJ1E1kuWl9BZ7b01CEEFzovfQ5mWzUfzfUcnB4CBHkTs+nw9LrUbfG1Fqs9cKtDwpQcPCiIkdih1xaf8OFO5nbH71ykTN5tj3wXW+PgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JbttJcF7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JbttJcF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714398269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RYS5S3yWSwSHg0JzayvFZZSifnsRbbHjihQuyNgzyo0=;
	b=JbttJcF73zMC+hQy2Xw1DDB7usDXcm6DP/vrVvH3FytY1ThWVi80nFgv4+vsN3mYuuVExe
	5i7gdilcSOmagtzX+yAIpbzOo4E1e2pIJ3pCJ71KvOexX49hltrVMrxjY39qVw0Gv3p5S7
	Xt7IM6/o9oiyNdC8JpbUSw63pj/Fy14=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-EWY7MaAqOASaa2j8-Sc4fA-1; Mon, 29 Apr 2024 09:44:28 -0400
X-MC-Unique: EWY7MaAqOASaa2j8-Sc4fA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed0e1f8faeso4530391b3a.1
        for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 06:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398267; x=1715003067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYS5S3yWSwSHg0JzayvFZZSifnsRbbHjihQuyNgzyo0=;
        b=pjEgOofNpoLvhO0ySs0Nc0vBRYfOUw5BZyZGR3asvj+BpY1BhYrHeq7pZ9TDFGCgI2
         QPS57Zj/aV6ipn/kbuADeJlcD2F+sRv2pkNwC6mVFl+AB04fJ9A4rxfXWhpJkdNjWV3p
         MxWsX0j+VTLk90xa9LdnoejXBtzm66ob0B6XkHvKxiqA1WC0hJi5Ppw2OMfYiEYTUZdG
         o2hN7mOrJsv+zxvut4TP8u3APFal/ZcXCvUzRBSg3AYboMiLyDMA1GoA7ZoLRfAnQOZT
         tgyzkaVEJ5JETbsrDYgj24CoxeiMoJPepxLpai35bBOyZVr5G1hc5lB8RapC7repjFIR
         Zz4w==
X-Gm-Message-State: AOJu0Yy2l7TnpDonAvKYkVNoEX6jF+q9b2tvUeHfhZ5sOTPLSJLMb7U7
	odWJRmTyphy1RIZTnxFTR5WcwDHQvNq1Tfk900Y3yyeRLa1funxVRr6IF0pQa75JTrVicjeJE7O
	Zbym4OdXGZyiexXRHtIOIIyFjttGWsgrleErlsNXgPfAAZ3LQr85njkM=
X-Received: by 2002:a05:6a20:9155:b0:1ad:7e4f:9564 with SMTP id x21-20020a056a20915500b001ad7e4f9564mr15394928pzc.9.1714398266630;
        Mon, 29 Apr 2024 06:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXPoKoXw7Zt2YnDNDUOOIO3bdm0V13Jikt3pQY9oYgvmxuC2lvN1MH6UgotnHfxiQynhI4cw==
X-Received: by 2002:a05:6a20:9155:b0:1ad:7e4f:9564 with SMTP id x21-20020a056a20915500b001ad7e4f9564mr15394892pzc.9.1714398266066;
        Mon, 29 Apr 2024 06:44:26 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id lc16-20020a056a004f5000b006f09f711e4esm18668561pfb.151.2024.04.29.06.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:44:25 -0700 (PDT)
Date: Mon, 29 Apr 2024 21:44:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v2] tests: _fail on _scratch_mkfs_sized failure
Message-ID: <20240429134421.k7tzw2valf4bpyst@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240429115826.9171-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429115826.9171-1-ddiss@suse.de>

On Mon, Apr 29, 2024 at 09:58:27PM +1000, David Disseldorp wrote:
> If _scratch_mkfs_sized() fails, e.g. due to an FS not supporting the
> provided size, tests may subsequently mount and run atop a previously
> created (e.g. non-size-bound) filesystem.
> This can lead to difficult to debug failures, or for some -ENOSPC
> exercising tests, near infinite runtimes. Avoid this by renaming the
> current function to _try_scratch_mkfs_sized() and _fail in the parent
> _scratch_mkfs_sized() wrapper.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> ---
> Changes since v1:
> - call _fail in a wrapper function, instead of adding failure handlers
>   to individual test _scratch_mkfs_sized() callers.

As we call _fail in _scratch_mkfs_sized, so don't need to do _fail after mkfs
fails :

$ grep -rsn -A 1 _scratch_mkfs_sized tests/|grep -E "_fail "
tests/btrfs/007-47-             || _fail "size=$fsz mkfs failed"
tests/btrfs/007-74-             || _fail "size=$fsz mkfs failed"
tests/btrfs/004-161-            || _fail "size=$fsz mkfs failed"
tests/ext4/021:27:_scratch_mkfs_sized $fssize >> $seqres.full 2>&1 || _fail "mkfs failed"
tests/ext4/059-26-      >>$seqres.full 2>&1 || _fail "mkfs failed"
tests/generic/449-28-_scratch_mount || _fail "mount failed"
tests/generic/171:45:_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
tests/generic/172:43:_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
tests/generic/173:45:_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
tests/generic/174:46:_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
tests/generic/735:28:_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
tests/generic/015-35-    || _fail "mkfs failed"
tests/generic/077:53:_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
tests/generic/083-54-                   || _fail "size=$fsz mkfs failed"
tests/xfs/057-55-               _fail "mkfs failed"
tests/xfs/015:46:_scratch_mkfs_sized $((96 * 1024 * 1024)) > $tmp.mkfs.raw || _fail "mkfs failed"

> 
>  common/rc | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 56f1afb6..e95070dd 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -968,8 +968,8 @@ _small_fs_size_mb()
>  }
>  
>  # Create fs of certain size on scratch device
> -# _scratch_mkfs_sized <size in bytes> [optional blocksize]
> -_scratch_mkfs_sized()
> +# _try_scratch_mkfs_sized <size in bytes> [optional blocksize]
> +_try_scratch_mkfs_sized()
>  {
>  	local fssize=$1
>  	local blocksize=$2
> @@ -1111,6 +1111,11 @@ _scratch_mkfs_sized()
>  	esac
>  }
>  
> +_scratch_mkfs_sized()
> +{
> +	_try_scratch_mkfs_sized $* || _fail "_scratch_mkfs_sized failed"

How about printing the "size" arguments?

> +}
> +
>  # Emulate an N-data-disk stripe w/ various stripe units
>  # _scratch_mkfs_geom <sunit bytes> <swidth multiplier> [optional blocksize]
>  _scratch_mkfs_geom()
> -- 
> 2.35.3
> 
> 

