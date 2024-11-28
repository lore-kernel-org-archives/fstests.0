Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D351A7AD0
	for <fstests@vger.kernel.org>; Thu, 28 Nov 2024 13:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800475; cv=none; b=fvj88Qz1Ml905qe1hUv7Zc4b2FZnNGy9YqXQAwTYhki9c7iBCdC41/afo1zsk/iuq3heqOKSzXJ30HBHMPFbXQdWKWKxjRGdj4rQDRtp1nMPM6Cegf8me5YOmsDVT9YU3PFpwyCLQGX+0ncNdaDi+Yj4oZCnmsrsc97Z4ay/XLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800475; c=relaxed/simple;
	bh=0s+yPItt2IrnjpQXbpel93eG29xJ3JXukb8NY6yCfIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuijnrQJOxYEr5IQG1Cw/tn+i3eDuGSMkR4/l6993XnKCMJw5n+W5/86AkGy8d5jXwxSVdBmOS9//hfko1yflSf13358XFYKzZlNQCwzs0Rlkn486aqvfuuMWCxrtXegcJFgfVjQn1vgL8MVzDM1j1hJadCOfhPxWzLkdjz412g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHnk/0Z/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHnk/0Z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732800471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/iTZ4q6mzizq8FBezBiN/RuDqSjRE18Wk055DMNaJqk=;
	b=YHnk/0Z/g4lXvRvVd0GsCT21AJSkNDLUtY1v7KQ+GkaguGTFeGBaDkQ6YqPS7yU8oPPLkD
	2QDG3BxtpdsgjalqwwmzU1ePc6gFBIYb1wo+0Vv86US/GIKIC6BNCh/hqlBUVvQrr/Itx2
	0q+a9mZdESH0AVfhkJYGfZWi6M55e/Q=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-DomJPNGXPxOJY7mditYQcw-1; Thu, 28 Nov 2024 08:27:50 -0500
X-MC-Unique: DomJPNGXPxOJY7mditYQcw-1
X-Mimecast-MFC-AGG-ID: DomJPNGXPxOJY7mditYQcw
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7251424982fso919278b3a.0
        for <fstests@vger.kernel.org>; Thu, 28 Nov 2024 05:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800469; x=1733405269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iTZ4q6mzizq8FBezBiN/RuDqSjRE18Wk055DMNaJqk=;
        b=Lt+tHzicwhkQjgxiZZqCpnyx4pGRH/5sBcJvTqd1yiPFWFvp1rgUCpRsezlQ5zm/A6
         zLomAWY/WUAsyTJotKv2jTcEPyWbQ0wOOT6QYgnO0vsvqyFf1n+fz8m7/K9jsZJ9neNF
         Yk60BE8ogYwN3/Op2ROVkDfOF+TUnd5ZTIX7uRi2sz3Nriqvzhf94i0KdjaIZN79JHJQ
         cTNoeH0d3qbarql9stE7VAgN6jEv5UuTGkjZ02r0DXI2tUibz9ijlfNi/X591hR3x/Kj
         l9lxIRKy++aSPQ3TiVkeeZ0IekfMZ1UXPzUQdxcdZKBoA3u6t5Ws8lc59K3OWFePDa0R
         kYsg==
X-Gm-Message-State: AOJu0YzZmfTKfNaUtrzBzHD9BR7vXv8T6jg8btavum5gCJkXi+e5J1Ru
	OYceY26+dctrRwVywJkABY48aDYG7sthL/04e3Wi3leCXAIXZCPvjofCb7czlNG+DpOD6vx4Prk
	LgnOXD2yNBWkpioa/KjzkOFAsDd9GjDgl72515mMekk71DoXfn+Ctf/Gh5Mgnvfe9GQ==
X-Gm-Gg: ASbGnctg10aZ3t9aGD5z8rtuPih55I1KpMNOVAZzpADn2j3b6LUVu++0hwcwdUZI2tm
	EABQfB2LTMEYPIrHB55uKcUOUrJumxjVOcZv1+6/l+k/IEDhgEjBZI2dtdKvP/dPVIRZu5ywoch
	CEvR/uFA1YjJApPAcKwuYmLAnzs9Yw7UVigulkvNVeuPASsrU3PJviPNypbYejPXbpuHAqJzsCm
	2PVG4+KE1wgAHnafK2PbE0j4ZnlGXuhc4B2BM3MURJWgokcoKeHaaFkePPpZN9zV+0P4eY4GbZ5
	La8VyfBwZ4yRBJw=
X-Received: by 2002:aa7:88c3:0:b0:724:5815:62c1 with SMTP id d2e1a72fcca58-72530133103mr10355858b3a.19.1732800469032;
        Thu, 28 Nov 2024 05:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvxPzHHwe3CTbSVYUKhipTOHl9LrWX8JcWHdp6FLY3nKR68fErJvX10PPr4XgWQ3xD6wEocg==
X-Received: by 2002:aa7:88c3:0:b0:724:5815:62c1 with SMTP id d2e1a72fcca58-72530133103mr10355835b3a.19.1732800468655;
        Thu, 28 Nov 2024 05:27:48 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbab6sm1528891b3a.106.2024.11.28.05.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:27:48 -0800 (PST)
Date: Thu, 28 Nov 2024 21:27:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/028: kill lingering processes when test is
 interrupted
Message-ID: <20241128132744.n4mryf5cw2bqojuy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

Good to me, I think I can help to unset balance_pid and fsstress_pid
if these processes have been killed before doing _cleanup.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/028 | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
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
> +		_btrfs_kill_stress_balance_pid $balance_pid
> +	fi
> +	if [ ! -z "$fsstress_pid" ]; then
> +		kill $fsstress_pid &> /dev/null
> +		wait $fsstress_pid &> /dev/null
> +	fi
> +}
> +
>  . ./common/filter
>  
>  _require_scratch
> -- 
> 2.45.2
> 
> 

