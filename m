Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D42DCBE3
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748009556; cv=none; b=R9BH60s05BVA1Z1NBf/xpcrq/j7tIMLAYDRXB1oJT7Umuu0LNJRYC/FhBLDbeJIV21+9Secf50YldJlTf0Yjm8ItcA3Wgx0i/IscUCzKSMEluwPF4JeyJKn10Z6pTZBrY6P2EttNhS9r93PXWHf38hKv4IkD1a3EPoWaK3QRVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748009556; c=relaxed/simple;
	bh=0n59eMFJlkKbjvguOEdIDHYhl/dBZQ1R4YdT1oXHhaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4hAjZZnIuQv9RP8YreW9A2ntbuWLmLwxyZk4R2EZHF/K9/CuIBduMRg7YxUFsVQBWIiKt9xwWpxtzVemZf0BGcIgBV9hCpKoTb5pmXeSaZW799iNxkZABzIZGix30tq19kVO/EbVT0FktUbfzNEeDsq7DFZkDwxYMFpRedoDQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3b+xqLy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3b+xqLy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748009553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H4+7fpqVuqjJM0FQ5QqoSe6SnJqWOfxI5NDtDYNoFiI=;
	b=U3b+xqLySD5d7ZVQ7kLCsbjKoqDhcKjQZPgeJJGrZ4pQCNODR/fA89aIdi1oy1vsBlG4dk
	3mG42lOKVxjsrByRZqlEElLJIgJQtLu2VnnQSqvRvTVtrNh/cimJdnMlI7Gsw8ygUQzF3V
	sfvChSV1VdAQbXkLWLOJRjB5Hg8f2X0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-JkxeHZx0MCKSgn19xAtsjg-1; Fri, 23 May 2025 10:12:31 -0400
X-MC-Unique: JkxeHZx0MCKSgn19xAtsjg-1
X-Mimecast-MFC-AGG-ID: JkxeHZx0MCKSgn19xAtsjg_1748009549
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-310e7c24158so1168704a91.3
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 07:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748009548; x=1748614348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4+7fpqVuqjJM0FQ5QqoSe6SnJqWOfxI5NDtDYNoFiI=;
        b=r6Rr5Byo8lQ6bUqa8qWWyDpMPdNpT30kVfsLLgkJVBwhzBdh9jZlIJ3prJk+pp5NBr
         MumNCyt+3u3lRqFZ7qilaDCtDpMxodrCXpyQ29fAHDyisQNT3xyai7DqWo1vX6Fsk7qr
         mffPPx3H3KgmkGIAgOcpC/XgnV1h9i5qSUcFTJZv53AVzi7P1GSIFHgVNNNFMtSqFEq9
         FxEAnkEE23/9X1+JLlqqo/lJgXmO12W9+fYlER5s0zub4h5kDx0M3KyLUOYJ9I0BZjo7
         UGxQW9I2+dFDorwHuh4+aBYKcjodqceue8yYfM/ForyqXSW43NU12s+4nFJ8IIctCFrO
         blJg==
X-Gm-Message-State: AOJu0YwCU+lnCzwlyAjuMNUQHllRZe0y4gplB2g2maLumBP3COiEITF+
	GsDAV8DWlFIQiUYqpE7aBXo/VWdtV6hXssntev9F5J4+D+lkR8PlzJMjx98hpNzMQnXrXXad0ua
	XcPrePXps8IbRMGQMFloeVYL26R3pa7GE1WR0ytuqLs42+fvXOGbw3hIzvO4=
X-Gm-Gg: ASbGncux5dfTd/R5bTDBMHvKOK6+u015EabcIbCOo+AGoOs+Kp2Kd4CQfQD+ovmD87g
	X6a8PCGZWSKiP2Qm9AKsR6JSYDtCOLEd1Zh2Dc3WzDqqsNImMGMd/w63cTKbF4BRXX5iSxy1KG0
	Xq9pmCBehCDb4QzPQhsyRn5G/FdNvdjnlJE43zgviZArqPd+mPs1qbzKwFzIxftnCQB9YTbBKAT
	YdhikIOhEYFZ87evzWMBsctxHTM3B5WPKcuUBdSZk9t4albpniHUlbBolSKYo73CeIuV3E9egF4
	W9dFobMaRyZ/CCHaG4Zhhm1Lw02g1qjvD5KGbVgS7u7SPONMh9Ga
X-Received: by 2002:a17:90b:4a8f:b0:310:8db0:16d3 with SMTP id 98e67ed59e1d1-3108db016d8mr18110858a91.17.1748009548354;
        Fri, 23 May 2025 07:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFflrRAaK5R8JT5jskEcknD1yOvlcyzxP3TpskbIROOPaj9vMTh/7mi/I9jRDExC1z9ZRp7w==
X-Received: by 2002:a17:90b:4a8f:b0:310:8db0:16d3 with SMTP id 98e67ed59e1d1-3108db016d8mr18110744a91.17.1748009547376;
        Fri, 23 May 2025 07:12:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e11e33c2esm12788555a91.1.2025.05.23.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:12:27 -0700 (PDT)
Date: Fri, 23 May 2025 22:12:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v3 1/2] new: Add a new parameter (name) in the "new"
 script
Message-ID: <20250523141221.dnndb3b24w27ocmu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747635261.git.nirjhar.roy.lists@gmail.com>
 <2b59f6ae707e45e9d0d5b0fe30d6c44a8cde0fec.1747635261.git.nirjhar.roy.lists@gmail.com>
 <20250523140343.nabmzlbss346faue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523140343.nabmzlbss346faue@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, May 23, 2025 at 10:03:43PM +0800, Zorro Lang wrote:
> On Mon, May 19, 2025 at 06:16:41AM +0000, Nirjhar Roy (IBM) wrote:
> > This patch another optional interactive prompt to enter the
> > author name for each new test file that is created using
> > the "new" file.
> > 
> > The sample output looks like something like the following:
> > 
> > ./new selftest
> > Next test id is 007
> > Append a name to the ID? Test name will be 007-$name. y,[n]:
> > Creating test file '007'
> > Add to group(s) [auto] (separate by space, ? for list): selftest quick
> > Enter <author_name>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
> > Creating skeletal script for you to edit ...
> >  done.
> > 
> > Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> > ---
> >  new | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/new b/new
> > index 6b50ffed..636648e2 100755
> > --- a/new
> > +++ b/new
> > @@ -136,6 +136,9 @@ else
> >  	check_groups "${new_groups[@]}" || exit 1
> >  fi
> >  
> > +read -p "Enter <author_name>: " -r
> > +author_name="${REPLY:=YOUR NAME HERE}"
> > +
> >  echo -n "Creating skeletal script for you to edit ..."
> >  
> >  year=`date +%Y`
> > @@ -143,7 +146,7 @@ year=`date +%Y`
> >  cat <<End-of-File >$tdir/$id
> >  #! /bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> > -# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
> > +# Copyright (c) $year $author_name.  All Rights Reserved.
> 
> Dave thought we shouldn't use "author_name" at here:
> https://lore.kernel.org/fstests/aC509xXxgZJKKZVE@dread.disaster.area/
> 
> If you don't mind, I'll merge PATCH 2/2 this week. If you still hope to
> have the 1/2, please consider the review point from Dave.

Oh, sorry, you've sent a V4... Please ignore this one, I'm going to review
your V4.

> 
> Thanks,
> Zorro
> 
> >  #
> >  # FS QA Test $id
> >  #
> > -- 
> > 2.34.1
> > 
> > 

