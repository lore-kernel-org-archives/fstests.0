Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCA1D88A4
	for <fstests@vger.kernel.org>; Wed,  9 Apr 2025 05:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744175101; cv=none; b=uGmWc1lpLcx+o/W3cpCxZJSIb3HEpC1vp6myjGZd46MMhyK4TJeftJpIig2MCSNxOyBzCmWfooGYgYtd9HZ3swI8CP8cbT5PHQuQYcX4E+4QeIJrlfDo2YEJ/GEY4g41eYAGBCZ6c49mlVaTMnmFvytohf2Ui21b+NULLpT5JAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744175101; c=relaxed/simple;
	bh=UqMD5apIFlDteCOIyX/lwa0HCAXVdzeqy/bejU0wBtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM0DWXGJ7auvj5p6T7v44OBLqIXyPx/FWsRoSfm5rTzoytDhHRCTiVTOIHH3G+3rjxy69N/vcssLXdNMeXSiqKrcbfJWp+CWMPcwYNgICmZ+lYV7zTRloKxOtwDbhxVQHuSd5LMS31Vd99Od7fpeUZj4Ne9jK/YjvTgHiK8TLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OUf5AQm/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUf5AQm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744175098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1y3iAg9Agds/Ogx11q6UpGaQVkkfD7b35TZnTxtdUOA=;
	b=OUf5AQm/rud5i4xRWtwXfQjG7+q1nmBulEHErVzSnSnSPCMfNNGN1/YZvKOJYXzu1bjrnR
	bxoOpr/QZIdxZFjCLIhdCM2Qysip76ySu3vGItsuxl2qVo30tZbRo8Ma1VAm6Rr//0j+CX
	DObQFH65iZOrzjrZiRCs3MCvF7qqVCo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-Bo1_pqRlNYWr4AaP1e5L5g-1; Wed, 09 Apr 2025 01:04:57 -0400
X-MC-Unique: Bo1_pqRlNYWr4AaP1e5L5g-1
X-Mimecast-MFC-AGG-ID: Bo1_pqRlNYWr4AaP1e5L5g_1744175096
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-306b51e30ffso3450600a91.1
        for <fstests@vger.kernel.org>; Tue, 08 Apr 2025 22:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744175096; x=1744779896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y3iAg9Agds/Ogx11q6UpGaQVkkfD7b35TZnTxtdUOA=;
        b=DGMZI29KGGD7TAWH+KTr3vwwVEGCwu3tXeVokg+z6YIWrBqk7BsN3WGi7IMN88WDRt
         kwPMBqA/zsp1FFcuesc7WgQnKztQhSdwKfiq3RSLn1KuauUfwhhL4ut54J2WMS+l56t+
         ZPf+sl8zNuRLg6UApyW/OIJbOGgffgxoXiqxm1fm8DQAZldkhTCOIsT2rvGferL/ovtb
         d6EakTv/DG1b/otbZY58Kxo7cLw5gF5D9+ncoAgL3xFmJSp4aPIZAe3FEahhsr4An7bz
         NfjcrqzORidSo3STvtLvKBg2rw0gZAR9yjn1DfhVPkQr2ParlHasnv+IgblHMsrz+Xkl
         8nig==
X-Gm-Message-State: AOJu0YxPSVV7j53HvYfskry098GBx8FN2a7HPilxPtUulDNXwQfimi7q
	jaQYBG55xY4cPyaU4qcL4VIYv6VS73EmveP2Kc8YONp7hA1F6rPZr+J4JKVXciRhJtmGVSZWNzx
	bS9Bjv7dNApNePqlRAzNpppebGUbc/2clv1SlqhvRpn2HW5G1xv0zHGI=
X-Gm-Gg: ASbGncuCHaP8nHR6nubVJzYuo40fHv00Fge/ewYQHFv0qSiy8LPbyA8bP3a/Bc1fG8n
	ySUQf7EV/nwmpw8A8pqDtOUwK/1iNgAax4q7GoNnaYPmu7YxFrRbX3wHp8bEYyQ+cuWbJrzdbLl
	TuwfixPQmPcspcRvP+4ZXwXsyJxhPvG74SZhWy7idiAugVOAWtOUXb58MXPCOT33Z4MAA+jriAF
	5EnN1LNjyb5So3esKrBo/l134oJPtxZC+BHE+BtMDV4KrpmYqi8pbWh3u12RxK+oeCc8YNKd72z
	gFnn/JZdk+49zrwhozhC9pUNOWR5JCM0SiKT0jM6UgoshNgnACtIPVuB
X-Received: by 2002:a17:90b:5488:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-306dbc390e9mr2115570a91.29.1744175096036;
        Tue, 08 Apr 2025 22:04:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDcrE2k0N742zHbBe7oI20IFqxVkjJZoXi1LOt1Rkg6ayMeaOnkhcBhB907+V8zBE2CUb15g==
X-Received: by 2002:a17:90b:5488:b0:2ff:6488:e01c with SMTP id 98e67ed59e1d1-306dbc390e9mr2115544a91.29.1744175095663;
        Tue, 08 Apr 2025 22:04:55 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb544csm2383045ad.167.2025.04.08.22.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 22:04:55 -0700 (PDT)
Date: Wed, 9 Apr 2025 13:04:51 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v3 2/6] generic/367: Remove redundant sourcing if
 common/config
Message-ID: <20250409050451.tzw5e2g5fpk3ktne@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
 <ffefbe485f71206dd2a0a27256d1101d2b0c7a64.1744090313.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffefbe485f71206dd2a0a27256d1101d2b0c7a64.1744090313.git.nirjhar.roy.lists@gmail.com>

On Tue, Apr 08, 2025 at 05:37:18AM +0000, Nirjhar Roy (IBM) wrote:
> common/config will be source by _begin_fstest
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/367 | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tests/generic/367 b/tests/generic/367
> index ed371a02..567db557 100755
> --- a/tests/generic/367
> +++ b/tests/generic/367
> @@ -11,7 +11,6 @@
>  # check if the extsize value and the xflag bit actually got reflected after
>  # setting/re-setting the extsize value.
>  
> -. ./common/config
>  . ./common/filter
>  . ./common/preamble
>  
> -- 
> 2.34.1
> 
> 

