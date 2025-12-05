Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED29E2571A5
	for <fstests@vger.kernel.org>; Fri,  5 Dec 2025 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764915426; cv=none; b=HqcOzkCiiIpfD0Vh8hjZ9IeT3R/Bi1QtwuZweO2nJb0aSzMId0v2OG5lrq4CLcSGSah7s98eXBjyNZOYtw93JTxOjD6k8zyH4gAW1atSa1hdyYWEKLZepys4aRLz2XppNAPk2Rqap5TOjqSvKGXCemIPBowCPTUgXezB+Zat2r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764915426; c=relaxed/simple;
	bh=lRvMy3Nsa4018CCXzjE5gndFWfgaLWm51xN0ZdAb1DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hps7iBeXjpjPcxn4p1/5zlFiThatDRjjoI9bbAuJ9Qobv305GUv5kxKILd57KstKfzaZvp26Ocpky1ekDhSZNwG9wRYU1Sw85IyeRu/aaRUzSkHnjG35wvXZLPBCM9uUZqdTkLbCarvn4RTxeJOsWM9gxr3hfbu5vnsWRba3lkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J1jRvutT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGhAPJYn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1jRvutT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGhAPJYn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764915422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xXzRynHVZD35dsZOQSAxDidWH5UYp+SP25S9dmTtEho=;
	b=J1jRvutTYDs+fDLX9nyy59li/lzxHy87XAwVbg+mYQssPH9etvlU3hNSljf0AzVoFAvrNr
	wB7hr5WtLcgp+HzkpdO5fXF1S9Meir4oGwiGiVVodBb/G8PrOdoda4dtkIacWj1s5JZ8tt
	BtIAWR7Liad8K5n/2cLBx3hDwANtwhI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-BoRCI9PBN5So0ZdUF6MtzA-1; Fri, 05 Dec 2025 01:17:01 -0500
X-MC-Unique: BoRCI9PBN5So0ZdUF6MtzA-1
X-Mimecast-MFC-AGG-ID: BoRCI9PBN5So0ZdUF6MtzA_1764915420
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29848363458so34365515ad.2
        for <fstests@vger.kernel.org>; Thu, 04 Dec 2025 22:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764915420; x=1765520220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXzRynHVZD35dsZOQSAxDidWH5UYp+SP25S9dmTtEho=;
        b=gGhAPJYn7RnryCgYJqApSohtCI2gYZjkA2DdsKVDs3KvozYUFtE8+GWZTxEj2J4hai
         8NJPrDajFz6wMUzzyKaVxTZmNtJQjx6tPxMunoO4jTT5gXpdyP02ZW7juxzPZp+m4tQv
         e0GplKahWdf/pcXWFeMHrie6dAOVm8xYyijyBK1GlaGnHXlxWd/ICX22RdCHwu7LvzEA
         u5PDInUuQDF+JqgRkZbe2VceNnXhHma37LuzN/9iI2MOhzIndmofqK9uSUzPPUxvNUnS
         pm/VOjpasp7wJLn+nV8FHCdeyEl0Jx7OFDTP8WTBltqcVEepQpfCXlkmU9PLPCbAXhXa
         DruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764915420; x=1765520220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXzRynHVZD35dsZOQSAxDidWH5UYp+SP25S9dmTtEho=;
        b=TOz4YDCyoDlQGlceyk8s3Cdegne6IIFaPJmwSEuYx6Hr//31q/dcDfeL5tCZehhlkW
         BdBtHh9iUIbqoZp+szaiZdICD3hU5rTSHCmWmK+FT4tnhgrZZvEV04argriP1qRE/vps
         +6dEPCWLXQpajKZVgoIG69HxcPtmFCTd2L8eEbLJ9+kadkBcsljypoEKjy4IksOemtYm
         R/nMme4LfsImdflxnMDLHYB8rNhXiKnSLLFjS+lfXiVw4lsAigxclKl1hzuieBrFV9u8
         ZsoqImw4nqLoGIa1C2D8jQCEqeSuatoiCZAFH2nJ+kS0x7Y9qePevJm3Xz4ULTvlgDSp
         GSTg==
X-Gm-Message-State: AOJu0YyVnT6nsymdeZEJQF//lOViQIvFX2dn1FUcSGHTlt52x1lDcUwV
	GhvSkSKK5SU7ud+9XAAnrtkTA/IEC1PfRQFiMFghppTEyTC1f+M+LGiUD5Sp3CmGJ/w6fKGxNf3
	7K5lNRvFZwO6RDyEHEjuU4HPQG9AXPnE2VopDCtbSeYBr6c+aW8sMRfgkDJk=
