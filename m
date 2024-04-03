Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DE43AB4
	for <fstests@vger.kernel.org>; Wed,  3 Apr 2024 10:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141696; cv=none; b=aVljik0TRDpK15LYREGJFXZz4Mlv31fiVribgMmXJ4SbOdGuZ+i+EtesgijoYlgwYRO11dhw2ohOZW25fkBCuRdUy7w2bU/sm0TgD1l+De1XqiUJJQcK1UgHdKlXWWdJ8SrhY+Y/xof6ZDn8JEF8WKprXjU6aUUBHwEaQMilE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141696; c=relaxed/simple;
	bh=eQIF0RE3HJVIHuhMd8KVokaYuAiVvvYWlFsaVZ3pRYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbbW/VjvGNnEN6/69uptwsvZybx/waai1wO1u18T6RQDzFCQ1oG8AYWt90ICHZMcWRPbFVZQlQ/9e4yR6kgZP1ddBGUQP8Xl3ez5hPos7295/rgcQ7A5NSHzUX2X9zYpS3OicOVk5ctMxFF5iQmr1DhyRiQd9JJJJufox5g4L0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HklAnmUc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HklAnmUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712141692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcN1fIRh+IuYFYybpTstXtOK/vglmw8d858lxm5uA/s=;
	b=HklAnmUcf3O+x4ZoRM8af11OMtWsrTdYNn4rlXrpebdXxTQZTM2LHM3Gk07XMlqKQzRJHa
	4sOSm+3tharHOzMf4Dyqjf+QBHirj6Q0RAHXdEnlVj3uFnTKbBQToiULJ1sMaKkwEoyMzf
	Py5/z22Y+IYoCfRi0qMMgnVvz43Nr4Y=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-IrPTO41KNEOmy1sXRUvYlg-1; Wed, 03 Apr 2024 06:54:51 -0400
X-MC-Unique: IrPTO41KNEOmy1sXRUvYlg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a266c4d38eso1135940a91.3
        for <fstests@vger.kernel.org>; Wed, 03 Apr 2024 03:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712141690; x=1712746490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcN1fIRh+IuYFYybpTstXtOK/vglmw8d858lxm5uA/s=;
        b=G40+CWCxZZIPFEawzz9+DwfTeFFkt+lsf/hb4c4q+yGt8Lg2V82de9HsVWhkk7z++x
         M44aEzli+rxLn0qMse7u70gazXfwn8Z6XlUG9iPeFejFmkZhQnH4jZCc0nY1192D/9cs
         MrRQ++Zj2PjA50LeiZ730zCRaRpqH8SVm4TvZdF74MaW/QHU/nFbkBW3AJFCByagRfTC
         9dx86hWa31PW689eqHh6X9khYMeCUFO9+Q/mDZJFcgIa706YjoKfwo3Z2B3Bc/w0UE11
         vbQ/tPJini6zK/NH+onI2tgnjm/9nlEtAbvGQXThH2mr0xPg20WRoi4EaJtCnU+vuJX9
         bKag==
X-Gm-Message-State: AOJu0YwDGfGxMUE0ZbxHqvU3GPj/yWThqlDrx9aEBReX6eFHJkeUhvsO
	TilExPJ5/YqBlwHwPeYPEhpDHk/czCG9XLxN4JguD377aMSjguio5EmQXYYtBoWKaPKW0inq/rV
	92W3ANDEE2abA0Ra1to5SCDG6nM3MhmUIjBxOMYlkIyWlldIPS/V+nJE2u9DCySi0Ik1y
X-Received: by 2002:a17:903:249:b0:1e0:b1a7:473e with SMTP id j9-20020a170903024900b001e0b1a7473emr14903059plh.67.1712141690158;
        Wed, 03 Apr 2024 03:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVYg9Fa0eUIF5vfTYqauhk9aybZhsJPu5SNQKoiH8A9jDpaBF2GrpvB4QekbKyvMsL2SxlEw==
X-Received: by 2002:a17:903:249:b0:1e0:b1a7:473e with SMTP id j9-20020a170903024900b001e0b1a7473emr14903050plh.67.1712141689765;
        Wed, 03 Apr 2024 03:54:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kh12-20020a170903064c00b001e2194ab34bsm12764868plb.245.2024.04.03.03.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:54:49 -0700 (PDT)
Date: Wed, 3 Apr 2024 18:54:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: =?utf-8?B?6JSh5pmT5paM?= <caixiaobin0807@163.com>
Cc: fstests@vger.kernel.org
Subject: Re: Re: about the format problem at generic/556, and supply a fix
 patch
Message-ID: <20240403105445.qqzzah7b5usx4cwf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <5c043f11.244a.18e9c783e59.Coremail.caixiaobin0807@163.com>
 <20240402155135.156ab20a@echidna>
 <13624bfb.869c.18e9d78f712.Coremail.caixiaobin0807@163.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13624bfb.869c.18e9d78f712.Coremail.caixiaobin0807@163.com>

On Tue, Apr 02, 2024 at 02:22:14PM +0800, 蔡晓斌 wrote:
> 
> 
> 
> At 2024-04-02 12:51:35, "David Disseldorp" <ddiss@suse.de> wrote:
> >Hi,
> >
> >On Tue, 2 Apr 2024 09:41:49 +0800 (CST), 蔡晓斌 wrote:
> >...
> >> From 40ff753ffb3dd4ab8789699dc45a83ece64a3626 Mon Sep 17 00:00:00 2001
> >> From: "cai.xiaobin" <cai.xiaobin@gd-linux.com>
> >> Date: Wed, 20 Mar 2024 11:13:29 +0800
> >> Subject: [PATCH] generic/556: reverse the order of comments to make the file
> >>  look more like a script file
> >> 
> >> 
> >> ---
> >>  tests/generic/556 | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> 
> >> diff --git a/tests/generic/556 b/tests/generic/556
> >> index 404a3243..ccefbcc4 100755
> >> --- a/tests/generic/556
> >> +++ b/tests/generic/556
> >> @@ -1,5 +1,5 @@
> >> -# SPDX-License-Identifier: GPL-2.0+
> >>  #!/bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0+
> >>  # FS QA Test No. 556
> >>  #
> >>  # Test the basic functionality of filesystems with case-insensitive
> >
> >Looks fine to me, although I'd suggest a simpler patch description:
> >  generic/556: move shebang to first line
> 
> >
> >Reviewed-by: David Disseldorp <ddiss@suse.de>
> 
> 
> Wow, your suggestion is good. Do I need to provide another patch with a correction commit?
> Thank you for your reply.

Looks like there're many special characters in this patch, please send a
normal "pure text" patch, with a proper subject and commit log. 

Thanks,
Zorro

