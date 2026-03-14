Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59093033C0
	for <fstests@vger.kernel.org>; Sat, 14 Mar 2026 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773520690; cv=none; b=tBkw0aiXuBqMl7QatEFxn1/k9vN/3FDPFLcBtL/dqxOqzSYXs+Qvq4VlTH72QV8DWzzZ7qAjGP5h/Z76PXJTGXc887bBz9XSD7qcDZq8/kegyyW/sLkOWlbvewjDkrobFWTaYxm7tcONwhikofXICCsWSefsvpxGNUpT2zXB//4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773520690; c=relaxed/simple;
	bh=3jsGC0oW8+Vhx/E9RzCl0LIHAoux9bsXXiQzRkWMAaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0HzCvmmC5dEC7hm5H1l+lETushI7hcz9b+yq4q2Sau6x8Khg9eD7g37d2DuhHT/JeOBpMqiIE3w/sna+daxM8ikcOVzSW9yXM9vUlgBHPwDDbWG8p2t/4whPDuGmy3oCCVs0CcRXLhLg9WYroOL1xfirjPdS6MPrdqQSxE6wn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y240C2QQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4S7TYGS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y240C2QQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4S7TYGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773520687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5kLm1ltD9Bl0VYZ370BXyzemIFUkmOHX1fkgy/6TVew=;
	b=Y240C2QQz6T/5gTSphytRIczzOi+Rz64EfaL+GzPXBYm+L1HhGmMOrcWumXoNgzkcMO9wy
	Yz9ENvHr48ec0nom71wqOB231zn1D9mH2VcZVBM6MeyvHEX8W+avH1UoJlbiBMXNsPF6bI
	4zqaPxN+Jam+wboeDmfgYebG4uoCQ/U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-pLsjqsoGMtGuvrK3SO38Yg-1; Sat, 14 Mar 2026 16:38:06 -0400
X-MC-Unique: pLsjqsoGMtGuvrK3SO38Yg-1
X-Mimecast-MFC-AGG-ID: pLsjqsoGMtGuvrK3SO38Yg_1773520685
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35a032cdd78so15745797a91.1
        for <fstests@vger.kernel.org>; Sat, 14 Mar 2026 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773520685; x=1774125485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5kLm1ltD9Bl0VYZ370BXyzemIFUkmOHX1fkgy/6TVew=;
        b=X4S7TYGSh6nrcy4pUWMe080Hg8mJkufpeDEKJUhKSrihvDPqZJfhB6Mmw50xyeD+va
         /8Vie5CaahR+jlmwVfRBJiN9MGBC1BmEdgg/zG4vDzeN7DjhoAvOZun139xA8elE3rpk
         9GnsDcTsyd/uYLEBAyfVPf64xwpxU61uk1YXJgNfkMEC9NKdBVKu06BnYd5vRLpz3XcW
         GDUl/JQbLAe1uo+fK4YBNS+Qn/b1yZQaqlIHZrLHN7MtUI5bzghPBVUXRui8GynY+0Uo
         tEVsvDhJb2yT1Q8iN9DO3atgjVu8bN3ygDWey1Sp+2gDSzVStvszNzPFl7YVyEQUr8IW
         lOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773520685; x=1774125485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kLm1ltD9Bl0VYZ370BXyzemIFUkmOHX1fkgy/6TVew=;
        b=c85Ou0km/m11TvyafcdIZ1b4+9BF4NreOrWDD5sIpaecLq8l+4F5avF0+BD2op73tC
         wHfDhgff4/KA8pgt9xYI0bgvevWCeYwabPDBaFp59Hci6iPwhXLZA4+4T3KZbDCFMtvH
         YE2PfGydwIMpLyHsfkf5v/pDpic53C6qfUy2Wwcse4kg2YGAxj7VZEazS+PGDV2XaXwL
         lRyexx4iGVMHzCrPfFz7LrtLbtgHeHgqUCbLK8ossc1GmrX1iIkNjeI3fmRG0G9x0E/N
         GMoPbtB9ssoIx8l8WjWvbj9BMWwLWMKzBDjz6zcBpt3qnp0Va0aMeOWyQ+AOFeTQTf1D
         2zRQ==
X-Gm-Message-State: AOJu0YzIqW4OqUf4v8KOHMzbZ9wU02epVBIHrwri+87qXA73wySU8L1H
	i9lwLWp6Oy+0elt9Ljy5wkJQye4ve9zRPqO3qIh6CbUE8r9qp0O9/5kqBsEUaDzKEaXFd8bJ1x6
	DwDRwqbtEJ5XN+GWC/MsSvhzPK9OtisFadItV9LJDqsfDXkrIS0Aqrvqp+QA=
