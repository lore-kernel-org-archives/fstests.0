Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF02B2DA
	for <fstests@vger.kernel.org>; Wed,  9 Apr 2025 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192654; cv=none; b=BQMn7rQEwZJ9fmkNgMnRcoWHN+qKeFFu5Vx08i1XHUpvfJDnXx9/WwOE3x67bearBjofqbPPB4YxMciu3y0+FiFe6AvJwOSgCiFFxs/pR2FdTRIHSekwHFfh7fZflsoU227Jj6cCDy6MMpz6K36vtC8XPqQXFXfdycVJ/HSpx1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192654; c=relaxed/simple;
	bh=f2YFhv/ay2EqQEIbM88ALqTA/Zc3CAZO57aacN3cWzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK4Y2bZJLoT25qOV+b7qkSSDc8RjGbM6ej3IwSVq5zqAIisgttQ9ZGYJtaQTsOmsFVhofaGKrxWOhtPNPAR3CjOzywDYMQpkotu4VrwzI5/tTYc4xjHfiSW/zkg+XxdsUbs5ryiZhwyme4fFiMD/prIIA+ESbQON7HuFpSe0yqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eO+jJmF7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eO+jJmF7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744192651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6W1d2djr/RGcRIDDdM1RhDN/5g3ZrQRAfMmDhaVSk=;
	b=eO+jJmF7Uqa3A5wBBPwQc6Jszao7JYfYs220xriiQOyDCAglyYJXQbl6mnKE55pFD7lZ5G
	XFw+XRav0ZW42rWMFGM3jdvgVsYaMPl92wpo/fI2nCXMAi//D5KtYs7SCL4YG+0Yck9p3v
	VOZS+X1E+HB1HowQ5AXdoBVG5PebzGg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-9mpoNLPhMnGM8EpUD1wf6g-1; Wed, 09 Apr 2025 05:57:30 -0400
X-MC-Unique: 9mpoNLPhMnGM8EpUD1wf6g-1
X-Mimecast-MFC-AGG-ID: 9mpoNLPhMnGM8EpUD1wf6g_1744192649
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso9706255a91.2
        for <fstests@vger.kernel.org>; Wed, 09 Apr 2025 02:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744192649; x=1744797449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO6W1d2djr/RGcRIDDdM1RhDN/5g3ZrQRAfMmDhaVSk=;
        b=cXLf6hXytHXJB+17rqclgFW2Z7mL4zxd8ge+H//o5ZuCi2+BXX9+9jd1v/7x+UWsF1
         B6pbSaR/cGlYAoG4EeBwxx6mqreduEozybcnPEM6FsdBQecmljQD3/pPyOVPI37Jaq89
         ++VYqwY8zGD7yxtZuLfsn/bws8C4jJbiDKS+ZYvqXMNdFNd9gv2heo5MmdmSpUC7FK+f
         +xc1fXM6lyEdPe8ZUvS8S8+SsrlsRxSOirBHzj5imoCiaYCXDOkEQCO1z+7ZChLZeU4P
         Pn2JMs677CDdvLuk8fgdWXBhqhXtEJvL4d90ahp2UtQR9xuO10QyjVRIBQFVbUUyRAPl
         LYeQ==
X-Gm-Message-State: AOJu0YzlIlWMLgz4jk3/c3JQpnMzyie2AavBAyXSLRN0JbZIhrySI+Ro
	eV/7simnjpBQ8uYfdTnjYty/lKqaQcaRGjxMKtAc0lhFcqiqQ92Fc8EbyuoDFR+R7dEibaYVL8W
	n0Jww2HaUckRv9BVyG1pFrfU4iA95m3cBuewxF23cHTAw8TM3uLaF0cM=
X-Gm-Gg: ASbGncuXjIv4A9GDFV6LUbeBxz3F9XsM8w4LAz88J50ZHnDeEX90zUTwiha8Is/4lky
	dgcDwOuE+0z3IpAPgvSRiKF/t9Hkfvso5SpXOtmUXkNXF15zuaE6NCKvPqkQTZjhHjw3aYgrqvY
	oCSHIigFPf32xGYtIXPk7OGtifhOdj6RRi75rlWdaEX4Xk67CBWbo3KrrW3V8mUnfMlmfvLQeiv
	8jYfplE/67ufESV0ns/GmonVzPEOLYKat2qdl4+ASgMsvqtt66olaqMYihY6z3b/rvidPOHDUdQ
	7WzLDfMKSBq5Wf3mHOq9uNMqrlZWlntHG1JRn30qikMtvk/elEAQ
X-Received: by 2002:a17:90b:5252:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-306dbbb366bmr3398411a91.20.1744192649121;
        Wed, 09 Apr 2025 02:57:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeejyU4fN7LUlJTruuiNultjp6mPjR1EWLUt8OgHgRdXRC+qeoifN/IyA2JHuU3AgxDAb3IQ==
X-Received: by 2002:a17:90b:5252:b0:2ee:fa0c:cebc with SMTP id 98e67ed59e1d1-306dbbb366bmr3398401a91.20.1744192648886;
        Wed, 09 Apr 2025 02:57:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306df401ab2sm1070707a91.48.2025.04.09.02.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 02:57:28 -0700 (PDT)
Date: Wed, 9 Apr 2025 17:57:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 2/6] fstests: check: fix unset seqres in run_section()
Message-ID: <20250409095725.xumxhw54igwapuue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com>

On Wed, Apr 09, 2025 at 03:43:14PM +0800, Anand Jain wrote:
> Ensure seqres is set early in run_section().
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 32890470a020..16f695e9d75c 100755
> --- a/check
> +++ b/check
> @@ -804,6 +804,7 @@ function run_section()
>  
>  	seq="check.$$"
>  	check="$RESULT_BASE/check"
> +	seqres="$check"

The "seqres" even might be used earlier than that. If your rootfs is readonly,
you'll see that.

Thanks,
Zorro

>  
>  	# don't leave old full output behind on a clean run
>  	rm -f $check.full
> @@ -849,7 +850,6 @@ function run_section()
>  	  fi
>  	fi
>  
> -	seqres="$check"
>  	_check_test_fs
>  
>  	loop_status=()	# track rerun-on-failure state
> -- 
> 2.47.0
> 

