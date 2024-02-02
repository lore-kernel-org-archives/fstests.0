Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A613EFEC
	for <fstests@vger.kernel.org>; Fri,  2 Feb 2024 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874974; cv=none; b=a/wK8uDuGFUtU2vFO38F+tdhPRltgs7Wq2fJ/qpZpO3Pfr7aPc57lykhccrElHQU+/qTJohLBopdWV0irrS6ZyMQ0+OtkjuwYXqPRUqWx9Nz9j6TBgZXMIc4jj6Mg/hMxMGxbLsNsuFPCJYUaxlbiWAMH5hoYkT6Osnf31PubVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874974; c=relaxed/simple;
	bh=lLPgmCpiohI17SrxUWfEgYjA27MeN30bgSLFMl1bbZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzS13ljWFDvGUcb8ZY4oQ5Cw0q04GIltna5LDCtGXLBg6UsMKTa9tOjUNSrsNraths7gR2BHxsRyXmkJBtz86ZVEU+SMhClr3vvLN/g+CddT//zqtQIzk6RCtvE7p2WPa1c28mSpUo4W+OZIBJtBLksTl2Sds8c5nm3sIrU/yFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWsSilCm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWsSilCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706874972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rfi6sByKNsCykA1O/aKPpWwVI2qdlHsFqjCRN/MTLPY=;
	b=GWsSilCmEgUqxtx1KQ7oe9Kt8TBTBkuVRJiLfRef4Vav+hzJjZTsTIQtuZ4gXWeU7EXNI0
	x7xkJBaRhTrbsmZCuoMXOL/z9U+YYKEfq2S+N68cwjQZLvwcyie7sQabkJg2kpFn1dQDE9
	qqrjWsFPOYLBKG0SN3iPdfhh2buupfs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-psvQCDVEPPGwMvNzV0_VUQ-1; Fri, 02 Feb 2024 06:56:10 -0500
X-MC-Unique: psvQCDVEPPGwMvNzV0_VUQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e129e28797so2010953a34.0
        for <fstests@vger.kernel.org>; Fri, 02 Feb 2024 03:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874969; x=1707479769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rfi6sByKNsCykA1O/aKPpWwVI2qdlHsFqjCRN/MTLPY=;
        b=RJFF61SmsK/jY7vt+jB/2Otu5SmTyku4YYVmHHYvTZ9R+pj6gqCt+KoYShYZKGncjb
         ZS/A1PSrOQlbB6Db72kthA/kO+5+b8JRab+4tSFZK2xO7SjnqonacPezeKHGBPABJxpc
         W35Yn4STXx+nNGyqgpzRzCAPvTgR7wzw+5WDZDOBpmsrHZhImN8hWcEw6kV/rfjlE+9g
         CjdweYq/YYdbx1YtLyVgXBQXdN/GygBNQMZvPb35vd5R+ylV9/34dD+kuYPgZDk7keEt
         y1xqr6KRWn4olm50IlPBy7LFuMnb56+iQcj3C1xipkxZxYAD05Vato5ggSwETXvQmWY/
         RQxA==
X-Gm-Message-State: AOJu0YwdQm2cUHi3UGtvyjXdjuLNVVyZfms60YFYXk6l66jVlFCWiPiH
	BpyqZuFEpaohXnVEVih0JRclKzzpz/hV5Xih8n1/M6GRzdSJLqjSirAekHYjvKYniguS46SGPz3
	l866VC6Q7+mGzAZGMg2DimCwmiw+2GMs6dobJEJ7TDfWGIY4mopFPfT7fIDd4XMztHA==
X-Received: by 2002:a05:6358:7f08:b0:178:618b:89bd with SMTP id p8-20020a0563587f0800b00178618b89bdmr1337445rwn.30.1706874969575;
        Fri, 02 Feb 2024 03:56:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFj/VnKYyZMEYE5Tdq3m1QwbxG9kThyqLRDsss0uVt2XGV4yDAJC3MLVAsLSlDE7RH1WO39A==
X-Received: by 2002:a05:6358:7f08:b0:178:618b:89bd with SMTP id p8-20020a0563587f0800b00178618b89bdmr1337433rwn.30.1706874969216;
        Fri, 02 Feb 2024 03:56:09 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b006d9a38fe569sm1427076pfc.89.2024.02.02.03.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:56:08 -0800 (PST)
Date: Fri, 2 Feb 2024 19:56:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic/682: update and fix-up golden output
Message-ID: <20240202115605.he7ciqxubrlglnzh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240201161732.6126-1-ailiop@suse.com>
 <20240201161732.6126-3-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201161732.6126-3-ailiop@suse.com>

On Thu, Feb 01, 2024 at 05:17:32PM +0100, Anthony Iliopoulos wrote:
> coreutils v9.4 introduced a change in the error output of mv under
> certain errno values via commit 3cb862ce5f10 ("mv: better diagnostic for
> 'mv dir x' failure"), which broke the golden output.
> 
> Update golden output to match the change, and further add an output
> filter to avoid having the test fail on environments that ran with an
> older coreutils release, taken from commit d9323ad7a05e ("generic/245:
> Filter mv error message").
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  tests/generic/682     | 8 +++++++-
>  tests/generic/682.out | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/682 b/tests/generic/682
> index a51d18338742..417598804bde 100755
> --- a/tests/generic/682
> +++ b/tests/generic/682
> @@ -54,6 +54,12 @@ repquota -upn $SCRATCH_MNT >> $seqres.full
>  echo $(ls $scratchdir | wc -l) files in $scratchdir  >> $seqres.full
>  ls -sld $scratchdir  >> $seqres.full
>  
> +_filter_mv_output()
> +{
> +	sed -e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g" \

Hi Anthony,

Thanks for this fix, I remember there's a mv filter in generic/245, we
just merged a patch same with above line:
  d9323ad7a05e ("generic/245: Filter mv error message")

I think you can merge the _filter_directory_not_empty() of g/245 with
this patch into one _filter_mv_output() function, and call it in g/245
and g/682 (check if there're more cases need mv output).

Thanks,
Zorro

> +	    -e 's/y[0-9]*/yXXX/g'
> +}
> +
>  # Fail at renaming into the directory as qa_user to ensure quota enforcement
>  # works
>  chmod a+rwx $stagedir
> @@ -62,7 +68,7 @@ for ((i = 0; i < dirents; i++)); do
>  	name=$(printf "y%0254d" $i)
>  	ln $scratchfile $stagedir/$name
>  	su - "$qa_user" -c "mv $stagedir/$name $scratchdir/$name" 2>&1 | \
> -		_filter_scratch | sed -e 's/y[0-9]*/yXXX/g'
> +		_filter_scratch | _filter_mv_output
>  	test "${PIPESTATUS[0]}" -ne 0 && break
>  done
>  repquota -upn $SCRATCH_MNT >> $seqres.full
> diff --git a/tests/generic/682.out b/tests/generic/682.out
> index b74708117237..db22d5f60487 100644
> --- a/tests/generic/682.out
> +++ b/tests/generic/682.out
> @@ -1,3 +1,3 @@
>  QA output created by 682
> -mv: cannot move 'SCRATCH_MNT/staging/yXXX' to 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
> +mv: cannot overwrite 'SCRATCH_MNT/dir/yXXX': Disk quota exceeded
>  Silence is golden
> -- 
> 2.41.0
> 
> 

