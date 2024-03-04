Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34456127
	for <fstests@vger.kernel.org>; Mon,  4 Mar 2024 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709525957; cv=none; b=tX1xCau0vlv5KdVbTVuJdaXHwqu6uUCPSvKYUO6jJtIBGyTu26hn7KLqjYgLeIQRLrg1CZLvoXTNO+6XwES6uZOYhZJpqRtZYYCU+fm1dQoCi6Czh6s9mDW3Ny4KETTcmuEbDGYRc29QKntvxNx9GVoTMJhZuHJwqb/RMsDRu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709525957; c=relaxed/simple;
	bh=DhNX2oBh5LvaglMly1c227TPqgbAm6OlZGGBdTpZTlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPvQ3tiIwKyqkY/o48KQ7W2X8X1S8NBEZ8b45BqdRUknoaIrwWALJS/aNEYQwQDEgRXihnA5w4b8IRUtJsmsl9PsnNCUnVGhbICUFDoIrm2nKeucDsDh5ANnkKZ8IX1VUujd2/ZFZwv4sKvXcjxZ5jFu6UWoUNb49Fu5v9r8wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XG9BdXFW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XG9BdXFW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709525946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=reWP60JwLe3mjI4/UtFge8V8YORp/pKuRg/jb6euxrU=;
	b=XG9BdXFW0hKocBe+0b+75BrfF8/u5X/J2b5qkzdBnP1prozL/O5/lLjSFe9PrAi1Srb8b3
	iNVXETxXfFjXuJPNMkeNvh/hXZu17MBS1jjWOhGK5ng6kl1iFeBPSEK0bkCh7r9IjwErHY
	39rv6v7jsW9QCqG9A092NPIawhBPfaI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-NE-7Yag7M2-GsqhchMDFNA-1; Sun, 03 Mar 2024 23:19:04 -0500
X-MC-Unique: NE-7Yag7M2-GsqhchMDFNA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5e4a072ce28so3828626a12.0
        for <fstests@vger.kernel.org>; Sun, 03 Mar 2024 20:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709525924; x=1710130724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reWP60JwLe3mjI4/UtFge8V8YORp/pKuRg/jb6euxrU=;
        b=kaYPdbVgRVsthPHHTO1nCr2JhWv5TYEp1lD1sNzcriCgxIzUbeRPZtYaWQ918Kp2Vi
         o5Q81EsLxrARgwmOnyfAqzAUxK3bKZCuRSNZ2GWpGVUOvZAqp0HmDsFUSCxRWpnv/XJP
         yE9THuievHocU+CvZj4h2M8d3TdDlqkbZMZZI9wyhwi07k5PdpT4SqBj0UXvLFl0XUc6
         nMgQC7TUKcchf62/+k08GM0FLg+5bQ95jA/ehYlwsem2g36ZV18pE1AUfalSUR07dp5I
         GPUIeZoCuSebRRvlVCD3lGZJKGhtq3urEeuJb0KRj9DJhdA2oqyGZVN20tAcx+KcWENA
         GJUw==
X-Forwarded-Encrypted: i=1; AJvYcCXaFb/fIo/68jVSrNw0JjJymK8NapPG5+U3mle9olw4QOUuoJRLHmqO+zqNlW3PwP7tEE/YTb55v0TY2IUrKuzvizxAG40tnQ==
X-Gm-Message-State: AOJu0YztmOq+UoACDaa0S3WLvnOeDcHoviukzIja5UYCGD17xMzT50mv
	5+OTxBSk1ybBYipp93ZQJZ6u+4ppSZu7+MjQu/qLoM/aCf661DqSWp2/ViNsloTJSVeAnyWLBLl
	fBeNHnFK+CI0Gq46dHx8/lGnixiNJn5OQz9CFlX14qrReJJGoGF1ZaZM=
X-Received: by 2002:a05:6a20:3f8b:b0:1a0:e187:87c4 with SMTP id ay11-20020a056a203f8b00b001a0e18787c4mr8464754pzb.38.1709525924119;
        Sun, 03 Mar 2024 20:18:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFw6kGXTHd06Ze1+sTp8Fzar2DKwEC/69hcqGG9ZOFN3aJpjidInR/QKVKzr6rLvDf8d3PHg==