X-Gm-Gg: ATEYQzzMeQ3iNXBlh+BbBzCHXeMv7WvACirF+m118DZ91KtjPPvS79iPYktqI2KiY1I
	TxQAGDLhs/OlKIIYzRUXL38ick63FesYswUOd3VZegGtubo1kQDQ1JdN5rrDBTE2FVYW7VW8G57
	3eEiTLM9iygJtzHyUYq2Wx01tcSLkOkf46zYQGiAHppm0ap2QZtlck6gUc58G9/epclJayzRZYu
	C9J9VJZMouQNzgpa+/xUFkX70lGU65SlnuCceSzGyr8rhhehVGbUyAbcla8Sn8dk0H9QJPiKuY9
	sFdh4XeYECMJAiAjCdh1AiY7tZa3X4JKlLNPJXUjR/dHKhgVHkyKkGmTBKRt5UBP5UPkqBymVN5
	5mLkEi81UtuQiAHEHqQ==
X-Received: by 2002:a17:90b:4b09:b0:35a:1ad9:c641 with SMTP id 98e67ed59e1d1-35a220a9dcamr6293092a91.31.1773520684837;
        Sat, 14 Mar 2026 13:38:04 -0700 (PDT)
X-Received: by 2002:a17:90b:4b09:b0:35a:1ad9:c641 with SMTP id 98e67ed59e1d1-35a220a9dcamr6293088a91.31.1773520684457;
        Sat, 14 Mar 2026 13:38:04 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b929558d1sm429634a91.4.2026.03.14.13.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:38:03 -0700 (PDT)
Date: Sun, 15 Mar 2026 04:37:59 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 04/14] xfs: set up common code for testing xfs_healer
Message-ID: <20260314203759.nbt523d7dyuhr6um@doltdoltdolt>
References: <177311403712.1186408.7032564474004561606.stgit@frogsfrogsfrogs>
 <177311403849.1186408.3223809492518597284.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177311403849.1186408.3223809492518597284.stgit@frogsfrogsfrogs>

On Mon, Mar 09, 2026 at 08:51:10PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a bunch of common code so that we can test the xfs_healer daemon.
> Most of the changes here are to make it easier to manage the systemd
> service units for xfs_healer and xfs_scrub.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  common/config  |   14 ++++++++
>  common/rc      |    5 +++
>  common/systemd |   39 ++++++++++++++++++++++
>  common/xfs     |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/802  |    4 +-
>  5 files changed, 158 insertions(+), 2 deletions(-)
> 

[snip]

> +# Compute the xfs_scrub systemd service instance name for a given path.  This
> +# is tricky because xfs_scrub only gained --svcname when xfs_healer was made.
> +_xfs_scrub_svcname()
> +{
> +	local ret
> +
> +	if ret="$($XFS_SCRUB_PROG --svcname "$@")"; then

Better to be:

-       if ret="$($XFS_SCRUB_PROG --svcname "$@")"; then
+       if ret="$($XFS_SCRUB_PROG --svcname "$@" 2>/dev/null)"; then

Or below xfs/802 will ...

> +		echo "$ret"
> +		return 0
> +	fi

[snip]

> diff --git a/tests/xfs/802 b/tests/xfs/802
> index fc4767acb66a55..18312b15b645bd 100755
> --- a/tests/xfs/802
> +++ b/tests/xfs/802
> @@ -105,8 +105,8 @@ run_scrub_service() {
>  }
>  
>  echo "Scrub Scratch FS"
> -scratch_path=$(systemd-escape --path "$SCRATCH_MNT")
> -run_scrub_service xfs_scrub@$scratch_path
> +svc="$(_xfs_scrub_svcname "$SCRATCH_MNT")"

... fails on old xfsprogs as:

  --- /dev/fd/63	2026-03-13 19:16:15.217899866 -0400
  +++ xfs/802.out.bad	2026-03-13 19:16:15.191834546 -0400
  @@ -1,5 +1,21 @@
   QA output created by 802
   Format and populate
   Scrub Scratch FS
  +/usr/sbin/xfs_scrub: invalid option -- '-'
  +Usage: xfs_scrub [OPTIONS] mountpoint
  +
  +Options:
  +  -a count     Stop after this many errors are found.
  +  -b           Background mode.
  +  -C fd        Print progress information to this fd.
  +  -e behavior  What to do if errors are found.
  +  -k           Do not FITRIM the free space.
  +  -m path      Path to /etc/mtab.
  +  -n           Dry run.  Do not modify anything.
  +  -p           Only optimize, do not fix corruptions.
  +  -T           Display timing/usage information.
  +  -v           Verbose output.
  +  -V           Print version.
  +  -x           Scrub file data too.
   Scrub Everything
   Scrub Done

If you don't have more suggestion, I'll help to change that :)

Thanks,
Zorro

> +run_scrub_service "$svc"
>  find_scrub_trace "$SCRATCH_MNT"
>  
>  # Remove the xfs_scrub_all media scan stamp directory (if specified) because we
> 

