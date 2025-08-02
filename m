Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4644A01
	for <fstests@vger.kernel.org>; Sat,  2 Aug 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754122730; cv=none; b=pabLOiol08wSBiM3W3XtE4BZddxucF+E+bokRuM8z59SCLlp5/Mh0ITGM5swdLrKWXpJ/2Tt1mvjtlS/Nu6H6KNcF8FyNwphb9T+h+zS6Qw6dfqksyujNxzx0kuVlxqfU8eGbgHBffOtWvWVUbU/JVX0tlmmKsr/A/Y7tNEh07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754122730; c=relaxed/simple;
	bh=ZPb92UXoYoBstPxrvH+BmwG3tRUtSr1DqHtspTQBGcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WieH94BqoyT/JlvZa9kRyvvtMOa+dTT3+lotYIQZgTnvJYUEpCxrREKT/4wksreaw3sS0qCQa+m5zGv9tLHDmf4PiG3caVhHvraAGpl/AQFVuJvY1lZD15DBNdpGln7pHFY61BULM7GkmN9aBttdV86/hEXGmp155bMh9q53cDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avcA02Eh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avcA02Eh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754122728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ctkLsza+5GIefWa+vyFSs9TRNgx1inMYSvhWFJuNFnI=;
	b=avcA02EhfM4lr3uur2v6pNrpgZSEE0GILEseFiHCs8RG2YJmnPoJuD+MN6M3Ou2Y1iZa0H
	U83hG9f4c9gLuHDD24ivuNn0mbE9ZO6vll0X/HgsdzT1PoEA665FhS6zJfSHO5aNbcRXJS
	x9FhcRqJ9v59QvixsFhcPUAXjictV78=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-gf77MoUTORi0RXtreUpuMw-1; Sat, 02 Aug 2025 04:18:47 -0400
X-MC-Unique: gf77MoUTORi0RXtreUpuMw-1
X-Mimecast-MFC-AGG-ID: gf77MoUTORi0RXtreUpuMw_1754122726
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24011ceafc8so24993675ad.3
        for <fstests@vger.kernel.org>; Sat, 02 Aug 2025 01:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754122726; x=1754727526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctkLsza+5GIefWa+vyFSs9TRNgx1inMYSvhWFJuNFnI=;
        b=QSe0V9Pq3udqGT63DOLOkxHAfzZD89Q45T3YgG4IuxdfjeWsWmO48jBq41YqMVKKsQ
         tLSjiBDUG6T+wpN6wIUzcNSFIqAtJbtrdq3b/hfVGgrlNZC1t0u7vsEfvuKJIZV26Lcm
         efC47ISLJAsaxZOa0w+bGB2eEX9At89PAw6Q3mSxd9NuT5B2Z4Bz0vWlZ9JIYakx+N0P
         R8Rqnfp3zq5C53ho3cvGugDxLUfwV4YkxokN6jIq6ROqM0AfK55/okGg+z0/6hTs+2lL
         gHHp95+8Zn+K1W8TwI70sFw8ziumRuyg/6JBynVGJBcCEdlAg1KQYVIrPcjOu0146k2S
         Jzpg==
X-Gm-Message-State: AOJu0YzEUSa+FoHG6btIMPRQ2dYj1g8wOfCbKcDcaJKWrniigee1wi3h
	+uB5vJikZn+aSlDF1+SAqfjK1S8d/c/bjVg8i4wtIcn7oP9thxPbX6LxFVR8DVmjvehpQYD+NWo
	b0kCpurq8hWpnyvYLQ6RFqnorBy26mRXZCX7KDz1h+XPsZpUet7VP+yokROk=
X-Gm-Gg: ASbGncs3sTeUCb/FTxshUInZdKVrtprA4H/+krEScmZrZ437SYfEeu3uXH9RVouNun5
	drBy8fpYN8qDEUSlIy2HLlhEu9uDDoTY7sVyoNr/uj7njU1f6b6hy87aR5rnLZFYg7uji+BK9O/
	CEcATQkBJDx2TZcjyFjZjROi2Y0y0egsnuWiYe+z43tYty6RzT5ZHe8tLGtgsFGf9FKNSvQsJzs
	aFISm6SyvI7L+fFsFuRRvuKQ2r5YMHVOo0rNwHDkRa1NQxC2XO3qQNJfJ8fRRTcMYuDhwT7b9KS
	css8x4oZ3d6jQVWjxtmBHBolo+tMVWW+I9lUyyUlrV4oFuMrxhHd/iJaeZ+1G1fHnkQSWG91qTe
	ENEiH
X-Received: by 2002:a17:902:db11:b0:235:f49f:479d with SMTP id d9443c01a7336-24246f3e84cmr29876575ad.3.1754122726004;
        Sat, 02 Aug 2025 01:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoyg9T+vcYnoLLXUhwyN/5RSxfQTEzfdYmpwkOJvClaFFujcVcJBED8MsKpFaVCp6Msf+p9A==
X-Received: by 2002:a17:902:db11:b0:235:f49f:479d with SMTP id d9443c01a7336-24246f3e84cmr29876445ad.3.1754122725656;
        Sat, 02 Aug 2025 01:18:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef48fbsm61362585ad.36.2025.08.02.01.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 01:18:45 -0700 (PDT)
Date: Sat, 2 Aug 2025 16:18:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 1/2] aio-dio-write-verify: Add O_DSYNC option
Message-ID: <20250802081840.usinvu6tkv7anbvd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com>

On Thu, Jul 31, 2025 at 06:05:54PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds -D for O_DSYNC open flag to aio-dio-write-verify test.
> We will use this in later patch for integrity verification test with
> aio-dio.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/aio-dio-regress/aio-dio-write-verify.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
> index 513a338b..0cf14a2a 100644
> --- a/src/aio-dio-regress/aio-dio-write-verify.c
> +++ b/src/aio-dio-regress/aio-dio-write-verify.c
> @@ -40,6 +40,7 @@ void usage(char *progname)
>  	        "\t\tsize=N: AIO write size\n"
>  	        "\t\toff=M:  AIO write startoff\n"
>  	        "\t-S: uses O_SYNC flag for open. By default O_SYNC is not used\n"
> +	        "\t-D: uses O_DSYNC flag for open. By default O_DSYNC is not used\n"
>  	        "\t-N: no_verify: means no write verification. By default noverify is false\n"
>  	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n"
>  	        "e.g: %s -t 1048576 -a size=1048576 -S -N filename\n",
> @@ -298,7 +299,7 @@ int main(int argc, char *argv[])
>  	int o_sync = 0;
>  	int no_verify = 0;
>  
> -	while ((c = getopt(argc, argv, "a:t:SN")) != -1) {
> +	while ((c = getopt(argc, argv, "a:t:SND")) != -1) {
>  		char *endp;
>  
>  		switch (c) {
> @@ -316,6 +317,9 @@ int main(int argc, char *argv[])
>  		case 'S':
>  			o_sync = O_SYNC;
>  			break;
> +		case 'D':
> +			o_sync = O_DSYNC;
> +			break;
>  		case 'N':
>  			no_verify = 1;
>  			break;
> -- 
> 2.49.0
> 
> 

