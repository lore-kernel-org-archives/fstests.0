Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1D29345F
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009034; cv=none; b=rQA+HKov7qCY2SmUadAZbro1PeArc8rJLwyCcIhj6Z+ZKUpJVekDq4RBDxcvowLEULBTCWGwUUMBW6P2fqAupdH8lTe8x9rvsfXYCLXga8oYavtonWCM9haTd17V7AK980E1m6LpqB71mQAChHTWt58Jv5Pb/UNkF0Zzo3ar18U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009034; c=relaxed/simple;
	bh=DGkXuHEeaKTLfrGvSNgzGoTOQMi11yZ1xm0b38NCK2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=darzLPjpPDKS3jNnqwfGF7geWCqhiy0nVZ5D8AoE2UFLQVAOVEpuMOKenUXi8Q8CEV4l4QpV2CrrI1wda08vXSZuVv9JnWiHtJ8kjaDLkYaizSG91Hy6rK6S7QkbyKSx1MsX/JtGnEn3YjstD2P7zL+z38KUSshQ6edk9X0nUbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iqHiE2Qk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqHiE2Qk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748009031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4YGRKcfNyyUn6jZ4ThCK6xz4VOL69I1YIik12BFOPpw=;
	b=iqHiE2Qk6MYc5f4Jm5wA8ktAkFblbK/B/8U90hZwWhcbIExefiqxLBF8CjSjANeIALNvzs
	uYc83AsDCwDx3cI3afa/0jwZlm/O9ccZ9NciSbSLVUZF6Nt0paGbIY8NBxCtGR3I1Z4kk0
	+v8ihSzT+1vU4oTZ/GFdfoKgdbjBL78=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-Ik_YPJRVNLW4t_omNqcrpQ-1; Fri, 23 May 2025 10:03:50 -0400
X-MC-Unique: Ik_YPJRVNLW4t_omNqcrpQ-1
X-Mimecast-MFC-AGG-ID: Ik_YPJRVNLW4t_omNqcrpQ_1748009029
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742a969a4d0so6531541b3a.2
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 07:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748009029; x=1748613829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YGRKcfNyyUn6jZ4ThCK6xz4VOL69I1YIik12BFOPpw=;
        b=VLU+fIiNS5mjMUYn+laqUDA10/gKMa2QOytrYCkv+RRUZ8LGFMDsprnzJ0m+7MbeqV
         D0GTbMij5JEQ+VFq2sx09/JhIUutSlxDtO12pP0WTh19lrkQNTivsnOz+HZsPKVHJnxx
         TiP1xuzkaJzHVa45JMPR2FUtWiAiZCekGYu7/S9YtIJKSMuQ013WEUe6b0j7vMVuEAf+
         Yg+ViGo3WAQzwfbKQv3cB/UILSznFYsNCfwIQjLmZ6z3B72hg8H6TKPDaH6TKEWDApku
         3Nxx3qvgSoevhIDeWhWwd+WwghcWbWz13iwZQweV/CXeLTHWF2jHLRC0ALux3hYelzfE
         496Q==
X-Gm-Message-State: AOJu0Yzu/eik73A6DuzRxGuy4RY7NUYcXac+OKBoQfrLvcof4aWqhTSE
	H4z5KtIz1QY2mVfRVG2fo5qEnzvexSgF9WceXpzHXHkLong+7iA+M1IAfThDvw9llQiiPxLmEeP
	rA+xgdBCBZPZMZLtQxHb7+ionFFxUSQEWqs4Yq6Yof2k/F0PLnjn3wH/hEUw=
X-Gm-Gg: ASbGnctQ16q/zGHh/bbbER9wQB0aJh2grS6jplBemXySa9/lBGJ1EsJ4HGLlW0aM7JH
	G6ubz7tJFE+EP9vQbghWXHIPYs7y66GNN065Fsj/yX6UhoydjkUGDdHcEXCCIS+f8iblysQVK36
	MRoH6lMx1gSEisdRk6sH8Oim2SIgMKIV8CiKkxAAnjERmSXEIZIaJyE3NOAY/Bnddq7pryCKHVx
	nuZL+LrAphdDgrrRg51fubeUi99wAudIoJOUA66ohSh5ScuP6hd03cewIPUov3DYoD5IqVV8MvU
	fOx2CZe/ApLRo34rEccJmI4gHuaL8YwN9t8DKgWpPqI97HXtwneV
X-Received: by 2002:a05:6a00:3cc7:b0:732:2923:b70f with SMTP id d2e1a72fcca58-745ed87c9b5mr4232723b3a.11.1748009029359;
        Fri, 23 May 2025 07:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj17p1KKn+GDztyBFqeRvJRnpGGbjfNutmIwYVNXD38chctaNMiPd24PVPyBf3pQmeyrOY5g==
X-Received: by 2002:a05:6a00:3cc7:b0:732:2923:b70f with SMTP id d2e1a72fcca58-745ed87c9b5mr4232686b3a.11.1748009028952;
        Fri, 23 May 2025 07:03:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a3403sm13273668b3a.177.2025.05.23.07.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:03:48 -0700 (PDT)
Date: Fri, 23 May 2025 22:03:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v3 1/2] new: Add a new parameter (name) in the "new"
 script
Message-ID: <20250523140343.nabmzlbss346faue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747635261.git.nirjhar.roy.lists@gmail.com>
 <2b59f6ae707e45e9d0d5b0fe30d6c44a8cde0fec.1747635261.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b59f6ae707e45e9d0d5b0fe30d6c44a8cde0fec.1747635261.git.nirjhar.roy.lists@gmail.com>

On Mon, May 19, 2025 at 06:16:41AM +0000, Nirjhar Roy (IBM) wrote:
> This patch another optional interactive prompt to enter the
> author name for each new test file that is created using
> the "new" file.
> 
> The sample output looks like something like the following:
> 
> ./new selftest
> Next test id is 007
> Append a name to the ID? Test name will be 007-$name. y,[n]:
> Creating test file '007'
> Add to group(s) [auto] (separate by space, ? for list): selftest quick
> Enter <author_name>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
> Creating skeletal script for you to edit ...
>  done.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  new | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/new b/new
> index 6b50ffed..636648e2 100755
> --- a/new
> +++ b/new
> @@ -136,6 +136,9 @@ else
>  	check_groups "${new_groups[@]}" || exit 1
>  fi
>  
> +read -p "Enter <author_name>: " -r
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

Dave thought we shouldn't use "author_name" at here:
https://lore.kernel.org/fstests/aC509xXxgZJKKZVE@dread.disaster.area/

If you don't mind, I'll merge PATCH 2/2 this week. If you still hope to
have the 1/2, please consider the review point from Dave.

Thanks,
Zorro

>  #
>  # FS QA Test $id
>  #
> -- 
> 2.34.1
> 
> 

