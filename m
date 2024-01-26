Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92BBA39
	for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272708; cv=none; b=kTyr144uspl1ohE/CMiZIKqIWt9wbDaC0/hlkJse2uAt9d1keayzl1VymJromigUf3zMvYqHJtmafHQLZbqDao9ypjlliVRlsQJxRsESH22ewQ1njNdezvZAu2nTyZhorEQ2GjYQ1Cpp3AVB+/tzhrSezbdZgD6oYQKhiuDuJcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272708; c=relaxed/simple;
	bh=/q3N+f/OD18jXpPq+chgFsXpSsttpD3ygV3epqchrKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7q8TOyP6BBfddV0GS7SasaqZUsoz29ydPhV5/LX5slEbQ4YWiKXjwO8rdX6iqZYoCjnaXs5OPwDx3vlnMOilhhuVfxpNjccla44ZR88X9CI0wsdbqbVrPs+95XVaKepYw3r1QBQxIv98ksbkxbhqgz2q79hTrRlrZEkT1yk0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiWWm7p0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiWWm7p0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706272705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FpXtWa/FbpyKoHWu9UKHP8n22Llt8QHnUvrPFjiZA/M=;
	b=PiWWm7p0fg7IBhC4wh8xcoKWVOWZChu1TLfHjg1tVgf0eFEuJT41pLtg4rh7EzmjiqT+ux
	/mmbCD/zBPDCyXcl0cRn3v2UTTkzEJrrxpamvaP1Q/msXQksS844XnLUYYQYzmi+hGrrlA
	wIUbjxb3Na4+JqiptDVRI//W31m581o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-txJyA8AzOlaLNTQOr5UX-Q-1; Fri, 26 Jan 2024 07:38:20 -0500
X-MC-Unique: txJyA8AzOlaLNTQOr5UX-Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2b6da35066so13832666b.0
        for <fstests@vger.kernel.org>; Fri, 26 Jan 2024 04:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706272699; x=1706877499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpXtWa/FbpyKoHWu9UKHP8n22Llt8QHnUvrPFjiZA/M=;
        b=LnLKQyPiUTvVkDv69jVAtL7aVRIbl5smphN2EX1QnAD6qms9hzZqdGh4Wmq9//lx2W
         gne4D6pLzMAiNa0q/xZk4xJSf2q7GPs9FLjkzu/sYbBuMrFo1ev3vzDdE3e9BAZ0mcQP
         Pu6/7+UPll7GrWmLIpfSQSSU2hUUfPj2U73DlT2lJbkIOynfO7UOJEeGvz550H4iKodS
         1AsSkJ1cPvILFm90zEaIxLtYKRQCQrcpJphLz9b89tHjw0pu52ABxu99W9ki1o6oweOq
         eVyyxaa5L5ocNUogGrGGg7gvZJcwdgkXuMeRqAnH4UjrlBvJLHP46nkdW0en12b8gDfl
         hhoQ==
X-Gm-Message-State: AOJu0Yy/qBLSmUODysK4AA3xE7mSAugxG1Z5Z9rPtiFhW01+6Gx3Xbz0
	ng38c2cRGVoK9lcnbJEzu+RZqQDC0nXeSKWpnezGcbTn+agMKT6up02ct2Zee9EDXYFBD+fLY1i
	GIhDHcuisuVG3n3zH1TCZ6St4Dgp+feIoF7mdNL329XHVBdg1pTSFkA==
X-Received: by 2002:a17:906:68d8:b0:a2d:52dc:1841 with SMTP id y24-20020a17090668d800b00a2d52dc1841mr535545ejr.18.1706272699812;
        Fri, 26 Jan 2024 04:38:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhUY1JUv7jiHgxMfx06oU/jmhOZo7rXSEL5a6svFyU0TVPHlLZldd7m1QCMRtwJS7HjGKmFA==
X-Received: by 2002:a17:906:68d8:b0:a2d:52dc:1841 with SMTP id y24-20020a17090668d800b00a2d52dc1841mr535541ejr.18.1706272699470;
        Fri, 26 Jan 2024 04:38:19 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i9-20020a170906264900b00a34a0163ee7sm579868ejc.205.2024.01.26.04.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 04:38:19 -0800 (PST)
Date: Fri, 26 Jan 2024 13:38:18 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, guan@eryu.me, linux-xfs@vger.kernel.org, 
	fstests@vger.kernel.org
Subject: Re: [PATCH 10/10] xfs/122: fix for xfs_attr_shortform removal in 6.8
Message-ID: <rnmqtpiatzcj6ysi5ivz2tbylbu3f6q5lblnot226m3tgoiso3@kfye2yeryfn7>
References: <170620924356.3283496.1996184171093691313.stgit@frogsfrogsfrogs>
 <170620924507.3283496.17636943697618850238.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170620924507.3283496.17636943697618850238.stgit@frogsfrogsfrogs>

On 2024-01-25 11:06:35, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The xfs_attr_shortform struct (with multiple flexarrays) was removed in
> 6.8.  Check the two surviving structures (the attr sf header and entry)
> instead.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/122.out |    2 ++
>  1 file changed, 2 insertions(+)
> 
> 
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index 89f7b735b0..067a0ec76b 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -62,6 +62,8 @@ sizeof(struct xfs_agfl) = 36
>  sizeof(struct xfs_attr3_leaf_hdr) = 80
>  sizeof(struct xfs_attr3_leafblock) = 88
>  sizeof(struct xfs_attr3_rmt_hdr) = 56
> +sizeof(struct xfs_attr_sf_entry) = 3
> +sizeof(struct xfs_attr_sf_hdr) = 4
>  sizeof(struct xfs_attr_shortform) = 8
>  sizeof(struct xfs_attrd_log_format) = 16
>  sizeof(struct xfs_attri_log_format) = 40
> 
> 

LGTM
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

