Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF563121
	for <fstests@vger.kernel.org>; Thu,  7 Mar 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824595; cv=none; b=QTZt3p/Q5OaIqQiQXjzixtjYeIQYDJgKEoerYDHpqfjrniTjSsiElEgbDJ3xCFo5sglrhuUwWhXc7+D64IBx4YixnYMJB+o6NsoHqMaE2+xgbUsMUOsfVSo207F7yOXjKrkvr5N8ZbAV8lhbsFFtO2zv7fi6QYmQxDkZRb5IfH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824595; c=relaxed/simple;
	bh=fmB/2fYDC523eDr7fhnoE0bYTJ4w/9VUvVJotNmRj6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1iJdbE8BCdwxWZcVXmVL+O82qJw34R1jDkWkG9Ygn9u56aacadvtFck8HSGuw4CDsSdZtw/R1yEpO5+kafl24BpSPEPKyWd0+TW+tdlZaJTdx2E0jhUBZBr7NBA4pG4Rg4KtadBwYei0O3ARJ7DhYmI/KG9JHCuQqPpirmSCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1//8ObO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1//8ObO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709824592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XgGCF6Ao6NnaPFHwjjrVnnOgsuHOgFMm7iHKQvatCo=;
	b=R1//8ObO5c3KxE57oKAyxJ8oNoS2w2/pOU7s6CIVBCZM/5qtCWS5Dd1SQ4cYsDRtd+SjU5
	sePWXs8lnG7nT8KM9biXjn5YMfRTcdiuflahJtdrrBofdNr20dxgIDAxK9/jFpF6VdkBgS
	oSJhuxJ7zURMtQUIClENgRVCgxXRdmo=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-4nFzP-D6MsKNcRC5Hg-kTQ-1; Thu, 07 Mar 2024 10:16:27 -0500
X-MC-Unique: 4nFzP-D6MsKNcRC5Hg-kTQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dc4f385c16so10962595ad.1
        for <fstests@vger.kernel.org>; Thu, 07 Mar 2024 07:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709824586; x=1710429386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XgGCF6Ao6NnaPFHwjjrVnnOgsuHOgFMm7iHKQvatCo=;
        b=tElGIpC6jTCTRaNrldUu2t/jBbz/MmFVUJ+yXhA4squej1QXRdHy7L1E9PBiLTy9os
         C1UucoIVzdwJGZRn9guGbnxSXQuorKVYNmUsYoOKHuERXEIo4D+r1m2d4fNla2KuvkLt
         iVrXa3eW4Bb/15+1IHlhrp4GD1x1JBZP7TgMZX2XlRKu4cjCU9Fns7E1gMu3RFkl7X/x
         mQT+vAZXl3qH85YRoTXyuPF5zv4tQYSz/iWaYby9WuWQkOYRRnAKZm/v0ZxDRe6LdJHZ
         yiunhZyvTdOYO1G7KC/rNqrIpyHd+tMHpBDQ63qOL56UIyoK1VKIXFQyswWFxi6wSvNC
         n3pw==
X-Gm-Message-State: AOJu0YzhnhM5Wf4tgUMwA0uAWK8YYHIbOJfLNcEiyrCACE3LHwF9bgt1
	VPXWTLWuIpGfnY9g3L9CCzKPDrbPFnsA8XgqrMp9WMZ176iduyO3BDOSzLEHHCmNa4c3VozIlCG
	AA6oD2RixZMebKxWEJNtrIZx+ieRIISVRzw3BnpBVgvSYBqtGRRIgnbI=
X-Received: by 2002:a17:902:ecc4:b0:1dd:8f6:69ee with SMTP id a4-20020a170902ecc400b001dd08f669eemr12105088plh.20.1709824586278;
        Thu, 07 Mar 2024 07:16:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFeqqO13RNZOBuElM9XVsP4yRu2BZGZcUUvMyWoakciyNzXFKfBQCybZBmZT2MgZNewLWW9w==
X-Received: by 2002:a17:902:ecc4:b0:1dd:8f6:69ee with SMTP id a4-20020a170902ecc400b001dd08f669eemr12105058plh.20.1709824585829;
        Thu, 07 Mar 2024 07:16:25 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001da15580ca8sm14715056plh.52.2024.03.07.07.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:16:25 -0800 (PST)
Date: Thu, 7 Mar 2024 23:16:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] common/rc: specify required device size
Message-ID: <20240307151622.warzurzdxovxh2gn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1709806478.git.anand.jain@oracle.com>
 <c74dc3a6f1dc8d45bc54ef6ac087e5e92a778509.1709806478.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c74dc3a6f1dc8d45bc54ef6ac087e5e92a778509.1709806478.git.anand.jain@oracle.com>

On Thu, Mar 07, 2024 at 06:20:23PM +0530, Anand Jain wrote:
> The current _notrun call states that the scratch device is too small but
> does not specify the required size. Simply update the _notrun messages.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

OK, I think that makes sense to me.

>  common/rc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 50dde313b851..5680995b2366 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1834,7 +1834,8 @@ _require_scratch_size()
>  
>  	_require_scratch
>  	local devsize=`_get_device_size $SCRATCH_DEV`
> -	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
> +	[ $devsize -lt $1 ] && \
> +_notrun "scratch device $SCRATCH_DEV should be minimum $1, currently $devsize"


>  }
>  
>  # require a scratch dev of a minimum size (in kb) and should not be checked
> @@ -1845,7 +1846,8 @@ _require_scratch_size_nocheck()
>  
>  	_require_scratch_nocheck
>  	local devsize=`_get_device_size $SCRATCH_DEV`
> -	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
> +	[ $devsize -lt $1 ] && \
> +_notrun "require scratch device $SCRATCH_DEV atleast $1, currently $devsize"

"at least"

Why don't output same message with above ? And why not have indentation at here?


I think the message is long enough, so the $SCRATCH_DEV maybe not necessary,
how about

	[ $devsize -lt $1 ] && \
		_notrun "scratch device too small, $devsize < $1"

(same above)

With this change:
Reviewed-by: Zorro Lang <zlang@redhat.com>

As I've given review points to patch 3/3, so I suppose you can change this
patch with the 3rd one together :)

Thanks,
Zorro


>  }
>  
>  # Require scratch fs which supports >16T of filesystem size.
> -- 
> 2.39.3
> 
> 

