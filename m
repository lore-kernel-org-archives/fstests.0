Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9045941
	for <fstests@vger.kernel.org>; Sat, 13 Apr 2024 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713037773; cv=none; b=P2NZNAaqasjoWLyX6O5STpyfVYt5UDtZPdlHZ1fAVePplvA8OGtFQ9zVo7+mWxqoXeEJK7rEgSB7KdaUkzwaGAkzd43vtK0v/Qim9oyXnneBYV3voXK/OdemA+2+p4EsxxIv5tu91aIJ7Vj4PHaQxPO89exs3v9ZSjxZQB99Ijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713037773; c=relaxed/simple;
	bh=wIs7m+elMpZNhATRAMsXh4VtfZ02nJaf0BNS+V/OWeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE1m8GFJr1CY6Kp6eeXFJAx7K/7/ZWdAH4Ke10lgOv6SCbHv/R8arwlAToEaaqPuLWj9THrge5X6olmZ9sY/y5WM60q+V8vQacF3MYdP1jD71MTvvTRlpol8jbum9ENq1Nif2u4wXl1yc7L23ATHDowpUS7701KvoEtgF21lj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDwhpLzT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDwhpLzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713037769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0Z/gQFc+oLUIuH9aw46M4RsCFYFiKHVXxEdpx5+HpM=;
	b=bDwhpLzTqx92x/zV7Zk9UvgIaYQTwP7kjQ2vxKUuzU1GuBFeZDxoRfJgf7Nz59ZnUm+bgP
	6G1dtmm8Mlk90x3hwK5TJaQD1zeBuogd9AfKSNGxsxT+UVpO2sZALrCGWsoSpxXkG7q2Cq
	JRfTTZkpwU2NXLJtw5fgeLbVX/m5Wf8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-ZGFJLqRFOLyWj9INpSTb1Q-1; Sat, 13 Apr 2024 15:49:27 -0400
X-MC-Unique: ZGFJLqRFOLyWj9INpSTb1Q-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e54e6ba9a1so19044665ad.1
        for <fstests@vger.kernel.org>; Sat, 13 Apr 2024 12:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713037765; x=1713642565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0Z/gQFc+oLUIuH9aw46M4RsCFYFiKHVXxEdpx5+HpM=;
        b=V1HJzbL46+dPs3I5pbjDuG/OVvjJtr9hfU8SsbQuUvqRPXDuV8OD+/XYfR5NcNkhRt
         A3Gz+BepxBZaWUDM1pjNZEC9cGXnl1e2Y5QG9RJWY2CNFJHt6PsSoKsJAgrc8pIY6Q6X
         tl/Aee3H8HciUe10sS2AvFuZgZhp1CTf67GGExWKbzWPByz3keJ5omXigWj4q3Ygny6W
         /WWvkD22PYo7zf0ogUUrcx1Swxzm5dsuc6igQGbuwe5jcj7CWte1SIRn4rLPxNKjYnN8
         Y6rV0qU4dF1QtWovn16BKAUaA2MQ09L0S7OLGvP44TT+YlWrOvTmCnN/Kx5x/MCcD1LO
         a0UA==
X-Gm-Message-State: AOJu0YxKl7ufY0/Xuhmf/+BaOIgwXcz/SvyNfv7B4v3cpa47O6iIMonW
	cjRJVY1iu3to+iqvGAAX+6+BrH343JBCCuTd6y8NRfqKDBpsJ3W1oGKh3fReOJPjZIM8bvU8YNL
	ZuxlzRq4WsYpn2/HjcGGj91setgN7n8OBLTO09XER1CpxZZQNJF7THXk=
X-Received: by 2002:a17:902:c94c:b0:1e4:dcfe:848f with SMTP id i12-20020a170902c94c00b001e4dcfe848fmr6379856pla.16.1713037764961;
        Sat, 13 Apr 2024 12:49:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7X5KKAl+Ql32EdDVhqpWGrLIBwQVd8+m8URqxT+9LmfH+mo1SKcW7zDKGlumWw+Lwv1yX2w==
X-Received: by 2002:a17:902:c94c:b0:1e4:dcfe:848f with SMTP id i12-20020a170902c94c00b001e4dcfe848fmr6379843pla.16.1713037764392;
        Sat, 13 Apr 2024 12:49:24 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u16-20020a17090341d000b001e51b690b7dsm4939869ple.295.2024.04.13.12.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 12:49:24 -0700 (PDT)
Date: Sun, 14 Apr 2024 03:49:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: =?utf-8?B?6JSh5pmT5paM?= <caixiaobin0807@163.com>
Cc: fstests@vger.kernel.org
Subject: Re: Re: Re: about the format problem at generic/556, and supply a
 fix patch
Message-ID: <20240413194920.ztj4wklloon6crbx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <5c043f11.244a.18e9c783e59.Coremail.caixiaobin0807@163.com>
 <20240402155135.156ab20a@echidna>
 <13624bfb.869c.18e9d78f712.Coremail.caixiaobin0807@163.com>
 <20240403105445.qqzzah7b5usx4cwf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <24c3e367.2ec8.18eb6525a25.Coremail.caixiaobin0807@163.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24c3e367.2ec8.18eb6525a25.Coremail.caixiaobin0807@163.com>

On Sun, Apr 07, 2024 at 10:10:34AM +0800, 蔡晓斌 wrote:
> 
> At 2024-04-03 18:54:45, "Zorro Lang" <zlang@redhat.com> wrote:
> >On Tue, Apr 02, 2024 at 02:22:14PM +0800, 蔡晓斌 wrote:
> >> 
> >
> >Looks like there're many special characters in this patch, please send a
> >normal "pure text" patch, with a proper subject and commit log. 
> 
> >
> The content of patch as below and see attachment for the file.

Generally we don't accept a patch as an attachment. But as this patch
is simple, I don't mind manually changing it and commit with your name
(for once). But ...

> 
> From edf74d60a83554ad2c85a86ab032767eafe75a9e Mon Sep 17 00:00:00 2001
> From: cz0807bin <caixiaobin0807@163.com>

Is the "cz0807bin" your name ?

> Date: Sun, 7 Apr 2024 09:47:20 +0800
> Subject: [PATCH] generic/556: move shebang to first line.
> 
> There is format problem of tests/generic/556 file and looks not like a script when it run.
> So makes a change of order of first line to looks well.

Don't you need a Signoff-by ?

Thanks,
Zorro

> ---
>  tests/generic/556 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/556 b/tests/generic/556
> index 404a3243..ccefbcc4 100755
> --- a/tests/generic/556
> +++ b/tests/generic/556
> @@ -1,5 +1,5 @@
> -# SPDX-License-Identifier: GPL-2.0+
>  #!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
>  # FS QA Test No. 556
>  #
>  # Test the basic functionality of filesystems with case-insensitive
> -- 
> 2.25.1
> 
> If there is any question about the patch, please tell me how to do, and I will fix it.
> Thank you for reply.


