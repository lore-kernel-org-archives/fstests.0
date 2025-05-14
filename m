Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA791EB5D6
	for <fstests@vger.kernel.org>; Wed, 14 May 2025 05:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747201016; cv=none; b=Yng15ODMOX9wmyEhIIti66Skb7ZLY80/GQUCrnFXAI+gYwV9meVbD5vbKQwYTD8yjNFdxnAHjSMHoVch7pFFJNWtIRcgxoDJmZtOt+BAeN0mk9W76mJEWlWuDHgh/LHaB48Lsnf4GVzS6kzHoFluu0Crc5TpxM9JCY6VDpIvsNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747201016; c=relaxed/simple;
	bh=5cfTI/aWoZlCOnNpty3N6u09TpujQH8CPhzu9Z7vEJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5TpPCDeMOudxVG8kbgZyJpFK5jI1SriRyC90Vh6RmRpknAmbH+DHq3lWv6yp4WsYWBlCJkiCgNJaPXHCG4I/zhaVmX5hi0g0aSse19jnbZuRxcDavoKEvqjNJFfUldyDDdHihWtCjeq2h5Q3FeuQxaV7eCdZ/abP+qS0nk/rYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DeEMRc9l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeEMRc9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747201013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k7DVWcCawpaeNJq2qKOr5EAfsfYlAClMdZ4LZ2aaJxI=;
	b=DeEMRc9lOWQT5QeT7dVD6hBqG/zUIqNYXmJAEl7UU7/iP1k8u20ZwOKKxPGjVqysKMEA7H
	brgXEi0Wf0hPLNtRG9UHYHJV3tgoh7X/sSLGk1pXFCPqhwf+661zAw1KdI7fQh7IXb/2Bb
	swsFmZvlQvXlwz7AdljE8bYxyffsSmI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-7LLPhM3LP72IlOj8w0zh0Q-1; Wed, 14 May 2025 01:36:51 -0400
X-MC-Unique: 7LLPhM3LP72IlOj8w0zh0Q-1
X-Mimecast-MFC-AGG-ID: 7LLPhM3LP72IlOj8w0zh0Q_1747201011
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2518fbaaabso4988527a12.1
        for <fstests@vger.kernel.org>; Tue, 13 May 2025 22:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747201010; x=1747805810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7DVWcCawpaeNJq2qKOr5EAfsfYlAClMdZ4LZ2aaJxI=;
        b=MOTGMGagnd1uKIY8V4ZsSdXVsW2MGcZnDYU0YL0RORMHvwGFLdn4Dm+Ckr11hBKqRH
         FWXKfPU/ID4wN2KcTBSIYWJpjjmFaKcsT6KevvG+Pbd0mkQiceIMQbRer0J/rGUJwO2m
         Hq4dgFkYdoH+IJNptnpBMnH1YZSwYUR5EhFPbEFEGSsNDddrnNddXcF6Gj46b+e/jFwZ
         iIfFbKD43j7To3cHxKJ6ZUfbsy17arZsyJSd6u1dH6Cv+hlb4UFQJl8aNIddXJycH0Fi
         VONX8MCcAusgJxaaA7VYLsUBUrvdnOhhzj2ZwdnG0sdVQOCNPkYR2K/IQUaRq5AAtuNn
         Gqkg==
X-Gm-Message-State: AOJu0Yy2kdQt3qAlBqmG7pCcz3B4oeeTG2E8xQFQDbg/L0xNEHJny3Hm
	ZwJ20eey6cYLyKK/tR3zSZJ62mx95N3OU+Rj1bY/VrPa1HmVWh1sPV2tPXu2HLlcaClAp3gGZ82
	CPAF0CwRi5UC9z3cCoxv+EA73iTwXqoJ28QiE+Rz1DgSo2pt67F66taw=
X-Gm-Gg: ASbGncsi4shGop5TPvGIxuUZlEhMbeSYaMc6QsUcHBTDlP0LWkL+t/vDxqORnE/RBee
	2oxkZy92EQgZB3VBrcD1nmL/Qh4zCPFe3E3rFx01QqmPUjHvALEq95qpe0dLrYmm8N0QRa9BLsZ
	E9+PJO5gg8Wr97MVTEmPYKQNuBvdxSumwGZNDY7vC6iOQenNoGAE7i7vCf8Zi+jQvWONjW962b/
	WMnVcO/UGWTCLsBtD3Hz6fC9AhqupmPXSbGDTHBXTLjE9pI9lip5a1wIEbMD2JLKB835b5MpzKU
	2CyYGbGcOhFrOQWF6EHBxk+QX2QlmQSiBN8v/7I7xqPiNBwhOFze
X-Received: by 2002:a05:6a21:33a1:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-215ff08f0d0mr2736426637.3.1747201010724;
        Tue, 13 May 2025 22:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5eWBBrJf4d2S34HMSb0MF2dI6lzhWWQaGfh5YOlas66yp91639bve2mCDTBX6wAna3TDIig==
X-Received: by 2002:a05:6a21:33a1:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-215ff08f0d0mr2736391637.3.1747201010402;
        Tue, 13 May 2025 22:36:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b236de8839asm8012301a12.40.2025.05.13.22.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:36:50 -0700 (PDT)
Date: Wed, 14 May 2025 13:36:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v1 1/3] new: Add a new parameter (name/emailid) in the
 "new" script
Message-ID: <20250514053644.q2yzlhceclxvvffn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
 <837f220a24b8cbaaaeb2bc91287f2d7db930001a.1747123422.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <837f220a24b8cbaaaeb2bc91287f2d7db930001a.1747123422.git.nirjhar.roy.lists@gmail.com>

On Tue, May 13, 2025 at 08:10:10AM +0000, Nirjhar Roy (IBM) wrote:
> This patch another optional interactive prompt to enter the
> author name and email id for each new test file that is
> created using the "new" file.
> 
> The sample output looks like something like the following:
> 
> ./new selftest
> Next test id is 007
> Append a name to the ID? Test name will be 007-$name. y,[n]:
> Creating test file '007'
> Add to group(s) [auto] (separate by space, ? for list): selftest quick
> Enter <author_name> <email-id>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
> Creating skeletal script for you to edit ...
>  done.
> 
> ...
> ...
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  new | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/new b/new
> index 6b50ffed..139715bf 100755
> --- a/new
> +++ b/new
> @@ -136,6 +136,9 @@ else
>  	check_groups "${new_groups[@]}" || exit 1
>  fi
>  
> +read -p "Enter <author_name> <email-id>: " -r

I think most of "YOUR NAME HERE" are the name of company, e.g.
"Oracle, Inc", "Red Hat, Inc". Some authors just write their names, e.g.
"Filipe Manana", "Chao Yu"...

So I think the "<email-id>" hint isn't necessary. If someone need that, he
can write it with his name together.

Thanks,
Zorro

> +author_name="${REPLY:=YOUR NAME HERE}"
> +
>  echo -n "Creating skeletal script for you to edit ..."
>  
>  year=`date +%Y`
> @@ -143,7 +146,7 @@ year=`date +%Y`
>  cat <<End-of-File >$tdir/$id
>  #! /bin/bash
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
> +# Copyright (c) $year $author_name.  All Rights Reserved.
>  #
>  # FS QA Test $id
>  #
> -- 
> 2.34.1
> 
> 