X-Received: by 2002:a05:6a20:3f8b:b0:1a0:e187:87c4 with SMTP id ay11-20020a056a203f8b00b001a0e18787c4mr8464740pzb.38.1709525923731;
        Sun, 03 Mar 2024 20:18:43 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001dcc7795524sm7523128pln.24.2024.03.03.20.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 20:18:43 -0800 (PST)
Date: Mon, 4 Mar 2024 12:18:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/121: allow snapshot with invalid qgroup
 to return error
Message-ID: <20240304041840.rfn6mhkk5a6mlxnf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240303065251.111868-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303065251.111868-1-wqu@suse.com>

On Sun, Mar 03, 2024 at 05:22:51PM +1030, Qu Wenruo wrote:
> [BUG]
> After incoming kernel commit "btrfs: qgroup: verify btrfs_qgroup_inherit
> parameter", test case btrfs/121 would fail like this:
> 
> btrfs/121 1s ... [failed, exit status 1]- output mismatch (see /xfstests/results//btrfs/121.out.bad)
>     --- tests/btrfs/121.out	2022-05-11 09:55:30.739999997 +0800
>     +++ /xfstests/results//btrfs/121.out.bad	2024-03-03 13:33:38.076666665 +0800
>     @@ -1,2 +1,3 @@
>      QA output created by 121
>     -Silence is golden
>     +failed: '/usr/bin/btrfs subvolume snapshot -i 1/10 /mnt/scratch /mnt/scratch/snap1'
>     +(see /xfstests/results//btrfs/121.full for details)
>     ...
>     (Run 'diff -u /xfstests/tests/btrfs/121.out /xfstests/results//btrfs/121.out.bad'  to see the entire diff)
> 
> [CAUSE]
> The incoming kernel commit would do early qgroups validation before
> subvolume/snapshot creation, and reject invalid qgroups immediately.
> 
> Meanwhile that test case itself still assume the ioctl would go on
> without any error, thus the new behavior would break the test case.
> 
> [FIX]
> Instead of relying on the snapshot creation ioctl return value, we just
> completely ignore the output of that snapshot creation.
> Then manually check if the fs is still read-write.
> 
> For different kernels (3 cases), they would lead to the following
> results:
> 
> - Older unpatched kernel
>   The filesystem would trigger a transaction abort (would be caught by
>   dmesg filter), and also fail the "touch" command.
> 
> - Older but patched kernel
>   The filesystem continues to create the snapshot, while still keeps the
>   fs read-write.
> 
> - Latest kernel with qgroup validation
>   The filesystem refuses to create the snapshot, while still keeps the
>   fs read-write.
> 
> Both "older but patched" and "latest" kernels would still pass the test
> case, even with different behaviors.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/121 | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/121 b/tests/btrfs/121
> index f4d54962..15a54274 100755
> --- a/tests/btrfs/121
> +++ b/tests/btrfs/121
> @@ -24,8 +24,14 @@ _require_scratch
>  _scratch_mkfs >/dev/null
>  _scratch_mount
>  _run_btrfs_util_prog quota enable $SCRATCH_MNT
> -# The qgroup '1/10' does not exist and should be silently ignored
> -_run_btrfs_util_prog subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1
> +# The qgroup '1/10' does not exist. The kernel should either gives an error
> +# (newer kernel with invalid qgroup detection) or ignore it (older kernel with
> +# above fix).
> +# Either way, we just ignore the output completely, and we will check if the fs
> +# is still RW later.

The explanation makes sense to me, just ask if you might want to output to .full
file, to save some information for debug if the test fails? I can help to change
the "&> /dev/null" to "&> $seqres.full" if you only need to change.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +$BTRFS_UTIL_PROG subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1 &> /dev/null
> +
> +touch $SCRATCH_MNT/foobar
>  
>  echo "Silence is golden"
>  
> -- 
> 2.42.0
> 
> 

