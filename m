Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7875204C36
	for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768756738; cv=none; b=okianwFG6XCzjopxRHbRfUsVESaodC4AeX69nYWpcDgDVzClVagheRtrUXsgu7Sfm/Ei9AHkjb8Y0U0CNdHunsazxLidIg2mzLv9JF8dXi+9WBEVT+fQiI0xHR2CtgHr86TXIdClybP+WWPxZ7Mz+pixXdKjf/jnSOCDWeV8P78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768756738; c=relaxed/simple;
	bh=79WwHjzXcHTApvbu86UG865ls2+qm8AFjVIGbrjMxfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgyadpKAENUO37meHihVLI1trxpjdpb/XipyAbDhEw/x+52XJS4ZruHXup3XFz/HfeoQDlqT0+LWp/J7O+LZWDj6LnYFUZk7gmRzNKN7j0ESUSLJrLsPQzs4BidsD9v55Wnu12mlO8Xo1PEaHq+7+oKIGCtjzqpppjBd+jbi9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUXvxKq+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jXfjRUNs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUXvxKq+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jXfjRUNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768756736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9Sh3sO4hz7HhjVEAHMpRjjqKNJlWjD7ufyRMWnbcZs=;
	b=IUXvxKq+VrjQhfsOMkxTEgzXOowk8Vsg3M1miILJjoNZ1p+VRS6k1r56Ltj9KOjxLX9AJX
	byBdv33WPsgeIwCwYusp4ATOJEoOLYWtDAobzjIylrFpC3+hZsEok4WH1VoRgXnFSK79iu
	xdRR8Quw2iIdcvPyh4FT9kaspukFwtg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-5XfnzdKxN96VxXOW3uja2w-1; Sun, 18 Jan 2026 12:18:52 -0500
X-MC-Unique: 5XfnzdKxN96VxXOW3uja2w-1
X-Mimecast-MFC-AGG-ID: 5XfnzdKxN96VxXOW3uja2w_1768756732
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0d43fcb2fso84036215ad.3
        for <fstests@vger.kernel.org>; Sun, 18 Jan 2026 09:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768756731; x=1769361531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9Sh3sO4hz7HhjVEAHMpRjjqKNJlWjD7ufyRMWnbcZs=;
        b=jXfjRUNsjaj7jZ1A8i6OgeTiKswoYu0KQzJSis0ZzQ8sqBS7dEYorR5S6VctALikj9
         0hTN4srkfI7VAg89SyPnoPaagNDG1hovmjLHSy6Zir5LDqRtC9967p8ETyiU/uWMUpYJ
         XDFzsGxsr301tgkyywwlFlAHr+9YTUu8H/o3kEOSXDcUxO+SQGF0PmYyuIo/e5P2khk1
         kIvIuUVb1to0u6nDzQjdLoXTDpBULehX8UJqF1x3sGW4Doa+P81kP53GKfld5n3xh6M7
         IzrYf5Jspb5IJeYF6CcywCcxhZEtaXatO6JcP0U5ltrjxPvYAnxpk7ZiZtTCPMN5K0pz
         0qKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768756731; x=1769361531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9Sh3sO4hz7HhjVEAHMpRjjqKNJlWjD7ufyRMWnbcZs=;
        b=Ttdm3FA4f7Jy2RzPnc0k1l4YAcZ4IoAU4a5YmPhu9LhTjKC/rac+Z2mCgX4+LhlVwl
         z3vB1Py7nXagy0feROrDcRzVaSfP1S4LG/woJI/SKHGraYdulcBwjJh6RvXXpPD2F1W+
         jvjUJJdVBNJYhv2bfwBf5CFeIlN9m8K+NLs5QciUJazbo6ZMY1s/rrK0LW0mHcTUL3Xi
         5/xwyKVwLSoyGVj1Wnbm68d/Xey4XZHISw11pPzIwbjdqFW7q1/3CLFGZIHzwlFnJU11
         ETU3yxmYzJfBoBSCi2GV5ziSbzdG0PTu2BEbxkFbvu6mFRRH4Awye58mpYxmvx7p7L6g
         TY2A==
