Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBB9296173
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 15:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013081; cv=none; b=A2qjvvv124PnEvtQuWQ7jtbd36wLxSaWgDWCqVzi9nMjMBe6tsE+5CDUDnnT52GJRJUUvtwbSPunlfaJGxhJhFCDYYMRTWvL9ydy+Q7imakwBy/EU1sHJB7NZkRi5kN3yMJAiOxdXT5b8oALGw8HPkqX2Qd/sVJy8/nBOqj2QO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013081; c=relaxed/simple;
	bh=+tReRAgv0vI30RDuIgS++Ebwbd8kzKFBgqf3nLvaLf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqWD/iAVrzRpW81ORW89+Pk0CkO9QigmQetM61Pysc9EWWuRVGAujIafXeBRZ7aIXCUHYQhX2DTcventZUzqyf0R2k+vioNParOn4WbFfANEaAuGZR8QmCm5k/zEouaXlaoWrOeECVRBmjbdpB+lSz0P9kYta/TSEXgez6/bDDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inchNBi3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inchNBi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748013079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=voaSsyYj2YOmvOIrQ6J0fboFnlH7C77mXI0eP3uhd0k=;
	b=inchNBi30TLt17V18v757EUbewEvspYBUhS4cZf9TYs/WNO5pqMYaTMvpvsrKX5UVSJc91
	yPPEyhaXShsdQy3KhOsAHotVZQNiDC/o658ltLMyEGTM8/ozAJZhy/MNBnMt7s9ZR54W38
	FwbFZRArlehO0bkLzzm2rKYEczt4eOY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-U4nWaPkLP12TqhpZnCcEUw-1; Fri, 23 May 2025 11:11:15 -0400
X-MC-Unique: U4nWaPkLP12TqhpZnCcEUw-1
X-Mimecast-MFC-AGG-ID: U4nWaPkLP12TqhpZnCcEUw_1748013075
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742cf6f6a10so85077b3a.1
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 08:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748013074; x=1748617874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voaSsyYj2YOmvOIrQ6J0fboFnlH7C77mXI0eP3uhd0k=;
        b=fbiD2uiUkmz+quSn/UReKeLes/R5qRB9DcD8Idn3+a/aZciIg7k4qcjH8+B+o2uZvI
         dQJa4pPegyNvBb5dlj1tAsCEmQQ90gR8ZzpmB3/7rHgOyB8JFW+t2HMnD3/yVdP8PV1r
         CgRyWV+RvLkZDNqs9T/hEfszKSdGPx16rMAGZWK8Olvr7URxxz0B+KvBb2gJqugbcTHD
         cqiyg05otnnJ3F/eUsEQHkyBc36qdzFzAPDlGbxjfQ1Gco/T8sf4kJzj4JG3sqs0BOqa
         cXY1QVUDGRdnSo6XOMgyRnBHR2Ex1xYz+Y4MXt5GPN/Eoz2wsk5Z2+BxgoANl7TpVhoQ
         hb2A==
X-Gm-Message-State: AOJu0YzRDTVxXuUJ+Nsy9Ab4i7oOAX0F/kt4SBzLq2qyGRm8mFWvLunI
	RAI7r7BAxrHGQ1blsd32O3z4rGqsOmW0Lv7cOSD6cTHbJi6S27SfM/DbGwSSI4l5PX2HCiVsNo0
	sGG4AzxNjGi7FEWfC8OmjhwlM7b9ONNSohiS0m4VQEAt4++iOThyDhx8ImJI=
X-Gm-Gg: ASbGncsa7ClYjAVoDvzqN2y9vb3ASPbl5rOPUMZc53csOwxW5G2rvs4KPPUEdXJaRla
	qmiiIop1L6hEd7TunQEgdAoSkI5C2qnnQOs4QOZAi/MJ/79uhsdGXWc07fF+aFQIw5v1r23q6Ih
	xvTOQqZbwWfygLaOkGugE+lP4Dj/Y5Ozt4xOWLqg1t96G3gnLgG2a1Thn2u7jKv5V9LZ/27GZPL
	1wGrFXiuU1U7uDIhp/X16+IVS1uwb3auUacyIXXdtJSCAH20T4eOwTNJnXdYe9m+w+Q7Tm/2w7L
	Gmf59Bvh5i5lg8oqYP2TgjeTSEQJKxCVw6yi+vIaAGaFpKZHiC0C
X-Received: by 2002:a05:6a00:1705:b0:742:da7c:3f30 with SMTP id d2e1a72fcca58-745ed8f5cffmr5029427b3a.19.1748013074607;
        Fri, 23 May 2025 08:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbaSPNwoZLNrAuqi+CqpvcPBlF151WSA0skLZzhPzzTFD58zs05MmaKUwsU1qXxvi/84EA2Q==
X-Received: by 2002:a05:6a00:1705:b0:742:da7c:3f30 with SMTP id d2e1a72fcca58-745ed8f5cffmr5029380b3a.19.1748013074227;
        Fri, 23 May 2025 08:11:14 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970e1a3sm12784504b3a.71.2025.05.23.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:11:13 -0700 (PDT)
Date: Fri, 23 May 2025 23:11:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v4 1/2] new: Add a new parameter (copyright-owner) in the
 "new" script
Message-ID: <20250523151108.axky3xfznd5yackb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747892223.git.nirjhar.roy.lists@gmail.com>
 <72c4879ec3f037db0478bdf0c64c1fbc6585cea7.1747892223.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72c4879ec3f037db0478bdf0c64c1fbc6585cea7.1747892223.git.nirjhar.roy.lists@gmail.com>

On Thu, May 22, 2025 at 05:41:34AM +0000, Nirjhar Roy (IBM) wrote:
> This patch another optional interactive prompt to enter the
> copyright-owner for each new test file that is created using
> the "new" file.
> 
> The sample output looks like something like the following:
> 
> ./new selftest
> Next test id is 007
> Append a name to the ID? Test name will be 007-$name. y,[n]:
> Creating test file '007'
> Add to group(s) [auto] (separate by space, ? for list): selftest quick
> Enter <copyright owner>: IBM Corporation
> Creating skeletal script for you to edit ...
>  done.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  new | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/new b/new
> index 6b50ffed..a7ad7135 100755
> --- a/new
> +++ b/new
> @@ -136,6 +136,9 @@ else
>  	check_groups "${new_groups[@]}" || exit 1
>  fi
>  
> +read -p "Enter <copyright owner>: " -r
> +copyright_owner="${REPLY:=YOUR NAME HERE}"
> +
>  echo -n "Creating skeletal script for you to edit ..."
>  
>  year=`date +%Y`
> @@ -143,7 +146,7 @@ year=`date +%Y`
>  cat <<End-of-File >$tdir/$id
>  #! /bin/bash
>  # SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
> +# Copyright (c) $year $copyright_owner.  All Rights Reserved.
>  #
>  # FS QA Test $id
>  #
> -- 
> 2.34.1
> 
> 