X-Gm-Gg: ASbGncujedgo4IbJhseMsk7vGsh3UCG8Co+p3u0arTzlhrWk/H+1JCnWSba2Jy+5xGe
	ij7CliVh/S0LdZe29X7cDF/YL9oKYQik25IfNxUkzTKECVOA7oxB6s2nU6J9lxQs54pTdNKUErL
	vxXnCLzL48BkEERTUx/TmIFLN0wy+pG+k/j2JrXjPEgcUDBNyvK5Di5oovLpdHqi8h7Eg4aNbY2
	a9lzYDBOa+T/5egIrS01No4RmHIkETKkWqFJu+Vo1DNvkZWayoocKz93bg11Wt90mftPxBYyy7g
	a/3RClyjAwcgTo6J15as/pr1rF6RW2dh0y3kIkvOdmR6MAdfQmYCaUtjQcDZFpVGhGZ/C3cdPbM
	DoTLP9nG9WrnKyy0AoLzNxb1Mm6/Srb56SSudYJJ8iSFPKqQgXA==
X-Received: by 2002:a17:903:38cf:b0:298:42ba:c437 with SMTP id d9443c01a7336-29d6848f252mr104944825ad.50.1764915420225;
        Thu, 04 Dec 2025 22:17:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1PWOM7eO8T0mI71RM9pRlNw2s5iGdFGEO38X35ZYLBc56M0oZfbuHAFiUklmP4+mopL57Tw==
X-Received: by 2002:a17:903:38cf:b0:298:42ba:c437 with SMTP id d9443c01a7336-29d6848f252mr104944545ad.50.1764915419610;
        Thu, 04 Dec 2025 22:16:59 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99eab5sm37735695ad.51.2025.12.04.22.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 22:16:58 -0800 (PST)
Date: Fri, 5 Dec 2025 14:16:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fsstress: allow multiple suboptions to -f
Message-ID: <20251205061654.gyoz2nvtokzgux5p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251204215317.GE89454@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204215317.GE89454@frogsfrogsfrogs>

On Thu, Dec 04, 2025 at 01:53:17PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> I got bitten by fsstress's argument parsing recently because it turns
> out that if you do:
> 
> # fsstress -z -f creat=2,unlink=1
> 
> It will ignore everything after the '2' and worse yet it won't tell you
> that it's done so unless you happen to pass -S to make it spit out the
> frequency table.
> 
> Adapt process_freq to tokenize the argument string so that it can handle
> a comma-separated list of key-value arguments.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Looks and tests good to me, it even works with:
  "-f rmdir=10,link=10,creat=10,mkdir=10,rename=30 -f stat=30 -f unlink=30 -f truncate=20"

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  ltp/fsstress.c |   43 +++++++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 00773cc004bfac..c17ac440414325 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -1792,23 +1792,38 @@ opendir_path(pathname_t *name)
>  void
>  process_freq(char *arg)
>  {
> -	opdesc_t	*p;
> -	char		*s;
> +	char		*token;
> +	char		*argstr = strdup(arg);
> +	char		*tokstr = argstr ? argstr : arg;
>  
> -	s = strchr(arg, '=');
> -	if (s == NULL) {
> -		fprintf(stderr, "bad argument '%s'\n", arg);
> -		exit(1);
> -	}
> -	*s++ = '\0';
> -	for (p = ops; p < ops_end; p++) {
> -		if (strcmp(arg, p->name) == 0) {
> -			p->freq = atoi(s);
> -			return;
> +	while ((token = strtok(tokstr, ",")) != NULL) {
> +		opdesc_t	*p = ops;
> +		char		*s = strchr(token, '=');
> +		int		found = 0;
> +
> +		if (!s) {
> +			fprintf(stderr, "bad argument '%s'\n", token);
> +			exit(1);
> +		}
> +
> +		*s = '\0';
> +		for (; p < ops_end; p++) {
> +			if (strcmp(token, p->name) == 0) {
> +				p->freq = atoi(s + 1);
> +				found = 1;
> +				break;
> +			}
>  		}
> +
> +		if (!found) {
> +			fprintf(stderr, "can't find op type %s for -f\n", token);
> +			exit(1);
> +		}
> +
> +		tokstr = NULL;
>  	}
> -	fprintf(stderr, "can't find op type %s for -f\n", arg);
> -	exit(1);
> +
> +	free(argstr);
>  }
>  
>  int
> 