X-Gm-Message-State: AOJu0YxQ3oj+WFRNPNLEiok94zKEZM/m3MGDu+m6NR+jPo9WItrISG/e
	FpACCfYwfQviuXyvu/JojpwZwdZGDmhykDxXb9Ak74tPV+ZBnoUFlj00+iY7TX7viQEB8O45hdu
	Un+daBvM+taB1/ZbZN6jeIpFWbTiIlIw1D+zyJBq+S/PVT3hrWBa8So4AxPg=
X-Gm-Gg: AY/fxX7Re6MNqlmMTU288aVe24qmlZkH6XHqThXlCGjxqtcuH7sKpglB6FStaNs31uT
	mN43r6RO3WQeWS47CrpcMUvRlA0hnL6za5f3JJhIza3z0EwBlr8UWV4pO9iyBppFUkL7QUiqSCQ
	k6EOqrNmfP9q5rLB3iUMoKn+1aZXRixOUBTECxz/fk04Q9JD50IB1EU1ZZiumu0ydsGJsYbSRUn
	rpmbiu0RKKm/vHofSzpcAaxV9/TcrLnswtGlaoJYAo3K9RxiMYjcLvRBKDgfkDB2mtuYfBjuxJt
	s0JXSNY7g2W9tf15aaQzaCfAwK4cFeG4ywW8gE1kfSf1Nr22V5q1PyhPogZsZ/esxyr2lJT/GoH
	6VnqLrzSPg3/srHjcZo19X5OhbZcLIt7t7clUB7ZhYZgiB5Xq6A==
X-Received: by 2002:a17:903:124f:b0:2a0:c84f:4124 with SMTP id d9443c01a7336-2a7177e2b6fmr79213455ad.52.1768756731584;
        Sun, 18 Jan 2026 09:18:51 -0800 (PST)
X-Received: by 2002:a17:903:124f:b0:2a0:c84f:4124 with SMTP id d9443c01a7336-2a7177e2b6fmr79213285ad.52.1768756731034;
        Sun, 18 Jan 2026 09:18:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193decfcsm71452475ad.60.2026.01.18.09.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 09:18:50 -0800 (PST)
Date: Mon, 19 Jan 2026 01:18:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fsx: add missing -T option to getopt_long()
Message-ID: <20260118171846.n5nxfoofpyi2od7i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <dcbecbe996375e0f04962aa2e1a97ade927ecf74.1768225429.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbecbe996375e0f04962aa2e1a97ade927ecf74.1768225429.git.fdmanana@suse.com>

On Mon, Jan 12, 2026 at 01:44:09PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently fsx fails with an invalid argument error when we pass the -T
> option (do not use dontcache IO) to it because it's not listed in the
> gepopt_long() call.
> 
> Fix this and add T to the getopt_long() call.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Wow, so no one used this option before :) I just tried to search in xfstests,
I didn't find any test cases or common helpers use the -T option of fsx, that's
why we didn't find this issue before. I think you might test with FSX_AVOID="-T"
or run fsx with -T manually. Anyway, thanks for finding and fixing this issue!

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  ltp/fsx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 626976dd..8626662b 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -3160,7 +3160,7 @@ main(int argc, char **argv)
>  	setvbuf(stdout, (char *)0, _IOLBF, 0); /* line buffered stdout */
>  
>  	while ((ch = getopt_long(argc, argv,
> -				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:OP:RS:UWXZ",
> +				 "0ab:c:de:fg:hi:j:kl:m:no:p:qr:s:t:uw:xyABD:EFJKHzCILN:TOP:RS:UWXZ",
>  				 longopts, NULL)) != EOF)
>  		switch (ch) {
>  		case 'a':
> -- 
> 2.47.2
> 
> 

